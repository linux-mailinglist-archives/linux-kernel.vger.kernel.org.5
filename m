Return-Path: <linux-kernel+bounces-101369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4987A619
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A3282A33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3CB3D3B1;
	Wed, 13 Mar 2024 10:46:55 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E13D386
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326814; cv=none; b=oDHzpVZ7MXMTRCvqxQV9ffoUgjptk4vgty4vJQxP4eXe3j6S0yorSEuW+S/CvCLQHiDRf90kwgl8qN+fwWnmKvduZwp1Fqb3hfzbyZ4OgFTggIQXEx19/DZrisdoLOWAFYpCPpZPBGpTG599lEC8F5PyJNoGBveH4HNlUF69n+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326814; c=relaxed/simple;
	bh=lY4PnK/nrOsu8EsdAOA3oMFu70AKJEwrXflCsNhz3CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmgu2hFR1rQX/P94W8Em/GYj8WweA36wtjjbTzvHwJ6LVeZJwIwkUIEXvFHaRANSf0bxpoKMDr9bEltjAZPeBwrdTWuVQOg3RNdRcB9x7xrahS/vygUPn5/NI2P3UniTmeG0Z9q1zYs7AC5BRLGZ9H3sSTquXQOivMm8aZHMUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.180])
	by sina.com (172.16.235.25) with ESMTP
	id 65F1840D000055F7; Wed, 13 Mar 2024 18:46:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6488834210294
X-SMAIL-UIID: 878316195B8A4D3F9594D1AA2F3D9A4D-20240313-184640-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
Date: Wed, 13 Mar 2024 18:46:28 +0800
Message-Id: <20240313104628.2178-1-hdanton@sina.com>
In-Reply-To: <0000000000004aa700061379547e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Mar 2024 09:41:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    df4793505abd Merge tag 'net-6.8-rc8' of git://git.kernel.o..
> git tree:       bpf
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10babc01180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/kernel/bpf/ringbuf.c
+++ y/kernel/bpf/ringbuf.c
@@ -402,10 +402,14 @@ bpf_ringbuf_restore_from_rec(struct bpf_
 	return (void*)((addr & PAGE_MASK) - off);
 }
 
+static DEFINE_PER_CPU(int, bpf_ringbuf_lock_subclass);
+
 static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 {
 	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
 	u32 len, pg_off;
+	int dumy = 0;
+	int *sbc = &dumy;
 	struct bpf_ringbuf_hdr *hdr;
 
 	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
@@ -421,7 +425,10 @@ static void *__bpf_ringbuf_reserve(struc
 		if (!spin_trylock_irqsave(&rb->spinlock, flags))
 			return NULL;
 	} else {
-		spin_lock_irqsave(&rb->spinlock, flags);
+		sbc = get_cpu_ptr(&bpf_ringbuf_lock_subclass);
+		*sbc += 1;
+		spin_lock_irqsave_nested(&rb->spinlock, flags, *sbc);
+		put_cpu_ptr(&bpf_ringbuf_lock_subclass);
 	}
 
 	prod_pos = rb->producer_pos;
@@ -431,6 +438,7 @@ static void *__bpf_ringbuf_reserve(struc
 	 * doesn't advance more than (ringbuf_size - 1) ahead
 	 */
 	if (new_prod_pos - cons_pos > rb->mask) {
+		*sbc -= 1;
 		spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
@@ -443,6 +451,7 @@ static void *__bpf_ringbuf_reserve(struc
 	/* pairs with consumer's smp_load_acquire() */
 	smp_store_release(&rb->producer_pos, new_prod_pos);
 
+	*sbc -= 1;
 	spin_unlock_irqrestore(&rb->spinlock, flags);
 
 	return (void *)hdr + BPF_RINGBUF_HDR_SZ;
--

