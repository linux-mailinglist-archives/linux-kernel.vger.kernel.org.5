Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38D9754962
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjGOOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGOOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:37:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A451FD4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:37:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f954d7309fso3596862e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689431840; x=1692023840;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEcQ/D91F2eoE0NLtVpOV/Qh8CoDBNXvds7PdOyG4r0=;
        b=r85unhBYz7KPyAQG8So/p2MeQyCwbBiZ6nk6oV6pi3B+2+9dt95XdqL65vcTMEDlc2
         UkufQKiJVLo6lrO1Uk8z9y7MDiEIfe7iNxgwgGmeKM96Rg/VQrkEL/IJfhb7BJL6nT+o
         JeDE7cl3iBv716eICMp8QGCYUKaNJAbAnO8i1mlkLFxKqQYJz6sqgNb8xFhThp7o6nR8
         j/fZ2DTvchZ3RC2xMJPvnhT5D+7FJtzsvAhuHpEv6IR4KbjukO/rHrZr0pGbjjsic8Uw
         d45HiWmAyeD1rZ324wYjm0WSGNgvDfx+N/OrAjBlwU/pZIVAvHzLpgvy+W9Dkqz/e9LY
         q0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689431840; x=1692023840;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEcQ/D91F2eoE0NLtVpOV/Qh8CoDBNXvds7PdOyG4r0=;
        b=bSMV0lLWT51TwyWzU4TGUrQUkR58QFyjX3UywRanMiZaYbWyKeVC3xwwCr2Gq77VYh
         tNgdREDF/zKT/LOqzwpbpmITVOeoWwUmuatn+rb21QjSMCDdYpnvt2PocrqgMdhT8Npe
         o1xXpTq9enDmulJ/h3xwmi8b6t9H99o9BOOwnA1rlkreL4WQljsEQWEsHLEgEWlLoL/U
         FLbFCslj5Qmcizw7fhLpJKLoG+PMXDYPUWscPpFFLNklbtMROKUb9ZF/Hswp/Y7sx/bh
         4l7hkVwoOnB8sRol8KEX9ZV0LHfSimK2BYkoK5kux6pXemqhUTuHj/Y4POWTql3270tO
         n4Jw==
X-Gm-Message-State: ABy/qLYLkq/HIGfqZqqOPMDl1A4pqF7HRjcq3xdjjP7FkhKxLjFVHwUW
        5Xwo4ez1VqlyCuy0vcTw+/VNzLUhBkpMQScvqbOtmA==
X-Google-Smtp-Source: APBJJlH2ZYi2LyhINX8AZmbE/E6LkvR5o50DGgbwXlxuaefMlYTi1FC5ne/EODOjwFSEfDwB1lvPIA==
X-Received: by 2002:a05:6512:3ee:b0:4fd:b7d4:70ec with SMTP id n14-20020a05651203ee00b004fdb7d470ecmr118222lfq.10.1689431839832;
        Sat, 15 Jul 2023 07:37:19 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2483b000000b004f858249932sm1927732lft.90.2023.07.15.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 07:37:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] Resolve MPM register space situation
Date:   Sat, 15 Jul 2023 16:37:10 +0200
Message-Id: <20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABavsmQC/4WN0Q6CIBhGX8VxHQ1Bk7rqPVprgL/6bwIOjNWc7
 x56101dnm/7zllIhIAQyaVYSICEEb3LIA4FMYNyPVBsMxPOuGCCSzr7CQ21sQ/KPuxkqTlJqUF
 ow88VyTetIlAdlDNDPrrnOOZxCtDha+/c7pkHjLMP7z2bym39UUglZbTUjZSq7molxHVEp4I/+
 tCTzZb4PwPPBuCVqiTUTcfaL8O6rh9W4TQxCAEAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689431838; l=2027;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HY4bja96z3HZK1pydbJM0rSpcC7fy2yGgK79IMSfsXc=;
 b=I5HQQyjFCoBt+fL13S3iDwYZxgitiRcPGqRZSP+r5mwRBGEBn73r/8ZH/6Peh7i6E/JlH0N5s
 zEmu+y/cZM5BtDvoS5Dl78Zt9Ji0rfV6PDMjgavVupYjMFafSjR3F9m
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Fix the example
- Pick up tags
- remove the outdated example from the cover letter, check bindings
  should you want to see one

The bindings for the wrapper node used in the yaml example are merged
in qcom/for-next

Link to v2: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org

v1 -> v2:
- deprecate 'reg', make qcom,rpm-msg-ram required [1/2]
- Use devm_ioremap() [2/2]

Link to v1: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org

Depends on resolution of https://github.com/devicetree-org/dt-schema/issues/104

The MPM (and some other things, irrelevant to this patchset) resides
(as far as the ARM cores are concerned, anyway) in a MMIO-mapped region
that's a portion of the RPM (low-power management core)'s RAM, known
as the RPM Message RAM. Representing this relation in the Device Tree
creates some challenges, as one would either have to treat a memory
region as a bus, map nodes in a way such that their reg-s would be
overlapping, or supply the nodes with a slice of that region.

This series implements the third option, by adding a qcom,rpm-msg-ram
property, which has been used for some drivers poking into this region
before. Bindings ABI compatibility is preserved through keeping the
"normal" (a.k.a read the reg property and map that region) way of
passing the register space.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: interrupt-controller: mpm: Pass MSG RAM slice through phandle
      irqchip: irq-qcom-mpm: Support passing a slice of SRAM as reg space

 .../bindings/interrupt-controller/qcom,mpm.yaml    | 44 +++++++++++++---------
 drivers/irqchip/irq-qcom-mpm.c                     | 21 +++++++++--
 2 files changed, 45 insertions(+), 20 deletions(-)
---
base-commit: 7c2878be573282a9961c359b806ccf70afe1a6b6
change-id: 20230328-topic-msgram_mpm-c688be3bc294

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

