Return-Path: <linux-kernel+bounces-140817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91C8A1916
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE56282668
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344D7FBA1;
	Thu, 11 Apr 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J52FszqY"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5B7EF12
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849601; cv=none; b=pc0TMPyyysiIcK+HQ8I7GT+NoHhixo9LS1Mh+AwaZ3VWktcrUIl76FHINfUlAtKJXSjf7Xxe+p00SX8KVaeK8cbAJuQsnRCnsHBO3jHH0RwN+PW1ehU4c9o+Ac5aWZYnNbIS4yB/MzD18Ut0+ncZsEY8aUpb4Tb42OMaJ/mTTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849601; c=relaxed/simple;
	bh=MXvvEeKipA1G+7oEfvEw5JngjhBVg2ht6/Kw9QFunSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvzgUiPhvTbOzgCyPuB4iKe18OlcmHAMnckzg3J7r3E6VG/4X36k14z7cPZDIJubN9vbRNjcQg36KeyFFdMvPdBhs46EzOMYtyZCktAsVD3ebSrNlgo57R6MX8xC5X8RhuIV+At7JGR1tpbGMxEAa417WM8vjsQBjFdozgJDZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J52FszqY; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9727439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849598; x=1713454398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRjGjwzC4TmLZADFw5ikGcW/m+835psHb3ho0jeo02s=;
        b=J52FszqYjdDANUUx0dWb9KZEq3A2UUIJXHmePARFqxo4K6aSltAegKuI2B7EmP2FmP
         raUEq9SHvhHbByI5ClDny4cTGVEdnWR4PmBLcwvytFkK4kTAt9MZ7t+vzi1Xt7WwR0zH
         +uo+jm19vgUmQQ3QNgP6Ca7eNOZPRZQwUh6hYvWFvn0fs87r0azL1J27nUJMw4h2/ghn
         pbllu2H6vR4ryj+6Y6DkA6m/3jA8o93bdKibUV3fIcOhA6ZCuBObuEjk9z3lQWcuKJDM
         0s3vDGtoBs7Andka8cPlV/ULOGfBir/ZHeAjq8Bi847TtUqgmS9z5y8Wftr5jmzr2xmD
         Umyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849598; x=1713454398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRjGjwzC4TmLZADFw5ikGcW/m+835psHb3ho0jeo02s=;
        b=SaYwxiNlfe7UzZSQg9T5xe4ApA/pHf6vgzRzGBKRCTWxds6ji5l2dJzLLVrAIw1g+P
         vEbAsRWAfBff7C5w9ai6hyrrtghVMASinc6EcoUOWqsGMgVuGDb0/qmKblV0+Y25KH8P
         xgmrlgkbsji2vuVRvxxMFUliUkYUIdHCwEekOgW7E0ucWtXvYa8HYbT0ZpPWRjW1AHcg
         L6KULGyWpw+bnLaTCYeQAZ9CoJfihnUv/iMgrB8vd2eu1CDv7kJIBJYwNiLTgvFgrULB
         3DctczS1QyWYNha4MET2ur1yGYQrOi8QIB9kGugyjJFo4H2A9UbbUjPqpsVvnNy3PsQM
         fyQw==
X-Gm-Message-State: AOJu0YwC7qF3IA0HZH+1GbJglpLicRNC69ZZe7hWrsksicBWg6Ei8PSj
	pn6KKrPnO+i7jNIb6k3iOWfCXTYFG6A+Og0NEtSxgKXXt8gk1q/qdhvO4EZ/oseWskO1pP3V4GH
	f
X-Google-Smtp-Source: AGHT+IGrUqG8I+lcA8frZ1+FZqp/1xi6hEOWX8YtlSOO4eEI+pA+7xiMD0aCBvTmDITY8DteZZpS1Q==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr207107iof.0.1712849598598;
        Thu, 11 Apr 2024 08:33:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 057/437] net: l2tp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:17 -0600
Message-ID: <20240411153126.16201-58-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 net/l2tp/l2tp_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 4595b56d175d..943c1ea51900 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -318,7 +318,7 @@ static int l2tp_dfs_seq_release(struct inode *inode, struct file *file)
 static const struct file_operations l2tp_dfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= l2tp_dfs_seq_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= l2tp_dfs_seq_release,
 };
-- 
2.43.0


