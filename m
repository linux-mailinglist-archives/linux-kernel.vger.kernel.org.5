Return-Path: <linux-kernel+bounces-61367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89B851176
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510EC1C2354C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B703A3DB92;
	Mon, 12 Feb 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBtSIAV5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072BF3D982;
	Mon, 12 Feb 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734735; cv=none; b=QG+aznbSodIDf2rLeFNxpOYNHYO8BrZFpfHLmCa9sT/C4aMeK5uGWRygGcjLx24g/qcD/F36gMMCHZrrEZZm/+8CZxXgo5xqvZVBjKkzqNeWbLBeSbbV7hMqzplrFidk9rhjLnbd3rK+qoo0IIALdT84fFLBI63DQHGgxnttCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734735; c=relaxed/simple;
	bh=HUQxRkObB8KLWprInhiPsP+17A+Mx8/GE9g+cdXpzvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppwYIL0m/PjI/EO80SROiO315RwzeQvUQWOryC1x5qvFBenrUpxXk+ZsgyudH7dioUVJbpcweWfc/StqV4F9PI4u3oL2dX2iq9mtn3KCcI7k0/3as9jbFCOyUVhxnc2UzY1emsR0HwqbWgFYpcyx1HBRO60NSZbxJx2trD0W7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBtSIAV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0352FC433C7;
	Mon, 12 Feb 2024 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707734734;
	bh=HUQxRkObB8KLWprInhiPsP+17A+Mx8/GE9g+cdXpzvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBtSIAV5aWhVrqbG6Oy91hGLsTz70IXHub4zo5xDQwHvnU3fqS2SE2E52IFqTh1sg
	 gb4dM/X/viM1vZ533KdpZWj7S6wqImX0ErXMOJcnKCCv/4S7KVS+g0G9vdttJkPDTb
	 OPclPgonJvPdYpAfje0VVNXdu58Fl8r3rXDh95gg=
Date: Mon, 12 Feb 2024 11:45:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Make scsi_bus_type const
Message-ID: <2024021246-canon-planner-2bf6@gregkh>
References: <20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net>

On Sun, Feb 11, 2024 at 12:33:50PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the scsi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Remove some extraneous whitespace.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/scsi/scsi_priv.h  | 6 +++---
>  drivers/scsi/scsi_sysfs.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> index 1fbfe1b52c9f..6a02114776b3 100644
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -54,7 +54,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
>  void scsi_log_send(struct scsi_cmnd *cmd);
>  void scsi_log_completion(struct scsi_cmnd *cmd, int disposition);
>  #else
> -static inline void scsi_log_send(struct scsi_cmnd *cmd) 
> +static inline void scsi_log_send(struct scsi_cmnd *cmd)

Why is this line changed?

>  	{ };
>  static inline void scsi_log_completion(struct scsi_cmnd *cmd, int disposition)
>  	{ };
> @@ -156,7 +156,7 @@ extern void scsi_sysfs_device_initialize(struct scsi_device *);
>  extern struct scsi_transport_template blank_transport_template;
>  extern void __scsi_remove_device(struct scsi_device *);
>  
> -extern struct bus_type scsi_bus_type;
> +extern const struct bus_type scsi_bus_type;
>  extern const struct attribute_group *scsi_shost_groups[];
>  
>  /* scsi_netlink.c */
> @@ -197,7 +197,7 @@ struct bsg_device *scsi_bsg_register_queue(struct scsi_device *sdev);
>  
>  extern int scsi_device_max_queue_depth(struct scsi_device *sdev);
>  
> -/* 
> +/*

And this?


>   * internal scsi timeout functions: for use by mid-layer and transport
>   * classes.
>   */
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 24f6eefb6803..7f1fede8ef5d 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -549,7 +549,7 @@ static int scsi_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
>  	return 0;
>  }
>  
> -struct bus_type scsi_bus_type = {
> +const struct bus_type scsi_bus_type = {
>          .name		= "scsi",
>          .match		= scsi_bus_match,
>  	.uevent		= scsi_bus_uevent,
> @@ -656,7 +656,7 @@ static int scsi_sdev_check_buf_bit(const char *buf)
>  			return 1;
>  		else if (buf[0] == '0')
>  			return 0;
> -		else 
> +		else

And this, please be more careful, it looks like your editor stripped out
all trailing whitespace, which is fine for new files, but not for
existing ones.

thanks,

greg k-h

