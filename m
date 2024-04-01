Return-Path: <linux-kernel+bounces-126500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443B78938B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71FFB21322
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCEBA2D;
	Mon,  1 Apr 2024 07:47:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD615A4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957654; cv=none; b=QfRna9rly5dvL4FIdr2HmBgLzlThh3C+9lvoQCdjhX7kZ2gZNLTTflNnF4gZBc/xnmmCOKVDyxhykSXdGbdZ5DyO/v1RdtruRALro8SNavJR0E+RZLwMMp6Imc2ctSDj/JkjinheiqGNPG+dUSOXNwjsk010Fup955GoDp7nC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957654; c=relaxed/simple;
	bh=+ZI2DP/qaKtIBC0/ule56jqNcJ6Jtlb5WWTWdjUCxcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u/S/RSxOdeYi93GITH8EO3m82XD2bEI38K846iA4qiPQ9O4jYRO5pQd4rXdrpucgl8e0BpSogb+86SLDXQHt+GuYK+lXH1hyV9qSSpC9qYhtfuEb+ffj+kI0MAC6CNTtoZ1NY++Z0euGxo+H/rwH7ME8ik4cX8I3DHxr8ciZGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so286475939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 00:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711957652; x=1712562452;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElTuJtmDQn1CxZbPxr5ImKVjUP9n6hi2pFM99DoBj+E=;
        b=jVL3poufrzgZQSfpeRk2IsmCuf1LUUXSIq4BL22MamF89Oysb30sRbGzpgYHGvGbfL
         /ppxvAcIgrqGaBID2HYnPBGWjVcP9RBeE+ZQEpLgWM7aBln4WXkPmlvKebCtkDTe9JuW
         M5aHlkMd/Dwt8uboTHPHrf32ZFj3vV4k81SgNZcAVlKFJ8jOXu5EXTZ03XzC/ENnNJeA
         6uh8ciQo6UioRhThaTkaMq1cH9Hbrg70GLMiGVBEG0c30jr2mNn1clqqT86hDsPCErfw
         yGWMOvwaSPvvFpLcoFwu/mNAOskuxfpCC2ffMF+bGypjHS7eLf2VugpQEVDieWPPUwWC
         jHrA==
X-Gm-Message-State: AOJu0YxqCc0cBOV2pHfIzF+ObpOCC6znA26mb23Cil0mJ1Nn7FUTN9Bv
	TqAOwkJlZpmJ7pgxaX3ZBwi/SmQ/1S2FTkjDljPEArHHURnWSB8gghaldYQyRp/VTvTl391Wqg4
	hbLASj/exSnD0CzvSTw7LJd9hy4yJwGbivD4HZ7X3rfPFnKUTFnBzCx7lDg==
X-Google-Smtp-Source: AGHT+IHBCq93SVMQeU/PijysUPhDpFbG0FJZliblkCqnW3L6nRtbd3NnSXSmJJKpatqwz5axoUzwtLFfULEWiC3JF8iBgsxc0h96
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1413:b0:47e:df47:df4d with SMTP id
 k19-20020a056638141300b0047edf47df4dmr479622jad.0.1711957652052; Mon, 01 Apr
 2024 00:47:32 -0700 (PDT)
Date: Mon, 01 Apr 2024 00:47:32 -0700
In-Reply-To: <0000000000003ad27a0614fa0b99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8aba3061504339d@google.com>
Subject: Re: [syzbot] [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
From: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..a7aa4f31c0e2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1696,6 +1696,7 @@ static inline void
 rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
+	local_irq_save(rf->flags);
 	raw_spin_rq_lock(rq);
 	rq_pin_lock(rq, rf);
 }
@@ -1722,6 +1723,7 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 {
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
+	local_irq_restore(rf->flags);
 }
 
 DEFINE_LOCK_GUARD_1(rq_lock, struct rq,

