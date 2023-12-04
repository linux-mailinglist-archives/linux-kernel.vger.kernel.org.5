Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48812802F89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbjLDKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:04:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C350EB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:05:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2868cf6cb82so573450a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684301; x=1702289101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xkx8GPy75vBaCmP/j4n1w8WqhmCSi5wgUaX+mZWFcU=;
        b=rf6oofieja6IQOugaPykxri95Q2+2SIAXU7lwCrqVEM7pe9EJh7sCnWMEeQrFzjfuh
         W0cahPjoRE6zaLTDc5kMTFPzzJtSQ4eggEN17FjQFBOkn40Xi6Hy67jyVYTJdbWkmIpg
         yVkXNuXvgKGq5VjAT3s3OzMk9khGSn5i5auSAMbZFWbwuTwn9sp/rb3rIQcOWl4gh2EH
         +ccR+FWWMs7SMhFPFxw1jqaNRVMLgLlekb0N0EdpxWwgxbRXwJDfK1FXzcdjyHT9e7nn
         +1Gqp2Uvw/SxCgZtfTjCUdfTzvKHh4I76w1qf8PBepNPUIxejNQscCIs/UQkOCJ+D9Qr
         Gm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684301; x=1702289101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xkx8GPy75vBaCmP/j4n1w8WqhmCSi5wgUaX+mZWFcU=;
        b=t/jQl0YHQzciCot2c4s2lEChN0shvuEu52i43UgDm7lEfIyafnCMQf0fudMqCbcGsL
         jRPLIcYrWqADkbGm8jlIMypbeC0kzPPceUO9S8qmjL4SvdQtD3NoHHh1j3O1NXCQm4xR
         ONdFhH3sPm2ZKPdOHzMTL1+PulyhwlaUWDaJ2jiZo4yXItw3VlO48Xzlqa7bhEpfxdMq
         zH5BKeVjvhiXbehsd+fLVypZFdI5d0MFNU0P0wVBEDoGYs37/O3WEC3rhk7IE4lMacos
         dEMuf4FtbO73VbdPpYF/amz5sWt68d6JPQbw+kZI3CTONpM87tTQXqiXgamoJ66els+o
         zRHg==
X-Gm-Message-State: AOJu0YwiMcwv8TxlsH3BIMXgPYoqeoJtas0byVsBlmccdM/yvZh2YjZy
        MuSqHKwfPJ+2XeXcdOZ0HtADig==
X-Google-Smtp-Source: AGHT+IFWjA1Wu6sP4nTlA0bzlqyA/wgugZnXrDujbsPlC316OOOabX0EUkapX+yc1X/bS0K0bKk9GA==
X-Received: by 2002:a17:90a:f408:b0:286:8dd6:db65 with SMTP id ch8-20020a17090af40800b002868dd6db65mr758714pjb.91.1701684301232;
        Mon, 04 Dec 2023 02:05:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001d0915435f8sm2335116plj.16.2023.12.04.02.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:05:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: defconfig: qcom: enable X1E80100 sound card
Date:   Mon,  4 Dec 2023 11:04:55 +0100
Message-Id: <20231204100455.212567-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sound machine driver for Qualcomm X1E80100 sound card, used
on several boards with X1E80100 (e.g. X1E80100 CRD).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The driver and bindings were posted here:
https://lore.kernel.org/alsa-devel/20231204100116.211898-1-krzysztof.kozlowski@linaro.org/T/#t

The DTS change will be coming soon.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e29d87008edf..d5be018cb348 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -925,6 +925,7 @@ CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_SM8250=m
 CONFIG_SND_SOC_SC7180=m
 CONFIG_SND_SOC_SC7280=m
+CONFIG_SND_SOC_X1E80100=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
-- 
2.34.1

