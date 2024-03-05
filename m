Return-Path: <linux-kernel+bounces-92060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F90871A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01197281FEA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73E45A4FD;
	Tue,  5 Mar 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bR1OojoN"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99758118
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633438; cv=none; b=Y5pLvzItsUOnLS0MAJFHzNrX8x488HM3a2AlY9dWCUVA5X3jjXWMJwVs8nuEU3DjjXus3kealLfjKyNmDfnAjohm9skEBtNvA+9FkF5roAZc7C+n+Htif1M0RuSsIoUbyqeJ2QdzkIFnielyom23epYmwfdQg786o89EEdtN2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633438; c=relaxed/simple;
	bh=Ltfy4agIWW8GFQ2wB/SGVqMVh7NAol3Xo3zP80oOSxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AlQMOFPlMGbqqX3NUq28Wvu6GTTE18WjwENgGbKTaneUIsWobWvrZK8FwOhHVlzM04jmPo8ivmg1vTauQk6KPCbp6CNOgGaFgJ9LFKXrUutBXDuShZ2bSvlha3PK5dFpQbiY7OUFkc0kPRkmrevFyaYWsQiR2j0KiI7shbeTdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bR1OojoN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso3678668b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633435; x=1710238235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnsMPssoThTQkcXoWA9Ekbi5Q1zZTU79wL6KH4AEkgQ=;
        b=bR1OojoNY9U4kBa3O3RTA/fUHlIT/7+MWl5yOH6dqCjfqG+w44d97LtHsK1Q9TEIX4
         1JQQBRt2bGO+qAO5ydtCnY3axo8YGLtYN60zIKUoKUYzHS3qjcNL5mMCoUYYGxDHsYkX
         Pw9RO/oR7D+tQHgLT92MlZypeEfkKm1CX6leM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633435; x=1710238235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnsMPssoThTQkcXoWA9Ekbi5Q1zZTU79wL6KH4AEkgQ=;
        b=Dv7SYbrY7SFlMoF5UozzHLqjdiR4Pf0MgZa/DEukERbM1XWnvpWkL7Z6py/Qo4r52R
         7Emz7VOjJ36HuYD1piqyDN/L8fuvV9ISas/LemSmQxpKAn7gHNntfi58x5F6PmlZPB4X
         ShHmdrDhNdAmkFKmAUBrrITvXtJbqOlyhzgSj6jOzmHqAr8gfmZVZNwki0eA3fcdGh4Z
         RzKURM/16qRZBiS+BT/5sZTJe8SOTrl7LhhmhWqOG9iZBI04DH04D/s8fV5f2FdXkfhe
         H7dTREMhfI0IHfAhafS8Omrr0KjVoAvjCU3yB4MakLqenJrJqBezKk0d6x9DAZKGO1++
         PZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvRb64+TgYCIDfszJbvsRTCNSUeprwslcgsuC+7lb6aRCxbHxTTvh7KYZ8luzl/c3d2y/ko5COKJmJ26Vk88S55/kCemENPVNRxXyv
X-Gm-Message-State: AOJu0YzVREUHer1F5Fr+EOJ68mO6QHbrgYtUSqb/mOv/Uv75kW9Y4072
	hdOBpJ/xymZ5i3NCT+pH9niZiTMDB4lxcvP/Hy4Hhk4kYoHgGetAFUv33A0erA==
X-Google-Smtp-Source: AGHT+IEiAWTgdgJYXNyV1wO/0LoKLC3IKAkw+TtluHY1zuMxHwA3vOiKJTRV4nyNTDEQlhJfiH3Lwg==
X-Received: by 2002:a05:6a00:2354:b0:6e5:80a4:2ff2 with SMTP id j20-20020a056a00235400b006e580a42ff2mr12396375pfj.30.1709633435073;
        Tue, 05 Mar 2024 02:10:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79849000000b006e61b0a4b17sm3625323pfq.185.2024.03.05.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 8/9] ipc, msg: Use dedicated slab buckets for alloc_msg()
Date: Tue,  5 Mar 2024 02:10:24 -0800
Message-Id: <20240305101026.694758-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=keescook@chromium.org;
 h=from:subject; bh=Ltfy4agIWW8GFQ2wB/SGVqMVh7NAol3Xo3zP80oOSxA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+QWH/R4wFO4/C60XHEU8ysAaQUzkDa/3+3d
 QWUIDhM692JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 JrvaD/wNahnrlFTqZJolsZvbWW0JKOIUHvIZ9tu5KXbYjElEyGOPqLCj2ubk3S/Q6iA9219qfa6
 pGqd/gb14P9uZyXmRoI9+3bS4VDQCYU2pVYoTkpLeg4mS3bLPisEIDg13VQAB8yGYFFzgx570th
 kBc2psi8XalZRDb+22nGBoKA0hP91pQ00G0kJzgtIobHvLf08qFlMvNbmsE5Pme/RYM37z+uKJo
 6Ht69bJWQXxP3brIzWYPe9S0kO8dNubvglHpUetBciWXQNmWqzDhkprvcsUARwd7gUvgA4Zl2bU
 BvI0Fxk7BBq4ju+5KUIEligRbrLMIOn2dxUIdSfr3k4opmEl5ETlonQ+wt0savTeYPsbW/lgGwn
 v86/q0pgtJ/5Oxcd8pnWLe6dDPg5ZGQ00IiZ9h1x5iSLqXFJ1MFi/B+uFSaLnK0guFBVXHIUCmV
 I6mhgVKYMZALTQfYuz9ZZDYkV9pTJCysElPoennpSXdeUJ7Pc/edHh0770uIOALNa6rXB1b+K6i
 Yd1XOLuB2X7tDGZOo7NgNDNoxOX71alUQybWMW+kUfUFYB5XoVlC7XOD3Ax3ixm0n6sjPCVCuY/
 t2ge5/Gjz6GsJY+hlaCoZ/t+yhtmsbD3m+Gu2eA5hteP/AAmSNJGiBGNGgQ09SV6+yyLUeBYps5 sysZ56s4nY6VilQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
use-after-free type confusion flaws in the kernel for both read and
write primitives. Avoid having a user-controlled size cache share the
global kmalloc allocator by using a separate set of kmalloc buckets.

Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
Link: https://zplin.me/papers/ELOISE.pdf [6]
Link: https://syst3mfailure.io/wall-of-perdition/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jann Horn <jannh@google.com>
Cc: Matteo Rizzo <matteorizzo@google.com>
---
 ipc/msgutil.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877cadd..f392f30a057a 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -42,6 +42,17 @@ struct msg_msgseg {
 #define DATALEN_MSG	((size_t)PAGE_SIZE-sizeof(struct msg_msg))
 #define DATALEN_SEG	((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))
 
+static kmem_buckets *msg_buckets __ro_after_init;
+
+static int __init init_msg_buckets(void)
+{
+	msg_buckets = kmem_buckets_create("msg_msg", 0, SLAB_ACCOUNT,
+					  sizeof(struct msg_msg),
+					  DATALEN_MSG, NULL);
+
+	return 0;
+}
+subsys_initcall(init_msg_buckets);
 
 static struct msg_msg *alloc_msg(size_t len)
 {
@@ -50,7 +61,7 @@ static struct msg_msg *alloc_msg(size_t len)
 	size_t alen;
 
 	alen = min(len, DATALEN_MSG);
-	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
+	msg = kmem_buckets_alloc(msg_buckets, sizeof(*msg) + alen, GFP_KERNEL);
 	if (msg == NULL)
 		return NULL;
 
-- 
2.34.1


