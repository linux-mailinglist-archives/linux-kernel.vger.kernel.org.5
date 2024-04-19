Return-Path: <linux-kernel+bounces-151860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA98AB4DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8741C21C30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ED013BC20;
	Fri, 19 Apr 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls7XD/PU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3D77F13;
	Fri, 19 Apr 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550398; cv=none; b=DHRcQCzAg+JoJ+dQxQ8RaPlXogMr1toljtwKz/13jyzECr5nMdXChHKIBqL8x5HHPG+Lg4s2QdE3WoV86/T37Vvn9H0rNhDw0Dq3tx/KYG4dNzFol9ybq89o7vFmoMsWcxye8PALu2qsvo/U0loklCavJIC6isPfL4dBdZ1l6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550398; c=relaxed/simple;
	bh=hOoTnHiBwf2rX2MwVUrEk0jw4KfQYDg5tOPaL5cUa0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7kSbVvoZiwVp9I7EdSi7EVL7vaeShTv6RWXjEz/NAgONStwYBPgQ70gmXpdyhd1CeMzHUWWyzd0G8XN/cy/zlM60iJWU+qjfR6QZ7y3ByK5OmC1xspe6txqwkJi6TQcPC2udp93ZDgB/YIEhpWTdyojhFTSpzijW++zlqMVmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls7XD/PU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f103b541aeso180666b3a.3;
        Fri, 19 Apr 2024 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713550396; x=1714155196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXuQiZ6Uxljth7h4zsRrHEZmoGaHKO2VIyJBKdyFiaI=;
        b=ls7XD/PUuZVrS7t429gpMqgX313kAKXXk/6ul12jXoYy2E36nL8IdmthFEVJOxvaFE
         vazT9CInI9Mn674XQd53aIa/zdKuoLRAYZPPBArrvth4mhHxdigVDuOdco52YtQ5RoqI
         H4YkA1BmS2jbtRmLTGImPlkgAeEh2GXDcgpplsLEV+sZoY6NvWxB0t0we5jV0A/PwtdM
         +o+0FAWVnz6ePHZKqm3I2BX+JzlhOPWmxC60OjtHgoFbu77j8OPZnTWNJnbYjZ8YBN64
         HJ2OEcqHzqWJQXIWUSOA9uz5AS/U40rWLBTG5RKY6yoDVTXAtg8UxZIpfNrbM3XK29J+
         sV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550396; x=1714155196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXuQiZ6Uxljth7h4zsRrHEZmoGaHKO2VIyJBKdyFiaI=;
        b=p8b8vwGvelTQXWhgV0es+RwLkhJtkKBDRxXeCnmoevj9pnPU/OEKYWAQ5Tiaq3SLJs
         RZWpoW4bRj02hiF2G/wItGK0b+l6x08Jse0xbhhpKue7tmuLFFEI6kRTd0hEe3ZJiTLk
         InpTEqLPlbSx+2z/cwKXjCuS20PD71/YchSRIQXjQ6qPKNXZEaV2A0qopg7X6zE/WUij
         vf8aHhJ0YnCEK9JP9TG/AQUKiljTaOUfDQUvRoNeypK3PIo83RyFppzR5OamAVKGyTcf
         5iVJhsQa6Ky/mGyOjQH1ohq8Hi9cXIefRWBfeY0HfVt/BAAKpKlpXWMppuSd9+QhDFiA
         Rknw==
X-Forwarded-Encrypted: i=1; AJvYcCXMS/nf1bWZgE2JZjt31ZUr8fc2vrQE4mx7/r9GnK3dADuh3SRMAojDHj/UrHMICi+YNtNR8UmnM47bNVprlGe5pN/p+lD2URRu6v5vv9h2PDIULhp/pApcQ1dKkGaB4soUxcTEaV+Fc/EPkK6k8SeOR9nruuPprkXHn1nh1jMZ
X-Gm-Message-State: AOJu0YzGGpulgb08Lzb5D910i2/daTWtsDcZvI9OhPMqlsE+H+iLrP8o
	CX3KZ1xm2z3Lbf5WOkg1URWAoe0rigNB0r0l8UjLACRc+nsetFhWGN6ALxUZ/+I=
X-Google-Smtp-Source: AGHT+IGNZK0ii7nuVFmi3UMPukJNc6P/XaBwLNfn739GOnYUs4dIu1Cf3G0hCJF4ek+v/drIdRnH/w==
X-Received: by 2002:a05:6a20:96db:b0:1a9:5e63:501b with SMTP id hq27-20020a056a2096db00b001a95e63501bmr2934392pzc.44.1713550396318;
        Fri, 19 Apr 2024 11:13:16 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a531000b002a537abb536sm5148563pjh.57.2024.04.19.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:13:15 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v2] net: ppp: Fix deadlock caused by unsafe-irq lock in ap_get()
Date: Sat, 20 Apr 2024 03:12:38 +0900
Message-Id: <20240419181238.29399-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000423dd10611261d47@google.com>
References: <000000000000423dd10611261d47@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


read_lock() present in ap_get() is interrupt-vulnerable, so the function needs to be modified.


Reported-by: syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/ppp/ppp_async.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index c33c3db3cc08..d12b8155e839 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -134,11 +134,11 @@ static struct asyncppp *ap_get(struct tty_struct *tty)
 {
 	struct asyncppp *ap;
 
-	read_lock(&disc_data_lock);
+	read_lock_irq(&disc_data_lock);
 	ap = tty->disc_data;
 	if (ap != NULL)
 		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
+	read_unlock_irq(&disc_data_lock);
 	return ap;
 }
 
-- 
2.34.1

