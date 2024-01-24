Return-Path: <linux-kernel+bounces-36284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1135F839E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7264DB22281
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAA1FAE;
	Wed, 24 Jan 2024 01:43:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14331874
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060608; cv=none; b=BbbtmbQjVAJanGalinIm772x0hyNFznutS+EaoSYmFHglTjm02UVkPKDJWsN9NNb7GwKpasMi+WPbxENlZe+J/fUOae3Vg/mK1UWiH0iyL2iPofbb8bSMBQHNELf+q8TmPcPBMlkcFN3+plivMocXkPRl6HYtzOwEGGESIsYQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060608; c=relaxed/simple;
	bh=R5aFdD+Xe0TcHNwIgY6OB8nZAzW5dpO7Hy+8bxGeQWc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=A7aWDzY+Npt754k0j0K5xAn0Uu2D/gvSasx5Oojf9Ib9H3TkUZr5+M0O4XsFixKSDVntqb9ZQEqhgQ5xQXLIknQxjUN9ZCvJOet9jwyByPhJZbukBfRIjROI/0BjGblCakKLUxeypwQmiDZsITVaOhIwTT0RI4AClQRGYIVYh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf0305ded5so286516439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706060606; x=1706665406;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5gZh8/QdnqiVwwPYOQzQKaz2g82YQry5vkssfRH5us=;
        b=jSq1pujd1JEBcW2FCRUPaIZfhW423wW1QTRkjLLKClRyMNoTZhtZ1VKguhur5b9rf0
         pZIr9ajg6s+jlboujneB028s8m00TG/an2qysOXcHQOJD+42VcHt1UYc/GhbAHKs+Zdm
         WxMkQpR2/EDtbcKTMCTPLmt9I5LnBBCmUzNDuKWRLPdEUoCd3o3HN/JkC2IEAW6wg0f5
         EV4WRLz1bJ9PKpGGKguyJ7yAwxAKsy0TULmS15z4m6IYPodbot1W6DBh64VQZ9VFQEVJ
         K5qsATpDpEv9p6D0kR1hsyaPBmbvOWVIUcOIu0m5Wm0lxYCkquwtty8PpR7xIsf+tdi/
         B+HQ==
X-Gm-Message-State: AOJu0YxzUBPUXITQNftTvh+q2+K8cJb6I3KJQ9mSaZ+NnO2siTiErccU
	aI9DR5N+uuBrPQnMX09q3EUQ5Yy4yKmDp9ucFBri/yVy0eXg3ucn0dRyRJI4V7bdZIJK/PZ8ExY
	xAhNSJ3jMc2QaiBIQYmkqdyYGYbiPgyCgLN/3FDu4RODcoUX0Ks67Gjk=
X-Google-Smtp-Source: AGHT+IHP03g3hX4Mpbhn28/EH9lIg6FE11vXt4+1tx0g3rFKmnMICVCJnAsF8DBLSjDjUjUUKevafzST6BvKnP/eiWeCne6wE2LX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4115:b0:46e:daeb:40f4 with SMTP id
 ay21-20020a056638411500b0046edaeb40f4mr9223jab.3.1706060605952; Tue, 23 Jan
 2024 17:43:25 -0800 (PST)
Date: Tue, 23 Jan 2024 17:43:25 -0800
In-Reply-To: <tencent_1E7AB26ECC2DC56C589658EB6AED3ACE000A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000621a0c060fa730a4@google.com>
Subject: Re: [syzbot] [jfs?] WARNING in dbAdjTree
From: syzbot <syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com>
To: eadavis@qq.com
Cc: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> please test WARNING in dbAdjTree
>
> #syz test upstream master

"upstream" does not look like a valid git repo address.

>
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 8eec84c651bf..bed14d5169f8 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -2294,6 +2294,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>  	 */
>  	dbitno = blkno & (BPERDMAP - 1);
>  	word = dbitno >> L2DBWORD;
> +	printk("dbitno: %d, blkno: %ld, word: %d, %s\n", dbitno, blkno, word, __func__);
>  
>  	/* block range better be within the dmap.
>  	 */
> @@ -2875,8 +2876,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
>  	/* pick up the index of the leaf for this leafno.
>  	 */
>  	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
> +	printk("lp: %d, leafno: %d, tp: %p, %s\n", lp, leafno, tp,  __func__);
>  
> -	if (WARN_ON_ONCE(lp >= size || lp < 0))
> +	if (lp >= size || lp < 0)
>  		return;
>  
>  	/* is the current value the same as the old value ?  if so,
>

