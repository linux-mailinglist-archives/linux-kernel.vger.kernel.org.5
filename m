Return-Path: <linux-kernel+bounces-103153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47B87BBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118291F23565
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA7B6EB4B;
	Thu, 14 Mar 2024 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcDIDZpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58D6CDB6;
	Thu, 14 Mar 2024 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414075; cv=none; b=u6bBLFeNS8nSbZVe7jyiMOP0m2ocw+MxtCixLLqQ9vvbzn0G70TPhTI+hhxWFuXlX1IXcf+JtMq1wArKHMaIYiZR88cymkmOaVa3lv8YAGwJAj2LWhRfPzo6vi7kdIo+v2MDC+GbQBQX+ymMBlkObk9dwz743qHs74YHiSxnfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414075; c=relaxed/simple;
	bh=hui6dIGTuxXacv/8Um90mAFCU+PzNLYrE6gXqUxus0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwjMkshvl9B0mWZeaPNObKu+lTPTwn4TsVZtNcnkTpv5oCu7nBQmI4B0OakFeQi75ntskkt7OuQVdu/821P67LbHEdSqti75rezTmTiLzFe0iJejW68zZ0AX2C/XVnLZTn2e0C0owr/T7KvRVTNpEhkNBFSMQD0Tr8xD255oCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcDIDZpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E6DC433F1;
	Thu, 14 Mar 2024 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710414075;
	bh=hui6dIGTuxXacv/8Um90mAFCU+PzNLYrE6gXqUxus0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcDIDZpVad7ubYqbZTHWR1S10DDL5ecyHlvJrj1zzPCzWrC5XiUfdD2Az8lUq5jL4
	 rYvxkuJgNISO3f1nZq9zOEy1F05nQsxbPeT65EqBshmbLmUcdP5XGFt/Op35OBmT4w
	 003wbkYje1N8vx+kekN/JbgNTcempBF72PWriKrW+QGdrZaUzcPrY3Gx1x5SdiYJjp
	 WnMCLEx6gQbzOX+3en+fz9MjF975GoHBcvd/BuRRzd50tHVTNYlLhTwYkkuE4/FeFb
	 HLJgz9RUDLauhSDMQTmDD/tFmi0Owm+lwtXsaQUvM8rRRoqgJqqF8uSM9zN4mpBloo
	 JP2nxUEHdpv2w==
Date: Thu, 14 Mar 2024 11:01:10 +0000
From: Lee Jones <lee@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
Message-ID: <20240314110110.GL1522089@google.com>
References: <2024030647-CVE-2023-52605-292a@gregkh>
 <e4906091-598e-4d21-9e8d-4cb088855d6f@oracle.com>
 <7591f33e-d64f-49c5-b7c8-deda2b6f0fde@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7591f33e-d64f-49c5-b7c8-deda2b6f0fde@redhat.com>

On Mon, 11 Mar 2024, Prarit Bhargava wrote:

> On 3/10/24 04:10, Vegard Nossum wrote:
> > 
> > (Added author/maintainer to Cc)
> > 
> > On 06/03/2024 07:46, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > ACPI: extlog: fix NULL pointer dereference check
> > > 
> > > The gcc plugin -fanalyzer [1] tries to detect various
> > > patterns of incorrect behaviour.  The tool reports:
> > > 
> > > drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
> > > drivers/acpi/acpi_extlog.c:307:12: warning: check of
> > > ‘extlog_l1_addr’ for NULL after already dereferencing it
> > > [-Wanalyzer-deref-before-check]
> > >      |
> > >      |  306 |         ((struct extlog_l1_head
> > > *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> > >      |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> > >      |      |                                                  |
> > >      |      |                                                  (1)
> > > pointer ‘extlog_l1_addr’ is dereferenced here
> > >      |  307 |         if (extlog_l1_addr)
> > >      |      |            ~
> > >      |      |            |
> > >      |      |            (2) pointer ‘extlog_l1_addr’ is checked for
> > > NULL here but it was already dereferenced at (1)
> > >      |
> > > 
> > > Fix the NULL pointer dereference check in extlog_exit().
> > > 
> > > The Linux kernel CVE team has assigned CVE-2023-52605 to this issue.
> > 
> > This code is in an __exit function:
> > 
> > diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> > index e120a96e1eaee..193147769146e 100644
> > --- a/drivers/acpi/acpi_extlog.c
> > +++ b/drivers/acpi/acpi_extlog.c
> > @@ -303,9 +303,10 @@ err:
> >   static void __exit extlog_exit(void)
> >   {
> >       mce_unregister_decode_chain(&extlog_mce_dec);
> > -    ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> > -    if (extlog_l1_addr)
> > +    if (extlog_l1_addr) {
> > +        ((struct extlog_l1_head *)extlog_l1_addr)->flags &=
> > ~FLAG_OS_OPTIN;
> >           acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> > +    }
> >       if (elog_addr)
> >           acpi_os_unmap_iomem(elog_addr, elog_size);
> >       release_mem_region(elog_base, elog_size);
> > 
> > This can only run when you unload a module, which is a privileged
> > operation (restricted to CAP_SYS_MODULE).
> > 
> > Moreover, extlog_l1_addr is only ever assigned in the corresponding
> > module init function, and it looks like it will never be NULL if the
> > module was loaded successfully, at least on a recent mainline kernel.
> > 
> > Since the module exit won't be called unless module init succeeded, I
> > don't see a way to trigger this bug. Is this a vulnerability?
> > 
> 
> This is certainly not a CVE.
> 
> > It might be better to just delete the NULL check altogether.
> > 
> > As usual, I could be wrong...
> > 
> 
> When I made this code change I thought the same thing: Perhaps it's better
> to remove the NULL check given the status of the code.  I assumed that the
> check was there as a failsafe on unload.

If Rafael agrees with you both, I'd be happy to revoke its CVE status.

-- 
Lee Jones [李琼斯]

