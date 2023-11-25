Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391617F8BA0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKYO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjKYO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:27:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E012D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:27:14 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f6efd64so3754438e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700922433; x=1701527233; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TguBUi5Cv47sLDgv6IijCaTHXjaPM3GN6pJ0DMkyP2M=;
        b=hOET8Ysz+J2bh+zQ38mfk+6rtFdTOr1MVRxhXJAx/HnXaR1W0XbpspBhRjvjuKDxmB
         Z2zKE8RIUYxCx5odoOvV5hOFIMgQHcPjgZkcbpfnPkODK/mnGgaNjdngilFbG5Xk6waz
         buc1TfjwizuKMYfr7R3dK1vo4gXiH40OU4igF+JJKUkNVJHEbEjYom2uMESeVBQe+kQn
         JEbJzYXpb/Ygx9UapmU89aL2pv+018D3aPtyOkp6nmVwH5obnYJMyu0Gd/om8binrgIa
         nPaXgXmzgyIQLG08glB/JojVvFGSe7EhCVOJJjox1fpxrV4m3jPpXPDn4So8iEWh7kJy
         X18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700922433; x=1701527233;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TguBUi5Cv47sLDgv6IijCaTHXjaPM3GN6pJ0DMkyP2M=;
        b=PnwB/yA/SREoa7bg+AA4GNPU6H39UVXLZgWYf2ExiV3MJutP0dMjBmZLMyCXb28Tok
         0T1eO94DPoVL+ij6Jib+jXrqdZO0yn5BOE3LHV2thVuD4Z0vBPNWgS0pF+az6ZEQrSGd
         sfN5UmSaESqSWhBD+a7TWV0W+ISxacKBcrQ1Bumr/QoqM39KObe2vv4zw6ntBIgHDCOL
         0geGtE/z1xXPf18Mfe2B4SSf8dg5fdxY0fGKwSWksdUh2wNeG9B9bIcM62rzyU4T/K1E
         Zo3/NWGZChyhwsJuyAl1j3WPMfWa+gpQLCewW/Q+ULqBXoP8sALvytTUcS/oVZZXoy+L
         PH8g==
X-Gm-Message-State: AOJu0Yx7BOeADq4y7/0Azqaupp/uy3klKiqxHpc6tUyp2gzv1FRuzmS4
        oKi7eknUboh6symlX8iXxITDFA==
X-Google-Smtp-Source: AGHT+IG24FMZbwNzPlXNLZq1ENi29ARHXnPm18UZOZOPB0wKsMugvDHYPpWH+wnm3W3LP5CkYxWabA==
X-Received: by 2002:a19:ac4d:0:b0:507:b935:9f60 with SMTP id r13-20020a19ac4d000000b00507b9359f60mr4330140lfc.57.1700922433094;
        Sat, 25 Nov 2023 06:27:13 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id cb8-20020a170906a44800b009fd4583851esm3569253ejb.178.2023.11.25.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:27:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 0/2] Resolve MPM register space situation
Date:   Sat, 25 Nov 2023 15:27:02 +0100
Message-Id: <20230328-topic-msgram_mpm-v6-0-682e4855b7e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADYEYmUC/4XQS2rEMBAE0KsMWkdBbn09q9wjhCDJLVvgH9LEJ
 Ay+e3pmFwzxsgr6FfSdVSwZK7te7qzglmteZgrm5cLi4Oceee4oMxAghQTHb8uaI59qX/z0Oa0
 Tj8a5gDJEaBWjs+Ar8lD8HAc6nL/Gkcq1YMrfz533D8pDrrel/Dxnt+bR/rOwNVzwJljnvE7aS
 /k25tmX5XUpPXtoG5wJQAKC8sqhtkl0B0GeCZIEiBYS2KCsMAdBnQmKhOBROuiiSC0cBH0maBI
 MCgP0itYE/UfY9/0XObyPGs4BAAA=
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700922431; l=2638;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0I8R25SRzKeRrQMqe0fAK3J+H2k5tsTdUqt2Uq5RJHU=;
 b=QFsXLnXIMN1IoCnqikWluUY14tvflsxnkWb8phLjcUqBiUXspGAGLvVysCH0QESP7XLOpVo1G
 4esWS6EyJL3CY2k1JE0MutJFaTtBVd/VbKDAXI5WzsUNV6Kx8r2qlXt
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 -> v6:
- Resending due to no responses.
- Change of base to next-20231124 (no changes to the patch)

Link to v5: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v5-0-6e06278896b5@linaro.org

v4 -> v5:
- Pick up tags
- Rebase on Rob's of_ header untanglement

Link to v4: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org

v3 -> v4:
- Fix up indentation in the bindings patch
- Add an example glink-edge subnode to remoteproc-rpm (its bindings
  require that..)

Link to v3: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org

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

 .../bindings/interrupt-controller/qcom,mpm.yaml    | 52 +++++++++++++++-------
 drivers/irqchip/irq-qcom-mpm.c                     | 21 +++++++--
 2 files changed, 53 insertions(+), 20 deletions(-)
---
base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
change-id: 20230328-topic-msgram_mpm-c688be3bc294

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

