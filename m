Return-Path: <linux-kernel+bounces-12329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878781F376
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BF7B22847
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C043280A;
	Thu, 28 Dec 2023 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MpNhr8GQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46F637
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fQ45L/V9FHUmoJgpgPF98iGYhFCLPLvTto8GWmM6kgY=; b=MpNhr8GQw7sFsj3LXjALSsEhsP
	tFowr5vjwJuvWAsloCXub7tNOBC/66Bcq1Upj2qqRVZvybltkwb7noDGj4sWKYm8WGkSnZwTxlbHD
	joEy8DYuCh9lfNdYKnADC9WPeT/BElo+6rs40UCjGN23Yx68skr/1OuxVr2JLrGcn4pl2423JTOMC
	wSqeasnFAkgaHyvbUgwBsQmC/aZYmXUkzvw3IQZnkUstVXA0kvP+LE0UvwXMaA8p08I+Hrk2eAfPp
	i+lwXDLvz7/fel+xucYAo6vBM2K81Ycwop2XDI5Ry81oOTZgR7cOSArY/2b1s7kLQ3UX5GQtHcEEf
	bs2b2LDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rIeX0-00BoUc-0q;
	Thu, 28 Dec 2023 00:45:50 +0000
Date: Thu, 28 Dec 2023 00:45:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
Message-ID: <20231228004550.GJ1674809@ZenIV>
References: <20231227-syscall32-v1-1-9621140d33bd@google.com>
 <20231227233444.GH1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227233444.GH1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 27, 2023 at 11:34:44PM +0000, Al Viro wrote:

> That's _it_.  The same goes for syscall_64.c and syscall_x32.c.
> Oh, and lose the __visible/asmlinkage junk in there - none of that
> stuff is used from asm these days.  See the patch below -
> Untested But Should Work(tm):

Unfortunately, there's this in kernel/trace/trace_syscalls.c:

unsigned long __init __weak arch_syscall_addr(int nr)
{
        return (unsigned long)sys_call_table[nr];
}

How is that supposed to work for anything biarch?  Including
amd64 with CONFIG_COMPAT enabled?

Confused...

