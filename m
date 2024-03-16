Return-Path: <linux-kernel+bounces-105254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E516187DB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B07C1F216DD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53061BF40;
	Sat, 16 Mar 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Undr6SRB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFF1BDCE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710610913; cv=none; b=OAZDU2hH/4CcvdUj3oWPdVp5Hd7c2ckqdo+k2LDNXHASAjaXE16eVAZiGSJdKG3fjoYIe33TpTcUXdS1zVslYmwzdU3Zacafh89q9HeFmgJrp3nDRPF22qMn0fS0eWzx13EcT4PfdacickGkW+0TyrQ7vIQqFoLlmjt1zoljm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710610913; c=relaxed/simple;
	bh=H40LPQ71XkDKM4D7T+X0RPvODmJ2Va0h9QUyQ7d50RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cj7GKfl7b5YUMBJ2nelgS5x4SXjQeud9KoQvx6+gZSpzC8GSKK3iTF8j9GDSrC+WVKhrjQ2X7lgriLRbPrSGnGhBghZbU/awWsHGh6i88UZdlttDAcpsJmMNl7YmvXQnExrzLgDN4b3D+0arVkQZz6HrQ1Y6VSLKjDUJ5vUE3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Undr6SRB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710610912; x=1742146912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H40LPQ71XkDKM4D7T+X0RPvODmJ2Va0h9QUyQ7d50RE=;
  b=Undr6SRBGwe0G0X/fnIxr51MoWG17dCc8BPHqSg5BdlmuL9bnQhOCiIL
   53+GI8R4CCWOMkX3mNtwj27nF+RXjHxE4QgFZRsDpgSfx6AtC41u49qXl
   oks6GTvVAWJaJO1/rjT0Vfk0z0SoMda/wyECSOLQmTIKeeUvp8wP5m2C7
   Q8q9qboxD+YOUPj/D3Y265+uZ2MdH+BnAXXsZNBxFyjUeK0KeDIshkWct
   KLzS6gE39GEr9oUDTFZfNqgSWNR2nufnbOiJmG1I8Sr56ytjbrICh9Ltf
   iHDOT8pEWfAPAMc5IKN//pdkhrOM5GS9N0OzqgzY04Jg7KuBxp7kSAmt4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11015"; a="5344205"
X-IronPort-AV: E=Sophos;i="6.07,131,1708416000"; 
   d="scan'208";a="5344205"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 10:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,131,1708416000"; 
   d="scan'208";a="13477257"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.6.225])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 10:41:48 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v4] staging: greybus: Constify gb_audio_module_type
Date: Sat, 16 Mar 2024 18:41:44 +0100
Message-ID: <6152476.lOV4Wx5bFT@fdefranc-mobl3>
Organization: intel
In-Reply-To: <ZfNGYSC8CDHqVPlm@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZfNGYSC8CDHqVPlm@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 14 March 2024 19:48:01 CET Ayush Tiwari wrote:
> Constify static struct kobj_type gb_audio_module_type to prevent
> modification of data shared across many instances, 

I overlooked these in v3... 

What do you exactly mean, in this context, by "data shared across many 
instances"? Can you please clarify that?

I suspect that by "shared data" we usually mean something different.

> ensuring that the
> structure's usage is consistent and predictable throughout the driver
> and allows 

ensuring, allowing (s/allows/allowing/).

> the compiler to place it in read-only memory.
> The gb_audio_module_type structure is used when initializing and
> adding kobj instances to the kernel's object hierarchy.
> After adding const, any attempt to alter gb_audio_module_type
> in the code is raising 

would raise?

Fabio

> a compile-time error. This enforcement
> ensures that the sysfs interface and operations for audio
> modules remain stable.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> 
> ---
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





