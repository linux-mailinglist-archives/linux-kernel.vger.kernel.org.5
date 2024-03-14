Return-Path: <linux-kernel+bounces-103299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991387BDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0751C226E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8C6FE13;
	Thu, 14 Mar 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYWkSywB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9D5BACF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422879; cv=none; b=kMLWgakALUiByRFcI26LIPgh5ltsSsVfpqQRhlkrtjjdhznZEHq+rWVeP4hByhhKxVzTsMoIhwTmzyXbcCPdFnKnjaIEIHYr8JvvBEnMd7Y0hStteO8JC28FqD3EAbh7GmzAmi0KKKUrshscab/amjvnkbMKB6fsFw0OLP5yWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422879; c=relaxed/simple;
	bh=AlzosFQIeUwDpF182A/3HVs1sGOOB9xuxDNbavIhXjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGCwE6CJbbpNW3PjJCGyoa5U/0DDhEjU6WwzMSHuHIMECn9L8OjtU55reL+be4PsE1nJRWMOgNEsYo0u4FWNmMUZuV7E81MrjEbG5msDVWEyKdwkBQQTw/rDFe4yCN8licW6L1+zr2v0+csu6AvbCI15XYQDOiFYbAHxoqcEMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYWkSywB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710422876; x=1741958876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AlzosFQIeUwDpF182A/3HVs1sGOOB9xuxDNbavIhXjg=;
  b=OYWkSywBfphZ8BGoIDXC/ITihP+aUvJvIQ7HDjyr2pxqMHctAGgwCPZ0
   CDvAyOnlCrrdfPc6GF4pjt2WUW48oI2WD29KlCL4/b0f6MFN7fbWXW6SZ
   /KIHsEOX6QV1nTu+dQHlGQpgHXTwuGVZ+5PxyjQCp8ydTHiQ28mxacoPj
   J3UA9eBxt9IfxOtEaDaRsL950CREu4bg0HkJ9KXIv4MpYTyWOuSeKgyRK
   3jjnFUQG1ISMmrUv1ZXadrLnCs7PzEzrkZ4Xf92Y26df0RJrioSiR/rH3
   X2oQxTixbJKyq2ubLZAx+y2Q93VSjPnkaWTJvE13othSUNLspgcNZ4iH9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="9062625"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="9062625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="43212728"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.6.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:27:54 -0700
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject:
 Re: [PATCH v3] staging: greybus: Constify static struct kobj_type
 gb_audio_module_type
Date: Thu, 14 Mar 2024 14:27:50 +0100
Message-ID: <2457147.jE0xQCEvom@fdefranc-mobl3>
Organization: intel
In-Reply-To: <ZfKxooDH2ef6/1y3@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
References: <ZfKxooDH2ef6/1y3@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 14 March 2024 09:13:22 CET Ayush Tiwari wrote:
> Constify static struct kobj_type gb_audio_module_type to prevent
> modification of data shared across many instances, ensuring that the
> structure's usage is consistent and predictable throughout the driver
> and allows the compiler to place it in read-only memory.
> The kernel builds successfully without errors or new warnings,
> verifying the change.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---

I think that the "Subject" line should be made shorter by deleting all the 
unnecessary information. I'm not asking you to make a new version just to 
address my comment, but please keep the following in mind for your next 
patches.

The "Subject" line is provided (1) to briefly explain what this patch is 
doing and (2) to uniquely identify the patch (e.g., in git-log output).

I'd write something like the following:

"staging: greybus: Constify gb_audio_module_type"

Who reads the subject doesn't need, and probably doesn't want, to know that 
the variable you are making "const" has a "static" modifier or that its type 
is "struct kobj_type". These information add nothing relevant to what the 
patch is doing.

Examples of shorter, yet sufficient, "Subject" lines:

7ab4de60028e virtio-mem: Constify mem_id_table
01e1932a1748 iommu/vt-d: Constify intel_dma_ops

Thanks,

Fabio

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
*gb_audio_module_default_attrs[]
> = { };
>  ATTRIBUTE_GROUPS(gb_audio_module_default);
> 
> -static struct kobj_type gb_audio_module_type = {
> +static const struct kobj_type gb_audio_module_type = {
>  	.sysfs_ops = &gb_audio_module_sysfs_ops,
>  	.release = gb_audio_module_release,
>  	.default_groups = gb_audio_module_default_groups,





