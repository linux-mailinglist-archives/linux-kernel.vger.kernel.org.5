Return-Path: <linux-kernel+bounces-6396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3181985B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD691C2403F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB110A3C;
	Wed, 20 Dec 2023 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gj8j1R2t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141C11715;
	Wed, 20 Dec 2023 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/2MsCHv5ddeNwlRjc7PnveNuAOAj+mz5mECFC1z+WFM=; b=Gj8j1R2t2DyJsLkMc99plnk9B/
	fp1gME+0m7AWJFaHqCUOHufs3ajv8cySB0kReDdUriAOfdgf4iHR0Tz/GlvtfLmqeJZUP5SLzIIcm
	o2Wr9h6cKAcPak5QXvp7mhooiIYM2/aV2PQ7twpi4niweiYl+MNBh8XAezaQ6kzoOL7qviw9Xrkh4
	iSLt1KUepxDyNQYiPCOQtJlIRvsgRdt630U2+muCRi+d/822muBx4MzdNQCxMXuXC6V+NJuKnjffl
	2cifguAyvX2y92AYbx2bu2923aXQ0kqo9PxxMq3so408esd8YXlufnxT15jJWXJ8zcHjZR1H61OND
	WOwgLITQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpd8-00HLnj-1v;
	Wed, 20 Dec 2023 06:00:30 +0000
Date: Wed, 20 Dec 2023 06:00:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baoquan He <bhe@redhat.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for
 opcode
Message-ID: <20231220060030.GV1674809@ZenIV>
References: <202312182200.Ka7MzifQ-lkp@intel.com>
 <ZYJ/M1HZ9ITfs4qe@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYJ/M1HZ9ITfs4qe@MiWiFi-R3L-srv>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 20, 2023 at 01:44:19PM +0800, Baoquan He wrote:

> >    arch/sh/kernel/relocate_kernel.S: Assembler messages:
> > >> arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for opcode
> >    arch/sh/kernel/relocate_kernel.S:41: Error: invalid operands for opcode
> >    arch/sh/kernel/relocate_kernel.S:126: Error: invalid operands for opcode
> >    arch/sh/kernel/relocate_kernel.S:129: Error: invalid operands for opcode
> 
> I reproduced this error, haven't got why and a way to fix it, will come
> back later if I have fix.

At a guess - after that commit ARCH_SUPPORTS_CRASH_DUMP is enough to enable CRASH_DUMP,
which selects KEXEC_CORE regardless of ARCH_SUPPORTS_KEXEC.  And on sh you have
the former selected on any UP build, while the latter - only on MMU ones (i.e.
not SH2).

