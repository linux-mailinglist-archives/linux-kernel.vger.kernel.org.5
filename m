Return-Path: <linux-kernel+bounces-75917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138F85F09D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA547284D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369864C7E;
	Thu, 22 Feb 2024 04:58:43 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828E7462
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577922; cv=none; b=TQm7cWhm5W4A9WmfkG2qoFixC/4TwKtYZAiY253jcWf4M8Yh57OrtdlmT/ICoLaPkuFrVodL4KR7JdlinwNafW6dK2BxNyIky5eV5IIODsfPEar7Bm32uprIHoWL4YGT1CwVICJx9ebKTA0bPi2++X0Xt6cUor2GZKF2v67e+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577922; c=relaxed/simple;
	bh=PL+A7RzxZSOSUnkECAJUAkk9WznoRE+scfa4iDvANrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVuH/378t/ZGV4EVkLCiOZv9yrHOMkbiUO760riEoj1V5YFyZ5kqULgF5jV00LVnUil5mX4jFcqTylC3xfrM/EdeMf4jXND3V3trV6RrduAXjLddRY0Nulg71oyb35jgmX0OcYQfCvjsV01QYv8PCg5yJ8El4MGF+RR80sGAd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.174])
	by sina.com (172.16.235.24) with ESMTP
	id 65D6D47000007333; Thu, 22 Feb 2024 12:58:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 21221045089447
X-SMAIL-UIID: EA7355BF4BE74D2CA281A1BA99AEDEF3-20240222-125827-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
Date: Thu, 22 Feb 2024 12:58:15 +0800
Message-Id: <20240222045815.101-1-hdanton@sina.com>
In-Reply-To: <0000000000006d96200611de3986@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 22:13:24 -0800
> HEAD commit:    83d49ede4b18 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ddc734180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  for-kernelci

--- x/drivers/media/cec/core/cec-adap.c
+++ y/drivers/media/cec/core/cec-adap.c
@@ -1592,8 +1592,6 @@ static void cec_claim_log_addrs(struct c
 	if (WARN_ON(adap->is_configuring || adap->is_configured))
 		return;
 
-	init_completion(&adap->config_completion);
-
 	/* Ready to kick off the thread */
 	adap->is_configuring = true;
 	adap->kthread_config = kthread_run(cec_config_thread_func, adap,
--- x/drivers/media/cec/core/cec-core.c
+++ y/drivers/media/cec/core/cec-core.c
@@ -284,6 +284,7 @@ struct cec_adapter *cec_allocate_adapter
 	mutex_init(&adap->lock);
 	INIT_LIST_HEAD(&adap->transmit_queue);
 	INIT_LIST_HEAD(&adap->wait_queue);
+	init_completion(&adap->config_completion);
 	init_waitqueue_head(&adap->kthread_waitq);
 
 	/* adap->devnode initialization */
--

