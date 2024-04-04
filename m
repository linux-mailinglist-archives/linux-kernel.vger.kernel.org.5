Return-Path: <linux-kernel+bounces-131274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A576898593
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C5F1C20F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D882869;
	Thu,  4 Apr 2024 10:59:22 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D180611
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228361; cv=none; b=iU/FP38M12KS/VJYf9Ro09GwZGlCb0nYTaz909YnMTgbNeZV2fkqDXZRvgVaKBcqnORWc0ZtLcTqvh6lSUlfni+LNqJTihuzNO0l3lgRix2KVolUw5zxzAPKD7MUR9I+7ajHkevvo2eBZ0TjuN+0igqMEOojtp/kWsiar/yg7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228361; c=relaxed/simple;
	bh=r9fki0uwP9xnEv19ryG/styyswsIaC53CUwytQDYMtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJS51BP2q7SVtAzfwKn3IwjhzKG3kAEisjiLLhyvB919pIj+0wFG/rhsAKekTIfgVIq98MSVeZT3M2ybmGG76SPmPh2r5t5d4TxezTMPD75m71271IwV++5L2voApsSl9ANHbwJ1KcdMpPlbimATRts6AGhXTBVRugtZNKx0xqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.253])
	by sina.com (10.75.12.45) with ESMTP
	id 660E87F80000589D; Thu, 4 Apr 2024 18:59:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6585231457660
X-SMAIL-UIID: 36321F20FE894DE38A277A00B2A0356B-20240404-185906-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [nfc?] WARNING: locking bug in nci_close_device (2)
Date: Thu,  4 Apr 2024 18:58:53 +0800
Message-Id: <20240404105853.4079-1-hdanton@sina.com>
In-Reply-To: <000000000000195eea0615368539@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 12:49:25 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1201b6d3180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/net/nfc/nci/core.c
+++ y/net/nfc/nci/core.c
@@ -560,6 +560,10 @@ static int nci_close_device(struct nci_d
 	 */
 	mutex_lock(&ndev->req_lock);
 
+	if (test_and_set_bit(NCI_UNREG +1, &ndev->flags)) {
+		mutex_unlock(&ndev->req_lock);
+		return 0;
+	}
 	if (!test_and_clear_bit(NCI_UP, &ndev->flags)) {
 		/* Need to flush the cmd wq in case
 		 * there is a queued/running cmd_work
@@ -601,6 +605,7 @@ static int nci_close_device(struct nci_d
 
 	/* Clear flags except NCI_UNREG */
 	ndev->flags &= BIT(NCI_UNREG);
+	set_bit(NCI_UNREG +1, &ndev->flags);
 
 	mutex_unlock(&ndev->req_lock);
 
--

