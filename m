Return-Path: <linux-kernel+bounces-105273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2AA87DB41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439071F21870
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5691BC4E;
	Sat, 16 Mar 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PO2qqzlz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA741B962
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710614727; cv=none; b=ECZUC6B01ONVd/8UgQknwoOxtoYTBFslIXnlWUyNfMzT+LC3+xoOhehXP13mN99mwOIfb+K+WF7TRYIpy6tmRxGlS3IH1IqVSRfQ2K+w9qJsijLoi/etzr/kQXb70GpxNB5tQicafPUbTmcbfMTShjNjgdhQzx4eE578Q2lAS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710614727; c=relaxed/simple;
	bh=yKt1j5Qoe8fvsNK5gDIjZKaUMtwpWrjtQqKtpQLSZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnU2NqGn62oWrQthCyKAgGP5Hm0MRgAyFyfhRMF+W/uCC5xX4qGU81tfqaW6FSYk8GzDYk+WPlD0FIvQozHgzzygcVSImk+QAeU6M4R3+be6rPLiWtUYKfGQP4yQJJmvH+DL0CIVlmvHFvDDL20oRelUTC++cW5kw+oaT24WUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PO2qqzlz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710614726; x=1742150726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKt1j5Qoe8fvsNK5gDIjZKaUMtwpWrjtQqKtpQLSZqY=;
  b=PO2qqzlznKqTTop5Xr6XhJOMmNdGVGmn5vzh+qcHLbqyza7CEjTq/NP6
   y1xu6o2+1GmHqTHBmAuKLUyEhA+XZMj0ge7xvsyxUpyMQro8QrVV8OR0M
   7PO1HRRj6WWzts5gzpHNoPxc2QY1/tZqZLCgnO4oqUlghwnWzYPSHE/2P
   vWsq6fiKWIywUp13q2HGXhBrmSDJZN/wMTCv7bdshdFMsUvloWuEjlmgZ
   2gHnbXbMEiRYiUjz8haWXSCtsYZYWT+Lr358dDEJcoJAwwG3nPS0Po9Tv
   vZxL6V9Thvd8AhCfyPle/lDd+SMNvUo5RfWunx8tBZU9sh5msg76HfWGi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11015"; a="5327707"
X-IronPort-AV: E=Sophos;i="6.07,131,1708416000"; 
   d="scan'208";a="5327707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 11:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,131,1708416000"; 
   d="scan'208";a="17626735"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.6.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 11:45:22 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v5] staging: greybus: Constify gb_audio_module_type
Date: Sat, 16 Mar 2024 19:45:18 +0100
Message-ID: <10634620.nUPlyArG6x@fdefranc-mobl3>
Organization: intel
In-Reply-To: <ZfXj1WkJ3nrYh3qL@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZfXj1WkJ3nrYh3qL@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, 16 March 2024 19:24:21 CET Ayush Tiwari wrote:
> Constify static struct kobj_type gb_audio_module_type to prevent
> modification 

I'm not yet convinced that being or not being const has much to do with 
sharing data. 

And next time please wait for other people to comment your versions. Wait a 
day or two and then please delete everything from here...

> of data shared across many instances(instances here
> refer to multiple kobject instances being created, since this same
> gb_audio_module_type structure is used as a template for all audio
> manager module kobjs, it is effectively 'shared' across all these
> instances), 

to here.

Thanks,

Fabio
 
> ensuring that the structure's usage is consistent and
> predictable throughout the driver and allowing the compiler to place
> it in read-only memory. The gb_audio_module_type structure is used
> when initializing and adding kobj instances to the kernel's object
> hierarchy. After adding const, any attempt to alter
> gb_audio_module_type in the code would raise a compile-time error.
> This enforcement ensures that the sysfs interface and operations for
> audio modules remain stable.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> 
> ---
> Changes in v5: added more details as per feedback.
> 
> Changes in v4: added more details verifying the change.
> 
> Changes in v3: added the message that verifies the change,
> as suggested by Julia
> 
> Changes in v2: incorporated changes in commit message
> as suggested by Alison
> ---
>  drivers/staging/greybus/audio_manager_module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_module.c
> b/drivers/staging/greybus/audio_manager_module.c index
> 5f9dcbdbc191..4a4dfb42f50f 100644
> --- a/drivers/staging/greybus/audio_manager_module.c
> +++ b/drivers/staging/greybus/audio_manager_module.c
> @@ -144,7 +144,7 @@ static struct attribute
> *gb_audio_module_default_attrs[] = { };
>  ATTRIBUTE_GROUPS(gb_audio_module_default);
> 
> -static struct kobj_type gb_audio_module_type = {
> +static const struct kobj_type gb_audio_module_type = {
>  	.sysfs_ops = &gb_audio_module_sysfs_ops,
>  	.release = gb_audio_module_release,
>  	.default_groups = gb_audio_module_default_groups,





