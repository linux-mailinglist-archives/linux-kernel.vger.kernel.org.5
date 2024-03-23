Return-Path: <linux-kernel+bounces-112252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D889887776
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229E7281FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55FFC05;
	Sat, 23 Mar 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNJcIgIh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E75D2E6;
	Sat, 23 Mar 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711179875; cv=none; b=mqEGdLv3aULBsycAGpjfBDlPHT74mCq6G3mXh5G4pSNxEJnbwooXvLwUdBc+7JqymsHSx3zx3ML69efou60jPXdDbW3xrHujGRQd+aP6h1TKYBXKfRxroRO9KgkXzRDCuX32dMrKOHpwRP9PRYqv0XIAC+QXNUNF3C9+Zrdva8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711179875; c=relaxed/simple;
	bh=bX77DFXEDB/VnzhM4jOvfjO9QqNc6uuSmRLrF/pTirI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhqsg362x7LDm1zecLn8nkYWEy/TQyaxywzzllfcpC5sI0ffWGdWxUHgQ+7qbYcryDu6dOTfmQVNXPtkkk684LYbJjuauWnU5G1FaZMCTJG4V2wBfSgEt+HPhTqJzHFJ7io4qwfHTLiW0kFniAGWtph46hse49VcA4YEH8iBVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNJcIgIh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1def89f0cfdso29180345ad.0;
        Sat, 23 Mar 2024 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711179873; x=1711784673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTIY4yTRBxvkkLS9ASNNrDGmsbUdt78o1hFukg6hNIw=;
        b=TNJcIgIhJS/nk6uy7R3Js3vNpkW+AzAY1Pm+ATo8OU/n4aS3gG3JTMab4/tO1U2HKu
         xrT1fx4X68O3/nKwyKZUGCYE8sB4x4otz9sG/4q8Q0P0J5Fgjq4wt0cBTZPZQdJDyD9r
         lfVM+s1RvrNKoohqTOlOxTjuKOlPb6jXzppftWhTLsmvQ/sinh2uR4nTW25o2HTEFK/6
         Okv3SHlWNaWK5KDbwTVA3nEQtWSxjaiFxnWHy5BC8XqiJMlr6CNozKOZNy7ubgRy40mr
         G5nqpWTsbc67ztLVC77ES/Xsc26WyBt9ccAz9mjy9kapiM8lm8A/kzhJhcKdkZOoxpQa
         qKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711179873; x=1711784673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTIY4yTRBxvkkLS9ASNNrDGmsbUdt78o1hFukg6hNIw=;
        b=w7ljeB77q21W6TsM2vVKDpmHrk7EYwlcWNklBSCvu1PXsdV14tPesG7+FDOZgiO1Hr
         kU8VDrtODX2wi268NUKmvjRG13Jv+uqCJtOVZ2dc1DoNMcrGu2+uPK/N8qj308vrhpbB
         2bkV3vY2SlA81ZIaEKvij0Ex/9PbHWJ4X0U64/v/se9j0DDvtQirB/eE5jCbZ2HLinfX
         FB+hby5cNaw8RL4WQWVEPCiKkgtpbu5yLxKw6LyDLARM7741rAD2uvkpmK9KFeGRUkhp
         FlV5GCtcqdIODuolj9krMWZrddWBIIA9HUi0q7nrmIh8PSN3FzWbARbHADVuqdUFBcGD
         27vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/gCyLHEA/P5RAA1EQjPG70lfyOLUtsN3Mk7kVD5ki0KNoDX4wFBW0+unkwxZaRPd28VJl2cgzB479BFdbjwW2fBs8839hFvLV+ZNBs7KJ972sSfT2mo+4KTujhKgoH13tLy7FrmwnPw==
X-Gm-Message-State: AOJu0YwIcK6DAF3m/E96AbID8K9RyxAOkUcrnlk0k0ZnyJh0WEJ40vlX
	Uf3N4sXH+yua6fBK/6kDvyv02/yeWro328eWJKOn65MM3ChODxlz
X-Google-Smtp-Source: AGHT+IHdc4Gm7WaeE+6u5G2RQlnuYHubN4Bx0O+eTcsJf5shPHDJ1OuAcYsWfWUuOeeUJ5jQIyLGBg==
X-Received: by 2002:a17:902:ef4f:b0:1e0:1f53:a164 with SMTP id e15-20020a170902ef4f00b001e01f53a164mr1942133plx.0.1711179873313;
        Sat, 23 Mar 2024 00:44:33 -0700 (PDT)
Received: from localhost.localdomain (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001e0410bfccasm976825pll.126.2024.03.23.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 00:44:33 -0700 (PDT)
From: INAGAKI Hiroshi <musashino.open@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 1/2] dt-bindings: leds: add LED_FUNCTION_MOBILE for mobile network
Date: Sat, 23 Mar 2024 16:36:09 +0900
Message-ID: <20240323074326.1428-2-musashino.open@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20240323074326.1428-1-musashino.open@gmail.com>
References: <20240323074326.1428-1-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LED_FUNCTION_MOBILE for LEDs that indicate status of mobile network
connection. This is useful to distinguish those LEDs from LEDs that
indicates status of wired "wan" connection.

example (on stock fw):

IIJ SA-W2 has "Mobile" LEDs that indicate status (no signal, too low,
low, good) of mobile network connection via dongle connected to USB
port.

- no signal: (none, turned off)
-   too low: green:mobile & red:mobile (amber, blink)
-       low: green:mobile & red:mobile (amber, turned on)
-      good: green:mobile (turned on)

Suggested-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
v1 -> v2

  - move _MOBILE before _MTD
  - improve the commit description

 include/dt-bindings/leds/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index ecea167930d9..6216ecdb06c7 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -90,6 +90,7 @@
 #define LED_FUNCTION_INDICATOR "indicator"
 #define LED_FUNCTION_LAN "lan"
 #define LED_FUNCTION_MAIL "mail"
+#define LED_FUNCTION_MOBILE "mobile"
 #define LED_FUNCTION_MTD "mtd"
 #define LED_FUNCTION_PANIC "panic"
 #define LED_FUNCTION_PROGRAMMING "programming"
-- 
2.25.1


