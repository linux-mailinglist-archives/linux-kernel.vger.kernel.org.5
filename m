Return-Path: <linux-kernel+bounces-102935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681E87B8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A811C21881
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0265C8EE;
	Thu, 14 Mar 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="jZiU/ttU"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378D1A38C8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710401967; cv=none; b=OxAVUPscKObUkXU3y9BgP7DV9AA3SpX3r7LlNszk6Ugvtzp/EFNyUI3lqGi1mmeD1rLn8OHpF60YCVg7c8iIh5AU6fdO1nvVoNB47QtZK/W6URIXJbr3I1NUPiT15kvHQfl4aToOI7eYLT/X97Int/Q72xQOpX1mRpN4hcaMhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710401967; c=relaxed/simple;
	bh=pnTHHt1TW382u+9+5iKCSJeq862HE4dvylrDAww2zLw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AOPCg1n8wbZ/atELmhR7p5X7Cb6M3/DD9GHoIlkBjPBc/zKgtH+UohYaXA7rTC39AK/fD4q3WCaYq39UeIrgvTeGUirhYOn4QugOLNQp68FyFSAKx28qXj6rWvQkFHmg+3hr0qfuY4obxH6OP7DsiUt8Q5d+X3sklou5K4UoUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=jZiU/ttU; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nnha1qea9vft3Z6+irMALn1pdyDOivvnlArNLW4U/VI=;
  b=jZiU/ttU1LGt8+0f3sWchKmhgdti1zFVFU2JDgTP4rk2oODyWKp/qfvh
   RejB4iqcdvW28UnBnVICna8A5c5v3xOwLOfsShcBDvOFUY6/V0jFJZGSo
   MjX2ulv8RXjPw1U2lITj7HaAbnYN3gYZLJGYECdqRmhP9tgDWPHnfLNT2
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,124,1708383600"; 
   d="scan'208";a="156590462"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 08:39:16 +0100
Date: Thu, 14 Mar 2024 08:39:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: Constify static struct kobj_type
 gb_audio_module_type
In-Reply-To: <ZfKevNRRNteRXZHT@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <58ef977c-9a85-c0b9-a7bb-b31f92597581@inria.fr>
References: <ZfKevNRRNteRXZHT@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 14 Mar 2024, Ayush Tiwari wrote:

> Constify static struct kobj_type gb_audio_module_type to prevent
> modification of data shared across many instances, ensuring that the
> structure's usage is consistent and predictable throughout the driver
> and allows the compiler to place it in read-only memory.

It would be helpful for the log message to include some hints about what
you have done to verify that the change is correct.

julia

>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>
> Changes in v2: incorporated changes in commit message as suggested by
> Alison
>
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
>

