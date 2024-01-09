Return-Path: <linux-kernel+bounces-21440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CF828F26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18661F260C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3D3DBBA;
	Tue,  9 Jan 2024 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCeptIj7"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD233DB89
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbd6e3795eso3024758b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836914; x=1705441714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vUT9WEUxRD9BkIbxg8bhQm6T8z8s7DL2miSnerAV6qc=;
        b=OCeptIj7HiM0o/49i8qDvPXyX4tDsnOPvCugkCmcwLhBJlM5/NxRB3eUNkL/hyNzNe
         VhYgpSzrZz/dfdZXt8WXThr20vurPcmXVNbCvcBV2crd0okznbRdLCF99JpzoamNQgdu
         FE5ptlKVGYTQjD/wkeI78N6En2hfeXlkX87hndDemnba42Y141XlA+iCrl9O6OLRpszI
         l/i+AuDVNM4vXqyqLOlXbeNumP3R3oLL3bRhOH8DI/hslzfh6kY6wXkkbuNBoSB6vId1
         D8uCHCzDfZ00iG7wfMdYX8cxJ8PhepdWbqlb2hfvPDcBJHlPKTSe1lVKVMVo4OzRQ6Px
         jO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836914; x=1705441714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUT9WEUxRD9BkIbxg8bhQm6T8z8s7DL2miSnerAV6qc=;
        b=DvL4IitSuwfBlCe8VmMrVZ2GzMGSqzyVI1KXEdNnC7xsknS81Urc1c8/uB+5r06mpp
         /6NJ8u2JPDG+xG6+c5Q83HCrLvXgh615Y5cyWGft8RBZxE1U9iQo6oi0Jy96EmziqItl
         gzKebGByANHzlh+uxOmzGOZkD6FRUL9vMPF9bE879mNzu4TNj55ckpsB2Nk0jZ8laT9f
         9Z1+2jWdK0uy8X2NEY9oXKJOnt4oppJrV3O/VlcI2zvPr44brerEF42pQqpaB4MH/HoH
         7lYbJLe101+phIHhdSGTspgkdIrOeFVxJpjjGUs9xCXNBP9Na8OwquOQCIpA5v/OIcKY
         +ZBA==
X-Gm-Message-State: AOJu0YzJBlVTUJGXcS5jzO094HqbZiahuAbkgwPLWSK4r/8WBthYhkCF
	GMi4kBEusYf9uVfM6KfQh8U=
X-Google-Smtp-Source: AGHT+IH6KvaSKJAK85q30Z2FmF68k9uvDkpvPuVVzy8FATqm5Cw3ANEuO6nPrdOEGB64M3gakeF1fg==
X-Received: by 2002:a05:6870:d887:b0:206:53c3:da6a with SMTP id oe7-20020a056870d88700b0020653c3da6amr181863oac.26.1704836914041;
        Tue, 09 Jan 2024 13:48:34 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:fd50])
        by smtp.gmail.com with ESMTPSA id c32-20020a631c20000000b005c66b54476bsm2084149pgc.63.2024.01.09.13.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:48:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: andrea.righi@canonical.com,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org
Subject: [PATCHSET driver-core-next] kernfs: Protect kernfs_find_and_get_node_by_id() with RCU
Date: Tue,  9 Jan 2024 11:48:01 -1000
Message-ID: <20240109214828.252092-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF helper bpf_cgroup_from_id() calls kernfs_find_and_get_node_by_id()
which acquires kernfs_idr_lock, which is an non-raw non-IRQ-safe lock.
kernfs_idr_lock used to be a non-irq-safe lock which could lead to deadlocks
as bpf_cgroup_from_id() can be called from any BPF programs including e.g.
the ones that attach to functions which are holding the scheduler rq lock.

To resolve the situation dad3fb67ca1c ("kernfs: convert kernfs_idr_lock to
an irq safe raw spinlock") converted kernfs_idr_lock to an irq-safe raw
spinlock. However, this was also broken as we call idr_alloc*() while
holding the lock and idr itself uses an non-irq-safe lock and also calls
into memory allocator.

Let's instead RCU protect kernfs_node and kernfs_root so that
kernfs_find_and_get_node_by_id() can use rcu_read_lock() instead of
kernfs_idr_lock. While this unfortunately increases the size of kernfs_node,
it's the most straightforward thing to do and there likely are other places
that can take advantage of RCU protection and improve scalability too.

Please see the patch descriptions for more details.

This patchset is on top of the current driver-core-next - dad3fb67ca1c
("kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"), and also
available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git kernfs-use-rcu

Thanks.

--
tejun

