Return-Path: <linux-kernel+bounces-52036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C289849327
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9291C21707
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B9DB64C;
	Mon,  5 Feb 2024 05:04:35 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62FB642
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707109474; cv=none; b=Z6Ic8apSQ5UC2B2A6J8XGBAtXupcogPYD2TkX43q8VlShjp+tuQSAK86P+ejpekJMokNCo1bv46ZAz5PtyQTfAiVJ9H9QfesEqpzScpka63d87REClh9+GYncmC6YJu/hrztX6bSaGar/ssqkYDNMJukl/vNXX65BNXHDrbiLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707109474; c=relaxed/simple;
	bh=gerY8TPaQgWIGSM+j+33YJCwHSFU/G98zU+avBFXmZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JktQxCXz9ihqgGUCGyvPXwQ/BPQA535JHrF4ild/PfEizZzTANdm15Pdzcar4wtNnoV9j7hri6fq1WF6E6zy5in7wtsHud+J7OQpJ7mG1xQqpKzF6vkRfk0WWBICuhih/1cmYrDuegpTSCyZ9MDHbwcQF+Lr9E4rik43Wr6zubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.117])
	by sina.com (172.16.235.25) with ESMTP
	id 65C06BC200000A83; Mon, 5 Feb 2024 13:01:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 93266734210238
X-SMAIL-UIID: 0EF47464A2504E1D8A25EB127E52D848-20240205-130156-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com>
Cc: Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] [net?] INFO: task hung in rxrpc_release (3)
Date: Mon,  5 Feb 2024 13:01:44 +0800
Message-Id: <20240205050144.652-1-hdanton@sina.com>
In-Reply-To: <0000000000007e79b806107c054a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 03 Feb 2024 07:38:34 -0800
> HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
> git tree:       linux-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1562f5b0180000

Test tj's fix [1].

[1] https://lore.kernel.org/lkml/Zb_-LQLY7eRuakfe@slm.duckdns.org/

#syz test

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1999,6 +1999,8 @@ static int try_to_grab_pending(struct wo
 	 */
 	pwq = get_work_pwq(work);
 	if (pwq && pwq->pool == pool) {
+		unsigned long work_data;
+
 		debug_work_deactivate(work);
 
 		/*
@@ -2016,11 +2018,12 @@ static int try_to_grab_pending(struct wo
 
 		list_del_init(&work->entry);
 
+		work_data = *work_data_bits(work);
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
 
 		/* must be the last step, see the function comment */
-		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
+		pwq_dec_nr_in_flight(pwq, work_data);
 
 		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
--

