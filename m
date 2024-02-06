Return-Path: <linux-kernel+bounces-54328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C284ADB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACF82860EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B82677F23;
	Tue,  6 Feb 2024 04:53:22 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78677F0D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707195202; cv=none; b=Ml22B/anxPJZ2wb7d0YCSN8TcnyOI2yHxp+h4gm9R8yXIKzmUGZG7XSJRaiRyUhg70DK5QoDrulsJuu6HMc/9iJnqRlVSzEfSofbnJjCJaSf4zhmt4t0Q2O1twuPI9n6t5nwjl9yfAXYo/qDOMBigKYNSAemc5MUNLoI3z6MrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707195202; c=relaxed/simple;
	bh=ZZvP+RD23gqZ5phIOGn1+1V0fU2ihN10kF7EjIg149w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDHiOgnFjnzaZfBmDghxmlVTFtKBfp/IchAlXJrj3qZ4UWVoV42eRAH51KFQxFewcvn2HzEz2o4FRE8CFMoMND7KoEunAy7D1V3O+fBMjAkelpK3+KVwoC35rZVZi9tAyvo97+0VsRXlkv4DDuhQ36jwJWP7hWhVIHNaKHiTQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.138])
	by sina.com (10.75.12.45) with ESMTP
	id 65C1BB2F000070EE; Tue, 6 Feb 2024 12:53:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 32314931458029
X-SMAIL-UIID: CEDFCF2855324CEB953C5C2DFB4AF3B7-20240206-125306-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4bbc13a207327f82b3b0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ceph?] [fs?] INFO: task hung in ceph_mdsc_pre_umount
Date: Tue,  6 Feb 2024 12:52:54 +0800
Message-Id: <20240206045254.711-1-hdanton@sina.com>
In-Reply-To: <0000000000001524350610a52994@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Feb 2024 08:43:25 -0800
> HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1255e7c4180000

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

