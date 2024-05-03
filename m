Return-Path: <linux-kernel+bounces-167846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670D8BB031
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108DC282844
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D39154441;
	Fri,  3 May 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdzw3IAA"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78E1509A4;
	Fri,  3 May 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751010; cv=none; b=BoJnWX9EE5/m0K8EUYTYZXopNNSuYdysJp1oeLL+IIztLvo5Qhuf940pM8UszfhCAAzD+zBzUIfAJU8Vts1W7pZbl5ZgDil02NgCkKkF/x1MtEVDrMA0jYluq2OYbKGSiCXVxI5B33bBqv75Vrn9YjMqPtOjnI6wyg0dnDnXl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751010; c=relaxed/simple;
	bh=liLAgj4dAWwVyJDbmVLEwRFJZEj2sBbyqcKE/mUzxig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nz6NiTU+lf6QHg54orLQGmn4ZIu8mPofKoUY73W2Bt8Wm7P2Ey7DIONl/NV+O39ootjxO6UOm74FHAwqnmUWTnj3Q+WRmuJBr+xgZCqMcAVA8zdX/wiHaPZDbmX9RdlG6+R6oTmNuWR8XP5vPDSSRTUwupcJl73ViG+a4wtBVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdzw3IAA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so7802232b3a.3;
        Fri, 03 May 2024 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714751008; x=1715355808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rmci5WxWXCx38itxGY4xcvtGsBsErI1KmcKxvvSN1a8=;
        b=Jdzw3IAAGY2gmY1zi+GlGRMMAImY0VafqJA4JkGJEEMM/1Cs7V93XwMCmh6uJ1dk6K
         xfhsZ54c3r5yLGLTnxfcjlpwithAmtJ/yWyj2ksefJ8wuEGJEDO723jUpNsqqwAj3NsT
         7pWaC9ni5wAsa+hlOYTdFzxuBPcxKi69LF9wiFV/vUpKTSbzv4/2KImULFeWr2q8qTaV
         er3cP6OB32Q/Pz6Sqs00dxcsPej0E60dZ6U1znFMYgo5wmWJXEUi1ypVTygdLb5yyaI5
         E1gWDObYKjnrOT/Q0FX82husrOaIdiyhZG8RVo3A/giifx+Bb/maUSYiQB09iiQJu01K
         Tafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751008; x=1715355808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmci5WxWXCx38itxGY4xcvtGsBsErI1KmcKxvvSN1a8=;
        b=jUGqdR89/9cxKqZqIR9VSbWfQYkoYR8PwgtrxUQe6/jP0ioFUJnRyiK8a8jSsqyNw2
         g+KWDkKo51PGgEoR3seb9lJU+F3NiWxyZjUsTBFWeXxccUK0o6EGH5wcExlpWVTf2/6l
         7KuhOz3UG+QXvJiwAW+2hmRKePnIYe1z8Hx+00ViKd2CHJjjq0gwhe3wi2pBQ06xWJw2
         tyzRYYUFc7Bz9faPcCICeFK4PC0Q2KkcSnUH8/v8F0xBhjoMhLRYL6i/9JzeqRs2ig3x
         /6U1U7EqsGxl/QT1COVolJ6sEWPGIXSMtIZW3RpZaCTF8IZW/HVm890OS5cZqeppfzK7
         DC1A==
X-Gm-Message-State: AOJu0YxAOchxjBv6bia9vlhIlpvF9aPXq4azy7IXyx1mbGL7DLVKZgt4
	/aYkAYB4Csf31I0k/s9W3R5E12F5sq5SkrpcEi8aL0FT4GfCsyoQmQ26Iw==
X-Google-Smtp-Source: AGHT+IEyCkhU1rm0nNa6B/g/QSp04EXVkIgZoEmKXEY8ETFGgz/a4SYZqF6WLGg3rBuUa9+ZlQ5Yxg==
X-Received: by 2002:a05:6a20:5530:b0:1a9:97d2:8082 with SMTP id ko48-20020a056a20553000b001a997d28082mr2872100pzb.9.1714751008170;
        Fri, 03 May 2024 08:43:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7800a000000b006f447e2745asm1991335pfi.95.2024.05.03.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:43:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/3] hwmon: (emc1403) Various improvements
Date: Fri,  3 May 2024 08:43:21 -0700
Message-Id: <20240503154324.517246-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch of the series converts the driver to register with the
hwmon subsystem using devm_hwmon_device_register_with_info() instead of
devm_hwmon_device_register_with_groups().

The second patch adds support for 11-bit sensor and limit register
accuracy.

The third patch adds support for update_interval attribute.

The changes were module tested with the script at
https://github.com/groeck/module-tests/blob/master/scripts/emc1403.sh

v2: Reworked first patch of the series to prepare for subsequent patches.
    Added patch 2 and 3.

----------------------------------------------------------------
Guenter Roeck (3):
      hwmon: (emc1403) Convert to with_info API
      hwmon: (emc1403) Support 11 bit accuracy
      hwmon: (emc1403) Add support for conversion interval configuration

 drivers/hwmon/emc1403.c | 749 +++++++++++++++++++++++++++++-------------------
 1 file changed, 453 insertions(+), 296 deletions(-)

