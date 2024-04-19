Return-Path: <linux-kernel+bounces-151344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4648AAD40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA62B223BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398981730;
	Fri, 19 Apr 2024 11:03:13 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B680629
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524593; cv=none; b=mRb23CCbeZmX/6Hseb0lDTMRzphZPcZyLy4WKjJdJfTH7Pvb7pUYYuVFLGtOn42rGfLviW166v40DdiiWRTcYKARkM4dkDS0YE/PBgXiR04Ei9ISgmfK46qid3x0GlyWM3JhHnk5xLExIdrnxqYOqEsiRK1oZjce/wRtcQWvU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524593; c=relaxed/simple;
	bh=EA2I8c3ppVC1x+EQitfhhfZDOkuv79dfnWWAKMXjulk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nglGBmmt7Tp8DW3vXwvLAM5NqsgZzIKxpvMmPuytkreMPbvCl7OzHhlkXSDiZpjV5UO6YzhPFo0EWh3aksY+3uxHqDc3fQH1RPPhxIHYpK3kW5dWzqBqWS/glQaI1AexjRyxogE0LxGs5gKRRboCFkrsw/FtrGvqkjS6LP65ELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.253])
	by sina.com (10.75.12.45) with ESMTP
	id 66224F5F00000946; Fri, 19 Apr 2024 19:02:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3018731457733
X-SMAIL-UIID: 226EC22C9F59408E96BA531040139487-20240419-190258-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+dddd99ae26c656485d89@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in __stack_map_get
Date: Fri, 19 Apr 2024 18:44:38 +0800
Message-Id: <20240419104438.2747-1-hdanton@sina.com>
In-Reply-To: <0000000000003f81750616646cb8@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Apr 2024 13:00:28 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f1f7cb180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  f99c5f563c17

--- x/kernel/bpf/queue_stack_maps.c
+++ y/kernel/bpf/queue_stack_maps.c
@@ -124,7 +124,7 @@ out:
 	return err;
 }
 
-
+static DEFINE_PER_CPU(int, map_depth);
 static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
@@ -132,12 +132,18 @@ static long __stack_map_get(struct bpf_m
 	int err = 0;
 	void *ptr;
 	u32 index;
+	int dumy;
+	int *depth = &dumy;
 
 	if (in_nmi()) {
 		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
 			return -EBUSY;
 	} else {
-		raw_spin_lock_irqsave(&qs->lock, flags);
+		preempt_disable_notrace();
+		depth = this_cpu_ptr(&map_depth);
+		*depth += 1;
+		raw_spin_lock_irqsave_nested(&qs->lock, flags, *depth);
+		preempt_enable_notrace();
 	}
 
 	if (queue_stack_map_is_empty(qs)) {
@@ -157,6 +163,7 @@ static long __stack_map_get(struct bpf_m
 		qs->head = index;
 
 out:
+	*depth -= 1;
 	raw_spin_unlock_irqrestore(&qs->lock, flags);
 	return err;
 }
--

