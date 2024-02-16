Return-Path: <linux-kernel+bounces-69121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE87B8584D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD33282DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DEB135402;
	Fri, 16 Feb 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhM6jn3u"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A341350F6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106781; cv=none; b=Wn0qTxawFULeQrq7xlzj/HogsEgemBgv6ZqyXb/BioAJStfA4uuqs4g/GKmpDWtkRadI7zwXWm+bsbaiiTX9BtH6Jpwd3Bl4fPaV4luW/Y164dbq/SKf+HMTrl5/1FoXpTJzyB3H0Q/A0dZqC5WvX7wG2zl4gEp3hNBO4qOo4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106781; c=relaxed/simple;
	bh=dwcDbWOPxRgiZhLXY8mPYkaEIPRTLSYlPdZIIJdc+Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVUZBYKKGSBlspMrK8TdqLbhkXNqr1hfOrG4tCxpvzRDOE5qfUS/3ApjYWAQIbHjXs7O5sfz9A7/oGN+TGOR9ICIx/+9DuhPSSAylQd3XN2Y/yY0OzEObFvUaW6HcarxN1/5mzQ1QrBv5XnFggH9tYRRlufJq8mSmO5fGakqM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhM6jn3u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7881b1843so20778315ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106779; x=1708711579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtvoN2Te8lsuMrpULW6AGCbHjbIm4X87ZQHxVBkQdBg=;
        b=EhM6jn3uGgGZb73vI9RkmtFYIcS+R/vLQe/gdAGCWzbu4a/iP76puwbvIGS2PitS6g
         Ukh1HuXnRl1O1JdYnKwXA6OA91SvJyK+t1YiykCvf6IwGSOyYbtiBHH/gWQm6CzxTOHL
         LAgexkt0+SN/hi5+b8fnW4ldJqDhKwbeCcq9zLx9Z1vO2M59S57R5LnUWjNFw/HtkSZi
         iuPin6jmDuNUoE7Cx4s5HdmBedPngMB1vQH1xenws1dDZbeqxcigOP+SiKL2h/1pJjow
         blwP4iY6AoWQKofqUdjZU6X4AEjmwFfaVuFltaLas2POIFxmhc0R6bMra47bNW+d6fws
         tQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106779; x=1708711579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtvoN2Te8lsuMrpULW6AGCbHjbIm4X87ZQHxVBkQdBg=;
        b=frdW6zAniv5rNA6mnblt5O8tUHPPiJxSu8TyK7s/scYg8rg3r2rqJ6c6adKhtijgyn
         Vdb4/rm5jeHC1p06VItY0kFAH67orD7yKyTVzQeTb1rRMrIq4RysfJnZ4UtY+yzdmn0s
         vSahvRAW2/9HP0il2wYBVBN5CKg+AzepZQwkcmSiTEwhFRm03iGYYFHaSmwlgnzUTCnH
         b7sUadnIQDir+xVOdjJR4qi9g2zdqs3vmpYddNIkq1zICMz/TEFB5meKj1aJMi65zyDn
         /xrhLiNdKGHedgddVSrbkR7vPCrXjOe6PlMES8mLIRUKtgexQhKVe7hP7fBaNZHkFjh2
         ZwAA==
X-Forwarded-Encrypted: i=1; AJvYcCUlAvF6w3/+LE56/DLjzeJVWAuc8yb8Ekr/+nzU+f01HEb6XGEMvbAxEwLrew1yIS84Swjcta3yt4HcA4JUGt1RE8T41FGaW8cK+ciE
X-Gm-Message-State: AOJu0YzhjvRP6i46olZeU9zLNs0PZgPmfcrdnM3o7f7KLq27rvqSg0zk
	6hPQkwdsR+oJjGFD7tbDG1RX275vmS18GEUjVSzOZP7QlpfbUVcp
X-Google-Smtp-Source: AGHT+IGMkaSGvblH3T+OFJgQBu3To2qLIEmYXBPn9SZZj3n2W6W3WLRw1wf3Q1TubPgLdjuDWvocWg==
X-Received: by 2002:a17:903:1106:b0:1d9:e18b:d916 with SMTP id n6-20020a170903110600b001d9e18bd916mr7103005plh.28.1708106778800;
        Fri, 16 Feb 2024 10:06:18 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id mn8-20020a1709030a4800b001d8d0487edbsm145269plb.223.2024.02.16.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/17] workqueue: Rename __cancel_work_timer() to __cancel_timer_sync()
Date: Fri, 16 Feb 2024 08:04:44 -1000
Message-ID: <20240216180559.208276-4-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__cancel_work_timer() is used to implement cancel_work_sync() and
cancel_delayed_work_sync(), similarly to how __cancel_work() is used to
implement cancel_work() and cancel_delayed_work(). ie. The _timer part of
the name is a complete misnomer. The difference from __cancel_work() is the
fact that it syncs against work item execution not whether it handles timers
or not.

Let's rename it to less confusing __cancel_work_sync(). No functional
change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 87750e70b638..7e2af79bfa62 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4075,7 +4075,7 @@ static int cwt_wakefn(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 	return autoremove_wake_function(wait, mode, sync, key);
 }
 
-static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
+static bool __cancel_work_sync(struct work_struct *work, bool is_dwork)
 {
 	static DECLARE_WAIT_QUEUE_HEAD(cancel_waitq);
 	unsigned long flags;
@@ -4159,7 +4159,7 @@ static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
  */
 bool cancel_work_sync(struct work_struct *work)
 {
-	return __cancel_work_timer(work, false);
+	return __cancel_work_sync(work, false);
 }
 EXPORT_SYMBOL_GPL(cancel_work_sync);
 
@@ -4264,7 +4264,7 @@ EXPORT_SYMBOL(cancel_delayed_work);
  */
 bool cancel_delayed_work_sync(struct delayed_work *dwork)
 {
-	return __cancel_work_timer(&dwork->work, true);
+	return __cancel_work_sync(&dwork->work, true);
 }
 EXPORT_SYMBOL(cancel_delayed_work_sync);
 
-- 
2.43.2


