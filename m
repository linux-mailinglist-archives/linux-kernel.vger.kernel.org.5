Return-Path: <linux-kernel+bounces-11759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A0A81EB45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06128B221FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB428FA;
	Wed, 27 Dec 2023 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="QuRx2MiE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D92563
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id B86BE3C011BD7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:22:57 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
	by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jxnYNEoBAdFu for <linux-kernel@vger.kernel.org>;
	Tue, 26 Dec 2023 17:22:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 301343C011BD8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:22:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 301343C011BD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1703640177;
	bh=FsbHtOvJgwS/hOaAhmUeU44rd6JB5JF9YpIG2bBxBuk=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=QuRx2MiEu6QedgLW/X6B54SuzzqaJ6FD9bu/OnLXlTtVww6SnQbxF0HFHzbJYl6uh
	 RzyRzLVUoOPNmn/4+DSXh+EK+8jCLlpyvZNpxkVP+cHOjxEkmydcGp3XHbz3dd08ze
	 zgVTghiGatRh1i1AXwxAz8niXqwThAqLWdGZvyneyzYIEczxQPhvvFwKRBHyAG4pvV
	 /DYBH7TPxQMufeBrgQd6cB4xtKRXVQ69Q/uVoHaQqf4Ax5hRjPxULOVn6mCgmCqOsI
	 AlnoK29GEXEPvRLTDn7kfwpFC9FSF7e0f397A4btjAdGSRZALL3Ai95WunrlBaNNjB
	 186TIofEDW0IQ==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
	by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lECc4gykTIZC for <linux-kernel@vger.kernel.org>;
	Tue, 26 Dec 2023 17:22:57 -0800 (PST)
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 1BAC43C011BD7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:22:57 -0800 (PST)
Date: Tue, 26 Dec 2023 17:22:57 -0800 (PST)
From: Sam Kumar <samkumar@cs.ucla.edu>
To: linux-kernel@vger.kernel.org
Message-ID: <326262860.30503812.1703640177089.JavaMail.zimbra@cs.ucla.edu>
Subject: Tracking Page Faults in Another Process
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF120 (Linux)/9.0.0_GA_4546)
Thread-Index: wU/rUzj5ozItGbuOsWuMTb6gUHUa/g==
Thread-Topic: Tracking Page Faults in Another Process

Hello, 
I'm writing a performance enhancement tool as a user program for Linux. I wanted to ask about possible ways to achieve this given existing Linux APIs. I also wanted to ask about ideas I have for extending the kernel to implement this---if there's appetite for them, then someone (perhaps myself) may contribute a patch implementing them. 

I am using userfaultfd to track page faults in the target process. I need to "mark" a page in another process, so that any future read or write to that page will result in a page fault captured by userfaultfd. userfaultfd provides a "write-protect" mode, but it only tracks writes to a page; I want to also track reads . So I'm wondering whether userfaultfd could be extended to also support a "read-write-protect" mode that allows for marking pages as both read-protected and write-protected, and detects subsequent page faults on those pages for both reads and writes? If there is any ongoing effort to implement this I would be curious to know; otherwise, if the community thinks it's a good idea, then someone (perhaps myself) may contribute a patch for this. 

An alternative I looked into, to force a future page fault on a page, is process_madvise. Unfortunately, MADV_PAGEOUT doesn't work on pages that are mapped multiple times (see https://elixir.bootlin.com/linux/v6.3.8/source/mm/madvise.c#L479). The MADV_DONTNEED option would work for at least part of my use case, but unfortunately it is not supported with process_madvise (see https://patchwork.kernel.org/project/linux-mm/cover/20210926161259.238054-1-namit@vmware.com/).

If there's appetite for extending the kernel with a read-write-protect mode for userfaultfd, or with support for process_madvise(MADV_DONTNEED), then perhaps I can contribute this. Alternatively, if such extensions are unnecessary because the kernel provides another way of achieving this functionality, then I would love to know! 

(If you reply, please cc me at samkumar@cs.ucla.edu.) 

Thanks, 
Sam Kumar

