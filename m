Return-Path: <linux-kernel+bounces-76897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C085FE58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE40EB221A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D81154455;
	Thu, 22 Feb 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+I2WPei"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC18153BEF;
	Thu, 22 Feb 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620263; cv=none; b=jeU8H2gl9H41V3BRfd/5D2kevNrN1HGtSByFmzyGChGYmIiiElMLdhET7Pi8MLG7pG9FSZizJcHiL+N3Gm/lopv2JLBjb2aYOOc/sVyD1gocRyznQJd2Fl4KsoQqiEcrGXJLgIZ3GTr8axYT+t0aJgoo4J7dzoohTp8YdNeT3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620263; c=relaxed/simple;
	bh=H7GyowQfVueX9u+mXBYajStEFd243OHU3m4TfVALRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ/6EOZV65bKOT1cFzkMARqYB/CpMYOmWBKHfFAiSrUOZfIr/mzKG5oRDo5QA3hg+lJbGtMoCofWIjNk4ivokXTH4ATSIt/+/raW9Je5BFtjsgrJTGTPORzsdWD1qcQ5UlJy06a8rSwuk+5Rzvne7bBtRmi4OsKUlUvCxgfKIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+I2WPei; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso14930145e9.0;
        Thu, 22 Feb 2024 08:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708620260; x=1709225060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcbNdLGTQbcf2fuT3ItJFHWUdIKmO9oNeQCZ3LPc8TA=;
        b=P+I2WPeilmWDV59yp7cE46JHZ6w0hmRfwJIszx+Khe82FB5BKqsqwIGNZFR2XTN2Ij
         Su33abXBSxjOxR+VY0yvuLjw/ApfK3QFlGCzJL2pDjFYPBelu7I/AGMXMm8Dk28tCE2C
         sc0W2QGCyaOusSYSoeE8DtebfvSGFFx+5oeBDpdtbAtahzCNAZjEd1fQgdhCgqak12Hf
         s+ixOu66ZV1nxfLBmhKM57pskRxNJyDOsCEEqWV2cnjUZceBvmzVgNHveqp/PNIz90XF
         aA4rzhCDXchr004KVrx1JE/ySMs4xFm4PjazTF4d5Q5GBhJWvDbBqBWvUL33+eoI+njl
         kcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620260; x=1709225060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcbNdLGTQbcf2fuT3ItJFHWUdIKmO9oNeQCZ3LPc8TA=;
        b=Oq6e/z5XpA3/g3ZxsRagfBgEtrAwKEkyjlwhTUt6hmXO+w6uPmq6AwV+aMuDYfzCo4
         xsT6wV3ZikSXWbjc/asEVvWEUYPPqDRO/8g1ISZvTOE+ZFvulsSkMlUSa7frStH7Vj0b
         gZaOdHLQLutrjHijbcFE/EBoaiCFIkqqG1DhvdNEzrRLdr+t8VD05EqXTLqzuPhnP0Jp
         y2QPJMFtFKQh9CJugjOQQGGSo8JGtqn2OHjUHT1BOMFQ2MT1sy1SWitLlKlEavywUB5t
         HOCeVflU00Mco4uEobzdY/drg6SO+LF86sbVLjvuSTt2ijdRqUhXwpeu+EqV9CdNBULi
         c9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVbYPMEzTYwN9IGFGTjW5/KYgyDGGz7C6KJVgJv3aMxYJ5nL5h8sMk3gxghxu8jT7kAkjoRNB1oqEpDVKdnMKAyF1/sPZINUa6RMm8yhrWVVCYLIhYf4wxywm2Hy3CveFVP2OYibDdOVw==
X-Gm-Message-State: AOJu0YxPGxpo1CyVKcxgts/wALYuhOWqHzPraiytKSaSC9YWUI1hhWN8
	iFPKymOjX2jJXsir2pA0J2MFj8zkGNbST8QGyyVQ56RB/h7yfeoh
X-Google-Smtp-Source: AGHT+IFNt485egaSmCG12sJjptke/Gcj6Y697CYaU6NQfQhfAVlQSLqd1ixQvqVdZ8/2eQ8csXhp4Q==
X-Received: by 2002:a05:600c:4ec7:b0:412:64a5:a21 with SMTP id g7-20020a05600c4ec700b0041264a50a21mr8657417wmq.40.1708620259827;
        Thu, 22 Feb 2024 08:44:19 -0800 (PST)
Received: from localhost.localdomain ([90.255.110.157])
        by smtp.googlemail.com with ESMTPSA id r2-20020a05600c35c200b004123b049f86sm22800420wmq.37.2024.02.22.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:44:19 -0800 (PST)
From: Adam Green <greena88@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: greena88@gmail.com
Subject: [PATCH v2 0/2] drm: panel: st7701: Add Hardkernel ODROID-GO Ultra panel support
Date: Thu, 22 Feb 2024 16:43:12 +0000
Message-ID: <20240222164332.3864716-1-greena88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221194528.1855714-1-greena88@gmail.com>
References: <20240221194528.1855714-1-greena88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I forgot to include the 2nd patch in the series in v1.

Kind regards,

Adam Green (2):
  drm: panel: st7701: Add Hardkernel ODROID-GO Ultra panel support
  dt-bindings: display: st7701: Add Hardkernel ODROID-GO Ultra panel

 .../display/panel/sitronix,st7701.yaml        |   1 +
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 158 +++++++++++++++++-
 2 files changed, 158 insertions(+), 1 deletion(-)

-- 
2.43.0


