Return-Path: <linux-kernel+bounces-98866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29737878076
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C1E1C20A73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89563E47C;
	Mon, 11 Mar 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="U+p3ZayZ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286973D3B8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163400; cv=none; b=rbdTIdh/si4Yj4u0NkB0zThVxBt/PbfFX9xkr8phGNT8PZJaPmlfkBwI7rb2yD5BqP3q3vhxEnjnpIScwgQfh59a6lzG+US5pqYmDZI4yyImTCUkha/dziVRtxik2vR5xeWzmK01SE3wkQ06Ycj7CTmg4eKnFOQscm2/wdj/Wno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163400; c=relaxed/simple;
	bh=llHCXS307v0+/xVYMGboBB8Qu9nNJVhICJ1Q6NQBsQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5gYU8rfKjDIzIYnIgHqn+DnGzi3t+Byb+XFnUhAJDhW5tMmBE7+R9dICJc7/E4sQSLOtv6np7UZbegL96ipsANCtLUvxM5P6bXTIdtlObwddh7RWi276xXxve8nRY9sMhIsp9KHbO3Gfg7xflkIY/Jre66+B2QvDxmIR9RO3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=U+p3ZayZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a461d0c90c1so144347166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163396; x=1710768196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vi+BVQ0XaUPCYN9d6qNKee0JVjNZ8kgX9tPudilBvw=;
        b=U+p3ZayZA72cwUqQ4VYYS4k1i7r8SWihTemGPVPBsDYEQrcEFcKMgs5krj0Vncy+OG
         Tt1A3up4t0vvuY0SDp0nruB9bLmOic0nQovE/k6iKd1f+S7LYUxD0fjjQR+/C8LSKG5y
         lrXzEkyy171EZquopIJm4hakgD+2PlYhNnYt765AqtlAbSt7DoBF8trefd0rtyRRP2c/
         RCShJ+Ui8dP3rudkG9KBzCvPie5kq+grDZG4h7a1evUJWR0UQM8BqlYQe/dxUwV5/U8c
         kik5qED85R6XDqhXw31PHoscg07xirsOgIrHZjiilDKyyuoIqsR6xSD70IZ6SetMD5RX
         bK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163396; x=1710768196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vi+BVQ0XaUPCYN9d6qNKee0JVjNZ8kgX9tPudilBvw=;
        b=OSYMPT7+BP/AeqsMlTufbCxGgR23kGn+Tl73/4C+qd4wv8Gxbbm8AqGQ1BG6S7WjCC
         NIIIWuAbvMQUJY5MxXAVCvJkGhvNZesozHKtYOYanAYmdAf2ZGX7sd50DsPwQpo3tlVM
         25U+zdojfYrZkvmi1stfu1SuL6Mvtpp0hJN/wEbkJJV+pKcNYt/y3zpR76X6MUZS922h
         Ch85JxltPDQvW/KSal4ywH4FcX2nXfEmIO+hu+IXEKj+0UB8+uVyaVgm4bOIUEa2AGbr
         IDmIcPMSqrHfJJVezc0T8Eq9iBnRTYRyy2TodnpMyQj0+a70Ia790yhFqgicR7Lywi62
         FR6g==
X-Forwarded-Encrypted: i=1; AJvYcCVBNI3C0oJyWXn1yFZN3Vzlcl2scJI4y9Byq7a2kOnrfz/wcsQ4KxubGK10WCyKCAYRvAFBhk1TY4My1eGeYI/cNXqCtyTnLfzEe/ed
X-Gm-Message-State: AOJu0Yw1ekWUH7lUq5KPiEdDY6aw2j+TM/f312tCoKmBsqdt6ncDhdUC
	dez2oWDZSVR4jGF4EGo4dGgKy5R7LA3cQ/UcZ6MVsbnyGxFbnEF6lwvTOOyeFRI=
X-Google-Smtp-Source: AGHT+IH2IupL5/62mpJ3riE2ilnMt1dhlFHSaJSK3URcSmpvb/NMdF5M2wPnvOLVBDtWeZ/3H36jvw==
X-Received: by 2002:a17:906:f9c5:b0:a45:c8cb:f5c1 with SMTP id lj5-20020a170906f9c500b00a45c8cbf5c1mr3769724ejb.63.1710163396508;
        Mon, 11 Mar 2024 06:23:16 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm2861075ejb.79.2024.03.11.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:23:15 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 02/11] arch/alpha/bugs: add missing SPDX header
Date: Mon, 11 Mar 2024 14:22:57 +0100
Message-Id: <20240311132306.3420135-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311132306.3420135-1-max.kellermann@ionos.com>
References: <20240311132306.3420135-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/bugs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/bugs.c b/arch/alpha/kernel/bugs.c
index 08cc10d7fa17..6a16559c1a8f 100644
--- a/arch/alpha/kernel/bugs.c
+++ b/arch/alpha/kernel/bugs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 
 #include <asm/hwrpb.h>
 #include <linux/device.h>
-- 
2.39.2


