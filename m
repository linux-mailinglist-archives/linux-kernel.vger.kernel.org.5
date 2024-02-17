Return-Path: <linux-kernel+bounces-70102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51F859316
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A6283937
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375580041;
	Sat, 17 Feb 2024 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImYTv7ZU"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41B7F7E1;
	Sat, 17 Feb 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708207423; cv=none; b=sXQNInWTow33gv+IEqjk8Sro789s31D/LvRhx4cWrEH/Pt2bTVUXwk4rVkROkkgXfHbte+F8g7swD/wfFVmmOYYTwz5HrxR/h/y9chfk7qTX0Gb34unB0XxR62xlvjNQ13uwsDs/G7PF0Hu0TBWrjNgyCRbtwVX9yN9E0TSDr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708207423; c=relaxed/simple;
	bh=xxIdMfBScRQZcaF1Wz/1u1LuvGn/UbTfZ5gG2Bwfdvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obwDC5fvj8WXZtxbxqmEDFfrGfD5D0WWekF4ZchyFt9ZzNQowLxZy+2NLIVgtoGkt/mSVdKpIleoliLR4pJABog3SD43ztptZkc+FqkP5RiZPB+cYq4uuqjUY90Qd1CXnFWGXv92o5aSUE2RyTkJfR90tl9xP8dW/efA6dCfIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImYTv7ZU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eac018059so4609157e87.0;
        Sat, 17 Feb 2024 14:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708207419; x=1708812219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PCQQo9PgtUEzFrEb8fsiYeGshRkf8kLmsq+MgCoelQ=;
        b=ImYTv7ZUaISaEfZ5ZGNFV+hAHBBD3d8NI9Zvq5VDEzIg1f6x0ZAjS55vVw/dTbXELM
         yHWu5YA3ev66VUOnDFSJghGSLep2fci4Ts3bAkbz6MJYkE7nB8OUkfufrvjZxdY2sjn+
         xuZNSxA/RRIZgut0IRE3RG3MI8um0gdZeRUBfWGTWxxyh7OuOrWSbnTxeww72/2aU14y
         5cB7aYIbEt5FnUF8XfkIx+DGEKurJIzE3Dp6R7fnQ+ODkwBg7JZIEKD4aa5Y16b2UuvZ
         1yOtDJoYyv1M7mtpZIU8fs39eUUr0K6A1Ea8iBQ0WTcyqRLEOafysnNyAqFteYmyHmMW
         8LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708207419; x=1708812219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PCQQo9PgtUEzFrEb8fsiYeGshRkf8kLmsq+MgCoelQ=;
        b=XLjEz4ZO1AQC22bwdgV6Dl3LXvUwHZXl+j4v/JSayBR5rHHP1jSwV5YDzjvvLVPXpQ
         TPwjvSuoOmMSYwFlDEC9V1Loq5IBdtmO1OWb5jFeou2jdA7fIzPLKI7wxUkPI9up+g7C
         6MFKBDnv+WJoqUwklDWHa/LeSj52lAlaKO+HUUZ9WWMsjMUFpomEOIkLtv0fj8HrWCDn
         VUkH3wRHXu2vyorkHp8ziKVuu/sRKTnE8LDjBWoKUOVSmIYEgJgOTNjTGHg5yTRkoQwm
         1gTq+3ISttCx0IC4YDwwLXAvuUfWUW3pIATKOWhBl4fjcHn1lP5/N84kmNtrQMhd1/gJ
         YqUw==
X-Forwarded-Encrypted: i=1; AJvYcCXO6pR0OhnNMT34pbNpnQT+SnXqjiewJhB0iFmR4Kdi1BkU1NqlhxH2m0npqwGs5gxeJY9DWRvWnI+1ypTeD/bAho7DR8WM5qzcl2Wi6UU5dE6a4IfCbl7BvYU3kJmqwCW4xEoK3MXyilTkdJA9ENrfM+dBrn/dQspg6k/hIElDAsmrWjH5
X-Gm-Message-State: AOJu0Yz2Fu1Ycs4u9uywFXbtCyZRcpEitDewno/mvh02ytyq2HOBHOYL
	kVWZACKjQvXAhNvIo39C/1FGhDusAGslWgSXIM+byoI78xh8seBz
X-Google-Smtp-Source: AGHT+IFDwEcJCqy2DxTscgIaBjiv+fp23IJMN9iDLjNRR89yDIoVoRJgSFKoYWmyZEv2s/rCDVzGSg==
X-Received: by 2002:ac2:5501:0:b0:512:8ac0:1f76 with SMTP id j1-20020ac25501000000b005128ac01f76mr4474952lfk.66.1708207419192;
        Sat, 17 Feb 2024 14:03:39 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id p19-20020a056512313300b00511936e2d61sm363836lfd.56.2024.02.17.14.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 14:03:38 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 0/2] media: gc2145: add basic dvp bus support
Date: Sun, 18 Feb 2024 01:03:06 +0300
Message-ID: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on PinePhone with libcamera-based GNOME screenshot.

Andrey Skvortsov (2):
  dt-bindings: media: i2c: add galaxycore,gc2145 DVP bus support
  media: gc2145: implement basic dvp bus support

 .../bindings/media/i2c/galaxycore,gc2145.yaml |  33 ++++-
 drivers/media/i2c/gc2145.c                    | 117 ++++++++++++++----
 2 files changed, 120 insertions(+), 30 deletions(-)

-- 
2.43.0


