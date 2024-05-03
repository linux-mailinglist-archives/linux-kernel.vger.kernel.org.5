Return-Path: <linux-kernel+bounces-167262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D78BA6A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA49B1F22A33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB24139CE0;
	Fri,  3 May 2024 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GI69xPgE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8F1C69D;
	Fri,  3 May 2024 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714468; cv=none; b=GQkuGrlqU7wJO4oM1Ckei+kUBBOqxLVFqL9+O0K453UK5v9n/OYwm9tTTmcqM3C0mTwBFl8Ctq9LLcmgGV0MvJ66cKQ8UvfVQsFX5oO6ROsx4UQ418cNbcmgVHP9SmEgD+0N/cc7l6wweiQ1ylBxaMmrAyCwWCqArYwhHQXa/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714468; c=relaxed/simple;
	bh=GcoFEG78oRmOEqdye4jXox30wukosSt6f14MGQzy2xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcTIv/BOh61mgfU6TDbIzaMgPk8EYNczPmyYfl32BMD0gHlkCvGUXj/JiApGq6bc+Ju/64F+Kh3eZY7ccpoXHDX/DxG4VUdSSocsGEpfNAeXp39cWn7McNVvQJw7k8zyNzS11SWTT0xSdHSBHsAcKbgrFPdyabBzM/ykk6uzjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GI69xPgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5784C116B1;
	Fri,  3 May 2024 05:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714714468;
	bh=GcoFEG78oRmOEqdye4jXox30wukosSt6f14MGQzy2xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GI69xPgEwXqz7gWnO5NqqPE6fMGxHiJrzquB8ZwNQyl60XRExkoofvEye9bnip7Pd
	 HOJRVto5dqfBtSugWlGA0/4iZjt9lFn2W3TlkSNvHhd3NiVw9K1iJIuouOqooRKR4m
	 hyBXzZhV2pbfiiTDYmIuXi8SbX1bGamqtp8KmeLA=
Date: Fri, 3 May 2024 07:34:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	davem@davemloft.net, jirislaby@kernel.org,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
Message-ID: <2024050357-shading-fedora-2d4f@gregkh>
References: <20240501084110.4165-2-shresthprasad7@gmail.com>
 <f1707254-ec32-4884-275a-c3c85b48d7d5@linux.intel.com>
 <CAE8VWiJy-2x6sKCAmN69Uq9Kf1cTRnaJezOoLDyZ0SbgPWuHAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8VWiJy-2x6sKCAmN69Uq9Kf1cTRnaJezOoLDyZ0SbgPWuHAQ@mail.gmail.com>

On Thu, May 02, 2024 at 10:21:16PM +0530, Shresth Prasad wrote:
> On Thu, May 2, 2024 at 9:35 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Wed, 1 May 2024, Shresth Prasad wrote:
> >
> > > Add `__free` function attribute to `ap` and `match` pointer
> > > initialisations which ensure that the pointers are freed as soon as they
> > > go out of scope, thus removing the need to manually free them using
> > > `of_node_put`.
> > >
> > > This also removes the need for the `goto` statement and the `rc`
> > > variable.
> > >
> > > Tested using a qemu x86_64 virtual machine.
> >
> > Eh, how can you test this with an x86_64 VM ???
> >
> > config SERIAL_SUNSU
> >         tristate "Sun SU serial support"
> >         depends on SPARC && PCI
> >
> 
> By that, I mean that I compiled the kernel and ran the produced bzImage
> on a x86_64 qemu machine.

But you didn't include the driver you were testing :(

> I unfortunately don't have the hardware to test it on, but I don't
> think the change is complex enough to require testing on real hardware
> (unless I'm assuming incorrectly).

That's why I asked if you had tested this or not...


