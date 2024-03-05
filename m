Return-Path: <linux-kernel+bounces-91628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F678871465
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D861F2258D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DA38FA8;
	Tue,  5 Mar 2024 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt+ef/ts"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8E27441
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610194; cv=none; b=MQP2yyFxribbDgQX1Y7FT4JKoL2UVk5c2SJTR1gizfHef3ljqgJ1gPUtxHFsjVc7ftXlwrLXrZP9idlFXNXypD9jonYR9fGQ5OWwuTI+m1BXLJWg8L+kSB2tk3Bpc+ep2msxIBek9/ObKtqexXXEY+mXIVkAL6zgEox/fnZT4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610194; c=relaxed/simple;
	bh=18BRUpYjHC2Mc6y+YFXhrjNT3aC6L+5/gbkyjCzr28o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp15gtFh+4stgU7ISIaGOM3uXYZDstFmELRsq4IlN1apGgq439UDYY4mygwODLedtDJ9W3GfuOwMC36+0ZUrTwf+9lMWiUXK/94ZV5HbGt7LpoVDwltpZtvXnr3PXCeXyjHMv26si13OYmiCc6gppwtJAbExjrWljsZpwxBu210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt+ef/ts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709610191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6kGB4PJsw+RxyQAsP6OXvm23s91Nia/LfKOo5eB2Zo=;
	b=bt+ef/tsMKhue33Y8venwYIxB5rNt+AuiloI0mk4vWX4QoZpv7UZa4x4L3TFBR9SCORJEt
	vBDKbKPo5b5bkE4e3y3EDI2Mz7m6EjJNnizOhR/OYSHMZ/q3jnOawSJ7VXEt6socxzT013
	qtm1ejHHdj9VPLDeLOEdgF8CMPiUXYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-xcNC_sGWPpSEc6FvnXfCqA-1; Mon, 04 Mar 2024 22:43:07 -0500
X-MC-Unique: xcNC_sGWPpSEc6FvnXfCqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A819910354E1;
	Tue,  5 Mar 2024 03:42:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7085040C6EBA;
	Tue,  5 Mar 2024 03:42:46 +0000 (UTC)
Date: Tue, 5 Mar 2024 11:43:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	dyoung@redhat.com
Subject: Re: [RFC PATCH 1/2] Revert "x86/kexec/64: Prevent kexec from 5-level
 paging to a 4-level only kernel"
Message-ID: <ZeaUxXbZ3MB/pXm5@MiWiFi-R3L-srv>
References: <20240301185618.19663-1-bp@alien8.de>
 <20240301185618.19663-2-bp@alien8.de>
 <ZeWnrhzU86pz7y5Z@MiWiFi-R3L-srv>
 <20240304111127.GAZeWsX3gBabiwrrVV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304111127.GAZeWsX3gBabiwrrVV@fat_crate.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 03/04/24 at 12:11pm, Borislav Petkov wrote:
> On Mon, Mar 04, 2024 at 06:51:26PM +0800, Baoquan He wrote:
> > It's not true. Customer may want to try to load a different kernel if
> 
> "may want" is one of those hypothetical things which we don't do. If we
> have to support everything a customer *may* want, then the kernel will
> be a madness.
> 
> Also, you do realize that the kernel doesn't care about "customers",
> right?

Guess you mean upstream kernel doesn't care about 'customers'. Downstream
kernel does care about customers.

> 
> And the question is, how *sensible* is such a use case?
> 
> In my experience, not at all. You simply take the same kernel or a very
> similar one and kexec it.

Hmm, there's different view between upstream and downstream. For distros
kernel, we need a lot of testing to make sure one kernel is trustworthy
as kdump kernel. Here, 'a lot of testing' means a long list of user cases
for kexec/kdump. Please see below file from centos kexec-tools package:

https://git.centos.org/rpms/kexec-tools/blob/bb7919506eba39a2b7277c8d36fe1774f9c33428/f/SOURCES/supported-kdump-targets.txt

And the kdump kernel doesn't have to be the same kernel as the 1st kernel.
I can give several examples:

1) Nvidia GPU or AMD GPU doesn't work well when kexec/kdump jumping to
2nd kernel in some releases. When we meet that case, we want to use the
newer kernel as 1st kernel. we also want to deploy kdump kernel to
capture the vmcore for analyzing once corruption encountered. Then the
old kernel which have been tested and prove to be working well can be
configured as 2nd kernel.

2) in redhat's internal testing, we also run debugging kernel to
test, while the debugging kernel require much more memory to boot up and
run than normal kernel, e.g KASAN memory feature will eat up 1/8 of
system memory. In this case, we run debugging kernel, but use normal
kernel (non-debugging kernel) instead configured as kdump kernel.

And the original purpose of kexec feature Eric developed is to facilitate
kernel developer to jump into a new and different kernel. We never
enforce users have to set kernel for kexec/kdump as the current running
kernel. But we do need explain why if one kernel can't be set as a kdump
kernel when it's different than the current running kernel. E.g kdump
kernel is too old, or like this 5-level case, jumping from 5-level to
4-level will fail.

> 
> > they have taken many testings and trust that kdump kernel, or for
> > debugging.
> 
> Yes, and those kernels will have 5level too. Practically, distros must
> enable 5level support in their kernels in order to support modern hw.
> 
> > The similar for kexec reboot into 2nd kernel. We don't enforce
> > kexec/kdump to work on the same kernel as the 1st kernel. With the
> > fail and message, user can take measure to avoid that. it's better the
> > failure is encountered when failing to jump to kexec/kdump kernel.
> 
> I can't parse that example.
> 
> Btw, kexec tools don't use those XLF_5LEVEL* flags bits either. Which
> basically means we don't really need them.

No, it's not true. Kexec-tools doesn't check, means kexec_load interface
doesn't checking the flag. But it's set in xloadflags, and checked in
kexec_file load. As we know, kexec_file load implements most of codes in
kernel. At that time, people were talking if continuing adding new feature
into kexec_load interface.

In this patch 1, you are removing the flag checking for kexec_file load
interface that RHEL/Fedora default to use.

> > I remmeber we have use case where customer used kdump kernel different
> > than the 1st kernel. While I don't remember why.
> 
> See above.
> 
> And that customer can still use the old distro kernels which have those
> flags.

These two patches includes two parts of work. One is marking the kernel
itself supporting 5-level or not. The other is if I am the running
kernel and capable of 5-level, need check if the being loaded kernel is
capable of 5-level. The 2nd part will be executed when kexec_file load
interface is invoked with 'kexec -s'.

If we take off the checking, and people want to jump from the new kernel
to an old kernel where 5-level kernel code haven't been added or
CONFIG_X86_5LEVEL is unset on purpose, it won't fail and prompt message at
all until 2nd kernel booting silently failed. E.g, the coming RHEL10 anchor
a upstream kernel w/o the flag checking, people want to kexec/kdump jump
from rhel10 to an old rhel7 kernel. It could be an extreme case, while
revealing the scenario.

> The point here is, going forward, 5level becomes ubiquitous and will be
> even more tightly integrated in the kernel so that it'll become just
> another default feature which is either there or not.
> 
> So the distinction is going away and the flags can go too.

I understand this and it makes sense to me, the existing code need be
combined with the realistic usage. I will check with our QE and support
engineers to see how far the targeted kernel taken as kexec-ed/kdump
kdump is allowed to be from the 1st kernel in our support or possible
use case. If no use case is concerned, we can take off the flags and
checking. Will report back soon once I get feedback.

Thanks
Baoquan


