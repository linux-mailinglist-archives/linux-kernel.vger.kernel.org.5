Return-Path: <linux-kernel+bounces-159349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189018B2D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AB028148F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B615624D;
	Thu, 25 Apr 2024 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bctpz+Mq"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9B1482ED
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086397; cv=none; b=LLL6T0zPiUPS0OVsLAgqE0DTnvfIEEIa7viP8krc9YXa1TRiQfuhfpBHO9fAUxcGXSnBa/xP6Kes7nOGSl+Dd3LJvYeO7v4jp392vIrJsRQR3jh3Z4UnWM4eZeshZi8e4LoL+01rlnmALsLnzu7vFYjYc7GtZSP2KnqjnEmJ4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086397; c=relaxed/simple;
	bh=UHhZMO4wsPohpM267TxwlQyERAVgSovrHDaKVDatEAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UHv3kdkAACE3Xwgg7JbjuJ4v3sd/6vyhYCMBypaWOghY/DgCm+mmSkkkFiUMWBB+RWT3NuE7Sk/YPoRh4O6uDcIhLLWDQylBnScNckroezZNzcHICbK3ggGHZhd2IbphEdpUu3wVjhO1vxWm4Rmjg26cScBOUf9CfvFI9tXiiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bctpz+Mq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-602801ea164so1066058a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714086395; x=1714691195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eimymwStJklzCg6oX/uwhhiWiHrKmDQSvz/PwpeJ5xA=;
        b=bctpz+Mq/+CzasY9IabdixZros5CwYDrzjWnB4pPT6EyTUYAUnyeACZHyWjKGw1Ale
         g7U5PBVN1kdMoRtmIYflW2l4lWnRpcPZ5LDL7dxn9OcdFauu8gOUsaXD2x4JAk/7kP2P
         TbZ2CEk5yjgLzq+NjoRJZqbcF+zpP0ZqewmQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714086395; x=1714691195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eimymwStJklzCg6oX/uwhhiWiHrKmDQSvz/PwpeJ5xA=;
        b=EGApBupqZyXVIPDPFtXn7wHlhMpExYE3XRD86MdubYriqkRk11dVjaD9G0u0ToP5p9
         VEK0Y69qRazCxc8pVyIVOLaetl/3GdYB6ctlZsZD19q3n+PlAfkwakJQA2LVLeV29XZD
         LrjcqFxRDCe33uyYgL919luT5BDtZoNJRD5MNt3QRwYHSQZcw8/JqHsJfIfTNHEto4vD
         TOabVGoU1lrAoQog4ipWW4gnRF/IoOPM5vWNv5UgizeRctteMu0dH8CiAkwGBVg0TULn
         vcLePj/HoyiI8BIA/CHehjcK7Cu4HW+B+1TxaTxGWwTrybp2q8kjcRr9FVy9avpDlm42
         e0pA==
X-Forwarded-Encrypted: i=1; AJvYcCW20E+XRos35ggFlqGEwHOjvw57/BiFboUPmDbLkuYKVg6dIlCJWVqcMW1GB8aCXhLtjaNHiEOiiMWYU7580VAD7wjkqHPkcLGwV7Gj
X-Gm-Message-State: AOJu0Yw9mDURF5rz7Y8My9Jf2eIbw1d+xpTtalMxQmKqIxOFWg5gk7ll
	cVWxQvIP10nICjuOfZ/qV/fbLb4Of3dATMJ8ENMdDJDXknYSHV8GCdTHlX9P2A==
X-Google-Smtp-Source: AGHT+IFB7CnZjhjbMqdLCxL6kbNyz0I6plqQ1HFZ/+ut+Ov9dDgBqYochI1FrLuh0b4OkdqHN2dw1w==
X-Received: by 2002:a17:90b:3901:b0:2ac:23ec:6a57 with SMTP id ob1-20020a17090b390100b002ac23ec6a57mr1016016pjb.39.1714086395600;
        Thu, 25 Apr 2024 16:06:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r92-20020a17090a43e500b002aa783c7749sm14654513pjg.41.2024.04.25.16.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 16:06:35 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/fortify: Fix mismatched kvalloc()/vfree() usage
Date: Thu, 25 Apr 2024 16:06:22 -0700
Message-Id: <20240425230619.work.299-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=keescook@chromium.org;
 h=from:subject:message-id; bh=UHhZMO4wsPohpM267TxwlQyERAVgSovrHDaKVDatEAY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKuHuxg9F448O+LhNizuZFxOtDE+n3+JMQAGDA
 4S9WH+uxy+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZirh7gAKCRCJcvTf3G3A
 Jp1dD/9wP9m0Yaj569sYQSXqGdXzblOduIrMo+AtFRvc0xd2AKyJHxsXLS61T+INM59iouke5Aw
 9YR+LuCdPp9eXN5Yu7P+9x+2B6RFsQWD8L4wUT/0Hcqh3Gx4lgbAT+IuTmKhfChASyJw5EgayV0
 r3c5pUeL9IqA9U2GSAukL3RgZ27hj7oemfxzttW2SsBfPO8sAUnxPT54a4ezY4zIJa/VZt9qsp4
 WIyeraP/osKgdFsgZniGgaID9/u40OAIKmHAMaUnGJiuhUFgT07goRW860r17E2n7WLgzesKnZS
 usocK3yVeqSknuv1laAy+zPeqQL3hWToTLYDH4S90v/mDXUf33sp/qE83LWH7ta2UFe8TsQWto4
 ckzdW/o4484lPxp9AdJJcixfAfqAt1GfGEriFvhqheOOGGlhHQBZqvIVFCng1+REwGqcunHAGSF
 fNOU2HUhp9qnump71s6Y/pLTAX/Wkq/BgYR1erAKn3yDnHT305hOTy2U+2s9zZrtlNpZSfgR5IM
 2ycTNB9RxeEJnEamzBDJ32l4pfewKZWoTXqNbXc8MIW3XJEFQOuQ9B3I3azu2orrc8VWRjNWI41
 AXhG8ZyI35kCEvwmkbTty+rV/uiSu94hAM1b8gM7CtijFh2nDWoTi9CzHIR4LGynVgiYvuw4yXB
 K0hpqmw QyqV5aEQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The kv*() family of tests were accidentally freeing with vfree() instead
of kvfree(). Use kvfree() instead.

Fixes: 9124a2640148 ("kunit/fortify: Validate __alloc_size attribute results")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 lib/fortify_kunit.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 493ec02dd5b3..86c1b1a6e2c8 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -267,28 +267,28 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(vmalloc)
 									\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc((alloc_pages) * PAGE_SIZE, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc_node((alloc_pages) * PAGE_SIZE, gfp, NUMA_NO_NODE), \
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvzalloc((alloc_pages) * PAGE_SIZE, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvzalloc_node((alloc_pages) * PAGE_SIZE, gfp, NUMA_NO_NODE), \
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvcalloc(1, (alloc_pages) * PAGE_SIZE, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvcalloc((alloc_pages) * PAGE_SIZE, 1, gfp),		\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc_array(1, (alloc_pages) * PAGE_SIZE, gfp),	\
-		vfree(p));						\
+		kvfree(p));						\
 	checker((expected_pages) * PAGE_SIZE,				\
 		kvmalloc_array((alloc_pages) * PAGE_SIZE, 1, gfp),	\
-		vfree(p));						\
+		kvfree(p));						\
 									\
 	prev_size = (expected_pages) * PAGE_SIZE;			\
 	orig = kvmalloc(prev_size, gfp);				\
-- 
2.34.1


