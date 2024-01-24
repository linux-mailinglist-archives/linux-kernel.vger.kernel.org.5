Return-Path: <linux-kernel+bounces-36280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E97839E58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C22B239BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF020F4;
	Wed, 24 Jan 2024 01:38:58 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33481C16
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060338; cv=none; b=eaCVyOdL8RHor5KaTYtDdXTFgAyfQ4AA5uHD0pbTizFho8YD1Oc2CsqO52XvM18HX7XaOwDj6kH6OTb2c5DOkJZLgBfJAB6S+oYUmAdXkl4IRbWEiEzl76uFaHXyBOD3X8Ns6UZGfgreQsQDiUgebBpcWhIIksV75LOo9AqE4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060338; c=relaxed/simple;
	bh=M4OByy/HDpQ3nE+NJeri8ZbevnYJ0vwrzaHmVGkccnc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ip+iauSWF68i8rb1XjiTQclU3gcDW+ogI8rXIpampaijoSNIORCAOB+dSKt6kMU2HtGV4UKIzUZnUHDac3jJOl4/PN/bxWSGp2Mn2XndOZc1D+U0MaCfS+DvAFG2Mcpx0WknYJpTp+DZKc1pKqNtb5Uj14gDurPd8KASstt1JLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso410100139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706060336; x=1706665136;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmiRrmVeeh30FE7qJwrcCK9ksfiIcWxYJjVpj8saJyo=;
        b=p6DCiI2gGeE50kqLrbVYgqbPdn5u2c9HGiYR+x3kpuGzcLJntnupsu9dyIpTtpvDuG
         7ahoGxn6khwdJyyTfMdatuv4pqEUnEbLwBuQscqwjQQFd/kXBW3c8UyOB7ExBsURX1KF
         QRHrP/3Qrnc4YOZqObx0AmFOVlFNcdn9piosKKGb99owMS2QIUm+xPPP7/om8ZFX87vL
         BaqT4uO/fg6yokajHdCJgoIHGoKKW81Ir0BO2wZ7jxkz1NeSp3GUvUXe0WfoKwUxplup
         y4MARmZiqYe0m2SaLCHAPpMunDrYOD3T89YnYhVq+lbFJ/B77X0qXFI+RKV2WKp86x8e
         7e3A==
X-Gm-Message-State: AOJu0Yxh+2fdZQwbjJEwJeXSBhBZ2ywPWy0O+We+bvY4CvYrfwM59J8z
	919ld3Ij6lg0A/2BzsW6pKf4BgPR0Damm4o3TzFCTXW9JTCYKjndWMz395oufYpnRrzO1ZevSq4
	fu2t4aGJSlnYPIoj9hbLPMV9Ji8gVxGhzqKTI/RgczZo/sJKZWP6MXsg=
X-Google-Smtp-Source: AGHT+IEnLqzGyzu0PsAZZSMDssk0PfgPilyHw1DcYq7C8C8RpoGYUIdXC+X2Xcsi4R0U4faaG31Py5F+7Wepn45TRTEGV5xNmDzM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:361:a97c:e267 with SMTP id
 a11-20020a92c54b000000b00361a97ce267mr82660ilj.5.1706060336136; Tue, 23 Jan
 2024 17:38:56 -0800 (PST)
Date: Tue, 23 Jan 2024 17:38:56 -0800
In-Reply-To: <tencent_E352FDC65FC9B06EFB6ED30C9CA7EF46DC06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d0ad7060fa720f3@google.com>
Subject: Re: [syzbot] [jfs?] WARNING in dbAdjTree
From: syzbot <syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com>
To: eadavis@qq.com
Cc: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> please test WARNING in dbAdjTree
>
> #syz test upstream

want either no args or 2 args (repo, branch), got 1

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

