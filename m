Return-Path: <linux-kernel+bounces-70248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33965859538
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19A11F21A56
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1C63A9;
	Sun, 18 Feb 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EuHQTCrE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99046AB6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240595; cv=none; b=ZKKKG7QvAc6bn+UK4tuC2BfuuGFFpj8gyvL/58FBEkIw12DaudY3b0VTbXmn1W4+1ldXF2A563srFSeV6ob+6R9rRULXjREnYuIsi+wzrnzj2MuRrG+Evrur13xujkNpP9k3f0GpVma6BMvPTsZnm+OrniYGxyOutAHrWZbyLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240595; c=relaxed/simple;
	bh=NhGvLYry/xX7Eukod5V3Os+Fwg9BvQj479WHho11Ty0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USo6PADVK/qucMANg8//0+YM1Q3BYaiZBS8OzEr3beJ84k/VSMS6JmkO6+F4mODYGzAX1pTcKDe6DSYjFdNOSBfgiNZw624zjG7RH2BF+tD7UPKAEFh6+ZHo1MyeoSmx8ZCbc808QtezAWDbyrzaf0nWloXTahynvOUWUJfUbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EuHQTCrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74B3C433C7;
	Sun, 18 Feb 2024 07:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708240595;
	bh=NhGvLYry/xX7Eukod5V3Os+Fwg9BvQj479WHho11Ty0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuHQTCrEXJn/yRy/QZUEZlvcHuDLGHFTNvnqNroyEEkmvgKKUVvL+7lbVmIbl3nnr
	 klW8a6mZNFW6Qyyy+P+m+smLxBegabKFGh0Od6vmAWfuMmKQMo44gbZKtBPQLvpWbK
	 hq5/7oKfDrpkkNHCO63Iz5fdOyaH93mqNxbxVERs=
Date: Sun, 18 Feb 2024 08:16:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: roland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root
 access
Message-ID: <2024021809-colossal-emission-72bf@gregkh>
References: <CAJe52t-XxSn2rK+wEg1hNAdsPdq+TO-fj3wEYPK_eBH0d-bsSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJe52t-XxSn2rK+wEg1hNAdsPdq+TO-fj3wEYPK_eBH0d-bsSg@mail.gmail.com>

On Sat, Feb 17, 2024 at 10:19:32PM -0800, Guixiong Wei wrote:
> Restrict non-privileged user access to /sys/kernel/notes to
> avoid security attack.
> 
> The non-privileged users have read access to notes. The notes
> expose the load address of startup_xen. This address could be
> used to bypass KASLR.
> 
> For example, the startup_xen is built at 0xffffffff82465180 and
> commit_creds is built at 0xffffffff810ad570 which could read from
> the /boot/System.map. And the loaded address of startup_xen is
> 0xffffffffbc265180 which read from /sys/kernel/notes. So the loaded
> address of commit_creds is 0xffffffffbc265180 - (0xffffffff82465180
> - 0xffffffff810ad570) = 0xffffffffbaead570.
> 
> Signed-off-by: Guixiong Wei
> ---
> kernel/ksysfs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 1d4bc493b2f4..ccef642dc4c6 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -241,7 +241,7 @@ static ssize_t notes_read(struct file *filp, struct
> kobject *kobj,
> static struct bin_attribute notes_attr __ro_after_init = {
> .attr = {
> .name = "notes",
> - .mode = S_IRUGO,
> + .mode = S_IRUSR,
> },
> .read = &notes_read,
> };
> -- 
> 2.20.1

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

