Return-Path: <linux-kernel+bounces-108914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67DF8811DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F129B233F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30D40877;
	Wed, 20 Mar 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTBnEuEH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136142059;
	Wed, 20 Mar 2024 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938835; cv=none; b=YpjIx9XYDsL9QAinzJoBN7uraqv4Q1DYagHfWFxkO6cKRr6te5ZFvuypYhHAqbdcqmgdaYP9p1HFB+q11HKzg9EG7L/rbBoqWsQb8uF2TTgs/4SDR1JbhapKGL7OHC+qQIzB9wUpdA3KTrrUaeE/R5Drs4PB1+8ZB6xqTshErMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938835; c=relaxed/simple;
	bh=PumoaNRhqeCdjNpmQ5E5KB9UvPgXpFhOYon1tT9ulRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvY9xFBdSKNrjPp+eslL95aOxxYdNDA9U5rtk/x+HQ6AAWqmrJbBWrKX8ZpEQSKyBL/zoNU1joa0ddg1cAJkeF4gRUa5b4dNiVCy0M8Le4UEZqZXWIsnhEFhWXG+K34muQsB2AtdWNiVDEOEM+uxWR3tbeJzJlRY0aKbYyWVZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTBnEuEH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dde26f7e1dso48869365ad.1;
        Wed, 20 Mar 2024 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710938833; x=1711543633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvL7pYKBZmrZonfhNQXehwF3fRzkkMerkgdJSvSaFCg=;
        b=FTBnEuEHkn5790o6qmiW+ORfkqq2h1fw6DFfdSN2ZCVu/p+ATwMBCstdEvdbA3mSyk
         u1earSm4B7JOkPSOSYeNRE/4spx6HJHU4rMhLJgb85nZr8zDhGV51y/2wOfxNNEI+LLe
         SYepyHERWFwfOczKYxDmWZ5GtcOdbdHLlvw98qXxGjV5umeCGP8bnaw2ZyFSc0CQu1hC
         28lOeFZ8RXXz35tyKLY49c6I+hInU5om09Dx0Hqiqh5Tb91VIUt1fkU/fsXdmNWlFX++
         8E3MSSGdpZNj5fix4TVqPD8gASHpLtzdM2peYcmHFJe/XKd227m/Y+GlQnM4DyfhSPSo
         b8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938833; x=1711543633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvL7pYKBZmrZonfhNQXehwF3fRzkkMerkgdJSvSaFCg=;
        b=SbkqEJamsY/fcG4eUKOUfA8evrwIhKkRNS7dPUwApAHCoCdSW0Vc1sX5B7YPCEcSl5
         KCx+iVjTzWh9XfjFAKiVXjXE2C9l+vZg2EPVdBkVS+L0pLQd0MuuhrFbWyahIWU3Iwh2
         WbOMmiUQutdmgXkuNaA0jcwecJkHCxU6Q+yl4tHkleEdBFnBSUo+PM5zEId8Cgzq2DhJ
         vH2wEf2Er3pDlOFDJTxLktRD5TWQL3yqJ7wayfCYTPOmOuKpvjtgerpe1fOsaGgVYJtr
         FUbaI/b2a+heqxcDlg6B/nPbHGqu2y7LIuDmGy2t4nV6Eb7gmVGpmAhrTKn7tiWPEyYP
         CqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqfJ4RUyAZjH5De8fDdfTU4h60UtR9q63KjjUJnuzB0LDsZ2sOvYjeWzXuY0GHdINWJhDDLNzvhR2YE7ZZUsUNwnH/z0zKClQ6Yi2sC5cKvo281fS26mvEy7NVt27IIBKSCCQt5HU8wg==
X-Gm-Message-State: AOJu0YwphOFDBVPO3HL6K7WoxHiy87fmQYmbGuj96MlSqyt5VWgLSKyw
	A2hYTjnvwQXtl3MyuHQjH3IYyYNW+vOGKkvI49mDTBDnPRAslHIn
X-Google-Smtp-Source: AGHT+IEodf+2+PLLFYFKLAGrcuTI/vflqdPXjP76rpdQGRo+VCLOUE7oJACuXm7ijLkmTotZPot1Yw==
X-Received: by 2002:a17:902:ea08:b0:1db:55cc:d226 with SMTP id s8-20020a170902ea0800b001db55ccd226mr15814248plg.66.1710938833134;
        Wed, 20 Mar 2024 05:47:13 -0700 (PDT)
Received: from localhost.localdomain (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001dda32430b3sm13441004plg.89.2024.03.20.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:47:12 -0700 (PDT)
From: INAGAKI Hiroshi <musashino.open@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH 2/2] dt-bindings: leds: add LED_FUNCTION_SPEED_* for link speed on LAN/WAN
Date: Wed, 20 Mar 2024 21:43:17 +0900
Message-ID: <20240320124431.221-3-musashino.open@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20240320124431.221-1-musashino.open@gmail.com>
References: <20240320124431.221-1-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LED_FUNCTION_SPEED_LAN and LED_FUNCTION_SPEED_WAN for LEDs that
indicate link speed of ethernet ports on LAN/WAN. This is useful to
distinguish those LEDs from LEDs that indicate link status (up/down).

example:

Fortinet FortiGate 30E/50E have LEDs that indicate link speed on each
of the ethernet ports in addition to LEDs that indicate link status
(up/down).

- 1000 Mbps: green:speed-(lan|wan)-N
-  100 Mbps: amber:speed-(lan|wan)-N
-   10 Mbps: (none, turned off)

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 include/dt-bindings/leds/common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index d4b8498bde7f..8d446cf88b4c 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -96,6 +96,8 @@
 #define LED_FUNCTION_PROGRAMMING "programming"
 #define LED_FUNCTION_RX "rx"
 #define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_SPEED_LAN "speed-lan"
+#define LED_FUNCTION_SPEED_WAN "speed-wan"
 #define LED_FUNCTION_STANDBY "standby"
 #define LED_FUNCTION_TORCH "torch"
 #define LED_FUNCTION_TX "tx"
-- 
2.25.1


