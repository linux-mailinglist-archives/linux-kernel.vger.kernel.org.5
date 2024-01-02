Return-Path: <linux-kernel+bounces-14313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D03821B38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98013B21DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808BF9DF;
	Tue,  2 Jan 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tCYWBjpU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D9F9D6;
	Tue,  2 Jan 2024 11:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C438CC433CA;
	Tue,  2 Jan 2024 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704196303;
	bh=7fkeBiP+TEUkDqsp/rCPTtcoASRwZlnzRxpDI+DWABE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCYWBjpUo9bbzyzm91kRqX9kmucLKjrQEfbMIpoSCEcKuQ0EX5MO1Sr1IB++DlLAJ
	 fC9ACgwsYhndj+nD73eUOHRDl2TA6jN61hJV6iK3iS2LuoohxhI2O+MHaJJ17GuM0v
	 UR9JyhWdHIirSt8g3DJm6tj6c1/guWiKHkIxCVZc=
Date: Tue, 2 Jan 2024 12:51:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: inappropriate capability checks in tty_ioctl()
Message-ID: <2024010247-polio-brittle-1b23@gregkh>
References: <19ed91a4.10d80.18cc9f7d2ea.Coremail.mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19ed91a4.10d80.18cc9f7d2ea.Coremail.mengjingzi@iie.ac.cn>

On Tue, Jan 02, 2024 at 07:38:31PM +0800, 孟敬姿 wrote:
> Hi!
> 
> We would like to propose an adjustment to the capability checks in the tty_ioctl() function. Currently, the function uses CAP_SYS_ADMIN to protect three subcommands: TIOCCONS, TIOCSTI and TIOCVHANGUP. We propose updating this to use CAP_SYS_TTY_CONFIG instead for the following reasons:
> 
> (1) CAP_SYS_TTY_CONFIG is more relevant to the functions: The three subcommands are responsible for tty-related functions: redirecting console output (TIOCCONS), faking input to a terminal (TIOCSTI), and making the terminal be hung up (TIOCVHANGUP). As the definitions in the capability manual page[1], CAP_SYS_TTY_CONFIG is specifically designed for "employing various privileged ioctl(2) operations on virtual terminals." This aligns more closely with the intended usage scenario compared to CAP_SYS_ADMIN.
> 
> (2) Consistency: CAP_SYS_TTY_CONFIG is already employed in other parts of the kernel to protect TIOCVHANGUP-like functionality. For instance, in tty_ioctl() CAP_SYS_ADMIN is used before tty_vhangup(), while in SYSCALL_DEFINE0(vhangup), which located in fs/open.c, the check is done with CAP_SYS_TTY_CONFIG before tty_vhangup().
> 
> (3) Maintaining Least Privilege: CAP_SYS_ASMIN is already overloaded and known as the new "root"[2]. According to the manual page[1] “don't choose CAP_SYS_ADMIN if you can possibly avoid it”, switching to CAP_SYS_TTY_CONFIG could be helpful for standardizing the use of capabilities and implementing least privileges. 
> 
> This issue exists in several kernel versions and we have checked it on the latest stable release(Linux 6.6.9). We would appreciate your thoughts and feedback on this proposal. Thank you for your time and consideration.

What would break if you made such a change?  Have you tried it and
tested it out?

Also, if you wish to have a change accepted, we need an actual patch to
apply, that shows you did the work and research to ensure that it will
work properly.

thanks,

greg k-h

