Return-Path: <linux-kernel+bounces-150751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B38AA41D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404A91F21C49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464E190692;
	Thu, 18 Apr 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQzP2Gjv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D586D1C7;
	Thu, 18 Apr 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472692; cv=none; b=KFOWu2IyEKHH9GBOA25DS+N3LKKeLOR7OpDDVMMk30uxRBzxlcwz2zbHldjqN3nnKIv1HnTOAzxYF+kjlHXruwbk/8Ph48dHFXisughrL9/YC07agrmfPLIRlqTUmJ160HEvaFKqp4ZedEvfbHxaSQnuog7h9+XufuN66Cpq+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472692; c=relaxed/simple;
	bh=sKiv4SDu35oSMqZnfSXRLAkPw/aQxk9pkreC9OwjRh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W+d1mSdY4kYF7y3HXK0iVrw/+79CsvarMB12g6qDzOLs2i6gpNVSlgZKk37kdya8acwsC96QtSGtWZYFdj3OiCddfcpNfs+Th9Rt5s/fAoWJ5xgb5WUwYTCChTCDbvDHD3LsSg/mP0imK1WRIfwLCTRuOvsS58EkV0iFcjjfnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQzP2Gjv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d0c004b1so1760014e87.2;
        Thu, 18 Apr 2024 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713472689; x=1714077489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JF4x+kNM/mmae+ZYoHJR13wougtTUOzbFPCVrpt7xuQ=;
        b=WQzP2Gjvjws3y3w3Pv2uACEP+xv89bXfhNbpuaCYqXBoCot71SCTqtmnfgmN2ioRK8
         Ld2VEijORIdsnu10gG60gG5YNR5pmp24bQl9qgtjtd+4gVoIkTcKARSWRq4mv0c44W4V
         S8jFradTmigBPod1hwfpnAvFCcJy3W/8yJMybGTROsIxQWElbniC63pqYw2sMLkXWn9D
         2dEKAJpsEA2hbMJzpq7F3PNjXn2V3HXCTih+kOOtohhLGvTBbbKE4DVToVPwM+9A7xPT
         /z1ZhEqJ90lNTdB+07zhqmKwaAvpHSyt5nQeqk0uuppzLte+CGIQhLzPxw+ySAvld7LC
         zpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472689; x=1714077489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JF4x+kNM/mmae+ZYoHJR13wougtTUOzbFPCVrpt7xuQ=;
        b=cytii94OsPVy9mVDfVbdtY1qww3CABSe8gmsbLo1QzR/O4PTVAjW/8SF10yPBmvh0L
         JUH3+OjR3oZ3vMQckbP+obxDo3d/bjJSAj4RXLjIKRa1u4WCmkU4706DiSpZo19TyrKB
         AyvePeP1Nf9VOCZH3wfOPR8/UkytwtrqD4CAQdhfnB7wqfhORQM2fhhPG91JVTv2w5CW
         ZOaVD958zxYV73lJ7Of+HrCN0slBqXQ6Uh/kfF+OzFnCUS0SrLin7ircwWmmkg28qFhM
         uw95s5klcPb9BADgmxp0PldGbrPTeN7M+xkede6Iew/Zz+FxAVoamwVGon7c29JhOihW
         lp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1WZXMOJdZ5tLNt5TTc+dVnIx6TYQp+Ly0vMlSjZXn4lwOmasb3bWcF110Ngm4QbB0ZdcMkuS46w4HjDMti1Gb0Do9lNvqG3kRkJK/6BXBDlDJvWvY470/PR7vAXMoa28MnGO5W7Vd4w==
X-Gm-Message-State: AOJu0Yzz1C0snFowppt3VXVcrlIt+eZRe4jq8PBbocZfuxdNcoHaC5Q3
	N/2Em8E5z5MggYRIVmMSvqvHm2yCA+UIXbh2f+mpyeYQXk7MldM6
X-Google-Smtp-Source: AGHT+IEQdvifaiqzhQgGeM5KMZbCp8qQgxPJ+Bl+TS4jV006wTpcy9/73atGZ2nqI696XMF1UUWulA==
X-Received: by 2002:a05:6512:2111:b0:513:9e44:c68c with SMTP id q17-20020a056512211100b005139e44c68cmr105129lfr.6.1713472688803;
        Thu, 18 Apr 2024 13:38:08 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906079500b00a473774b027sm1305649ejc.207.2024.04.18.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:38:08 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>
Cc: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Add DSP node for imx8ulp
Date: Thu, 18 Apr 2024 23:37:17 +0300
Message-Id: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add devicetree node for imx8ulp's DSP core. Also,
update the schema for the DSP node to accomodate
the clocks used by it and add a new schema for its
syscon type node dependency.

Laurentiu Mihalcea (3):
  dt-bindings: dsp: support imx8ulp dsp clocks
  dt-bindings: mfd: add schema for 8ulp AVD-SIM
  arm64: dts: imx8ulp: add DSP node

 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 51 ++++++++++++++-----
 .../bindings/mfd/fsl,imx8ulp-avd-sim.yaml     | 42 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 39 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 22 ++++++++
 4 files changed, 142 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml

-- 
2.34.1


