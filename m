Return-Path: <linux-kernel+bounces-18806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C153A826336
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8401F21D2E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DC212B6C;
	Sun,  7 Jan 2024 07:00:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFF125D7
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.153])
	by sina.com (10.75.12.45) with ESMTP
	id 659A4BE8000049C4; Sun, 7 Jan 2024 14:59:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 85437231457880
X-SMAIL-UIID: 25D86A25DE9648949CD5BA5B556EC8F0-20240107-145954-1
From: Hillf Danton <hdanton@sina.com>
To: Uladzislau Rezki <urezki@gmail.com>,
	Wen Gu <guwen@linux.alibaba.com>
Cc: linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] mm: vmalloc: Remove global vmap_area_root rb-tree
Date: Sun,  7 Jan 2024 14:59:42 +0800
Message-Id: <20240107065942.3141-1-hdanton@sina.com>
In-Reply-To: <ZZmBh-g_evLcNHT1@pc636>
References: <20240102184633.748113-1-urezki@gmail.com> <20240102184633.748113-5-urezki@gmail.com> <238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com> <ZZfe4O850fFaxOgQ@pc638.lan> <52766da2-41de-41ce-b60b-1118da343b8a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 6 Jan 2024 17:36:23 +0100 Uladzislau Rezki <urezki@gmail.com>
> > 
> > Thank you! I tried the patch, and it seems that the wait for rwlock_t
> > also exists, as much as using spinlock_t. (The flamegraph is attached.
> > Not sure why the read_lock waits so long, given that there is no frequent
> > write_lock competition)
> > 
> >                vzalloced shmem(spinlock_t)   vzalloced shmem(rwlock_t)
> > Requests/sec         583729.93                     460007.44
> > 
> > So I guess the overhead in finding vmap area is inevitable here and the
> > original spin_lock is fine in this series.
> > 
> I have also noticed a erformance difference between rwlock and spinlock. 
> So, yes. This is what we need to do extra if CONFIG_HARDENED_USERCOPY is
> set, i.e. find a VA.

See if read bias helps to understand the gap between spinlock and rwlock.

--- x/kernel/locking/qrwlock.c
+++ y/kernel/locking/qrwlock.c
@@ -23,7 +23,7 @@ void __lockfunc queued_read_lock_slowpat
 	/*
 	 * Readers come here when they cannot get the lock without waiting
 	 */
-	if (unlikely(in_interrupt())) {
+	if (1) {
 		/*
 		 * Readers in interrupt context will get the lock immediately
 		 * if the writer is just waiting (not holding the lock yet),

