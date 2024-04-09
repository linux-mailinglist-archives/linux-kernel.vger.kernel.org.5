Return-Path: <linux-kernel+bounces-136973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3C89DA82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8726B22221
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404D12F5A7;
	Tue,  9 Apr 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0jbSYxVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAA12EBF7;
	Tue,  9 Apr 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669905; cv=none; b=LjmpiHkKcS5QsVlgtis5Uyt4qkJO5b6jxfF+X6XqZZ59CW4N0aWdw+gza+y/vh8mgx/qtHL0oacQqSDQsPlRWQUYzYF1EdwBo97tVTit5NmPri3bnS7d+WZoJxGg/OTYMBv8Lwikrkl575wpJ3U4+1jXxOCcw4lFk+hxTAU2tOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669905; c=relaxed/simple;
	bh=peQqCOotkIJimL+cJu7ThX6HtNMoK2xBm6fdtFNcy9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nak15ysxX8f4l/e+xQiedXg2S83Jji4IRnTLseCqXt2nMPpg3mWXR9k8ExOhEHvyYno1/AeWawMPJHYBMfBSD30ZjZ0xz++yOua2rsrDiLL4BE+4l5gGoHqNfMB76zuxgwH4RbM0nHxMQKOxtbYeD3dvOlcaDdNVkmE+dBOUJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0jbSYxVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B51C433C7;
	Tue,  9 Apr 2024 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712669904;
	bh=peQqCOotkIJimL+cJu7ThX6HtNMoK2xBm6fdtFNcy9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0jbSYxVG1SOlgAEiCWRAf5n9aFMnQJIEd7mbkZgdAQWWXVqAmxNfYzMOgPVYvKPqH
	 OUgFzkcZhooc61avUTVjSJtJPC5P1x0y0S6AMUHw4u1IsseMFNlBL9L+MNFPDNH1xW
	 19Od2NtULDW2u04N365V7hAwSXlKcX8lVlAir1o0=
Date: Tue, 9 Apr 2024 15:38:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yi Yang <yiyang13@huawei.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: vt: selection: fix soft lockup in
 paste_selection()
Message-ID: <2024040943-tightwad-handcuff-5eb7@gregkh>
References: <20240313094529.679957-1-yiyang13@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313094529.679957-1-yiyang13@huawei.com>

On Wed, Mar 13, 2024 at 09:45:29AM +0000, Yi Yang wrote:
> Soft lockup occurs when vt device used n_null ldisc, n_null_receivebuf()
> is not implemented in null_ldisc. So tty_ldisc_receive_buf always return
> 0 in paste_selection(), this cause deadloop and cause soft lockup.

Why is a vt using n_null?

What is causing that?

> 
> This can be reproduced as follows:
>   int ldisc = 0x1b; // 0x1b is n_null
>   struct{
>   	char subcode;
>   	struct tiocl_selection sel;
>   } data;
>   date.subcode = TIOCL_SETSEL;
>   data.sel.xs = 0;
>   data.sel.xe = 1;
>   data.sel.ys = 0;
>   data.sel.ye = 1;
>   data.sel.sel_mode = TIOCL_SELCHAR;
>   char bytes[2] = {TIOCL_PASTESEL, 0};
>   open("ttyxx", O_RDWR) // open a vt device
>   ioctl(fd, TIOCSETD, &ldisc) // set ldisc to n_null
>   ioctl(fd, TIOCLINUX, &data.subcode);
>   ioctl(fd, TIOCLINUX, bytes); // cause deadloop
> 
> Fix soft lockup by check receive_buf() and receive_buf2() is NULL.

As you had permissions to do this, why prevent it?

> 
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
> 
> v2:Change Check Condition.
> 
>  drivers/tty/vt/selection.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 564341f1a74f..715e111376a7 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -397,6 +397,12 @@ int paste_selection(struct tty_struct *tty)
>  	ld = tty_ldisc_ref_wait(tty);
>  	if (!ld)
>  		return -EIO;	/* ldisc was hung up */
> +
> +	/*tty_ldisc_receive_buf() won't do anything and cause deadloop later*/

Comments need to be properly formated.

And I do not understand this comment sorry.

> +	if (!ld->ops->receive_buf && !ld->ops->receive_buf2) {

Why check reciev_buf pointers here?  What is that causing?

This needs to be documented a lot better please.

thanks,

greg k-h

