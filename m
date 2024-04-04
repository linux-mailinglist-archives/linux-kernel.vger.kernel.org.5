Return-Path: <linux-kernel+bounces-130759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF401897CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDAFB2185B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420E1C2BE;
	Thu,  4 Apr 2024 00:01:15 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7889101E6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188875; cv=none; b=CES5+ur9aA6wrYN8sdRcjEAjViCtPOYmw5ENoFwA93jlAS7CJYYpMcWo46egmffTtnpr906yEbRhgdSKRb7j9FZjUjG0GSQPYFmjgO9gbVkdgKxXU5ZMwKuCNmNe34PRSSALOXNN+G6pxgsdcbrZCyoKnY2uFiakY+mEpmZhGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188875; c=relaxed/simple;
	bh=eC1aYVYAAKRFGaFrPzu+pNFeosAE4bFpaTP1je5KirM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDtrwbYdHhouKDmNpQ1kMe9o4xEHgZg9EGF3X0OzDBMK4yr2gRyj16EhZYg6qpuhZhjWv2LrrckqnnYpXDYmuzGaOEnoL6V9UsD99PCW2rRNuc78FJ/HWws+ApX8hgsfMM5qglgthhlJ6oB6/cTX78H22gDhusAjHxdIiooRxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.253])
	by sina.com (172.16.235.24) with ESMTP
	id 660DEDBA00005DD1; Thu, 4 Apr 2024 08:01:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2157745089611
X-SMAIL-UIID: 791D657EF29E45C090CE7142AF62D62F-20240404-080101-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [nfc?] WARNING: locking bug in nci_close_device (2)
Date: Thu,  4 Apr 2024 08:00:49 +0800
Message-Id: <20240404000049.3868-1-hdanton@sina.com>
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
@@ -560,7 +560,8 @@ static int nci_close_device(struct nci_d
 	 */
 	mutex_lock(&ndev->req_lock);
 
-	if (!test_and_clear_bit(NCI_UP, &ndev->flags)) {
+	if (!test_and_clear_bit(NCI_UP, &ndev->flags) &&
+	    !test_bit(NCI_UNREG +1, &ndev->flags)) {
 		/* Need to flush the cmd wq in case
 		 * there is a queued/running cmd_work
 		 */
@@ -601,6 +602,7 @@ static int nci_close_device(struct nci_d
 
 	/* Clear flags except NCI_UNREG */
 	ndev->flags &= BIT(NCI_UNREG);
+	set_bit(NCI_UNREG +1, &ndev->flags);
 
 	mutex_unlock(&ndev->req_lock);
 
--

