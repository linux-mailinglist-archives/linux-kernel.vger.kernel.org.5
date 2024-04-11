Return-Path: <linux-kernel+bounces-141058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02058A1AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423AAB290FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC51D214D;
	Thu, 11 Apr 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L5M2j7BA"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D747A55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849974; cv=none; b=I1BXlYlaDVEZFQSPX2MFPRtoZqT0e8PYM+bMl7L0gvLMHTIQhzvbVleuNil6gfzOJ21JHVjMxJIfAFjHRc89ZpbuZ1Z8HJ/edjUq5ShuZm64Esc1seSqisuCqENi9eXAKcZ9w69pjo6ycsnPjvAUod9HOGbs9dDYBwHucNoo4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849974; c=relaxed/simple;
	bh=dpjjwJpMsVv1KxGUBCsBNvBL0/N3BNgZWI4u6TND3cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI5+In9huDb8JM39xsRyBi3Qgej6ob+SSHpv/hTlBgtbepqHPq+zMmSQgE+tqj5v/I03Qf66eDtZKaFRlvBVzNCKZQedKyGnLG/miRbergTz/yH0TQ9mmajMtYTURNlXUwwsM4VNK88fyKFasUWLmY/znjE22/woWJjORDAhReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L5M2j7BA; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69636339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849971; x=1713454771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh/LnGv4wN19TgvJnr2PitMJOHvtGuK64MU0s7R/ELU=;
        b=L5M2j7BAm+RXF0na0TxAGovYldAaE2SwppnTPj619wpuIuvyCbF9X95TRcdpbg0lFo
         SMScmp4C56cL8hQYnzGkgU9RtlKDkUJiSgBrg+kbXAVQ/CGl6wAVpSZWHNFSapQbqgfX
         cUuXWqw+RXwz3+uclLE5QMNkGwHtRrmZL32/3TTeiB2fuouechP1CnJGKjhABf+62JaP
         +PfJvQTg/zVBJvKyMdHtpmrk7vqrBP53Ki0fBkqbci4Fne79IvbZbT+zMrfCP2nbkuk/
         IXy2UaA89as9dJr7+1dXZ40sZcxPR3n2IgWHUYgCrRCbOav2GiCpRxbGsXHu1RKLBazD
         IEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849971; x=1713454771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh/LnGv4wN19TgvJnr2PitMJOHvtGuK64MU0s7R/ELU=;
        b=DynUYjXU5bKo0lj7RioxXfHBF1zNUiwfPaaRaGYkONmZLDVJGthv1Ud8f6JYPpXFik
         TdpgiSsmEhpXjkdBLxvJRmpcYVonxG9VsRLHoJOPRSLl2m8pFxDx8Dv/evx96m/2jWyB
         ZRz1KeEhJiDqLBkHQShSHft5Y1DPchYgXqf1UtlCCgtTkoPFE85vtt6A5fgW7yzL6scZ
         wQiF1kC+ncBmOzKVlJ9HvrgDFRkdPoN1pNWUCzXtW6kFWIUBfHeggvgHaruDfyIDSWeI
         cW18Az64q4L+LHvyyKWh7hgBqVGunjsojSU43fTLdJicSf6j3Kc/16MYBEtl40704Ulr
         sPbg==
X-Gm-Message-State: AOJu0YzUja587/I3JvFq+78jUH6bwQZKvj5Rf45DKS1hyMFTtVk1ztIr
	9FVy5rZIVGpnuuw/G4lY2/P8XBzsSzkEhomHQWLpQuhhsGPdfackzE0NE2TwwY6cGA1+8seFR7R
	B
X-Google-Smtp-Source: AGHT+IEO7aRCs6Pg4FzBAtH2QjSaW9e0qzDN92Fs8nDkVQE7QOHAtWtg0prfuYeC8GVs/H2Y7css8A==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr227522iof.0.1712849971438;
        Thu, 11 Apr 2024 08:39:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 285/437] fs/nfsd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:05 -0600
Message-ID: <20240411153126.16201-286-axboe@kernel.dk>
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
 fs/nfsd/nfs4state.c |  5 +++--
 fs/nfsd/nfsctl.c    | 10 ++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 84d4093ca713..cbe82431633a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2958,7 +2958,7 @@ static int client_opens_release(struct inode *inode, struct file *file)
 
 static const struct file_operations client_states_fops = {
 	.open		= client_states_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= client_opens_release,
 };
@@ -3011,9 +3011,10 @@ static ssize_t client_ctl_write(struct file *file, const char __user *buf,
 	drop_client(clp);
 	return 7;
 }
+FOPS_WRITE_ITER_HELPER(client_ctl_write);
 
 static const struct file_operations client_ctl_fops = {
-	.write		= client_ctl_write,
+	.write_iter	= client_ctl_write_iter,
 	.release	= simple_transaction_release,
 };
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ecd18bffeebc..788194ac663d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -118,6 +118,7 @@ static ssize_t nfsctl_transaction_write(struct file *file, const char __user *bu
 	simple_transaction_set(file, rv);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(nfsctl_transaction_write);
 
 static ssize_t nfsctl_transaction_read(struct file *file, char __user *buf, size_t size, loff_t *pos)
 {
@@ -132,10 +133,11 @@ static ssize_t nfsctl_transaction_read(struct file *file, char __user *buf, size
 	}
 	return simple_transaction_read(file, buf, size, pos);
 }
+FOPS_READ_ITER_HELPER(nfsctl_transaction_read);
 
 static const struct file_operations transaction_ops = {
-	.write		= nfsctl_transaction_write,
-	.read		= nfsctl_transaction_read,
+	.write_iter	= nfsctl_transaction_write_iter,
+	.read_iter	= nfsctl_transaction_read_iter,
 	.release	= simple_transaction_release,
 	.llseek		= default_llseek,
 };
@@ -162,7 +164,7 @@ static int exports_nfsd_open(struct inode *inode, struct file *file)
 
 static const struct file_operations exports_nfsd_operations = {
 	.open		= exports_nfsd_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -177,7 +179,7 @@ DEFINE_SHOW_ATTRIBUTE(export_features);
 
 static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
-- 
2.43.0


