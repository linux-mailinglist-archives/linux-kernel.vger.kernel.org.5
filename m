Return-Path: <linux-kernel+bounces-140975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9D48A19E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8C61C21161
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D41BC7A6;
	Thu, 11 Apr 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0K5BRT66"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28278C97
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849848; cv=none; b=FQKFbpMUsTgQfWj7FvF5XOvJ2X0rm8PhSVML3F5NJtl0WSyhDjo+kOqwsD5nX3eAMGgUNJEgOpvd4Qi3vED9YWAinjWmVOElH5vYCxj2buUF7bRuHiAaomlwagBjYxwdy3Da5jbvch0xaqaiNespXzVHHeUC39Xs/pT2kZ9oaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849848; c=relaxed/simple;
	bh=RwQMnBL78ma9gpE6oT6aJLPe7CuKFi1pZhRbZlKjVQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECglotMgL9G6u32en1NK2zBGhOEV/hdDwONU4gpLXO23IuvoleXgBdp+36sP0GmLohtPTRE0f2cQA0jC56g5XI0BbIzP9e44VI7VDXjVMmU1Qt12r4iFkKFmtaMiSkldp4hTnsaa0LH2XjyHYaOw8VRsuPIpZTEUsHN8OkndsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0K5BRT66; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58103839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849845; x=1713454645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxF/BLT131IOdlBMzuxjsslI37rIyb//18KVj2WFY3A=;
        b=0K5BRT66JD/0ZSkskLbPqSaKeKB3aNscsqzINz0cPBelD8L/y//im476J6+ZsXRRXY
         NeiYD7TObagOf/kUxrOalUxBNPP4rPC64SorSARPY2WEa/MCUhkSvj7IUEmEwWQruCd4
         xtUPh01s22dxeNN0HyBWtbbFD3XsDjzH61tYgIGK9Z4IPN6kQoyGXAE+P1d2KjIqpEc8
         w/FvcumNdMSWUpjNQWfFaqZGHT/Pv0uTvO4ybWmvaB62LulK8r8hlOmpIp54vGt/N7N5
         tr0lYnbKTBnBkT34HGtNtiVn6tnQjxV2Tu7Vk2dy4E5SHX6UDqGnYu5gBf3dJ4NFvF4y
         c0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849845; x=1713454645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxF/BLT131IOdlBMzuxjsslI37rIyb//18KVj2WFY3A=;
        b=hFvtvKyId8Oca2iN7zz7jUqQ5aka24PVA2GKBxLpOb3sUghWs1r2CihPLZd/G4FBFk
         8ME/rfoPRk4uKIW2KuSnL0T+BEtCFcqhHvS7R34b9QRIKn/h+1dESOVHg24Tvk36kvTe
         iT7sq/VJeIV3r/dfcdt3sY4lV7KE8I3fuSqCWgqM7ayIlfIgx17GkBw9l8d9OxF5EEKm
         eSGFKvQQKCaSisw2ujARNBTOaj0++FhXX+UYHSMUIeXZunhEYPsoyFjQ48GFDZw0xjJc
         0LXJIDXWG9F5HMmAjbNqlaBDQ7J4cHBeqX+ndVm3MPLluYyhsU4N0MUF6YAHxR3DxDHI
         AWwg==
X-Gm-Message-State: AOJu0Yzu/2y9ih7r8vAs7Wi2lLdIQPNn4jhly05a4mpAgoXuGMhkOgoL
	Uufg2ZaBuvwZ2pTkkeymOeZiLThPnW7sFXCi0CNMlpyYoYvHknw3JPWYZR3HqEWFrBod6uSXTf8
	0
X-Google-Smtp-Source: AGHT+IHLuzo97s9p6mRhxgClbTzcy/j8JUuvDz6VVR1yWPN9tFJhuLRoLVs+BQTtGI0OKbHV2X4ZIQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr188551iov.2.1712849845291;
        Thu, 11 Apr 2024 08:37:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 206/437] virt: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:46 -0600
Message-ID: <20240411153126.16201-207-axboe@kernel.dk>
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
 virt/kvm/kvm_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fb49c2a60200..9530584af843 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4373,6 +4373,7 @@ static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
 			&kvm_vcpu_stats_desc[0], &vcpu->stat,
 			sizeof(vcpu->stat), user_buffer, size, offset);
 }
+FOPS_READ_ITER_HELPER(kvm_vcpu_stats_read);
 
 static int kvm_vcpu_stats_release(struct inode *inode, struct file *file)
 {
@@ -4384,7 +4385,7 @@ static int kvm_vcpu_stats_release(struct inode *inode, struct file *file)
 
 static const struct file_operations kvm_vcpu_stats_fops = {
 	.owner = THIS_MODULE,
-	.read = kvm_vcpu_stats_read,
+	.read_iter = kvm_vcpu_stats_read_iter,
 	.release = kvm_vcpu_stats_release,
 	.llseek = noop_llseek,
 };
@@ -5064,6 +5065,7 @@ static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
 				&kvm_vm_stats_desc[0], &kvm->stat,
 				sizeof(kvm->stat), user_buffer, size, offset);
 }
+FOPS_READ_ITER_HELPER(kvm_vm_stats_read);
 
 static int kvm_vm_stats_release(struct inode *inode, struct file *file)
 {
@@ -5075,7 +5077,7 @@ static int kvm_vm_stats_release(struct inode *inode, struct file *file)
 
 static const struct file_operations kvm_vm_stats_fops = {
 	.owner = THIS_MODULE,
-	.read = kvm_vm_stats_read,
+	.read_iter = kvm_vm_stats_read_iter,
 	.release = kvm_vm_stats_release,
 	.llseek = noop_llseek,
 };
@@ -6153,8 +6155,8 @@ static const struct file_operations stat_fops_per_vm = {
 	.owner = THIS_MODULE,
 	.open = kvm_stat_data_open,
 	.release = kvm_debugfs_release,
-	.read = simple_attr_read,
-	.write = simple_attr_write,
+	.read_iter = simple_attr_read_iter,
+	.write_iter = simple_attr_write_iter,
 	.llseek = no_llseek,
 };
 
-- 
2.43.0


