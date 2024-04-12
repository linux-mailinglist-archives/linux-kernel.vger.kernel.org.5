Return-Path: <linux-kernel+bounces-141974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1588A25AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3FEB21DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9001A28C;
	Fri, 12 Apr 2024 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nt8PC0dC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A8D531;
	Fri, 12 Apr 2024 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899331; cv=none; b=tzq0XlpCWeOO3dGuDcgWoBrEZO8a8QrG2k1QhNuQZgZVPqk+9vcmbE2hR3ug0MeMiEVtv4YBtyBe1CrcituYnuW4JIO+k4KziNTMhu4wc0yd1TU4Sc9Hi9/8dI+KX/lka40VMU6MggK8YqLSCiR47Mz37JVBCUoeknmWuvYXfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899331; c=relaxed/simple;
	bh=a5uBuZZAQBvcD3nu0kxCuF0HhAHsxu1HdhHDndDLL3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtuyBsrdIJnvalh/iZseJ8Ujy/M7s6k2hbXpir0dfUUSuZF17tXeAHyosQuUNYhzJEN3xXm/numk38h/uFJBdpQ4QfC9pw92TIiN0xU1NLIpBxEUs39xPPyO5ncOmDYVwreUcqv4ZLqun7LjWDqFed7MsV35Na62TBMGvR5CrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nt8PC0dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7CEC2BBFC;
	Fri, 12 Apr 2024 05:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712899331;
	bh=a5uBuZZAQBvcD3nu0kxCuF0HhAHsxu1HdhHDndDLL3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt8PC0dCTBV+JCBeHkrqK4Q3GcKue26HfGwqBA/jVTAwGyhfP5BhPkUabMrXXk/Oe
	 f3cpIbXQKMu3i2ViVuQd1/zHRJYKgpR2dsNv143zsmrDj6K7tUy7gaO4CFph+OTQXD
	 r7cXAZXozVWPf30/7CunBIhbn86xcxImpR/E+me4=
Date: Fri, 12 Apr 2024 07:22:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: jirislaby@kernel.org, Julia.Lawall@inria.fr, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
Message-ID: <2024041222-credit-finally-9580@gregkh>
References: <20240411180256.61001-1-romeusmeister@gmail.com>
 <2024041146-exciting-predefine-05bb@gregkh>
 <CALsPMBM9DG3-St9Ne6qZMXiNzSBxSXL=pzJn8Eu9be5hfik2bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALsPMBM9DG3-St9Ne6qZMXiNzSBxSXL=pzJn8Eu9be5hfik2bQ@mail.gmail.com>

On Thu, Apr 11, 2024 at 08:25:10PM +0200, Roman Storozhenko wrote:
> Hi Greg,
> 
> This is the output of the checkpatch:
> hedin@laptop:~/prj/linux-next$ ./scripts/checkpatch.pl --strict
> ~/lkmp/course_tasks/coccinele/patches/sysrq/v1/*
> --------------------------------------------------------------------------------
> /home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0000-cover-letter.patch
> --------------------------------------------------------------------------------
> total: 0 errors, 0 warnings, 0 checks, 0 lines checked
> 
> /home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0000-cover-letter.patch
> has no obvious style problems and is ready for submission.
> ------------------------------------------------------------------------------------------------------------------------
> /home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0001-sysrq-Auto-release-device-node-using-__free-attribut.patch
> ------------------------------------------------------------------------------------------------------------------------
> total: 0 errors, 0 warnings, 0 checks, 16 lines checked
> 
> /home/hedin/lkmp/course_tasks/coccinele/patches/sysrq/v1/0001-sysrq-Auto-release-device-node-using-__free-attribut.patch
> has no obvious style problems and is ready for submission.
> 
> Before sending this patch to the mailing list I sent it to me,
> downloaded from the email, and then applied atop of the tree using git
> am. Encountered no issues.
> 
> I can guess that you checked the whole file and got some issues. But
> those are not related to my changes.
> 
> Thanks,
> Roman
> 
> On Thu, Apr 11, 2024 at 8:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> > > Add a cleanup function attribute '__free(device_node)' to the device node
> > > pointer initialization statement and remove the pairing cleanup function
> > > call of 'of_node_put' at the end of the function.
> > > The '_free()' attrubute is introduced by scope-based resource management
> > > in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> > > '__free()' attribute makes a compiler insert a cleanup function call
> > > to the places where the pointer goes out of the scope. This feature
> > > allows to get rid of manual cleanup function calls.
> > >
> > > Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> > > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > > ---
> > > This patch targets the next tree:
> > > tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > tag: next-20240411
> > > ---
> > >  drivers/tty/sysrq.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > index 02217e3c916b..1d1261f618c0 100644
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
> > >  static void sysrq_of_get_keyreset_config(void)
> > >  {
> > >       u32 key;
> > > -     struct device_node *np;
> > >       struct property *prop;
> > >       const __be32 *p;
> > >
> > > -     np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > > +     struct device_node *np __free(device_node) =
> > > +             of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > > +
> >
> > Did you run this through checkpatch.pl?  Please do so.

The issue is the blank line in the variable list now.  Odd that
checkpatch doesn't catch it, which implies the complexity added here
might just not be a good idea :(

thanks,

greg k-h

