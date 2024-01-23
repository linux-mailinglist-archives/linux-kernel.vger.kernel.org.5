Return-Path: <linux-kernel+bounces-34987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1D6838A30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A81F29517
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772235820F;
	Tue, 23 Jan 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="FCU1ffDE"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A15811E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001685; cv=none; b=D9LIDMYd0lri2vMCiuuNXurDEj5rqnF3Bn1+l/Z4JHJkMau4LhHWXInaZsceR9v0CGB7U244hvMSvdzBaLw+25ueviUreO+eNfs34wDLAmeFO7BCUfEzyoDZXMg7P1taSpoUfg2ff3IrcvlA+x+Uby6MBuVgo9lMjbAfe/eI1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001685; c=relaxed/simple;
	bh=FR/Lt8hCWLf4BJION9Icx5d5GdS0Oj5IF1M85CIYC9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crdZA4CngnTc1YRya2zy5wXkhlhMEez4grlxwLv0ALNOPpsQPkvnSy14Xeb35DL8lHymo4Z3R08iRFvLdN1wP4IiREyY4Vo44OZM9ast2xBwFK+3BlAPZKbHHcIqQA//lZB/LvjAxn/6dMmUIwCPakMMq2IB6kf/VLTWNBzMpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=FCU1ffDE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbb4806f67so3463178b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1706001683; x=1706606483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0lqcueCBy3FeODNoPZZYWM4Zx9qtOGexvsaM0ZvdHU=;
        b=FCU1ffDEuSvI7NqKirw2po2tmFKsYgRkMVyOROVd0Do8rG1VVCkxxZib0GiwJa3v93
         7X/8o52JN03jwjFhBHxMFdl1A9UFfNCAjnO1Ok50gLgamhIp4TlhbkpYqy7QhDwE3lzc
         Uq35z6OsABbXqBjlPh0UDYOTzKgPq5QKKCrmcRZiCV+oVXe/VXHmD63dygrSFOiyjSCl
         iz2Wfa5064KTyOtM8v0yBFQGDN4MGbmbw8yK8XHqAx/4E8LA/7GAuWsYtEZ25EFjhkLI
         9IV5AVU4FEH9U2lA3rDBU++Ti0ZjFiJj38l8ZEMgzm6ZE0HUfGFK7JZODgwkHqWTKJXH
         NJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001683; x=1706606483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0lqcueCBy3FeODNoPZZYWM4Zx9qtOGexvsaM0ZvdHU=;
        b=YRNabp5BpBBMQJEBn/2Ea/DaRA45b3so/4oeGU7T5/dIDMfHAWI5GciZ9Wy1KZBoI2
         B25JMnymaOWYqPwUsbYlzCRh4RCI9MN7oP963sc7LcdwZlAM4gMe+VLn/aP45jOjpg5d
         7uw67TBniH11PQ6IQXIDVTOCyAXgKCXzkgw9ehD/nk1qjgYj0a2HpIWRvAd3szFI1apG
         X9zJGwwXfJD5TcGpiy37bbiR5E7MEvG4zF3zrODiiwJGpkl4QNquDRl8lcaiZRZ1CB16
         Kj2zxtw3E0hsS+Z9GmMbT/zI4ILSd7bTtdw1GviIdaTFfcrGHjW11oVBhR+gAod368xd
         BEHg==
X-Gm-Message-State: AOJu0YxyaaTpc6Sn8OYVJKJfH+zR2LZT2UDV8MK6FKXSC6iJSkQL666T
	Uo5R1QhatG9yy4br3uGzrKDKYG/XZK0swgYyL9vEyC5vBQc2gF0Y1jIKoclMO/k=
X-Google-Smtp-Source: AGHT+IG6N3uyl08knvYtVB3RFhiOFCF4c+HLjyvTFetuTHFgNYJqHY2iM1WQrnwYSGKIi9XXtiz5vg==
X-Received: by 2002:a05:6808:1891:b0:3bd:bb2b:86e2 with SMTP id bi17-20020a056808189100b003bdbb2b86e2mr2758987oib.101.1706001683322;
        Tue, 23 Jan 2024 01:21:23 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id i15-20020aa787cf000000b006dbddea71e2sm3650707pfo.79.2024.01.23.01.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:21:23 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/3] x86/resctrl: Display the number of available CLOSIDs
Date: Tue, 23 Jan 2024 09:20:22 +0000
Message-Id: <20240123092024.1271882-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can know the number of CLOSIDs for each rdt resource, for example:

cat /sys/fs/resctrl/info/L3/num_closids
cat /sys/fs/resctrl/info/MB/num_closids
..

The number of available CLOSIDs is the minimal value of them. When users
try to create new control groups, to avoid running out of CLOSIDs, they
have to traverse /sys/fs/resctrl/ and count the number of directories.

To make things more easier, add a RFTYPE_TOP_INFO file 'free_closids'
that tells users how many free closids are left.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384a..577d870ac45f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -113,6 +113,7 @@ void rdt_staged_configs_clear(void)
  */
 static int closid_free_map;
 static int closid_free_map_len;
+static int free_closids;
 
 int closids_supported(void)
 {
@@ -133,6 +134,7 @@ static void closid_init(void)
 	/* CLOSID 0 is always reserved for the default group */
 	closid_free_map &= ~1;
 	closid_free_map_len = rdt_min_closid;
+	free_closids = rdt_min_closid - 1;
 }
 
 static int closid_alloc(void)
@@ -143,6 +145,7 @@ static int closid_alloc(void)
 		return -ENOSPC;
 	closid--;
 	closid_free_map &= ~(1 << closid);
+	free_closids--;
 
 	return closid;
 }
@@ -150,6 +153,7 @@ static int closid_alloc(void)
 void closid_free(int closid)
 {
 	closid_free_map |= 1 << closid;
+	free_closids++;
 }
 
 /**
@@ -912,6 +916,15 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_free_closids_show(struct kernfs_open_file *of,
+				 struct seq_file *seq, void *v)
+{
+	mutex_lock(&rdtgroup_mutex);
+	seq_printf(seq, "%d\n", free_closids);
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
 static int rdt_num_closids_show(struct kernfs_open_file *of,
 				struct seq_file *seq, void *v)
 {
@@ -1755,6 +1768,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_last_cmd_status_show,
 		.fflags		= RFTYPE_TOP_INFO,
 	},
+	{
+		.name           = "free_closids",
+		.mode           = 0444,
+		.kf_ops         = &rdtgroup_kf_single_ops,
+		.seq_show       = rdt_free_closids_show,
+		.fflags         = RFTYPE_TOP_INFO,
+	},
 	{
 		.name		= "num_closids",
 		.mode		= 0444,
-- 
2.25.1


