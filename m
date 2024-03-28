Return-Path: <linux-kernel+bounces-123826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13F890E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998DCB23030
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0B1327E6;
	Thu, 28 Mar 2024 23:28:34 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866C3BBF1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668514; cv=none; b=IKt14rD/XKEi5UWl/NsJ/O+r0QzSqHNBJ5gdJRFlx6q4o01bfhxJ0yuJ1SyXu5e1JIGUyx0nIClg5tizAYaYNIE3WU+h6zgLmSCWxn+hsYfHVb3XvYPQJKX7KLHIOKQ6zYz20Nrl874VfiX9mE5tsdqIG6zLoib4CnenDv1B4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668514; c=relaxed/simple;
	bh=rDzS2GrmNAA1F/AQ4Xqb60h6PqGRmn11ugerccIK6wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OC8e0cRxfvqrI7BFZdfXMeMEDM2fm95DFteytqNFELkLLdaNeEa+tMCMOgxiqeoMmJYhkhYCFiMuhZBCsqMg1OQm8w3vxaysgZ2GRG0wqsy5c27BhB8smbEbpjEC/46vzCf4U1OQMe4F0yXnKR545Rso5lTH/Ao9cnkVME3NJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.240])
	by sina.com (172.16.235.24) with ESMTP
	id 6605FCF200003BB7; Thu, 29 Mar 2024 07:27:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 55047645089439
X-SMAIL-UIID: 96AF6B17DFC14B69A8766741FEBCB0EE-20240329-072748-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in kauditd_thread (4)
Date: Fri, 29 Mar 2024 07:27:37 +0800
Message-Id: <20240328232737.2973-1-hdanton@sina.com>
In-Reply-To: <000000000000d929dd0614a8ba8c@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Mar 2024 11:39:42 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112840ee180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -980,7 +980,7 @@ first_run:
 	rcu_assign_pointer(q->current_entry, next);
 	spin_unlock(&q->current_entry_lock);
 
-	hrtimer_set_expires(&q->advance_timer, end_time);
+	hrtimer_forward_now(&q->advance_timer, ns_to_ktime(NSEC_PER_USEC *200));
 
 	rcu_read_lock();
 	__netif_schedule(sch);
--

