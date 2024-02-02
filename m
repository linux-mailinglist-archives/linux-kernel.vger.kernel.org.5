Return-Path: <linux-kernel+bounces-49022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1588464E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90E928373D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2B10F2;
	Fri,  2 Feb 2024 00:08:20 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5D188
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832499; cv=none; b=ZEV3n0Yl9O+9hWZmuuUkLcr83z0G/xS/rSnbnUfGzZzZQ0UufGGQF4Udyl4LKH+2oaTTo7hxqSB3LFC8HSoAsu82pfm3ycIEhnq+uwMd6MuXHoYxdkyUGH5APjA2SREfVP7zCVlZIj/ViM/F26LGAGmpISMOyMPPX+I3FoiY8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832499; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tB2gWOH8K0HSf6pMmFf588ITg4FLmqhJEMAdrA2UXnAGdF/FRg9cuK3UrNv6Js06nWKzi1fsRUgCgVUjTLU1qoC4hc/kN7wJ2/KmpOh16cRIPDLs8HgZMF6Tea5bwRpLkds+GFFKTbKrmIvymXy/vNmxk2yx40R/Ei2GH8Js8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3637fbf4d1eso13130085ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 16:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832497; x=1707437297;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=sxWrcX+lEg9b2VZ/DrjFjUGlsNkoUPX6jfpZF6ufIGm/UlLT59QObRrP1aInf2hXyA
         NOVDOIITcDgZt85VKHBSILtgEp3BLJKR63dmYKTkONlqIpFFq/tUykg6qTLO6L0lqInr
         BfRMhqC/wse7hEKlbgocYLsiQgTeSTnJXTFg2m1yp4+74FLFhQOcyAEFNz/qUlpy3/jD
         C+R4LsLTXrLSqHKoATrGbRUvmRsr4PZ5x/Wo33sKhjPlyUW3pnHOH7A8F0ZMGHQjwn5J
         elEpaFpDg5GQ37XRcTkt0LQ6PJ88M1W8S0+5RSZDx3fCJgdOOSV9Li7rL2QGxrJXs8fA
         Ad/Q==
X-Gm-Message-State: AOJu0YzaAtElHbUuRfhmCzFwB9YV95oJQbeh/f4bHJ19crnsFmGJ5ZYv
	lEWRWw7CHkGF/6jWJ2f7X4gi3yev5vhCQf/diBqAD4HkpezTVu1qwTVCrlns6J+ozRxMTxHASlr
	IApozw+OXihjjXuZZmFbRt88k7RrnJ3VHYIGEp5ZOqojllV092Oig/uE=
X-Google-Smtp-Source: AGHT+IFh6rPkpvnTpkhqIyzh88eiONvMoSw2oblVG+U294VcHimyqA5qNFoUju+wCc6Nbr6ALRpN/ya37moEeFn4cz4w5BNo8Dox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:361:a961:b31a with SMTP id
 x13-20020a056e021cad00b00361a961b31amr572373ill.5.1706832497612; Thu, 01 Feb
 2024 16:08:17 -0800 (PST)
Date: Thu, 01 Feb 2024 16:08:17 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b61df306105ae8ac@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

