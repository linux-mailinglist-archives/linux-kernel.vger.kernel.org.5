Return-Path: <linux-kernel+bounces-102715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634887B66A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4D51F232E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BBB4A15;
	Thu, 14 Mar 2024 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwDJ+9JZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E541C06
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383210; cv=none; b=LjkXGKhUxsSipnltA0GDmcc9ViZOYI6VxAZX7iSG/ddUr62huR0poocqxN47cf2ZpFk+N3wUuLBkPqDBECzz4e7dOw87l1DQlw0bu383au2KgaHbOGMeE8wSMQyKo0U4FwP9//Yof1fSImP8b/QuN6v8oKJth9tse/KyzmJzhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383210; c=relaxed/simple;
	bh=isznYQj6c1rnwEUqLiHaDxS2i6jtXknSZw3ne+WB6UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvLt3krmt2xi8IOA0+SXoXsLdPdZThY7CgSXP7N+fcqkV3PJkfjJ5NWj80+R9+3BZqbQLPOiJFHjj3RpIT/zrUOuF/rncNRFGgqtduD/SQsSKUDqIlMR3hMaSUt+qVxAhOPsZG3cobOwoB5O23WndEEz7t72QrU999gb9XVWm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwDJ+9JZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710383208; x=1741919208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=isznYQj6c1rnwEUqLiHaDxS2i6jtXknSZw3ne+WB6UA=;
  b=KwDJ+9JZ7wp4cJDgTEyEHXFvtjKKZR4n8LNteWaAXdGf0mm3l6iWpXJB
   wTTmm/jBMlpwufvSgU+JDjudzVvcWOT/OyuRz+fPDT9hLY5wt7qTTPTCB
   xpXoqrvcp4X3M7+3ec2dr1lbJ/ETRT8LdFJLatqpOjYKK+CTkV5aZ39xI
   SlibLwEsdaEK3vaToPme0vbAiUHBVfB6RU7HNjfnOlKM+krFpPxMu4jJN
   cmd0YFdK3A/RFX3DN6qVjbV3vLCM/n/JoTwcfA5WgKrS6H5+o7RobfLkm
   5wrXyo4za5UQjAK51vdF3c6DGZ1eGyzIkTOWbJ+SEkiKqORpEp5ZQfr8y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="16341235"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16341235"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 19:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12152202"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.131])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 19:25:49 -0700
Date: Wed, 13 Mar 2024 19:25:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: add const type to struct kobj_type
 gb_audio_module_type
Message-ID: <ZfJgK51wzy06WYdn@aschofie-mobl2>
References: <ZfH4YZ9qyK231T5l@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfH4YZ9qyK231T5l@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Thu, Mar 14, 2024 at 12:32:57AM +0530, Ayush Tiwari wrote:
> Add type qualifier const in struct kobj_type gb_audio_module_type to
> address checkpatch warning and conform to the kernel coding style.

Thanks for the patch. A couple of things you could address in a v2:

1) 'Constify' is not a real English word, or maybe it's made its way
into an urban dictionary by now. Anyway, it's a common patch action
and you can read more about and improve the 'why' in your description.

Try: $ git log --pretty=oneline --abbrev-commit | grep Constify
and you'll find many patch examples. I think you'll find a crisper
'why' for your patch description.

Also, here's a former Outreachy Interns blog about the topic:
https://medium.com/@bhumikagoyal/linux-kernel-const-annotation-8db591148e58

2) Now that you know about the work 'Constify' please use it in your
commit message so that it doesn't cause line wrap (80 lines) when doing 
$ git log --pretty=oneline --abbrev-commit audio_manager_module.c

See the First Patch Tutorial Section: Following the Driver commit style

Alison

> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/greybus/audio_manager_module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
> index 5f9dcbdbc191..4a4dfb42f50f 100644
> --- a/drivers/staging/greybus/audio_manager_module.c
> +++ b/drivers/staging/greybus/audio_manager_module.c
> @@ -144,7 +144,7 @@ static struct attribute *gb_audio_module_default_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(gb_audio_module_default);
>  
> -static struct kobj_type gb_audio_module_type = {
> +static const struct kobj_type gb_audio_module_type = {
>  	.sysfs_ops = &gb_audio_module_sysfs_ops,
>  	.release = gb_audio_module_release,
>  	.default_groups = gb_audio_module_default_groups,
> -- 
> 2.40.1
> 
> 

