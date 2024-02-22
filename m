Return-Path: <linux-kernel+bounces-77278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E12E860367
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC04B27581
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82B54919;
	Thu, 22 Feb 2024 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIa4R+sd"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61A14B815
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631184; cv=none; b=WfP/Es5WLePKOhtj/ogM535itVKtETimYmyX+BpXEl/JL7XRmbrre7TR7ZZD38GfD73eJLHjV83o0m3c/INTu1Qw457QdZjd052QfFa3oP6rTeGAZCJ6GiU+iIhiA6eGSdZDvOfg3NLnpyQtpuhAT62WgubQ2SytZo5B9keE0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631184; c=relaxed/simple;
	bh=QR8wsxpn61c6bZNiH82UFjpggpnzUY5VC+cjL5uh/lA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fTnVOJP089cJtTVcgIsVlg53K0qXzJV/vAi96mQiBnvsTC24QhcSLyxcvJ5XmmJnRnb9gA+MpjZE9sEyAfmTUgqdN8yH26MGoeqdhFviCI5Qx3h99RNHXUrNbXrPC5xDpjpZtwTUruXHOoVKCr9nRl/e8c8nitsqLStiYlTeXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIa4R+sd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-787a843003eso4304885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708631181; x=1709235981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avkomLKBJ3sytSufqOwSv0efxNpypNMAMWMqdPXHCPw=;
        b=GIa4R+sdDVomfRLT/+ndwTYR9VrAiqB3vrtQyxnwT6llT2HWKBLrP1oQsca/5F2uGJ
         tzWdtUdx9+HqzLPJ9c2LKg7fUz1w6Y2mMX9DGreVPQeDjh2rXmeQ/UBFje7zTcCKYdtb
         tItRfqHJYJoBu1CWZXMhsTW1qSveDyjgCx9M4Chb90d74+K3GqY2D60INn9e7044kKN4
         jCjnIWkqxlZypnbn7MfLFSupOnN/hCJxBY+1LmXYotLVirisNnUeNyV8C2idMLNylZfO
         U4BTvg6sNXNBx+zWR+yn/NYoIkSlM2ezMjon4yygMSWDkYt9eKfTBno7vJricMPh8o05
         ThMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631181; x=1709235981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avkomLKBJ3sytSufqOwSv0efxNpypNMAMWMqdPXHCPw=;
        b=BwBpNaUv2kRbMAezGonOJV8LR4GPUZ8FSi5FODw9gasFkAE5fzmjc3igvNiXsBSuhi
         wtXubUbld6OUHCLmzgjMMhAaONhAg45DsXAQFILdmq5n1NrBuxP8pMXriIG3ao5mNvxP
         K6Ttkh36ofH5tr4hIjiJqtInZ2vf6iDdMap89BzcfmtICcnhyqOWM6cvrqUHGMi9R0yf
         kHlH5xhVaUnv/oDRahyER1JMunPSFzv5rv0re1s4u/abMZN6XGZsUzc16tVm7qYO/2Sf
         vpekuExkjJluyd0a7IPaCDw+59UmuipdXCXrK4NBSFdy4pP42dYwxBQ0okltWhXrt59x
         DnGA==
X-Forwarded-Encrypted: i=1; AJvYcCUmAeGfuVrU75NwjkTqI7pDIN4XwO1LrXXmxAvY1uHP3apnkvjP+wyLLUkcaM66QDVrfatFF9IcsrOrnfKE6VCpqeKjq5innLchqc/U
X-Gm-Message-State: AOJu0YxrZj3637ZwXYxkPNRsiW97lFEGdvJhFMlcxcjz1pqrHrBjPQDm
	sTSSiSHmr/dZ5eGzUl3L6eUOmUwu+RrVyJvfLsbwYzd4hKMOPqoB
X-Google-Smtp-Source: AGHT+IH3rJkCUyjr2ZtstPMqdCnt+Zuya6HS6B6d6Gxf4zGuXtNp9qxAaWUtpdXD1+0sx87TRmNSrg==
X-Received: by 2002:a05:620a:88c:b0:787:aa2e:22c5 with SMTP id b12-20020a05620a088c00b00787aa2e22c5mr10566qka.72.1708631181512;
        Thu, 22 Feb 2024 11:46:21 -0800 (PST)
Received: from localhost.localdomain (024-171-058-032.res.spectrum.com. [24.171.58.32])
        by smtp.gmail.com with ESMTPSA id dy4-20020a05620a60c400b007872ade6cf1sm5626389qkb.71.2024.02.22.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:46:21 -0800 (PST)
From: Matthew Cassell <mcassell411@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	mcassell411@gmail.com
Subject: [PATCH v2] mm/util.c: Added byte count to __vm_enough_memory failure warning
Date: Thu, 22 Feb 2024 19:46:17 +0000
Message-Id: <20240222194617.1255-1-mcassell411@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 44b414c8715c5dcf53288 ("mm/util.c: add warning if
__vm_enough_memory fails") adds debug information which gives the
process id and executable name should __vm_enough_memory() fail. Adding
the number of pages to the failure message would benefit application
developers and system administrators in debugging overambitious memory
requests by providing a point of reference to the amount of memory
causing __vm_enough_memory() to fail.

1. Set appropriate kernel tunable to reach code path for failure
   message:

	# echo 2 > /proc/sys/vm/overcommit_memory

2. Test program to generate failure - requests 1 gibibyte per
   iteration:

	#include <stdlib.h>
	#include <stdio.h>

	int main(int argc, char **argv) {
		for(;;) {
			if(malloc(1<<30) == NULL)
				break;

			printf("allocated 1 GiB\n");
		}

		return 0;
	}

3. Output:

	Before:

	__vm_enough_memory: pid: 1218, comm: a.out, not enough memory
for the allocation

	After:

	__vm_enough_memory: pid: 1137, comm: a.out, bytes: 1073741824,
not enough memory for the allocation

Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
---
Changed the debug output from the number of pages to the number of
bytes.
 mm/util.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..6710efaf1802 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -942,6 +942,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
 int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 {
 	long allowed;
+	unsigned long bytes_failed;
 
 	vm_acct_memory(pages);
 
@@ -976,8 +977,9 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
 		return 0;
 error:
-	pr_warn_ratelimited("%s: pid: %d, comm: %s, not enough memory for the allocation\n",
-			    __func__, current->pid, current->comm);
+	bytes_failed = pages << PAGE_SHIFT;
+	pr_warn_ratelimited("%s: pid: %d, comm: %s, bytes: %lu not enough memory for the allocation\n",
+			    __func__, current->pid, current->comm, bytes_failed);
 	vm_unacct_memory(pages);
 
 	return -ENOMEM;
-- 
2.43.2


