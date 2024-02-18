Return-Path: <linux-kernel+bounces-70254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02E859548
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611091F217ED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3DADF57;
	Sun, 18 Feb 2024 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrJH4PXP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686C2CA8;
	Sun, 18 Feb 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708242427; cv=none; b=oYplBnMAzMieAUscnSTcHnoMEHYCcVHExT06/yoSNiLjm0SSMHzcLYrO5U0d+Sq+BeF9suvdhRYV+FXX/4CY9e/edOwXPzEITM3AqDZtewHRikXHzuKM2lMadikSj+IeVe0Sbm9zd7kXWI+w+SRF5LeFpr5gFhT/0LiF/WvzfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708242427; c=relaxed/simple;
	bh=BKs6y9EPQXIUNlMVIpvBS2yT3Xy2/9dOIOPM54bzss8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuaNIVzUa99w7cRKLgnSc7/ZNzBNW8Et+J9FU6tFDW3AiQTM1TiHGU6hHYn0wlGNfGW+87ee+ospS27xLbex2TSRIIXay6ZgyYJcLJgsSa2tQRTHQCUTEUdEB2A6wH9ffMq/LJvjIG8Xzx7xD6m2opQ30E8KtGDI1uQr945F52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrJH4PXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55038C433C7;
	Sun, 18 Feb 2024 07:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708242426;
	bh=BKs6y9EPQXIUNlMVIpvBS2yT3Xy2/9dOIOPM54bzss8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrJH4PXPj/dz7a/quQl5Hjug7zHvT5vyRayjwBJFYOwA8GIMArzsiA9avJPhw5js9
	 bZyXGSWdNpsFtd3rycPnV5UkltleXfQ9kqrmrTr2Q9t2JOOkcNz7qSAsrsgmIMinUF
	 hEJYTKgQKin7fiEjAUpmojYcbu3WfGgkZYZaPC8c=
Date: Sun, 18 Feb 2024 08:47:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guixiong Wei <guixiongwei@gmail.com>
Cc: linux-hardening@vger.kernel.org, jgross@suse.com,
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org,
	Guixiong Wei <weiguixiong@bytedance.com>
Subject: Re: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root
 access
Message-ID: <2024021825-skiing-trustee-a56a@gregkh>
References: <20240218073501.54555-1-guixiongwei@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218073501.54555-1-guixiongwei@gmail.com>

On Sun, Feb 18, 2024 at 03:35:01PM +0800, Guixiong Wei wrote:
> From: Guixiong Wei <weiguixiong@bytedance.com>
> 
> Restrict non-privileged user access to /sys/kernel/notes to
> avoid security attack.
> 
> The non-privileged users have read access to notes. The notes
> expose the load address of startup_xen. This address could be
> used to bypass KASLR.

How can it be used to bypass it?

KASLR is, for local users, pretty much not an issue, as that's not what
it protects from, only remote ones.

> For example, the startup_xen is built at 0xffffffff82465180 and
> commit_creds is built at 0xffffffff810ad570 which could read from
> the /boot/System.map. And the loaded address of startup_xen is
> 0xffffffffbc265180 which read from /sys/kernel/notes. So the loaded
> address of commit_creds is 0xffffffffbc265180 - (0xffffffff82465180
>  - 0xffffffff810ad570) = 0xffffffffbaead570.

I've cc: the hardening list on this, I'm sure the developers there have
opinions about this.

> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> ---
>  kernel/ksysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index b1292a57c2a5..09bc0730239b 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -199,7 +199,7 @@ static ssize_t notes_read(struct file *filp, struct kobject *kobj,
>  static struct bin_attribute notes_attr __ro_after_init  = {
>  	.attr = {
>  		.name = "notes",
> -		.mode = S_IRUGO,
> +		.mode = S_IRUSR,
>  	},
>  	.read = &notes_read,
>  };

No objection from me, but what userspace tool requires access to this
file today?  Will it break if permissions are changed on it?

And what about the module notes files?  If you change one, shouldn't you
change all?

thanks,

greg k-h

