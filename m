Return-Path: <linux-kernel+bounces-137718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645E89E655
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768411C22665
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D357A158DCE;
	Tue,  9 Apr 2024 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TLuqmX/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD74158A27
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706389; cv=none; b=IkIoThaqAB7fXapZ/GDIiuVKxWe3VqYzO0yg3JWOmTTD11SfLE8YlTx09J87FBiGQxlbpGGdqhOGeb/BHhQqqjwJeMOKbpwIlZoht5IXun5yOX7Z6T/j+f5rdNIhTQ0o0XksElkdyrRW06JKPcv4pRRaT1f/Xgbq2HLtK+sfNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706389; c=relaxed/simple;
	bh=HBJVVaWz8JX97xuVuvJd+mzwWz9q/Je1QwskHu9FxZw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rb/mNsFU2i20u5UwZYFcLafX1yW04ukYPplQuhJyJjwuvGLGoYIw14Qdldc2whelQV01oU8iluGwrv+6CNeUBrQDSFJW6tMyxsFeUDMsx2GL6P5QEZzTpWRQUd0h6n2zxkfFDZOsEegn553eLiAwSDU4BhiFgXpuVPiM4kkLcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TLuqmX/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D00EC433C7;
	Tue,  9 Apr 2024 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712706388;
	bh=HBJVVaWz8JX97xuVuvJd+mzwWz9q/Je1QwskHu9FxZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLuqmX/pqFQ4BD7UUGrq4wDvvLzOgy+cEoJ1yiiSvfqGO/NRpbcCm5bPJzc/6ibuz
	 wrEXi+kG3GfkyAzGC7N3ioZ+s9N0TslW9GMX6tcIkIn0GymjFJrdMNjvakRgyXcery
	 5g4sYF/iRu9uAfRr9DldP9smuzYaKUPp48SDBj3M=
Date: Tue, 9 Apr 2024 16:46:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+57adb2a4b9d206521bc2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in
 hpage_collapse_scan_file
Message-Id: <20240409164627.b4803e09c81c01ccb6f55601@linux-foundation.org>
In-Reply-To: <0000000000009db84e0615a73698@google.com>
References: <0000000000009db84e0615a73698@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 03:16:20 -0700 syzbot <syzbot+57adb2a4b9d206521bc2@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8568bb2ccc27 Add linux-next specific files for 20240405
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=152f4805180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca5acf8d2eb3bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=57adb2a4b9d206521bc2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1268258d180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1256598d180000

Help.  From a quick look this seems to be claiming that collapse_file()
got to 

	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

with folio==NULL, but the code look solid regarding this.

Given that we have a reproducer, can we expect the bot to perform a
bisection for us?


