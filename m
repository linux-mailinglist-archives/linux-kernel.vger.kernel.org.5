Return-Path: <linux-kernel+bounces-141125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327958A1AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B68B28EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E91EA744;
	Thu, 11 Apr 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kBCTdowk"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F41E9C2E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850077; cv=none; b=GxzbziRgu/PnE49IHWwR9GbeEyYbqCslp/DWwXnITtwyF/8BYbUlTWCTZMhyHtQ+0yZa7b40GZ+4ceUhPsfmKn1+Xls1/GU5X8dXuaUc5+Pje8zTouyZ6LPz/ew/MucgcAA6fPCpyMbxZxT+ZqE7TqEmiFWW+jH7qc8+HqCMhXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850077; c=relaxed/simple;
	bh=j4AyBh09Y/PFBXy7IvktHeljaYLAC36fLppXt93g+jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwY+mmxKhPbT6KnUhwzoqEPcJLL15MATuf6axzUcpc9gcfAWexExrTldaGC17U77bcB9OrVigrk9EIdrwGh5KSMcQ3HC4XK06iohhAmX1MMWUXCs9ySJdAeBFBTZB0uUkBpAAEz+aVhhITQpD+M924uKZWYh9ZplqQ4IaMBDGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kBCTdowk; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9904739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850074; x=1713454874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3uht9aBlkrsCLM3su+LGMAtykGs5fn7572ZGAj+gSg=;
        b=kBCTdowkXZz1HJwdTdj09FZV6eyPYxQlIYfgGCmeUv4dpEa8w9JE1ySq7h/nsWVlEa
         ShuS2Dob6SGZ15RF7mWbRAWIVeA9vsKiemPTe1q7zM2V1+U0kP8+vfkjHkjPglMvn634
         tb3ET5/6QhdH5+rS3ngWcv8kFrfADdjK9c/7yzQnBEu5lFDUn76KE6O/Pddd4xV7AxLh
         8wqiBHQ1JuK8h/1OmoYYPhYZMbEvZRYUpL5ZD6+uqPFGdRERPdClJpmzXJIHeCx51Qns
         1+aKnB25+khQi6iIA/wji+Fs1qN+lit+bQwkCdXROan9juWb4M0tqTfK+h0ITqHCH9QW
         L0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850074; x=1713454874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3uht9aBlkrsCLM3su+LGMAtykGs5fn7572ZGAj+gSg=;
        b=HR7n5bo1O+mv0izg4O3vqg6gssnFDkxCT3JnHk/6nbT/RYwSYncBdoP/FyFfX+mM0W
         wnYYhA3b09nPh0R65F4t9CQ+GUeDLZ8Gin+2TUEBq8yhAyypks9sImdmSBEVz/tkG9hm
         K1sXNMDeEfsFJghe1Rl8O7vtspBr/TfD4awpefcwIHP72gYeTyV0MsVv4sT44LYpwS1L
         bzvNf86ULwpvnA/H3WaHWT7sB3/gFC+AXksB7THR8UReKShcbHD8IUQ7mLchH4vATAuw
         yxARwapQegIxhjEZyQnhSXTuVhqwnVofAS65b2/iFb/ozbqWO6+1fkWisWc1nS0jrDGx
         CSfQ==
X-Gm-Message-State: AOJu0YxnrjBn39jlQavhACkE/Y1USqImB5Iu7B60H723HWGtPqiwoBcZ
	mmOFDPOwfpCJuMMaDnRyXdioyVPvSfFETT9CiKSqWPDQQvZg7e0jogUNSQFaDZ7jOOoxxkKdSka
	6
X-Google-Smtp-Source: AGHT+IEhaWt52FIfvtgDuAVnmA/KVBLwW8DJjigC9NxxyOrZXGXMHAeSIuBS0VrsEe2Zf1rNEzvk8Q==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr206232iop.1.1712850074591;
        Thu, 11 Apr 2024 08:41:14 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 346/437] s390: vmur: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:06 -0600
Message-ID: <20240411153126.16201-347-axboe@kernel.dk>
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
 drivers/s390/char/vmur.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index fe94dec427b6..187b0dde22e1 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -461,6 +461,7 @@ static ssize_t ur_write(struct file *file, const char __user *udata,
 
 	return do_write(urf->urd, udata, count, urf->dev_reclen, ppos);
 }
+FOPS_WRITE_ITER_HELPER(ur_write);
 
 /*
  * diagnose code 0x14 subcode 0x0028 - position spool file to designated
@@ -580,6 +581,7 @@ static ssize_t ur_read(struct file *file, char __user *ubuf, size_t count,
 	mutex_unlock(&urd->io_mutex);
 	return rc;
 }
+FOPS_READ_ITER_HELPER(ur_read);
 
 /*
  * diagnose code 0x14 subcode 0x0fff - retrieve next file descriptor
@@ -799,8 +801,8 @@ static const struct file_operations ur_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = ur_open,
 	.release = ur_release,
-	.read	 = ur_read,
-	.write	 = ur_write,
+	.read_iter	 = ur_read_iter,
+	.write_iter	 = ur_write_iter,
 	.llseek  = ur_llseek,
 };
 
-- 
2.43.0


