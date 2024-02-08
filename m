Return-Path: <linux-kernel+bounces-57926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB8284DF17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B811F23ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB00E6F52A;
	Thu,  8 Feb 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CU1AlERc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5176E2D1;
	Thu,  8 Feb 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389764; cv=none; b=VGpGDvRLIGcitcjZqhkMGgKnUJ/+195HiLYNqIVPah9y/qAu+R57zBEIzcTGpiUiv2k+6XhiY4AYr5gBeoPTH1PXXmgP12dNSKvS2QQIuvZtd80gTpH5edKVxMyUnCOk5rSnBQb7OqiJUYhLp4Zqy57p73wb6mu/5kzceFxUxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389764; c=relaxed/simple;
	bh=8Z4tyBCIZ1+COc9EX7GYyGke8vZAkKNTm/jG3Jij07M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5VVrMzHU+KQYOi0c4QQXPmOFQf6cP3DOC/NmUrxeCbemSNTWrLMwqDutm4RU32zX5uOlHP0JfKR++YtSIH0fZYtALEdNvjym0UKq/88g1B+vATfierb9F20oF8ABnKz1xPaFAMmPHbxiS8tkPlbuhxt7dcyqsBrFXorDOix4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CU1AlERc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D79C433F1;
	Thu,  8 Feb 2024 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707389763;
	bh=8Z4tyBCIZ1+COc9EX7GYyGke8vZAkKNTm/jG3Jij07M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CU1AlERcPKXuwdF+eZN8gCem9/7c6zgZJoUa4kvIR1dS4d5/54cJPZy9KholIOVjZ
	 RFuMOeC0rFz9SM2f1U+zHVMvzn8jiJ9huBfGWAlo3+d4g8Pwl2HIZX0w3oQu30wOyR
	 thJJFOUNZn1IOBpCsZCEghjJhDbC7QjJA5nBfC+k=
Date: Thu, 8 Feb 2024 10:56:00 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, rafael@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH riscv64] kobject: fix WARNING in input_register_device
Message-ID: <2024020812-snowbound-version-6bfa@gregkh>
References: <00000000000047631d0610d010c1@google.com>
 <tencent_AF9E941B3D4BEF1B2625D4BA18BBDA332108@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AF9E941B3D4BEF1B2625D4BA18BBDA332108@qq.com>

On Thu, Feb 08, 2024 at 06:46:55PM +0800, Edward Adam Davis wrote:
> The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> of data to env, which will result in insufficient memory allocated to the buf 
> members of env.

What is "env"?  And can you wrap your lines at 72 columns please?

> Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  include/linux/kobject.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index c30affcc43b4..74b37b6459cd 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -30,7 +30,7 @@
>  
>  #define UEVENT_HELPER_PATH_LEN		256
>  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
> -#define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
> +#define UEVENT_BUFFER_SIZE		2560	/* buffer for the variables */

That's an odd number, why that?  Why not just a page?  What happens if
some other path wants more?

And what's causing the input stack to have so many variables all of a
sudden, what changed to cause this?  Is this a bugfix for a specific
commit that needs to be backported to older kernels?  Why did this
buffer size all of a sudden be too small?

thanks,

greg k-h

