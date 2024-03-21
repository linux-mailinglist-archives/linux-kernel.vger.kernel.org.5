Return-Path: <linux-kernel+bounces-110707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C18862B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4D281EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22913666F;
	Thu, 21 Mar 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bvk6XnlF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129913664C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057854; cv=none; b=rbA0Dh8oI/m548CBNaVhcAEkczUrlNYmdvsqw5L2zsk2ev735y4uRufXdL4hJBSpgHPicLxeqEVOdhibSB8/64ICsIVxZTg2kiTJOojl/wTEctq9QfbZ/5HQvZE19thISOxiqSlLdvtx08vqgaIJbavVly3LMateKqp/w0cQOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057854; c=relaxed/simple;
	bh=1q6/bssNd0006rOsrKjCaBr6cGn2MsVcOHvN/FPDSTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sf78krockjAPoyiV0BIV/QmE9zV9IHRWMz2ut+yKtg1m3XbOwuq94N0pXvV1C1P5JgUz8blc8Q1R5HAnwMMCoOIi/qtohbXFjz0uu3W6vT36MPP2lWy5axXi1lvmnR/QapG+G7jlQDXE2dNuyFpIFSoQB2evXe0Kz7lku55vfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bvk6XnlF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711057851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aSRv2DetjMO/TSqj6Dtwz7BI28in2keILcLTnyc5ezU=;
	b=Bvk6XnlFtwaAn286obWs0wBZiRS9H0MNCUWU9L37RBX/vr+y8C9bFqEAgKGKU88mRG2+yP
	pcqKk9Vdo0uj5hf6tn2nQBsRV1niCXnz4hg4MMKxes4eeJE9eqiMXRA1WlV6oF6jqofIfI
	MgAGeVzVoTJ4DrZatDQBUmCfC1KggkE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-hjGNVwQ9OGepQnV6o-WdwA-1; Thu, 21 Mar 2024 17:50:50 -0400
X-MC-Unique: hjGNVwQ9OGepQnV6o-WdwA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e6ae0d2cf5so335298a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711057849; x=1711662649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSRv2DetjMO/TSqj6Dtwz7BI28in2keILcLTnyc5ezU=;
        b=mDb3LhKMWvIAZLymR4fJU85FJ54X60DlnYplNscIcH9LuZkW3tTprfUq2cTNlkW4w1
         P8pwBNny1RsqyNZ3e11oXQPRDIXbGiJPcNZGUQYNuF/dk6KowQvBEWRgr6Ak9I0bkU1f
         YJBqY+s/1hRrx7AysoCXfXf8YZG2dLoR5OFQJkIbiFpdFvdsJvXb+BHGtvEY6lZPd7ds
         Fb8Uzm/xcnVI1i5lBZyY5E5SvXpAozUiMD4dJ8VZvartDF7+jYLetkNVcTBkuoTI55PC
         SUaglYyern3IgqZvPnMDa3ujOOdGGQkq+gcgBm8AGf5oAjcwWm+hfZTFcNnp42qWT+Es
         fyUw==
X-Forwarded-Encrypted: i=1; AJvYcCVOXNM2UJqGNOE6/WYpuBFStFHv4JOUChs6PLDtjN+SdVD6s9l00Eq9nLrwJlZ4pdQFxAKxtXk2lsMslPkB5ViKHYujy268sZffkDkZ
X-Gm-Message-State: AOJu0Yw5JBD0hj2zJaKDtW4pMBeN5K05UL127m/OtsCWQGF+5QAKT4q4
	+gLzubWUKfgIDv+9aiRUrh09Mv2kggiaj1hBT/z4RlP0/OuGKi/KlfoydpIVGoF7xKxUZvirVQK
	+ElyK0F1zgK/kxuNcqjfEDTvpN51Rn3fDC5hyd1Z9j7JRUhiizNYTBsqXqBYHlQ==
X-Received: by 2002:a05:6830:1517:b0:6e6:aecb:a4cc with SMTP id k23-20020a056830151700b006e6aecba4ccmr472989otp.3.1711057849571;
        Thu, 21 Mar 2024 14:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXP5i6En054QksU/9nYfuolH8wCep616IgwaADmT0nLBglGHG04UCSqFWJZjM6dLY5e46Vxg==
X-Received: by 2002:a05:6830:1517:b0:6e6:aecb:a4cc with SMTP id k23-20020a056830151700b006e6aecba4ccmr472969otp.3.1711057849229;
        Thu, 21 Mar 2024 14:50:49 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b00789fc91dcf1sm268952qki.87.2024.03.21.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:50:48 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	David Hildenbrand <david@redhat.com>,
	Nico Pache <npache@redhat.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH] selftests/mm: run_vmtests.sh: Fix hugetlb mem size calculation
Date: Thu, 21 Mar 2024 17:50:47 -0400
Message-ID: <20240321215047.678172-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

The script calculates a mininum required size of hugetlb memories, but
it'll stop working with <1MB huge page sizes, reporting all zeros even if
huge pages are available.

In reality, the calculation doesn't really need to be as comlicated either.
Make it simpler and work for KB-level hugepages too.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index c2c542fe7b17..b1b78e45d613 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -152,9 +152,13 @@ done < /proc/meminfo
 # both of these requirements into account and attempt to increase
 # number of huge pages available.
 nr_cpus=$(nproc)
-hpgsize_MB=$((hpgsize_KB / 1024))
-half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
-needmem_KB=$((half_ufd_size_MB * 2 * 1024))
+uffd_min_KB=$((hpgsize_KB * nr_cpus * 2))
+hugetlb_min_KB=$((256 * 1024))
+if [[ $uffd_min_KB -gt $hugetlb_min_KB ]]; then
+	needmem_KB=$uffd_min_KB
+else
+	needmem_KB=$hugetlb_min_KB
+fi
 
 # set proper nr_hugepages
 if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
-- 
2.44.0


