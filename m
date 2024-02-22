Return-Path: <linux-kernel+bounces-77403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B928604D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485651F28803
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876E73F26;
	Thu, 22 Feb 2024 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hh5Zm4Yv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376D673F29;
	Thu, 22 Feb 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637378; cv=none; b=koT+/WChDGstGblUUNImmVwXYwBYw8NqLLPDrv7kEOSEj2cCbJiKS2Pb1fFa1AHLQgUwMi8OlWIufkh2yiICsgGY9n0Xyr/4Ua+VQz8rLKnRt3pr3RkN7hxK7zFgbIQuOoLt4dBy/cMDjpT7zVwoq6LmP/Bu+5HScD8PmubTp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637378; c=relaxed/simple;
	bh=t85/vLINNj4QjqTdLkHVSWfMx17aHlL+u2dxKq3yYy8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o6rxLrkZCH/egxIbYV77YfeP6vZPrpd7g0Ql+k4Z34NNyKop35BOtdgu1aW7vllwvPd3FWMAOUWyj5zNV3zxdx1Is+SpDePqeoZiymfyHSN/Ctmw2dIO85TtQeAgAMjGCATCz5nFbU1Dq9X/ftoPSVnEQqe68xrq/lE8OJTiNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hh5Zm4Yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18839C433C7;
	Thu, 22 Feb 2024 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708637377;
	bh=t85/vLINNj4QjqTdLkHVSWfMx17aHlL+u2dxKq3yYy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hh5Zm4YvDfOKF5br8tkmh9sJvT791U5KssSAIS8LfOqGSzl3slitWdXs3E1Em8lxo
	 eW/hjzCE3XTpXQTswpeuaep38I7mm0zb4+bnWgNGgZIUZ8CEoNf8Y2On7Vgpn2ddNO
	 Q3Fn70VpnIcWdCXFtJ96SSNkluqeWjcO+vqu/Qw4=
Date: Thu, 22 Feb 2024 13:29:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>,
 piliu@redhat.com, linux-sh@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, ebiederm@xmission.com,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up
 related config items
Message-Id: <20240222132936.e7dc50acbf5d1b653cb2e02c@linux-foundation.org>
In-Reply-To: <3393a42f-d9b3-4031-bdef-78bb2ce758f1@linux.ibm.com>
References: <20240119145241.769622-1-bhe@redhat.com>
	<9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
	<Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
	<559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
	<20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
	<3393a42f-d9b3-4031-bdef-78bb2ce758f1@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 10:47:29 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:

> 
> 
> On 22/02/24 2:27 am, Andrew Morton wrote:
> > On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
> > 
> >> On 04/02/24 8:56 am, Baoquan He wrote:
> >>>>> Hope Hari and Pingfan can help have a look, see if
> >>>>> it's doable. Now, I make it either have both kexec and crash enabled, or
> >>>>> disable both of them altogether.
> >>>>
> >>>> Sure. I will take a closer look...
> >>> Thanks a lot. Please feel free to post patches to make that, or I can do
> >>> it with your support or suggestion.
> >>
> >> Tested your changes and on top of these changes, came up with the below
> >> changes to get it working for powerpc:
> >>
> >>   
> >> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
> > 
> > So can we take it that you're OK with Baoquan's series as-is?
> 
> Hi Andrew,
> 
> If you mean
> 
> v3 (https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/)
> +
> follow-up from Baoquan 
> (https://lore.kernel.org/all/Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv/)
> 
> Yes.
> 

Can I add your Acked-by: and/or Tested-by: to the patches in this series?

