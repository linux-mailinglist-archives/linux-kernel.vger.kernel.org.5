Return-Path: <linux-kernel+bounces-133705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2828C89A791
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7928284294
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C536B1C;
	Fri,  5 Apr 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5Yekg7L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64315672
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712359169; cv=none; b=KrAh7WSvg8Afmm+LIOPqKu8D5mk9Eff7P31i+eSttTrd5CeodRTPOaX0hRYiym6Dlssh+xoFEikStiq691m/sU7F8UIoHOlHn9/vBHS7oTcRm0BnMd7hOKvEdMqRvq4uSsDRzwcdz9QMgqFZRPxweCTr9mvGehpSj3mUq7F3Fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712359169; c=relaxed/simple;
	bh=nTD0gkfW1v3gofTr/mokto28ytoGlLof1Sal1Q1071Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWeaCaeVhTbjHgklLj4uJ7L3QYEI6j0vKXcAmb5xGlK6XNlBfQUDPcE/FrB1p5gljVm+yTheaW+f2Ye+xIFvqT1MDIR0FtidJokwXI79MKei5yRT6d+MmqK9JZgPMDFMmLYmhXHzptVUeK8KaMwE/kEo49cGsHxbtym+QJX6I+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5Yekg7L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712359164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HKzTrJInktvfKVrY1P9Lu04jr4tbB0gdRSWQZFOhm8U=;
	b=F5Yekg7Lgc/m3SeOuxUVQsvH64Jpw/bnuPmbqnF6x0SRunkwlM7rie7xIeuzPzrwSrdwpH
	MysfPIibsHxJf45qN9vv2liPsyxgIprHp/D3EczF4m2bTqkQLRcsJkSnC8p9UvhKX61pfC
	2sNPdGLSXKJhkJFfye5pcGlhN6jjivU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Vw69LP_EOTC9ZmHxASCdiA-1; Fri, 05 Apr 2024 19:19:23 -0400
X-MC-Unique: Vw69LP_EOTC9ZmHxASCdiA-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6dea8b7e74aso796737a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712359163; x=1712963963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKzTrJInktvfKVrY1P9Lu04jr4tbB0gdRSWQZFOhm8U=;
        b=WqXg8bX5kMA4ngoSm8TEOTkQXW0aHFqf8T720A+o/nBSyPU9h4iFob5P4t1/5ImhDp
         3fkBNztTxydOAupU6P9InPp/fRAs3DD6hRFIgjLn+VkH2tU0E9m6xL1h/gKXLaDd0G+9
         YD9z4uqmf04CBvpCe5s30qOUk6oXpwtBLlvzx9Agl6R79i+VmBIadivDvqGo7pw5n26p
         rFgwIuLO5yGgkXqyVa7fHk3o0/QYclZ84onD7z8UIItXq5w0cCXMKEvLhvDScz9RLm9b
         dzxlpviQLSs/pVRk7G0HOx0MGTM4Bl62byvmlzvWy9tIunVD/AHjD4RBzwc5KV+Tsqp8
         utwA==
X-Forwarded-Encrypted: i=1; AJvYcCW2cWfqHr2o+g4fOxkH1kb8wtABYdjobmnK/1fX4LJe3bJzcaQogohHuVm2FMXbRkTR5Da86nxT4tqFMWuOkG/7Js3oMGb7gPNohqyJ
X-Gm-Message-State: AOJu0YwwutYx2aO50ktrIwHa9TfWHi0haXpaecZKyfOSDBQK4g/GRZ6p
	o2gg3HquAiylZM0+LP+FN3lcD7BPaG+2Ma54X/MDRcwTqdnm7BM8TLU8hPU8V8nteZ6mAFhENvx
	CTlR9XYnVguVooRsPHlrQt0dZ7K/+Gwk12BBcwXyqCE60JLS4fzvl0v8qk6BQXw==
X-Received: by 2002:a05:6808:2385:b0:3c5:dc47:99e9 with SMTP id bp5-20020a056808238500b003c5dc4799e9mr3109026oib.5.1712359162428;
        Fri, 05 Apr 2024 16:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfjPnSmiyv8P7CJzOP7HOWBiDhIEG/B6ZJWV2xwl0fun8uJUpqbxe6oOulVbdccni8vhEdEA==
X-Received: by 2002:a05:6808:2385:b0:3c5:dc47:99e9 with SMTP id bp5-20020a056808238500b003c5dc4799e9mr3109003oib.5.1712359161965;
        Fri, 05 Apr 2024 16:19:21 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm1201198qtb.87.2024.04.05.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 16:19:21 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-stable <stable@vger.kernel.org>,
	syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
Subject: [PATCH] mm/userfaultfd: Allow hugetlb change protection upon poison entry
Date: Fri,  5 Apr 2024 19:19:20 -0400
Message-ID: <20240405231920.1772199-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

After UFFDIO_POISON, there can be two kinds of hugetlb pte markers, either
the POISON one or UFFD_WP one.

Allow change protection to run on a poisoned marker just like !hugetlb
cases, ignoring the marker irrelevant of the permission.

Here the two bits are mutual exclusive. For example, when install a
poisoned entry it must not be UFFD_WP already (by checking pte_none()
before such install).  And it also means if UFFD_WP is set there must have
no POISON bit set.  It makes sense because UFFD_WP is a bit to reflect
permission, and permissions do not apply if the pte is poisoned and
destined to sigbus.

So here we simply check uffd_wp bit set first, do nothing otherwise.

Attach the Fixes to UFFDIO_POISON work, as before that it should not be
possible to have poison entry for hugetlb (e.g., hugetlb doesn't do swap,
so no chance of swapin errors).

Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-stable <stable@vger.kernel.org> # 6.6+
Link: https://lore.kernel.org/r/000000000000920d5e0615602dd1@google.com
Reported-by: syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8267e221ca5d..ba7162441adf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6960,9 +6960,13 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			if (!pte_same(pte, newpte))
 				set_huge_pte_at(mm, address, ptep, newpte, psize);
 		} else if (unlikely(is_pte_marker(pte))) {
-			/* No other markers apply for now. */
-			WARN_ON_ONCE(!pte_marker_uffd_wp(pte));
-			if (uffd_wp_resolve)
+			/*
+			 * Do nothing on a poison marker; page is
+			 * corrupted, permissons do not apply.  Here
+			 * pte_marker_uffd_wp()==true implies !poison
+			 * because they're mutual exclusive.
+			 */
+			if (pte_marker_uffd_wp(pte) && uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
 				huge_pte_clear(mm, address, ptep, psize);
 		} else if (!huge_pte_none(pte)) {
-- 
2.44.0


