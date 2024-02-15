Return-Path: <linux-kernel+bounces-67136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612F8566E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0F61F23B92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B329132C04;
	Thu, 15 Feb 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPtIZ+DX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98D132475;
	Thu, 15 Feb 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009610; cv=none; b=Jm5XjVPo9YtHyqsjzY1S9nT2zlsPfZhI60flbvUJydO+xdmewxJCn3ruIkpPgRlFC/y2ExrgI3+qNqqPos/3e/u4IyffMilTIxUI0cOSQ2sFfoLpGkBAKwyN2BKRSpmkYSOUAG6XpAi8H3foAAUGAdVgn3B8vY1hVwPhCFvxaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009610; c=relaxed/simple;
	bh=dYgvVx5J6FbrtTz2KxiUN3WJoc9vX9mVpIumVJo3C/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Se1Ecm0XKPScTQY4y3zbZ+BUsaaumQw4a39GhAgkfTUlFiRmiMeaM4A04wM8ecZNHLVbITHzKOcuxOulpJrbl9bjVq30cJtk2dm8wT8QQlw5bJC6MVPkFz08fu1Nwcm1mKWlOmI/7sdHG/dwz9wnrHbn3/rENQTGyazZ5sR4GCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPtIZ+DX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db51e55023so5931355ad.1;
        Thu, 15 Feb 2024 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708009609; x=1708614409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRHZqIOyBrytKgjz2NXJfF7uGwSTiUJd7ozSIo4Rz5Y=;
        b=lPtIZ+DXzIyzRKv6fL/ZkPhnWJFs9TrMWFgDwUewDEO51ooboeg8SPHCKIf1s+ODyY
         1XgrZUbr+PwhVjnJoI6cuvFdyS283GxeSzYKfDtp90KOOMMVuQFEvGar0Fg5Y7maJSxp
         lZB62rWZXePpK1KsPrIsVVrevafyjoesWZYbVckYanFmddgumc+viXjuf9k5ZC8Vl/2m
         Wg7LXRJMdPZXp5kmOMhNXTZ0XIGyUj2B0nMjpfTcEza54qhGOA3PWnfPrx//UPsJ/TQ3
         Zfy5PSM+VIQ3GwMvTi3FBLz2tW9+qM0GME0ExTQe3jzfSnLUwDUosBVl224iXZ2qL6GS
         gK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009609; x=1708614409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRHZqIOyBrytKgjz2NXJfF7uGwSTiUJd7ozSIo4Rz5Y=;
        b=U8RgZ6Vd77WR5PwxrR27XoLP6an8adbFot7TGjxUXNsbEcuJJhnQiCfU8sHdzrgWWO
         10diU1x8/rbPH5HvKGtqKsTr3UxpStIrGfe7+F6VOaU86nUC/Sfge8sx2l0e37uFRyrK
         mtu/KUeFX72LeDT5yFTAwcmQjg02slqBGGtT6fZV6sI29hrb2VOJ7CxBHcmijMMnE13y
         psKhXc0grg4lEca2S682bToBelOfSuAiY/G4IEYmtm+QLHnQ40Cvz2n9mZ/CTRYYsy6l
         SH2UlRBgg1fQ+kLkfq9R7xdbQYISD8tZcK7BTO5qeT7Bhs9HqO2lwyuAn3DAAiuTJKls
         pE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMXxfwKzqJ1MO3OiL0I5K1yIz6aYm+koc2q+MgoOlg0FyJijNWkd0GuAUsXo2teuJ1+fpehuV+txXlFsMFHDhQUMcCLeJQDP0TNPJzSn69zfEmWXKhMbKD7W5qAlqS+03YLhAk4dbf6013OD7Ciio6vTpEVPklmioeFjYAAY8dtvwV
X-Gm-Message-State: AOJu0YxQqkhjJpK9ctUieWM6fbEedBKiqrr5TIJuDKJJSydysWkB73KW
	vFiohwpsceutyk0FEk2NsGVrdQw8E8qQUsrlANgTwrfjVdld80+9
X-Google-Smtp-Source: AGHT+IEblop9x6atphDkcaL7O9OM5+yWMRm/XmJEMDeW45mWdx6pdQdYqGT8NM/WQeUzq7tk9pqffA==
X-Received: by 2002:a17:902:c948:b0:1da:2b52:52d4 with SMTP id i8-20020a170902c94800b001da2b5252d4mr2938295pla.39.1708009608588;
        Thu, 15 Feb 2024 07:06:48 -0800 (PST)
Received: from joaog-nb.. ([152.249.118.214])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001d8aadaa7easm1375987plz.96.2024.02.15.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:06:47 -0800 (PST)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: aford173@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	alexander.stein@ew.tq-group.com,
	andrzej.hajda@intel.com,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	kernel@pengutronix.de,
	kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	marex@denx.de,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	p.zabel@pengutronix.de,
	rfoss@kernel.org,
	robh+dt@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	tzimmermann@suse.de,
	ulf.hansson@linaro.org,
	victor.liu@nxp.com,
	vkoul@kernel.org,
	will@kernel.org,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>
Subject: Re: [PATCH V8 00/12] soc: imx8mp: Add support for HDMI
Date: Thu, 15 Feb 2024 12:05:59 -0300
Message-Id: <20240215150559.287571-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>The i.MX8M Plus has an HDMI controller, but it depends on two
>other systems, the Parallel Video Interface (PVI) and the
>HDMI PHY from Samsung. The LCDIF controller generates the display
>and routes it to the PVI which converts passes the parallel video
>to the HDMI bridge.  The HDMI system has a corresponding power
>domain controller whose driver was partially written, but the
>device tree for it was never applied, so some changes to the
>power domain should be harmless because they've not really been
>used yet.

>This series is adapted from multiple series from Lucas Stach with
>edits and suggestions from feedback from various series, but it
>since it's difficult to use and test them independently,
>I merged them into on unified series.  The version history is a
>bit ambiguous since different components were submitted at different
times and had different amount of retries.  In an effort to merge them
>I used the highest version attempt.

Tested-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Tested on Toradex Verdin-iMX8MP.

Thanks!

Regards,
Joao Paulo Goncalves

