Return-Path: <linux-kernel+bounces-12322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C154E81F35E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62973B2295A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9D23A7;
	Thu, 28 Dec 2023 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DKGjIDec"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5531C3D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MP16u6EN11eo7xZ2yXWU55KJjCzR/dx7xVgAy3OFLzU=; b=DKGjIDectkRFa7HaOtXNKUroOX
	s7hFzpKTYX3vBXDREusrkX8XEgXJYL0mKuFEdoVe8SfLk2NojBvBBtUWCtDYCALDz6meul2f2nOOT
	jHqCjZ6wNl1aQh812Ku9gp2HHHjT8u1yqVs9rlGTJRUJVfovZYiTMbtlNj6+S4mn7oy8fbXNDnuiu
	aNIb56x7mZ/0MBkencnLWcoU+LUdruPSmYn9Gy1l57SWCZvybP6ID4xIxdomKSimkYV7wO3Xy1dl+
	aJiIlO/lYAW9SDHd/iV6uXwsAYifQFmyDNcQIHiDBZb3ty4xJIMTTMDpfTLeEXTU2KwhkWAfxVOHA
	xC18zzAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rIeE2-00BnnV-2g;
	Thu, 28 Dec 2023 00:26:14 +0000
Date: Thu, 28 Dec 2023 00:26:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tanzir Hasan <tanzirh@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
Message-ID: <20231228002614.GI1674809@ZenIV>
References: <20231227-syscall32-v1-1-9621140d33bd@google.com>
 <20231227233444.GH1674809@ZenIV>
 <8B198413-0C9B-40A2-8478-F22206AAE6FA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B198413-0C9B-40A2-8478-F22206AAE6FA@zytor.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 27, 2023 at 03:50:33PM -0800, H. Peter Anvin wrote:
> > /*
> >  * Only the low 32 bits of orig_ax are meaningful, so we return int.
> >  * This importantly ignores the high bits on 64-bit, so comparisons
> 
> __visible is for LTO, no?

If we need it in cases when array defined in entry/syscall_32.c and
used in entry/common.c, I would respectfully suggest that whatever
we need it for is misguided garbage.  I don't think that LTO does
need it, though.  How is arch/x86/entry/{syscall_32,common}.c
different from e.g. fs/{namespace,d_path}.c, where we have
fs/namespace.c:100:__cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
and
fs/d_path.c:166:        read_seqbegin_or_lock(&mount_lock, &m_seq);
respectively?

