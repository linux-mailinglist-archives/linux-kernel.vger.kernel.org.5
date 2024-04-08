Return-Path: <linux-kernel+bounces-135955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7A89CDD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD5A2849DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F5614884B;
	Mon,  8 Apr 2024 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFTehzjZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A011442F3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613158; cv=none; b=bMnxpuMB7jn/fYDO4lJBZyaqfWcfI2v/jdJNLnf+pxqHV/R3otNN7WmiBeSVog+wPwHdgfxITvUhrxXL0SDSml2xJ2a8U6jjCbc9nnv9U+Ar9RmYRtZpUxthie4RlXtNX2zjHHjAQ0xOF2fOg9KwALfJDeTgoteSg2aSg9JaYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613158; c=relaxed/simple;
	bh=nvpM8tXyK/CURoTjuw83DuYMKwJ9CyjRJDN6oCQ+WcM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rPMlj8DPgvA6VrR/cw+M53jrKN5k9cpnJ0pBvQ1DS9yin69sllS0lgoY1IEjA36rJtDiZZNR7eDPuqFmvT1NNi8XACDXFlxjkI3uDxlgCJouxFdkCJ4TM+kSz1jcqUT0ytd8cpgSWO4zNDBdN/htOAC+CERq/SDWiGg64zYXxuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFTehzjZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61506d6d667so84903427b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712613156; x=1713217956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=amcZSzW3yyTzEXypL37TcjBNZBV4M3dWgOvIguTbuzI=;
        b=KFTehzjZWAYt/par8SOgZJrE6uQ7QnRoaIeo1W6zXkM/3vv17gRR8exgPPpaXIsh9l
         7SHnq9H/+ZkMzn9lYDlsM7Z33ZeT+HUfbIA/OLmi6PTlRR1zuKfboNs8uFNNZqk6YW+v
         VgCWq47v3o0c88gEc6nlR1dO/HpnplipYCAT5v4LNiQTIUA/T7vsXxC49c3cpfDHXpyd
         FMUQ6sdjfWRJ10vd+r0RWBVEurVBSqrOIAIZ+RoKgFaYo2OGjtlEe2lH1iHuEI39/Y7o
         Nk91oi5ry9ANeV53K6QbwK6/yAiKIAOZI0l1mSVPz7IjfeLfu0N4/4V1f6+RGqRJq8y0
         IodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613156; x=1713217956;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amcZSzW3yyTzEXypL37TcjBNZBV4M3dWgOvIguTbuzI=;
        b=tXpRt2oKYttLh5lKOW8wFpVfYD6E8XMlNj4ODZHCMXE36TYddYrlmMO+Ji9VAPhsCl
         BmcK4LFMLQGoylNzm1QIUJEA8hdbqJVpLxxw6O07AmTCYah6IxizXj9euFsyrOhkTt6N
         sTt5dyeoylPD8NZeYCGvsCPIy6O2TyRuY71nDnk7iJXmgBS/upIJVxTWxlDE/RcWWNPu
         b1og5qj+niAxF6BJYuZ7IRFaJEP8hLMTGyLABzPauHCttvwGavZG7L71Uwf/Emjgnz2e
         5lKWlCSiHpmUk6e/my8kcVeZTNJQUGAmqKozGzYcdfFMO8PtHkLMU903OJSs2a3cyfm2
         uVxA==
X-Forwarded-Encrypted: i=1; AJvYcCU4O5/HndATFQKc6Se9hAfxOgvaVyG8ef9AePO23RBrzPI/EM+n9ghjIs537AlCld/Xt4aHX2yOB5mtEiGtQP/hWMiJ7zuXH/P28/2o
X-Gm-Message-State: AOJu0YxuMLohkh05XWzdP+dzkbtITJ/09v0wT5vmyxwTA0wlEwDTkr0d
	AZRdSv0HiuPaHD1IHFE15PWXUS1MgyBN7Pc1qYLt0GXeHabMA+43axinsAaDMwIZlNAv8ly3wT7
	TrbIccw==
X-Google-Smtp-Source: AGHT+IEkq+yrPhgyYDRCrGfUbGremKSvF9Tls/NyM9Ex8fLO1ww0uaL+bHkVzWJv2HGc6KYIwiPvmzeEyS36
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:9081:5db7:4b17:a606])
 (user=dhavale job=sendgmr) by 2002:a81:ff05:0:b0:615:12a5:49c9 with SMTP id
 k5-20020a81ff05000000b0061512a549c9mr2538367ywn.3.1712613156122; Mon, 08 Apr
 2024 14:52:36 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:52:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408215231.3376659-1-dhavale@google.com>
Subject: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
From: Sandeep Dhavale <dhavale@google.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, 
	syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

erofs will decompress in the preemptible context (kworker or per cpu
thread). As smp_processor_id() cannot be used in preemptible contexts,
use raw_smp_processor_id() instead to index into global buffer pool.

Reported-by: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com
Fixes: 7a7513292cc6 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/zutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index b9b99158bb4e..036024bce9f7 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -30,7 +30,7 @@ static struct shrinker *erofs_shrinker_info;
 
 static unsigned int z_erofs_gbuf_id(void)
 {
-	return smp_processor_id() % z_erofs_gbuf_count;
+	return raw_smp_processor_id() % z_erofs_gbuf_count;
 }
 
 void *z_erofs_get_gbuf(unsigned int requiredpages)
-- 
2.44.0.478.gd926399ef9-goog


