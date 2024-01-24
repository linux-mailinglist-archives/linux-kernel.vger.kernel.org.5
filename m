Return-Path: <linux-kernel+bounces-37101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619083AB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E495F283192
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF057A724;
	Wed, 24 Jan 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4W1/8eK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDC7A70E;
	Wed, 24 Jan 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106072; cv=none; b=eq+48fGgdph8aiM8UCKMKv/Mp/cbQMkEtD+CGsD30B9gZXERLye/UEtnoUWOyhU1Um5KwWLYFktqvsj3kRJa1X6i3J+p8xBkSIK5KGR31TkNad9f9mORKkp4D1FKaMqRmIN6DBLNt2KMXHnT8OzLeEy3Bg8mlQOmlvFzs749pAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106072; c=relaxed/simple;
	bh=UslCulOJ4hP1Tj0nrRmZ2+wbi2W8i3qotKFb2uburGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7WJJEHqgQOxFYcsRB7s1/XoUn/lDbwas8U80yLavGlOpkVVDkSoUeVOZIkkXcPGt2sVOMU+XEpEqrjOFxxKr8XXM27JnN4NwAqu9SdMYpF0zdlI3gYF+EO/sA0do9rUYIUj7jSnLVmvkw+xfLtG5CCEPp+J6EhyIu2223ZMBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4W1/8eK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d750660a0aso17160495ad.0;
        Wed, 24 Jan 2024 06:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706106070; x=1706710870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkM7C9VM6ZU2FxPGHAohF+g/nyjtbEK3pFaS9kpNcFU=;
        b=d4W1/8eKg4px+YehuFC9nz4GY6OI7IzmB79hKUx74ivKzWAsMXn0/Fsrtv4KOHR5WH
         /IHIiithkObEf10YEqJ0/KKP7D1UexZ+XnrtIHixJEgew9huj174mwgXv//+I75SHkSv
         QVaOB5hyBq1CfzRA3dXdWXU0N4QrRlSLqJyGxvD/5pRI4szGj2LvOThjGQYkbebfmexO
         ZJ16MRom/YbKuuJ95l3zNJCNA7sf3o+tguTj6Xf+RAT+5TpigdqhB/C5yeGlYjNJfeDt
         s2v+4AlS19jWOJ/xXptTfpQ1Jhf3nLcKU0keTmjA/2eXBMg0St1ZMdbabEKYT698Egm4
         mVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106070; x=1706710870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkM7C9VM6ZU2FxPGHAohF+g/nyjtbEK3pFaS9kpNcFU=;
        b=KUIYfmk/Pbsj/wyK8QIe3O6yIFHE3clAy8AGQ8WCsL4V4njfsTuZdZ6AhStbzE2fmn
         T4suhHbMLOWCS72RlZCGqhrvsvysODEmnh5aqSu1x8ZRnrjWLIbIUWdRdo0xg0ConEmR
         /5p87hfX/z+9q2sG+1Zuc3wOnOll/xa+yjTiBHgQRRoGQoSS9Em1DiNSaEH2c5YtbP4D
         MUFw3D0LdF4LnAkSGrybiLWcqR1ncG8D6ebxOq/kFHeDsNr9VL8j47o6+CBQiXQXfv6P
         GNThPrmc6I9lCZLexnZiZCQQdod7qz7PqL1k3c2m6/EAunHe3Xr8GB2lHDd1tsVCCKBq
         +qfg==
X-Gm-Message-State: AOJu0Yw3RNXkeusJKMIo73S/8HTmIyIGwYeTDgexu07dpO7gA/LY3M2q
	gf5wYwZCT9zr8Xv10IIcjqvgjStxmAGLFDN9XmS6KWlPJWWJLk3b
X-Google-Smtp-Source: AGHT+IF40Uft6qdKvHYCwchjPCpWLMrA/WX9D91nJJwLr/P8AKj7oyRiZsst11c/Y341gKFa9sTVhA==
X-Received: by 2002:a17:902:7b90:b0:1d5:4c3b:2aab with SMTP id w16-20020a1709027b9000b001d54c3b2aabmr754138pll.114.1706106069910;
        Wed, 24 Jan 2024 06:21:09 -0800 (PST)
Received: from hdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00234200b006ddb77d443asm634848pfj.209.2024.01.24.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:21:09 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2 0/2] nxp: imx: Add support for Apalis Evaluation Board v1.2
Date: Wed, 24 Jan 2024 11:13:18 -0300
Message-ID: <20240124141849.26254-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series introduces support for the new Apalis Evaluation Board
v1.2. With the introduction of v1.2, a common dtsi file, containing
shared configurations for both apalis-eval.dts and apalis-eval-v1.2.dts,
has been created. The eval and eval-v1.2 dts files will now capture the
differences between these two boards. Additionally, updates have been
made to nxp/imx/Makefile and arm/fsl.yaml to accommodate these changes.

v1:
  - https://lore.kernel.org/all/20240122123526.43400-1-hiagofranco@gmail.com/

v2:
  - Add missing off-on-delay-us property with 100ms to reg_3v3_mmc and
  reg_3v3_sd.
  - Fix startup-delay-us property from 100us (reg_3v3_mmc and reg_3v3_sd)
  and 1ms (reg_can1 and reg_can2) to 10ms.
  - Fix pinctrl mux from 0xb000 to 0x1b0b0.
  - Add Acked-by: Conor Dooley.
  - Add Reviewed-by: Francesco Dolcini.

Hiago De Franco (2):
  dt-bindings: arm: fsl: Add toradex,apalis_imx6q-eval-v1.2 board
  arm: dts: nxp: imx: Add support for Apalis Evaluation Board v1.2

 .../devicetree/bindings/arm/fsl.yaml          |   3 +-
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 .../dts/nxp/imx/imx6q-apalis-eval-v1.2.dts    | 200 ++++++++++++++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dts    | 108 +---------
 .../boot/dts/nxp/imx/imx6q-apalis-eval.dtsi   | 120 +++++++++++
 5 files changed, 325 insertions(+), 107 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval.dtsi

-- 
2.43.0


