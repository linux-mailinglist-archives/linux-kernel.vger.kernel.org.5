Return-Path: <linux-kernel+bounces-74697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863F85D7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E101C22068
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B304F54F93;
	Wed, 21 Feb 2024 12:30:05 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50D4F88A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518605; cv=none; b=H+uJn1WL+DOQHJ551rVx6SvSowz2IGdMl4n5+7yHyYnaPoukOK0tR0ekoViCYtYzDZKw/Abz8hZEUB9mO9xjO9Ewy9oMnPxsrgro98H7yOaNAOFHa+4P85h4RS+/MJ/zIsdyTNuS7OWlKKPo5mVcIJbqcrJ49MfIuPpdF2FjCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518605; c=relaxed/simple;
	bh=/rve7Yh6o6FE1Zdw5ssfvFHBaR5OWILMvPZl5mSKeUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gB71+Qw6gJA0h9TFKywlg2cIz9vFLI5gJ3RvgDOxp1AkBFD0+sz1u+nmvj3XWkxA3p6oiDNBCGT6PmFXkZ3A0FUUy6Jj8RqUt7V4M0YhEpUdBUb6wdf1fxH7UiSnOpurT9OWixlJca8VNJSeZ6Ace9OgP0+HoF0NBAAuCPR4n/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.19])
	by sina.com (172.16.235.25) with ESMTP
	id 65D5EC980000067A; Wed, 21 Feb 2024 20:29:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 81409134210322
X-SMAIL-UIID: 73EBF547B8C24724A602B099B8740D11-20240221-202914-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
Date: Wed, 21 Feb 2024 20:29:04 +0800
Message-Id: <20240221122904.1393-1-hdanton@sina.com>
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
@@ -1575,7 +1575,6 @@ unconfigure:
 	cec_adap_unconfigure(adap);
 	adap->is_configuring = false;
 	adap->must_reconfigure = false;
-	adap->kthread_config = NULL;
 	complete(&adap->config_completion);
 	mutex_unlock(&adap->lock);
 	return 0;
@@ -1592,6 +1591,8 @@ static void cec_claim_log_addrs(struct c
 	if (WARN_ON(adap->is_configuring || adap->is_configured))
 		return;
 
+	if (adap->kthread_config)
+		return;
 	init_completion(&adap->config_completion);
 
 	/* Ready to kick off the thread */
@@ -1605,6 +1606,7 @@ static void cec_claim_log_addrs(struct c
 		mutex_unlock(&adap->lock);
 		wait_for_completion(&adap->config_completion);
 		mutex_lock(&adap->lock);
+		adap->kthread_config = NULL;
 	}
 }
 
--

