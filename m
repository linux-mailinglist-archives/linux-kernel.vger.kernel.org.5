Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DB7B092A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjI0PqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjI0PqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8F3272B4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:46:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso83049865e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695829567; x=1696434367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSqf2S54Kv1lkMAHr+0KP81a4E6zfxwF+MNET+Rax3c=;
        b=IWl0QOCkM8lrXZ1jZzlyBzdXx2OF+33inXwOXs20l/kx+WXdtxI2INUhTRH7As/Hv6
         jYVkN/P62rapmmjgO8vFeqG3OnDo8xbCFO7hs6l1IcUlJ3g9psphfmUoo3hSJP6z8v8j
         ecSgoo4QjokjceebU2tCxvqnrqDFnXGFNfwlETnc4NeF+U9BLDQDg3WHbiupdo5w47p9
         W2TnvxvmEctIMpKVPdeRpzG1hNBexBo1yPL6B1ywYyPUDpsUR29vUdURxE4rSvB63q76
         y+cjlBAlwk93qOQwVsImwaUJjcOkB4ZQ393W6jHvgKAjZD3RqplOTiAgvQOp/+/aFl1m
         jRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829567; x=1696434367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSqf2S54Kv1lkMAHr+0KP81a4E6zfxwF+MNET+Rax3c=;
        b=n1ckyPvSOeCtXLdVBlqekuj1HX7eqTiF8z7JcXDJJbL38kAEnd2+aAFsU+gxoc2M5w
         9HLKRS0uWuuoY2mOlkG7CGnMM0vXJlG60hMrBQISOdTx0bDfoa4zWl1TM/k3gf9ZvJk/
         DEjWMV2p+kFai592xuH/JCtgedhtNKjVz3U77TukyulBClQ4Vouo0aQ8DftEkmMatkns
         mn9/cZhR7JlL9UlsaVhR4yCycvTVEZql4l8FuqdpmSghF0tvu2hyM6Qobg0mrdNsEqzv
         kybwpgTTi+XSvnSMJiQgtrqIX0UTod4mDkzWpRdhBQOnky3KYX9KSnBo0Ay7ZhsC5wvu
         u1kA==
X-Gm-Message-State: AOJu0YwQ60TdXIk3P4olpVPBwUj7xEKQJIXSOLT3VK/nmZCxpV888Y01
        j777T3KN5dVRdvgEs4UCVwjw
X-Google-Smtp-Source: AGHT+IGO1bx0oPXzCkNmPkew0sz+yNY9AldZkArrIHA5dVTPBnO/w6Qh1wcNpIsNRipkFsrEl7at+g==
X-Received: by 2002:a05:600c:1e14:b0:406:44e6:15f0 with SMTP id ay20-20020a05600c1e1400b0040644e615f0mr1832590wmb.5.1695829567489;
        Wed, 27 Sep 2023 08:46:07 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id s28-20020adfa29c000000b003232f167df5sm6925852wra.108.2023.09.27.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:46:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v3 3/3] PCI: tegra194: Use Mbps_to_icc() macro for setting icc speed
Date:   Wed, 27 Sep 2023 17:46:03 +0200
Message-Id: <20230927154603.172049-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927154603.172049-1-manivannan.sadhasivam@linaro.org>
References: <20230927154603.172049-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe speed returned by the PCIE_SPEED2MBS_ENC() macro is in Mbps. So
instead of converting it to MBps explicitly and using the MBps_to_icc()
macro, let's use the Mbps_to_icc() macro to pass the value directly.

Cc: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v3:

- New patch

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4bba31502ce1..5feac690e127 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -321,9 +321,9 @@ static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
 
-	val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
+	val = width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]);
 
-	if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
+	if (icc_set_bw(pcie->icc_path, Mbps_to_icc(val), 0))
 		dev_err(pcie->dev, "can't set bw[%u]\n", val);
 
 	if (speed >= ARRAY_SIZE(pcie_gen_freq))
-- 
2.25.1

