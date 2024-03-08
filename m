Return-Path: <linux-kernel+bounces-96719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210287608F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12CE280E42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0985339A;
	Fri,  8 Mar 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2JyF2v1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E822626
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888487; cv=none; b=GvTjIR+n5C3rPsV88HgwAoE/InjLbjRiJThrgs9lf1//IBrJ5fro5NIlb14p/wbfp/dywaQa0mDLmCdURnLylnel8jah5+O9hD20AVPrCjdcnmGPHJGpYV5jFE1qM09zaM4KM85x+qdehlTfcb/v1F5iJ4t5eEyLfPQN4Oic7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888487; c=relaxed/simple;
	bh=/5ZjGBbYQVs4I+O/KoTJ+PVJQE4K/gaDCvf4loCIOGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0v5/W/qCG3n8iNuciWICIOSLfjv+Uh8OxsyMDuWnXhGIR0tUVaP9BHqBKXKqTF2udN7UIKOFHI/Kxp9PNrwWS+9fSDgPcDdJr3sWQhcE1j0HTQZtTRnUIKSArbjwAdGl1X9PAL5zCFPyneV+C8sIzAaa09g6oawpnXV1JoAhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2JyF2v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525DCC433C7;
	Fri,  8 Mar 2024 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709888486;
	bh=/5ZjGBbYQVs4I+O/KoTJ+PVJQE4K/gaDCvf4loCIOGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2JyF2v1IMkmwBvvv15cch7DK49/EqwkS6LPMWUb4gWr+tJXGC6bEw+HSDVqdKQcp
	 sBhDRag/vaymwj2+H5EycoQr0zSmB1N3Mp5LbM5J16cmkp7ZCc/9uAtjK+GEuLjtPY
	 +4jc0x2YoyyLTeXsUuIIVOpeYzE8WWSGPw8DJpmI=
Date: Fri, 8 Mar 2024 09:01:24 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: make sysfs_emit() return ssize_t
Message-ID: <2024030803-bulk-grader-3ad1@gregkh>
References: <33cd8f96-4b4f-4741-ac05-ef1bd267ce6b@p183>
 <2024030713-favorably-liking-2135@gregkh>
 <f57ab790-d0a5-4454-977b-9bdc146e6e93@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57ab790-d0a5-4454-977b-9bdc146e6e93@p183>

On Fri, Mar 08, 2024 at 09:26:01AM +0300, Alexey Dobriyan wrote:
> On Thu, Mar 07, 2024 at 10:04:41PM +0000, Greg Kroah-Hartman wrote:
> > On Mon, Feb 05, 2024 at 01:11:36PM +0300, Alexey Dobriyan wrote:
> > > sysfs_emit() is most often found in functions returning ssize_t
> > > not int:
> > > 
> > > 	static ssize_t oops_count_show(...)
> > > 	{
> > > 		return sysfs_emit(page, ...);
> > > 	}
> > > 
> > > This pattern results in sign-extension instruction between
> > > sysfs_emit() return value (int) and caller return value (which is
> > > ssize_t).
> > 
> > Is that a problem?
> 
> Small problem, but, yes.
> 
> If sysfs_emit() returns "int", then every user compiles to
> 
> 	call	sysfs_emit
> 	movsx	rax, eax
> 	ret
> 
> Given than sysfs_emit() is the official way to print in sysfs,
> there are lots of users and there will be more users in the future
> as it grows.
> 
> This trailing "movsx" instruction is duplicated every time.
> 
> If sysfs_emit() returns ssize_t then it is folded into sysfs_emit() and
> appears in the code _once_ saving bytes.
> 
> Ultimately, all this confusion and mismatches come from snprintf()
> accepting "size_t" but returning "int" (despite working on very large
> strings!) which sysfs_emit() copied.

True, then why not fix up the base function here, vscnprintf() and
vsnprintf() and then propagate the fixes outward?

thanks,

greg k-h

