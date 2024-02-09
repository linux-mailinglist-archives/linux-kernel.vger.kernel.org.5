Return-Path: <linux-kernel+bounces-59104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2984F13E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BC3B23668
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B265BB3;
	Fri,  9 Feb 2024 08:12:26 +0000 (UTC)
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAB50A8C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466346; cv=none; b=LZst2DkYzsfMwf92e/WyFtN+WFGGl2kWMGXnDh52Z/z97DoZstddSk9BkiFKyHU0r567fcZ6SFKf80pMLjDA11nPuDzwk91hNXn3fxKYVbHwhBtPkFeS2E1GJatwL0GEuZJecUiKKCGllh4XJoYuKwovYU6/6JauryPJU44dGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466346; c=relaxed/simple;
	bh=Z48bvkmC9QYsX9/nNoBG9HpckaZ4P+smt/flhUcFE5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkew8fcDRo/wJD33+XzzPFqYN6eB/jStEKjbVC3EYhMli1HmtXMLQoLxp9geJGiZfi5Mlo/BqtWUK88S/6yE7hcscbbse8bzTYqIXS73V5Wk5sFuD7+KGDmnl7vdUsWdaTTSPfowTxHp/W3i8peGXlqUKQSBX68Dj2ux82RkIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.25) with ESMTP
	id 65C5DE3A00006783; Fri, 9 Feb 2024 16:11:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 20688612059212
X-SMAIL-UIID: 11E1DBC888EC468C8BC81CD3AECCEA32-20240209-161141-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] possible deadlock in v4l2_ctrl_handler_log_status
Date: Fri,  9 Feb 2024 16:11:27 +0800
Message-ID: <20240209081128.112-1-hdanton@sina.com>
In-Reply-To: <000000000000ce2dde0610db47a8@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 08 Feb 2024 01:17:28 -0800
> HEAD commit:    b1d3a0e70c38 Add linux-next specific files for 20240208
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1746f9b7e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  master

--- x/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ y/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -2550,7 +2550,7 @@ void v4l2_ctrl_handler_log_status(struct
 		colon = ": ";
 	mutex_lock(hdl->lock);
 	list_for_each_entry(ref, &hdl->ctrl_refs, node) {
-		if (ref->from_other_dev ||
+		if (ref->from_other_dev || ref->ctrl->handler != hdl ||
 		    (ref->ctrl->flags & V4L2_CTRL_FLAG_DISABLED))
 			continue;
 		log_ctrl(hdl, ref->ctrl, prefix, colon);
--

