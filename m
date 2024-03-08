Return-Path: <linux-kernel+bounces-97097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD387657D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C050D1F25821
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F863BBE2;
	Fri,  8 Mar 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLJFRJ/4"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927217EF;
	Fri,  8 Mar 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905165; cv=none; b=jMBIhFv2MpDCz48653iD3QZ76jBZKACxcXJkegndVJRZgRSakCUFgdUwHePZKVu1BfaxyZmGQRZmFjXJhpvo8n1wEUX6CD7Mxl/cyKMvoEHNyOMWWzbcFUmfZn6V0GHDFFHDDDchv2jIs4YZWLtjqTIWXDLEAmVC4h7Op/7IZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905165; c=relaxed/simple;
	bh=27ijGwAcHi4/OxMZhzEqyuP8A1bO1+mOagHVsZu6/LA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cc+tbfV5AgsPBUDjdodFtI+9MPm9HUVXDonFYIQkdoFDuGw5/7olAdKluuNrvlLLqYqtOZBEmxEwZ8YhHv5olWIRbDPu5hNrPgTPL54faYdJH26v9/xczSoQ3G4cyYvYy2KqAzIxTy9asihUf4YxANPIx30UMMoWybEUhrmp9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLJFRJ/4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4131a5e3685so3669685e9.1;
        Fri, 08 Mar 2024 05:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709905162; x=1710509962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmSwf1GXNG8FcmTatGusE4kangHWWi5lffewaC7Q0+0=;
        b=kLJFRJ/4hZUryTY2x+6EPxWic547FIja1SImiggjyuPjLSfpjw8WUrhYzwWZ8/H/1W
         EOL15TGMkPYCe+L46mAJBxPzb64W2TOQdMTby0lWfVS931w57QDEKlBv7g5f0xIx2bcv
         RWfKtQ1Gn1ODyeHszIQeWTNVAXlSWcqTS7J4FAy8KKb2OqwQEw0QX/UertCjCTtx23BF
         NoX5pBrE2DJsGlHQDwG1uSNVdl3R4vOk19oj4eOIcl2fDLzFi3NRnWDMiSXy6kslmW9s
         OYDe7xMEY1APdnyqb0jp2Y5KIH0A0qvVmr25ER1UsUWCCPRj+Id1s4FDykOay2CoMTix
         0weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709905162; x=1710509962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmSwf1GXNG8FcmTatGusE4kangHWWi5lffewaC7Q0+0=;
        b=xFfWgdIRqdYuwI/OgH6JZhKQyldwnDM/tLqXAUp6+4SJOiyvVLaIjBeC3CuB3dxRTA
         rClSxP+X7x5eWy1ftK5n5p6tAuwxzb5kWGh4wbTCD1dAGWdLn1at4quvzgbu7c8glZ9A
         z0lm2emqPPse941XaYGYXUd/6Gw/YNfBX+OGVuRS4XEZMSw7w0U0sGqfgEOundU3YR+x
         VJFA2LjEkGEPtM4YQtnC6j5clCluEwVlwG8u1XHHsADjM6I4f4/hIZa6nGnqcDbc3Fl+
         u+8V/NlikIiz+x6NT4GYxzuvY8ZakQ1CGn/EVnzVu2XtVMOHz9q53YA+Wm8AYGfNP9ZP
         HbOw==
X-Forwarded-Encrypted: i=1; AJvYcCXiZ6kuN7PjG5uqOg/IKA2w83fmdw93o9nRd8/3u48n05DhpKQ7mvAZD7FaGQgozFzAL9U8+27mJOe75krJFheOvVdm/j+WX+DKuExUPH3T02I3OIET5X0eXuWvjcifQv8+UnjTsUCEdHU=
X-Gm-Message-State: AOJu0YwvVVwFIV00OjyCWweIZOTlMc6jE/vFUBBR2CGb+S9ou0h38jZS
	lNUJY4b8dZxXAow0g0ObkwX/ak3F04cD7pAUEDmNitj9W4qbOQV+r1tOYo5QXSQ=
X-Google-Smtp-Source: AGHT+IHV4nlHLhb/Hc0jjbbFGVfsp8Wa9NojsjwaQ+UHmL+O1QQPw2dQQDsm5KU5DG2ZSUv0O+m/HA==
X-Received: by 2002:a05:600c:1e0e:b0:413:1438:cbd4 with SMTP id ay14-20020a05600c1e0e00b004131438cbd4mr2628577wmb.17.1709905162087;
        Fri, 08 Mar 2024 05:39:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b004131bb71c07sm948625wmb.11.2024.03.08.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 05:39:21 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] block: partitions: only define function mac_fix_string for CONFIG_PPC_PMAC
Date: Fri,  8 Mar 2024 13:39:21 +0000
Message-Id: <20240308133921.2058227-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The helper function mac_fix_string is only required with CONFIG_PPC_PMAC,
add #if CONFIG_PPC_PMAC and #endif around the function.

Cleans up clang scan build warning:
block/partitions/mac.c:23:20: warning: unused function 'mac_fix_string' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 block/partitions/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index 7b521df00a39..c80183156d68 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -20,6 +20,7 @@ extern void note_bootable_part(dev_t dev, int part, int goodness);
  * Code to understand MacOS partition tables.
  */
 
+#ifdef CONFIG_PPC_PMAC
 static inline void mac_fix_string(char *stg, int len)
 {
 	int i;
@@ -27,6 +28,7 @@ static inline void mac_fix_string(char *stg, int len)
 	for (i = len - 1; i >= 0 && stg[i] == ' '; i--)
 		stg[i] = 0;
 }
+#endif
 
 int mac_partition(struct parsed_partitions *state)
 {
-- 
2.39.2


