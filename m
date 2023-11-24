Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436EA7F75CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjKXN5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjKXN53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:57:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCA198D;
        Fri, 24 Nov 2023 05:57:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28041176e77so1512762a91.0;
        Fri, 24 Nov 2023 05:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700834256; x=1701439056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPgQmqgsB4VA8sM0/4BuwIbl5ukliYjBNcn9c+Qv2X8=;
        b=GcNs11VY79q4TQfVfLRmqplDvJ1U38amZVVE2b+ByC5xrbROg51pu9BL8dHIk9xLFp
         qFhqjzNQE7x63SefJUUJMVjNurm5wW1P6WfakFKx5OO3dv7DQP+WCW2SYEJ6fyTWx1g4
         xgYGdPvZgr1xwNn8cB73PGej0irwFZ8EP05MZnZKK0tVqbKTREL7lNoPGH0BOP+3CoyZ
         oRQvc/0eRs09LNkFCYngl6seXf0VirVQwVWvrwJ6Pl9tEv//yq7IyHMhHmJ+5b0mF85F
         kL2iyBgr0PcY7QI8wCWkXiCbmAc59dBd4AMcAFO+LKFOrrIc9HZGf8Dcl6HYweB0J/yV
         dMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834256; x=1701439056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPgQmqgsB4VA8sM0/4BuwIbl5ukliYjBNcn9c+Qv2X8=;
        b=GA+vjy4np3vaqPwzpOLfrOC3kR/k0jQSO37SqIgSSaDCSxTSNtB46UKPSWO4LDTblV
         ctx+5FVB8Tdz/54AuiM5l2+cACWIBdU28iQTSi+BRK7J/ehKRCWgMzFqB8Hk7JyO36sV
         7Y4o97cFgJy8gR2i+qdozVwfAhxzDAAyJsC8kfUWzmM6gSHLIuMp269bM9UMdCRBYFTo
         I0OMZUAlC/quimkHe3+uwFe8IRKZA1EpSwpMWhCyQYQKWfNgtLb55BPVBFBpTrIEoXtN
         zGpQpbYaAkACflA4CvHd5NtbaaNsRC9nLC306BqFYAOT5QZMNFMZDs+irkFP2Ff2/76i
         yJaA==
X-Gm-Message-State: AOJu0Yz3VwPlRAgwTJdG9EaFQ7/gaUqhpMtaOSPQMC8fhpda+FNQCDBU
        iAYVbhaFqbtjxV4v1BKS7GMyukyR+so=
X-Google-Smtp-Source: AGHT+IF1DR1aKTqIPsiab5wZPOO/ew65cdKB63CfMrIFsv8jDzM6kWwmqNq//44UE044H+FOQKy/Eg==
X-Received: by 2002:a17:90b:3005:b0:27d:3be:8e13 with SMTP id hg5-20020a17090b300500b0027d03be8e13mr2684534pjb.12.1700834255812;
        Fri, 24 Nov 2023 05:57:35 -0800 (PST)
Received: from localhost.localdomain ([192.166.114.90])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b001c3be750900sm3179417plg.163.2023.11.24.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:57:35 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8250-xiaomi-elish: Sort ufs node
Date:   Fri, 24 Nov 2023 21:57:12 +0800
Message-ID: <20231124135713.5610-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124135713.5610-1-lujianhua000@gmail.com>
References: <20231124135713.5610-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufs node isn't in a right place, 'f' is front of 's', so move it to
above usb node.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 3d4ea428e4cb..3de7cb918448 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -657,6 +657,22 @@ &tlmm {
 	gpio-reserved-ranges = <40 4>;
 };
 
+&ufs_mem_hc {
+	vcc-supply = <&vreg_l17a_3p0>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l6a_1p2>;
+	vccq-max-microamp = <800000>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vccq2-max-microamp = <800000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l5a_0p88>;
+	vdda-pll-supply = <&vreg_l9a_1p2>;
+	status = "okay";
+};
+
 &usb_1 {
 	/* USB 2.0 only */
 	qcom,select-utmi-as-pipe-clk;
@@ -678,22 +694,6 @@ &usb_1_hsphy {
 	status = "okay";
 };
 
-&ufs_mem_hc {
-	vcc-supply = <&vreg_l17a_3p0>;
-	vcc-max-microamp = <800000>;
-	vccq-supply = <&vreg_l6a_1p2>;
-	vccq-max-microamp = <800000>;
-	vccq2-supply = <&vreg_s4a_1p8>;
-	vccq2-max-microamp = <800000>;
-	status = "okay";
-};
-
-&ufs_mem_phy {
-	vdda-phy-supply = <&vreg_l5a_0p88>;
-	vdda-pll-supply = <&vreg_l9a_1p2>;
-	status = "okay";
-};
-
 &venus {
 	firmware-name = "qcom/sm8250/xiaomi/elish/venus.mbn";
 	status = "okay";
-- 
2.41.0

