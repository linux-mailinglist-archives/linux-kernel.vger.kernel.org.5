Return-Path: <linux-kernel+bounces-159343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323AE8B2D50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E260C284F35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22D155A56;
	Thu, 25 Apr 2024 22:57:35 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212212BF28
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085854; cv=none; b=V4YD/BWfbRSE/Rx4AUNbs5pZ223RPO4E9NKC04107PHVp5cKlISU3QHcu5hjGF9FQc8d8xitYsqnrr2MnxjYc6f/B5kyeaVrcRX1sYaD6RsP1TaGdu2GhjSJsfZ0qJ6j7C+AGJCvHscLdi1B4jncsdZIlcyrq1K3UE5OObzfCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085854; c=relaxed/simple;
	bh=LGzbZC8/xoQQsXyfN11J1Puhk0Soqjo6+qmLU5QDD1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EAbJKQ8hrgqMgA4iwy1CnlElbcCLjhym3n9Z6hvI7hSs+7CNg3dC2iam+uCX9HUEnPM1tA1y75YVkbhiYcBfbVUkAbxHmHV9KSWWyYtvX6PWx+nbpPt2u6jjBZc2izV1uYIqoWE6Yh1aewBnLyJKmFAJB0phYJcF6qGhBLEhMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.235])
	by sina.com (10.75.12.45) with ESMTP
	id 662ADF4300003BBD; Thu, 26 Apr 2024 06:55:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 31961131457685
X-SMAIL-UIID: F35C7840F749482288CF30E0B3AFBC17-20240426-065501-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c6a1953c27ace6cc34e5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] WARNING in wdm_rxwork/usb_submit_urb (2)
Date: Fri, 26 Apr 2024 06:55:01 +0800
Message-Id: <20240425225501.3242-1-hdanton@sina.com>
In-Reply-To: <00000000000092e8f90616e4627f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 21:40:22 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    a160e1202ca3 usb: dwc3: qcom: Add multiport suspend/resume..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166f3d27180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-testing

--- x/drivers/usb/class/cdc-wdm.c
+++ y/drivers/usb/class/cdc-wdm.c
@@ -311,11 +311,12 @@ static void wdm_int_callback(struct urb
 		&& !test_bit(WDM_DISCONNECTING, &desc->flags)
 		&& !test_bit(WDM_SUSPENDING, &desc->flags)) {
 		rv = usb_submit_urb(desc->response, GFP_ATOMIC);
+		if (rv)
+			clear_bit(WDM_RESPONDING, &desc->flags);
 		dev_dbg(&desc->intf->dev, "submit response URB %d\n", rv);
 	}
 	spin_unlock_irqrestore(&desc->iuspin, flags);
 	if (rv < 0) {
-		clear_bit(WDM_RESPONDING, &desc->flags);
 		if (rv == -EPERM)
 			return;
 		if (rv == -ENOMEM) {
--

