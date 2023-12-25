Return-Path: <linux-kernel+bounces-11179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F381E291
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9078528166D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D853E2E;
	Mon, 25 Dec 2023 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHvkKei0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007F53E22;
	Mon, 25 Dec 2023 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7811c16ce6cso356297285a.1;
        Mon, 25 Dec 2023 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703543351; x=1704148151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itzMXVoCv9j1w1f/Q7ZRq3fNWiDaf3bJqeVynZuN8k0=;
        b=XHvkKei0PREzhbq7DpXouhhyAtC+s3Q7MxK4Wf+jcraPKwwCBqivFs/uMaUlcU9KjS
         XEt7osoaOan8uLFE3m8LBa8PMDGzmXZjdLE13Fe5OpVFRQJcvh4ncEaI7duLEtxzIVnt
         uNLNmwwBBVeigAwc3a2/AQ/Uc0nnMKT0fv9Kmlmv+SuEtgcdR2EHJd2LvHGgloiJ3PuM
         MJgPo/pSxsa+zE65Jd2/z6jexU+EKQq5ZRVOA1TevUlKJ4GddS8j6vUYP3ku8UaKlksE
         NyHvv3O8EMOO8WsXwDPAoBGBsIzDXpsL5+RGcUVAlQ73S2krmxMIFHNv02FiEf6ZDfBZ
         EmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703543351; x=1704148151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itzMXVoCv9j1w1f/Q7ZRq3fNWiDaf3bJqeVynZuN8k0=;
        b=qXnY83isXsHsewjg1RTKwCZtXSZAdzy8F/D4YPv0cFBO8f05zK0xrmVCaJrkduXOrB
         WvGznV6y1qzz49GCF98XGIih26hFBTPH6g5pR99V4IRFg+S0LV4jkcOpRK7pVt/DVIXa
         qaHbnfVu6ve5LodRuk52+qGz6pNwM0KWEmlyfv7bUsQm4KNZrBWuS0uKXycls9lH/qg7
         ui1Jt3l/OzQNDo2Dk4lOxz7e7ReQUZY1CpDlc1WNd/+qB3gcelX2UCkMv2BjiyHSXzbM
         x+kvFyc20j6p8l4jvC3chbyEp+EzLw6yWwvIJu63wZtLGzy19omlfDFMriIZ+gDd2SDH
         VyGQ==
X-Gm-Message-State: AOJu0YwVL6GQ9FyIxBAyDjwIKKWFX+O3/5V7HDR2sX7aNZkyhXAMGP6z
	V3hFpsCpTkEZwxUnvL3Z1Ss=
X-Google-Smtp-Source: AGHT+IGvKTDnv4qt19H/Be8Gp8HiEl1PFhupgr9g58mx26sTM4Yh8MT9jWUTm9h4TJYyCuwevjjuCg==
X-Received: by 2002:a05:620a:2942:b0:780:dde2:deff with SMTP id n2-20020a05620a294200b00780dde2deffmr9946891qkp.98.1703543350774;
        Mon, 25 Dec 2023 14:29:10 -0800 (PST)
Received: from localhost.localdomain (107-015-241-140.res.spectrum.com. [107.15.241.140])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05620a178800b0077f15eb3528sm3881457qkb.70.2023.12.25.14.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 14:29:10 -0800 (PST)
From: John Clark <inindev@gmail.com>
To: "Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Heiko Stuebner" <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: "Thomas McKahan" <tmckahan@singleboardsolutions.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Clark <inindev@gmail.com>
Subject: [PATCH v2 1/2] arm64: dts: rockchip: support poweroff on the rock-5b
Date: Mon, 25 Dec 2023 22:28:19 +0000
Message-ID: <20231225222859.17153-1-inindev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the rock-5b to poweroff its pmic. When issuing a "shutdown -h now"
on the rock-5b it reboots instead. Defining 'system-power-controller'
allows the rk806 to power down.

Commit c699fbfdfd54 ("arm64: dts: rockchip: Support poweroff on
NanoPC-T6") similarly resolves this issue for the nanopc-t6.

Signed-off-by: John Clark <inindev@gmail.com>
---
Changes since v1:
 - added commit message with additional patch detail
 - expressed the related commit using checkpatch

---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 74719aaf697c..dc7b88f29172 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -426,6 +426,8 @@ pmic@0 {
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 
+		system-power-controller;
+
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
 		vcc3-supply = <&vcc5v0_sys>;
-- 
2.43.0


