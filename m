Return-Path: <linux-kernel+bounces-56414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBE84C9DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C392B1C25B56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801491B80C;
	Wed,  7 Feb 2024 11:45:24 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7491B7E4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306324; cv=none; b=WKZPq3MIO/8Mki84kW0rVa7+rh10sPu1cBrY527bmTpKLL5POt6dn9w9IC4pl18P/spQkBVOoCRenhP0NFOBnWzxSOmVrW/GgHY9D87QCn+jos2Ky5JtvDgjz1/+ZLpQh9g+D0v/quFLgCCbOkjqQo1xBgACT0YOFqfLa93m0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306324; c=relaxed/simple;
	bh=stlP0vmieVdfUXs897eV+2lDHbI2JnfyviKh7jFm2EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fkj52+2NzBr6q1XqQ+k4ycgCK5IuYqNBVDDKGurfGGFNcjCTAz1dKL4yN9b6PYw1aVu0ZOaOyGOfyaynmAQb5LW9jt62EqA3xQa6idDnfwSydu7viQa3UFiDKx4GEN4VgffA4X+dlW+RkGB1A6ME7tPhdG1budhgpsrBgtyCp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.212])
	by sina.com (172.16.235.24) with ESMTP
	id 65C36D43000042CF; Wed, 7 Feb 2024 19:45:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 40857945089154
X-SMAIL-UIID: 8F64AA2310FE48E6B16A23EFFA41A0FA-20240207-194510-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0260338e3eff65854d1f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_inodegc_flush
Date: Wed,  7 Feb 2024 19:44:59 +0800
Message-Id: <20240207114459.1057-1-hdanton@sina.com>
In-Reply-To: <00000000000088268a0610c6b3ae@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 07 Feb 2024 00:44:21 -0800
> HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13811004180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  076d56d74f17

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

