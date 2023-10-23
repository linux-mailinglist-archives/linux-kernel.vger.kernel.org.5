Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F057D2F95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjJWKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:22:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6C188
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083f613275so25756915e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698056569; x=1698661369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUnnGAdmDfMipB0/9liPZMIOUoXhP0zAlTuz0GroIGc=;
        b=jFNeP0L5vwS/zBrTIHKxpjJ3G6aUx5EonbyLaKnNV2zF3CVXCZKZhjmf5w4YyVn0H3
         XTb89EUSTzW55RP7OncMgXrgwI4R3cEQtnR/tA7c+98BX60W8kLhyVqSb5CN5XXyUoUv
         gxpn7kvcH+k4yOlC4mq+rAfmN50jDQ4YqD1oAS9x70aXKASqSPB3y3HpfgVAxTi3wc/l
         XdQkQ4O/JPias7dY4y5E4XwjzJDjZBSFZq5n82gNRbtJUM4ghpOoom+Wpu8VrGr+bs0p
         EVgBn2oAOho+dvU137wejGGlV0bGxCgqdo50iURrb/Du7WUc5gLM8x5S+P+Ucmsh2aUX
         oBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056569; x=1698661369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUnnGAdmDfMipB0/9liPZMIOUoXhP0zAlTuz0GroIGc=;
        b=NS2yl6GGIKhUMaHyVspGd1XlMgtr91MlFUAuN3iJLkz4Pm74q0jNSGCbrSMVOi9mEB
         yb80vPSi4zfVPBhstqaRbxtOpKIFkboJjftsVh3sh+un+PYn1OO4awpRWfy41RQJg5rL
         u0EbyL5bFJkNubUUd+JiQGM5ob+8QYUuNrJSp+qXO18SMZZ6LuapSYSRd5/AtG0DvVoU
         dS6zLbDxrgoxZKURfMeJyBU11B3fzY5CznKYHZhvttdLQ8U8nh4NSF9KGj0ZD/7zRINI
         fhTIesjL+99psWILJpJSbtZ6fhdektuST4gqeVfq5Q81ik2zjZxhjMJ+WG78U38zdeen
         MIig==
X-Gm-Message-State: AOJu0YxkctNi6/dJFTisSypLQhEJgJNBLWd9JCzxjjIzbAHGFB4ZEjOp
        klTu4r33dHMqu3JS/s/Cju5ZMg==
X-Google-Smtp-Source: AGHT+IFqYO5bI+Kdl0SkjyRuSYnohDay+J2f9QzfY0pKi3Y493KGEjzuhSot3Dc88fVZ0pL4mUkG7w==
X-Received: by 2002:a05:600c:3d87:b0:3fe:1232:93fa with SMTP id bi7-20020a05600c3d8700b003fe123293famr6882340wmb.22.1698056569060;
        Mon, 23 Oct 2023 03:22:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm13593275wmf.5.2023.10.23.03.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:22:48 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/7] irqchip/renesas-rzg2l: add support for RZ/G3S SoC
Date:   Mon, 23 Oct 2023 13:22:16 +0300
Message-Id: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds support for IA55 available on RZ/G3S SoC.
Patches are split as follows:
- 1/7 updates documentation
- 2/7 adds IA55 clock
- 3/7 minor cleanup on the way TITSR fields are populated
- 4/7 implement restriction described in HW manual for ISCR register
- 5/7 adds support for suspend to RAM
- 6/7 minor cleanup that replaces spaces with tabs on macro definition
- 7/7 adds IA55 device tree node

Thank you,
Claudiu Beznea

Claudiu Beznea (7):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: document RZ/G3S
  clk: renesas: r9a08g045: add IA55 pclk and its reset
  irqchip/renesas-rzg2l: add macros to retrieve TITSR index and
    associated selector
  irqchip/renesas-rzg2l: implement restriction when writing ISCR
    register
  irqchip/renesas-rzg2l: cache registers on suspend/resume
  irqchip/renesas-rzg2l: use tabs instead of spaces
  arm64: dts: renesas: r9108g045: add irqc

 .../renesas,rzg2l-irqc.yaml                   |   5 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  68 +++++++++++
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/irqchip/irq-renesas-rzg2l.c           | 111 ++++++++++++------
 4 files changed, 152 insertions(+), 35 deletions(-)

-- 
2.39.2

