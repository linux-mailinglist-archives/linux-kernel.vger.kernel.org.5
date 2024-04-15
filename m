Return-Path: <linux-kernel+bounces-144443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BE8A467C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3262CB21FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0E748A;
	Mon, 15 Apr 2024 01:13:47 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F933CA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143626; cv=none; b=NX7fLZUbfclGURcA70LJXzKJuhZuvZieCB7jnEyOdoL67OXzLyT8IxspdkcmEqxZC6LZiuRGPYAf4k+H9SUdEUe70ZBem/7pYJI04n3sZdNlt98N26iHGPcXcokatEPsAo/NcvgrvH1yVR15FetLr6YVh2BqGZD7iej2qnKF3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143626; c=relaxed/simple;
	bh=LAMc7X54zX1UJXweD7V5kV7gftyCWvDPmgkXAmyHkd0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CB1ANfsKrjyqqO+DB4ggAlsBkqQHAX7VYCqXnfQ8BGlvhrKSNyLTXbc0ZIFNEjJeM65skbkL4ye1vj/mXkEK0QV4mo+8e/TnFJOMMC6GRfsV44Jy5fe7xeR0eZWCBhdRUS7Nr4wi7a+kfm9F4P9aQsQLNFWXOjjOAV/IT+E4sTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d667dd202cso268738339f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713143624; x=1713748424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaB9cQsHbFhSbb/FCOGavc7IgtiKsRPBmnY5k4OM25U=;
        b=Y7zXtppC14SBxYoe2ppGWq5XrkSLAFMlOSiL6g6yZtbeHuIbWmIcVLJIILWb8LyWoL
         wiGBjXVYrp6Pv9c3fwrgNkCwQ+RC5bdKAfqSArIZ2xmMnpCktbd17Nk7TKNKcuSe0L8P
         gBmUtVhGddpWyJNP/lnp6vuViGt0SymOMLP/URxtpua0jbMMb7d34aHIe/yecxwBKyN1
         uzEPuZu13JYxIq7/Zcrby1C6Fq539MbcGlNgRE4LKPyJvnOuJkfrwJWQVviHMUzWGKxy
         mQX2ikGWFLV/xC/LJu1xXSQ3gq/3RaVtKNQgWVAUbslKnIMgsj/QWHQjFrN6B5QR+jLR
         Bgnw==
X-Gm-Message-State: AOJu0Yybig0gmuz4QZ2kgSgA1fQm6e9CvLcBQmdZPHtj6+EqEjJSQPvd
	BA9rC2i8BHMLqgW3EC9Wb4GnZ/3kC/z5lU0hhxvGChmZfhkX05t/DcFI7u2tOhFHLBaEK0ZRpdF
	Ds/Q2mcKDbDIpTycfbRb/so92djrFtkVV87SpHtK8O+FcB8BiVJi8MJw=
X-Google-Smtp-Source: AGHT+IGSBr8e1/rrFWRPS1ylpWaTRTCbC5G/OF+Q88Mbsexk817kngfFh5VvlII7dxxurSahPuJvSBT+4tm3UlbAouo/RPRuK7kB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410a:b0:482:fa6e:648c with SMTP id
 ay10-20020a056638410a00b00482fa6e648cmr249532jab.3.1713143624649; Sun, 14 Apr
 2024 18:13:44 -0700 (PDT)
Date: Sun, 14 Apr 2024 18:13:44 -0700
In-Reply-To: <0000000000004f557c0615d47e6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032618c06161855cf@google.com>
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
index 8cddf955ebc0..71ce8d1576cc 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1007,6 +1007,7 @@ static void trans_drain(struct gfs2_trans *tr)
 {
 	struct gfs2_bufdata *bd;
 	struct list_head *head;
+	struct buffer_head *bh;
 
 	if (!tr)
 		return;
@@ -1022,6 +1023,8 @@ static void trans_drain(struct gfs2_trans *tr)
 	head = &tr->tr_databuf;
 	while (!list_empty(head)) {
 		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+		bh = bd->bd_bh;
+		bh->b_private = NULL;
 		list_del_init(&bd->bd_list);
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);

