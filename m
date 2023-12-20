Return-Path: <linux-kernel+bounces-7663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264681AB63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E6B1C233F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC254E1D4;
	Wed, 20 Dec 2023 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UNa404fI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293134D585
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7b3708b3eacso8400339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116517; x=1703721317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqwPaQqmenUw9eRcinVgTHm+ZDOG0CHY3aysuEWfhMk=;
        b=UNa404fIZzDDmWKdork9ZDgJDqQTFPke4qm1NHcs+1ya96f2EeSE5qngsLKy1/pvQs
         E9MarPSrXP4GFc92aPf4MUE5VjUXJuj348EnqGhiWhZZIYWvF9nSqR2HlX3HdR7Qo5QZ
         NaLK8HQmzxq1IQW9IfemCVxbOXZbCE8yenykY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116517; x=1703721317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqwPaQqmenUw9eRcinVgTHm+ZDOG0CHY3aysuEWfhMk=;
        b=khijlnJR4Nc65S0A2E7fLOGxRrupmEgdNDrG0Vmvi4o2p3PjyxJ4+4mwhqloRIhKHR
         eyCTCpRkjRAbPSkD+IdhRdfwdAkPYDofczDd9LLbRAG6UVLZm8LeX2HiP2EVVCxyF4wS
         xTsL2OMSVmh62Zt/BB3udbMsvCT/5fyagxsmhBIne+hVVeqx5Od+L0MsQN72dEef081h
         ij3SbS0UwJMgFN0dBHdxj+aT2Yq8hOCwEJlXT2w/ddiH5AzY0PN1mg+eSzMYzXdsK5xp
         FjFsUHcE7z0R9yrlnHIERbmceTSh0Ik4u+wOiWs5i5xuX4yWpYDNVGpwOU7wTPEtGDOA
         PgQw==
X-Gm-Message-State: AOJu0YzLDm3BORG/FmwXnJi1BrGKN7ZEEFKRJ1FrSjr1wOQ7+s+OVc43
	++G0Xi/1mS+ofDHQYZOt/KhqVbMjj6/kPg8MJfo=
X-Google-Smtp-Source: AGHT+IGMe/Z9RFCpmHfT3jd1XYj7esK25Q3besGk8XDKQEr5sJIDR1GLwrxSPfaU1Eltl1MnNPIZww==
X-Received: by 2002:a5d:8c83:0:b0:7b7:fe6c:e6d3 with SMTP id g3-20020a5d8c83000000b007b7fe6ce6d3mr2659120ion.2.1703116517315;
        Wed, 20 Dec 2023 15:55:17 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:17 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 10/22] arm64: dts: mediatek: mt8192: Enable cros-ec-spi as wake source
Date: Wed, 20 Dec 2023 16:54:24 -0700
Message-ID: <20231220165423.v2.10.Ibd330d26a00f5e219a7e448452769124833a9762@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220235459.2965548-1-markhas@chromium.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec driver currently assumes that cros-ec-spi compatible device
nodes are a wakeup-source even though the wakeup-source property is not
defined.

Add the wakeup-source property to all cros-ec-spi compatible device
nodes to match expected behavior.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-Split by arch/soc

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index f2281250ac35d..ab44d382f757e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1332,6 +1332,7 @@ cros_ec: ec@0 {
 		spi-max-frequency = <3000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cros_ec_int>;
+		wakeup-source;
 
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.43.0.472.g3155946c3a-goog


