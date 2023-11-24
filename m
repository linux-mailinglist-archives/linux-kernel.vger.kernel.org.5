Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E17F7509
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjKXN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjKXN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:20 -0500
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 05:27:33 PST
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A91998
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
        t=1700831882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZABsrju+3feVMwii1H8J45xoKumLKlmUGlla0b8ba5E=;
        b=jXzO0DrLUL7ua5QX/TEPywrG29VAR2py2fqQDxTQGtaD20peAMnLCYPNFuAObVRJ9HJ2c0
        AWN6s9cSudgJtfBr/T8uOXmKVwnSDZvw76ufPgrlcrC9U6RnTd3agHRxehNBWezIsCsmTR
        PRNVRd+SUmOPj08liTSTt5qyiY2KL1zPIcaBZDaqo2QnsPjUkVoWx39t18K0xx5sgIxhAC
        31bGgwBxjtNSMBWmCcgOSlVgVNgZpJ1itm3nlQEisRWPk7VzTGuVkugmYBJSe3jsmM1an8
        r8M6HNmJe5LfSXytw4PhrH4W5vAAWqArUIJTkxmSVCcaxX5HqMzk1aXSFW+FpA==
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH v6 0/3] clk: si5351: add option to adjust PLL without
 glitches
Date:   Fri, 24 Nov 2023 14:17:41 +0100
Message-Id: <20231124-alvin-clk-si5351-no-pll-reset-v6-0-69b82311cb90@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHWiYGUC/4XPwW7CMAwG4FdBOWNkJ3FbOPEeaIeQJiMiSkvCo
 k2o777ApglpB46/JX+/fRPF5eCK2K1uIrsaSphSC916JezJpHcHYWxZSJSKkDSYWEMCG89QAis
 mSBPMMUJ2xV3BWW8smo4ZrWjGnJ0Pnw//8NbyKZTrlL8edZXu018ZByJSUm94kLxloJ+i/XzJZ
 TOexX256qeFl6dUDQhGcdej1Ij9uD+2f2CKH7649GfykynxlcnN9GjpaFj1fhj+m8uyfAP54jg
 xVQEAAA==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series intends to address a problem I had when using the Si5351A as
a runtime adjustable audio bit clock. The basic issue is that the driver
in its current form unconditionally resets the PLL whenever adjusting
its rate. But this reset causes an unwanted ~1.4 ms LOW signal glitch in
the clock output.

As a remedy, a new property is added to control the reset behaviour of
the PLLs more precisely. In the process I also converted the bindings to
YAML.

Changes:

v5 -> v6: 
- collect Rob's Reviewed-bys
- no further changes, resend only

v4 -> v5:
- address Rob's comments:
    - min/maxItems on top-level clocks:
    - remove unnecessary else:
    - remove spurious |

v3 -> v4:

- remove spurious | per Rob's suggestion
- simplify conditional clocks/clock-names per Rob's suggestion
- remove mention of clkout[0-7] still being admissible in the commit
  body of patch 1 - while the Linux driver still tolerates this, the
  new dt-bindings do not

v2 -> v3:

- address further comments from Rob:
  - drop unnecessary refs and minItems
  - simplify if conditions for chip variants
  - ignore his comment about dropping '|', as line would be >80 columns
  - move additionalProperties: false close to type: object
  - define clocks/clock-names at top-level
- drop patch to dove-cubox dts per Krzysztof's comment - will send
  separately
- collect Sebastian's Acked-by

v1 -> v2:

- address Rob's comments on the two dt-bindings patches
- new patch to correct the clock node names in the only upstream device
  tree using si5351

---
Alvin Šipraga (3):
      dt-bindings: clock: si5351: convert to yaml
      dt-bindings: clock: si5351: add PLL reset mode property
      clk: si5351: allow PLLs to be adjusted without reset

 .../devicetree/bindings/clock/silabs,si5351.txt    | 126 ----------
 .../devicetree/bindings/clock/silabs,si5351.yaml   | 265 +++++++++++++++++++++
 drivers/clk/clk-si5351.c                           |  47 +++-
 include/linux/platform_data/si5351.h               |   2 +
 4 files changed, 311 insertions(+), 129 deletions(-)
---
base-commit: f6abdcb2444f6ebe06e19cd9eee767c7c46612ae
change-id: 20231014-alvin-clk-si5351-no-pll-reset-ecfac0a6550c

