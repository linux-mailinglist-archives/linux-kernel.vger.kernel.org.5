Return-Path: <linux-kernel+bounces-104353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FC87CC7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A63B223F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24ED1C69E;
	Fri, 15 Mar 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZA8tl7Pw"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623891B81F;
	Fri, 15 Mar 2024 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502743; cv=none; b=ldR4B3ISFYmLSGu1nafjSSo97SW4fLW7u43VRSm7xl7Zz6hVMtwIlzIGdTR16oSudRus/HjgFOGNw1qeCXIKgWmHQuO3FFn+o1mXARoqGQPr0cUyHWhHSUMiH4lOvpstUQ32SH7EyAZ6BNEPXDuXm/MbZBJbBwodRc399UBgM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502743; c=relaxed/simple;
	bh=HmGGEmUedu3998fS4GIHrSJ4xICz6CRhS6+OSHoY6Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoyEfMEZcVXAUi620WygZsP+0JaooSUBYMBXpPXfd+/RBdK9q8wwEbpIsPHNSnSDyv5sZSeZfLHTutvwbUUtvxzaGr1nxCNO5THAccWQV+Z44ENzc6S9fGxrOG+LCDgFapI1YwbB7PxUuZjZAQhy4+axLdymzOaI7m3ETSyyCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZA8tl7Pw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2669626a12.2;
        Fri, 15 Mar 2024 04:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502740; x=1711107540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbGx8NSxuyFGtW+6h8d45ucKpQT9LiM32oyhrb8awck=;
        b=ZA8tl7PwfGUz8WjOiAFleW3DARsqcXFaFfcDOQMw3TYtTzik0vZPdNsOKWBJku1RoK
         mY4YiBXV90aMio9Cws3Yn/isaBC2WNZhKyBUNHVA7V4sMbmugdXomAad7VLNKEw53jKT
         TXx+YEC8qq3GByVugA5p+nhL8flbBBWUCuth0Ps5diS5sWnFP1u78w04FaCML56IMoOu
         oFRlWKqH3LHwxBH71LmVywGMK+00KC0ZdGr1F+qaO/FVsCIZOFMWqdqoWncY5xsutC/C
         jLHSgZu5DMlRgmZ8stSBXTwTfTvAO7nDZnyxGwRmK1IrmEfyYNRhfKhbUQ67NQUM2kxo
         qDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502740; x=1711107540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbGx8NSxuyFGtW+6h8d45ucKpQT9LiM32oyhrb8awck=;
        b=Pt4RcYkxNYEB5x5abCcx72HZMyX18dfWastShNURd1p/3OMYAVQpnOfOMpfj50mms+
         R/+A9fvxkZ+1lC16wPTksN3HfjxMVgiYhRb0iXLoPAIo7BYrPpoaCZLws168yFTWsp50
         3b66PGjofOAFLFyXigK7Qw+CCJFJn0cX/lecHl6/g85KvdWDPeaTeMkaO1t2QXm6YzQr
         KcBnGsm03JmTLXs0mgysrbuj0JUmTtnjQNajRKkE+XHvsJn8lPFO2K10cF66b+WthRjY
         6UH4hPaIyN43Nf5D/VqqvPR3v3l/MuweWoiCSYxvJ7pgE/fdgx97J813JRvhXNPWAMgX
         adig==
X-Forwarded-Encrypted: i=1; AJvYcCWyEkQKJvz8D4BNTKEx4EhcIMBH88bhVPDAmqcQKdMQdDsyUm6GJig5XeoTFEU7SsHPBb8APrgfD0FirxNtAK7EPZJiwb8IEGTZRsCGH76HkE3OAdXlCALfJski3i+zH9fSsWDDPSpoatf4def8ZqYpG8PBQsJstFafy1TlP/Q=
X-Gm-Message-State: AOJu0YyiwMDMK4VtuV4NwjXz+m9x326o11hP21cOaBgCJF0v0eFSK+sR
	xEQBuzFWEqkhGMJXNQv6LZUBNzBunXk94zQ3JXHADMwglTAQOZ5Hy9YIyNxOjkeNpg==
X-Google-Smtp-Source: AGHT+IFY5K+9DDgx4ObwJ0dCYxDgSvtfoZadfKP7DyB/rvVKCmS0q5ZNQdZ4UE7liIIVw2Wnv2Owpw==
X-Received: by 2002:a05:6402:b34:b0:568:32cc:f808 with SMTP id bo20-20020a0564020b3400b0056832ccf808mr2135290edb.15.1710502739644;
        Fri, 15 Mar 2024 04:38:59 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:38:59 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>,
	Serge Hallyn <serge@hallyn.com>,
	Alistair Delva <adelva@google.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 04/10] block: use new capable_any functionality
Date: Fri, 15 Mar 2024 12:37:25 +0100
Message-ID: <20240315113828.258005-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Reorder CAP_SYS_ADMIN last.

Fixes: 94c4b4fd25e6 ("block: Check ADMIN before NICE for IOPRIO_CLASS_RT")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   rename to capable_any()
---
 block/ioprio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 73301a261429..6e1291679ea0 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -37,14 +37,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			/*
-			 * Originally this only checked for CAP_SYS_ADMIN,
-			 * which was implicitly allowed for pid 0 by security
-			 * modules such as SELinux. Make sure we check
-			 * CAP_SYS_ADMIN first to avoid a denial/avc for
-			 * possibly missing CAP_SYS_NICE permission.
-			 */
-			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
+			if (!capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN))
 				return -EPERM;
 			fallthrough;
 			/* rt has prio field too */
-- 
2.43.0


