Return-Path: <linux-kernel+bounces-133312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159589A218
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948D81F221A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0B171078;
	Fri,  5 Apr 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXMekkAP"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272F16EC0B;
	Fri,  5 Apr 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333257; cv=none; b=DjkF5kK5vj+RW/SLAnFlZq4JKkIQy2EBokiTYGXk0jvrQ/42VdUicBl3bNGICvTpvRvRVDx+zWAAZAgQjwVlFzY1mNEAoSCUXRihatk0b5/SUtBWgAjYrsp55KSv+G41S5m1lGKmZGQLVdfN6pryiYkaB15MZLC6uiZ6hho9/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333257; c=relaxed/simple;
	bh=JCg24l5O0gOfe0KIuyI+DI7HRre4Hr0HKChSVFoKMjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JKYd6MmLGXbOiHoX8CaIRD7oINjqj3ohneKnQDxvAkd7ZvNSzWiXQ1qb6Og85spQvct52e/Z+gi9Q2kqnuDyRdLid7A5yfqvBANusl0Em67IOslV09JaLezOHahP0HUjThnWAeBzQ7/nsojHYvweutu4Mgmh+jwJJUNeezNnnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXMekkAP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d86e6908ecso7321221fa.2;
        Fri, 05 Apr 2024 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333254; x=1712938054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8ACUCkXVn+Z+2m55cWPPzA56jBR7xG2uunEsI9uDIY=;
        b=JXMekkAPFD3RFeMde3LmgtDcy4PjqntLBgeUKgg7pam84GjYJZGxKwJZkXOtSoADml
         wQlg5vKxeTF2Sehspw5kGMfOhveNHzbgSNQ7l9SHD3Wpi10nuqEQKwIwugA8kpSarh+K
         H267c6Ej/MVuqY9Y4E2JpPdtE3fYcIMoIsi8wfio4Dsb/XA7mH3DF3cSEiSXGlEIRuex
         50N0ZSVW09A3CrI3hSyPT4UiLgq0fNHHIcMexiynOAt5qhQWQpjcx07ppo7mHtZb9m96
         KXVtbQl1847wpLpSJkKvopKOEaPR05VNxM85KET56Uy+gzrTm/5eXNuI7kmyVPRjYu2x
         3hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333254; x=1712938054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8ACUCkXVn+Z+2m55cWPPzA56jBR7xG2uunEsI9uDIY=;
        b=dPGMP5Z+tsxqn6mbWc01BeTAWtToo6sHBNGL1DwlSH+hEe67YPiku/bJDXUVtOGFDS
         p5rpNlHsSKgXpBMrWprVFMn622aa0IRfX6X26QQh5gnuXrkvheXeuqc3bQv1//bdkjd2
         /ewuaI8LyV2IRP01IW8xt0FGHVsI9akO0WzlMFslpT9TvkXityhjam/YXYjLPkWVG0kg
         y7fnfLIZwOW95RxiYGWv+vKARQzXezrct+6r+jX7wECJoFbc+Czq3G/sqAy4yjPqrwVm
         5cSaQMl9vRasPfgTE+enFGukB+Ct76YEjAXEy+7VPg7NV8fh6Ml69IS/c365uYzfsVzw
         fYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgjZhBFdsRqZidTvrj0FnKFzMSs3hTRiLwi0Qo1znYrQZ+KkmFSSjhBW45rfeuLi8Hbvr0EaEPvcjCITxwyW/ytl18/KHW4CW+yKFs
X-Gm-Message-State: AOJu0YwMgtYneUBsQxgTGbPko54/7iRkgotg8a608sflATCxbmQH4mH6
	90740zdRcGGQM2q2QxZzEMca+0y+IREH6uQK7RrPWflOxsFkMVmM
X-Google-Smtp-Source: AGHT+IFSqqF7fc40vyf1BiVSyKrPRsJgTa+Q3MsIjbw97gBnQC3Jo7hyUsS9wUJ/Dl9TigwPbatgHA==
X-Received: by 2002:a2e:9f4b:0:b0:2d8:6787:eaed with SMTP id v11-20020a2e9f4b000000b002d86787eaedmr1764254ljk.2.1712333254344;
        Fri, 05 Apr 2024 09:07:34 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:f624:ad13:2091:c808])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b004156c501e24sm6902651wms.12.2024.04.05.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:07:33 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 0/4] arm64: dts: freescale: verdin-imx8mm/imx8mp: add sleep-moci support
Date: Fri,  5 Apr 2024 18:07:16 +0200
Message-Id: <20240405160720.5977-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

This patch series adds support for sleep-moci to the Verdin iMX8MM and
iMX8MP in combination with the Dahlia carrier board. sleep-moci is a
GPIO that allows the system on module to turn off regulators that are
not needed in suspend mode on the carrier board.

Stefan Eichenberger (4):
  arm64: dts: freescale: imx8mp-verdin: replace sleep-moci hog with
    regulator
  arm64: dts: freescale: imx8mp-verdin-dahlia: support sleep-moci
  arm64: dts: freescale: imx8mm-verdin: replace sleep-moci hog with
    regulator
  arm64: dts: freescale: imx8mm-verdin-dahlia: support sleep-moci

 .../dts/freescale/imx8mm-verdin-dahlia.dtsi   | 39 +++++++++++++++
 .../boot/dts/freescale/imx8mm-verdin-dev.dtsi |  5 ++
 .../dts/freescale/imx8mm-verdin-yavia.dtsi    |  5 ++
 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 26 ++++++----
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   | 50 +++++++++++++++++++
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |  5 ++
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    |  5 ++
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 26 ++++++----
 8 files changed, 141 insertions(+), 20 deletions(-)

-- 
2.40.1


