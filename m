Return-Path: <linux-kernel+bounces-42881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA5840816
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D1328F042
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341365BBE;
	Mon, 29 Jan 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFr3eE/R"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154765BAF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537946; cv=none; b=GkeWVlWx6XYyt/Axl03zfMlT1yVilk3625JCs8dn81AWOgIP2LKicc6Pcq7MG9FbBTI/KPUdS4rLD73YWkY02dTbYBoym5gUT7JR86BOqYrtoOBf5uplRet4N3PvpUoskF/kPoEKa07IDCwFudeIBPu1k48aTB/fi76VARCF/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537946; c=relaxed/simple;
	bh=Gnwfp/Egjb88DXFVc79CpP+Kphf6d6Ub9Z0ZLmJp43Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oA0kO2Hkbfieb8W8Nziiz3kW89DqRTH202U7k4+3x5PXRCXdCEnPAT+zH0U5MiPVlf8B+MztqRFCIXq6n5xO3jVmAYFhHAQyYY+nJ+5Tno3VgxeWxttnLkwBGP25+HRGP0iQBomsLxrlBoI1aqHkZpRf7p2VWyAlxw/MEHGB29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFr3eE/R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so922568f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537943; x=1707142743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLS571dVw4X8+n8FbYXlJLtZy4tBEfQY4YRQLn5hanA=;
        b=NFr3eE/R3CvhHbHe4NklODYEIZramYsu1vtMGm9H/M5826eG6jySVn/l5F3XvVM9t7
         1CBJ0grCKTpjgLoCkVAkQn/gUUstinwkk3W1qvv0+zN8cXKUgIaL03HQIb2H0gz0mqwq
         UEa4vT2os93Fg3x4/xRhuNJPX02/bm2H1ksVNO3nBF2C85tvui4tisQ98BKkpzSwBpBM
         cfnQW1V0SpSRAJIGGUiM1qQHH/yU8C8Voh12A5sUdsD+bPHqzMjlkWTaV3JnzyBLPrNO
         vHVTRPevDR1BDfBtrSndOjvhIksbFFsP8+SSbc5TMV3UgTfNA0d7DpMCZMFmOIuA/EdD
         7jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537943; x=1707142743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLS571dVw4X8+n8FbYXlJLtZy4tBEfQY4YRQLn5hanA=;
        b=GVq38Od98z70yTeR+kHqbTtizNj4D1rFtEHUqXe66h/5ls+iGdOZ8vQB8AhHvZeDNL
         mM4Ni+5MWNEiM15cF7Y36vfcFkwMgfyRPni9EFY2wOkHTzhrxSUet7pLCmtC5RdbmPxV
         +WvSU1zbqWduM2g6yzmCwlKS0KRo8p+7pxUyrvVwX8+xuzeVljhWFaYWk828zAjHdWKM
         D40lM6F8dXbewW12u9i0dgplkXlVnMMre2O1mngX/zfASVq/28ZNvTbRFWar6rM2Udly
         p5wf3SZloNGdB1adnYpzAlCgBvx1ZOZsjoVuWy/keEFZ5lYOyOL0eeF2agBZaSf1p0xO
         UdcQ==
X-Gm-Message-State: AOJu0YyrbpqUQug8Ge0fedvET57r/sxCL0tR+CiADA2is+bv6vKFEU2u
	vuJHaSTo3rlqTCuOOlNAT8tCzFwcoCNkrRYCf56EQWUYtnroyBOE
X-Google-Smtp-Source: AGHT+IHuI7h+GeXoy0qKXnNpp7HNkXdurZuvJjrOTcuh1RRQbe/+/JPGj2LgCVKlFFzQvwAifygcGQ==
X-Received: by 2002:a05:6000:1561:b0:33a:edc9:8e32 with SMTP id 1-20020a056000156100b0033aedc98e32mr2457546wrz.26.1706537943022;
        Mon, 29 Jan 2024 06:19:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVyyKnhuYqmON6CZr8R4wWpLf1kN9+FY1GG/3yN9vciHGBbQQa3kUr41pV69X5cSLALGRGAuh+PXJzzGDE8RpH1ZRNljfbAMvMnX1p9lQCwhBD/7SHSgNfvhvyB5vuanS5WPss4HIK5f49zumVO4GAM05cLs+FPHJreIHDHnrxy5s1pNoLCd+VYA2H9SCn9yUJt+fySif2r+4cU+xW+60cT8OsxQ93
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d59c8000000b0033af2a91b47sm1768430wry.70.2024.01.29.06.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:19:02 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Mon, 29 Jan 2024 16:19:00 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH 0/4] Staging: rtl8723bs: checkpatch fixes for rtw_mlme.c
Date: Mon, 29 Jan 2024 16:18:52 +0200
Message-Id: <20240129141856.416532-1-meir6264@Gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch fix series for rtw_mlme.c

Meir Elisha (4):
  Staging: rtl8723bs: Remove unnecessary braces
  Staging: rtl8723bs: Remove extra spaces
  Staging: rtl8723bs: Fix block comments warning
  Staging: rtl8723bs: fix else after break warning

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 241 ++++++++++------------
 1 file changed, 114 insertions(+), 127 deletions(-)

-- 
2.34.1


