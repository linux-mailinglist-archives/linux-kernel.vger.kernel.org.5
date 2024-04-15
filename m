Return-Path: <linux-kernel+bounces-144476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C488A46C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA68B23165
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA51864C;
	Mon, 15 Apr 2024 02:04:56 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D117758
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146696; cv=none; b=YINNUXqNwa1W2TwmrozJobz4VTBr9nDtfMasT5eFYftasfNnz2L/3NkRvs5t87C6EIR/C8R16ts8ufKrUxpspp43CB42rZ777vGGeHQwc6qfLbzGYrrVlvRSrJJoyKh8TjOXl+ZlKF/sLyVPkcZFrb1yn156g7RdT4w9G2HImvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146696; c=relaxed/simple;
	bh=DMYNnRuncHGbJBEYcNrNzscIDkyxlXne7jum5Wo9+Uw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qa9YLi98A03D8madV1iA84+fFSNvSwum/POZfqUiii9xD8NC0W98MS5YBNS/B+AEKZiknLyIX6HehmmViSiNRMw5yeiE7McU8bx+DESlLcAM5yknXb2oyqasQXJC8b8pLjcjJ/1P97YjJtmR3jfJ94JJiuemLn/SY0DRZB6YVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d66a30a83aso210872939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 19:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713146694; x=1713751494;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lM02CA8w/kz/NAdXHuf87L2UB3HDqNXDonRaeuetwxU=;
        b=bxNEfRTqA72DtXX2bFscz5MRSZwHWs4gtrV+YXTHj4U+fV8bjjWjSgqwOeUpNWn2VY
         g8pWCRKj6ywyVl8iRQLicN06JaPIHHzALj0su2k7zAD5V79OJ+KcK7czdFQnayiylcde
         WadpxfN+hPKASz1yIaKLX193COKBrp4YCCpyPqq9hxvi7aE7LkxddsIYqMQASVCjh59s
         IQDmvZks/A0em86JIHg1WQxtR9MgHu5ZDGImsXjpP3UXBiPDrgYFFRm+GeTx6i0jJsPH
         WyIRhC6Wn4c1+64qW7esQh9+2q79iMJf6hs5vByppK7/f20VVdL42PdQjbAeueMkIsLe
         rIXQ==
X-Gm-Message-State: AOJu0YwaavQa44yuerabrme71QZNiAd80vAnBZtBtGSFfp9jt/HT2UE/
	thBPbi9HPNmGw1Ilf0Svnia6J1qbxYO9T+duyWyvOCam8y1U/ONbzc/tUSkovCqTJ9d4eP3uLVx
	vS30WClj94IwrWxWcbXJVi7kxXC/+ydLVuAP0kM8pfdFqZ3vpYCzF5Y4=
X-Google-Smtp-Source: AGHT+IFfZLPVOIe4oxf6jCCqHaPOqvd6wt2bUUzjAEiM/XoWn//qvyDA6ESibDMyodC3sXl/4BBZuFDl2NYBRhWLy+NKeobsmFrv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c541:0:b0:36b:1b7:5a85 with SMTP id
 a1-20020a92c541000000b0036b01b75a85mr593738ilj.2.1713146694285; Sun, 14 Apr
 2024 19:04:54 -0700 (PDT)
Date: Sun, 14 Apr 2024 19:04:54 -0700
In-Reply-To: <0000000000004f557c0615d47e6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000294d860616190c51@google.com>
Subject: Re: [syzbot] [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e8c39d0f57f3

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8cddf955ebc0..8b1d4d6da855 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1007,6 +1007,7 @@ static void trans_drain(struct gfs2_trans *tr)
 {
 	struct gfs2_bufdata *bd;
 	struct list_head *head;
+	struct buffer_head *bh;
 
 	if (!tr)
 		return;
@@ -1022,10 +1023,12 @@ static void trans_drain(struct gfs2_trans *tr)
 	head = &tr->tr_databuf;
 	while (!list_empty(head)) {
 		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+		bh = bd->bd_bh;
 		list_del_init(&bd->bd_list);
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);
 		kmem_cache_free(gfs2_bufdata_cachep, bd);
+		bh->b_private = NULL;
 	}
 }
 

