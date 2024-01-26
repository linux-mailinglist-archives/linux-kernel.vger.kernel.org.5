Return-Path: <linux-kernel+bounces-39914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC8D83D759
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FB41C2E4B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BF1C68F;
	Fri, 26 Jan 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BW7p7oIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AA1C2A0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261146; cv=none; b=hVjYsGH5vjMYdWJ5xmZa4dtxAuUslkN+v4/pCgSglnTMNIjrA6TbK3+/5RjZ3xiCP8X02oTgKFCDR7FDXwSBGXnHjlL4Mkuh60f3JHAESo0apYE5oOfsEAq2a31IDB1oYGyN78Nf64vObA7c5TmuXYDaKJmJowCzjDs1NWtK9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261146; c=relaxed/simple;
	bh=yvjK49YeH3fT+kfbLz0NUAJLqFpzOT4UcCQn3OypYTY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y3nn3cJen21Rr38/xqjbTl9Q8aiLzpU9sPpDgA2Vh3IBoN0Demu1PLxgiB5a7nL46mZBmqFveAWuh6YD/fSRllnadI+ckEoVLHkvjBedw1kpX4OnHyUCEbz/fNdR/no6VD9jeMJp8HttbK6L7v1nzKUnZDNfZRqf1UkksOqbX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BW7p7oIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A972C433C7;
	Fri, 26 Jan 2024 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706261145;
	bh=yvjK49YeH3fT+kfbLz0NUAJLqFpzOT4UcCQn3OypYTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BW7p7oIloxclVlzTOx02Tv3FlLG1rxtCEqNHs7+Wh9/qOFES7N0VySaCmlvUEuU41
	 MSh+XMDZ/Xzn0vrQCyZsSqiseKOJRF3Anbak14KAutEmVByDBc/cmwGZkQkJPrAYbS
	 jADOTnxPtNlotmJD8nqKVDQs/iD5F4YV9fZs0qfs=
Date: Fri, 26 Jan 2024 01:25:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+a1deb5533794ff31868e@syzkaller.appspotmail.com>
Cc: leitao@debian.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] possible deadlock in __unmap_hugepage_range
Message-Id: <20240126012540.045d8521de02fab64f3cbf78@linux-foundation.org>
In-Reply-To: <00000000000063895c060fd59596@google.com>
References: <00000000000063895c060fd59596@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 01:04:29 -0800 syzbot <syzbot+a1deb5533794ff31868e@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8bf1262c53f5 Add linux-next specific files for 20240124
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1218a7abe80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4b59a824278780
> dashboard link: https://syzkaller.appspot.com/bug?extid=a1deb5533794ff31868e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151a9cf7e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b70cfe80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7696d711072d/disk-8bf1262c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/92cd47c28072/vmlinux-8bf1262c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/add5c7493418/bzImage-8bf1262c.xz
> 
> The issue was bisected to:
> 
> commit 947b031634e7af3d265275c26ec17e2f96fdb5a1
> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed Jan 17 17:10:57 2024 +0000
> 
>     mm/hugetlb: restore the reservation if needed

Thanks.  But moments after I moved this into mm.git's
mm-hotfixes-stable branch, in preparation for upstreaming.

I have fully dropped the patches titled

	mm/hugetlb: restore the reservation if needed
	selftests/mm: run_vmtests.sh: add hugetlb_madv_vs_map


