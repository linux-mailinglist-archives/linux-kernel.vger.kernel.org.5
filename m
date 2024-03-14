Return-Path: <linux-kernel+bounces-102963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9087B927
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A267D1F22EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D925D73B;
	Thu, 14 Mar 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="CIHsjYEt"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2365D480
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404108; cv=none; b=Mxu7MkigMFgPzwoSZf9QQxFuJ4a3P2mBYodguaf161XN6bTqdH5lbboeUg2qUsHR2TxfKAe3B3fNrlwMAQUBax67wG4gzEcNGeotHXk/LWOLNXBpk+xpmEy18bUmevoH0FxTiFpEFt8zW4KuKKS9YtLHz7DDqDBopCR9gtiw0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404108; c=relaxed/simple;
	bh=6bEs252yH1PuMOBve77E9zTRg4An3cSmWETzdXtI56w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ztlpn4qEotoGVD4PTYB/qwHdyet8TeFUb7U1cPUjUkZM0S0RSQqoyoF34awog4FJL5aUnx7N/ILlfKbx6yGgnhsM9PZe9em9JCgHuYmELqNivQ0dEBfxDML393a914PRtuViXz6X4KFWe6vzOkMoyav14QZDjPb2VeXS4w8Ehcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=CIHsjYEt; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CrQJ6b884butDUGz+jESNM/wO/YQFcIzKA6F8ASSahk=;
  b=CIHsjYEtp2EPAL6CshHmBpXIzafDltrbnjkWg15FzPzU9E2RYN+7b4sn
   WvZzwYcpVA8UFZ4u6lLCL8/bFZkJirA3R1NmgLKWTmplGGTCH83p9xiO2
   ioy2mhOQNBP6YqBebOGCcdfkbB+c++XEaDF1c7qG0bvEYV4PLwDRi2KqV
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,124,1708383600"; 
   d="scan'208";a="156599393"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 09:15:03 +0100
Date: Thu, 14 Mar 2024 09:15:03 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: greybus: Constify static struct kobj_type
 gb_audio_module_type
In-Reply-To: <ZfKxooDH2ef6/1y3@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <666c8cff-f3f2-254d-8d56-13e050fe94d0@inria.fr>
References: <ZfKxooDH2ef6/1y3@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
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
> The kernel builds successfully without errors or new warnings,
> verifying the change.

Actually, casts can hide issues with const, so building successfully is
not a sufficient answer.  Where is this structure used, and how?

julia

>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
> Changes in v3: added the message that verifies the change,
> as suggested by Julia
>
> Changes in v2: incorporated changes in commit message
> as suggested by Alison
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
>

