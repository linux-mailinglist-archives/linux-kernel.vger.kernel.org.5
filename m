Return-Path: <linux-kernel+bounces-136936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17589DA18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF91FB240A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269412DD8A;
	Tue,  9 Apr 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yza+R/ef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70312F37F;
	Tue,  9 Apr 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668993; cv=none; b=kXIgJWNPgPcEp0tAijRkbIObz9vEZ5aMacP3rc2dUFzd23Y1w9rcT+XoHcPHF2JeQAbNzrJKQalvfyh8uESTciROPtcfmZyIBkSNeZ1/z+OEya+8Ge2wEp81hoj369XQvbwuM2HBrjxyC7Vgmla+MvAdy3+VUtE6sCudOFsHjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668993; c=relaxed/simple;
	bh=7SxGLOMEl/NIZezLT1wZsWVVVZ6kZmZI1q3BxM/hXrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYzax3KqVg0VDbCwahqnWenPTr0azq1jdS1HWjHQHcM8cDDVPmrDwujjOmmr7UyS1Jg1pGvmbY9S+sCF3reYX3ism0oyD9DxPsvFwZNUn1J+XfRmM8tEFYA7CJs0O80b+pT88jM7ANNwyfdC1VZSFD/Q4XslEetkzRYRULgrPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yza+R/ef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B508EC433C7;
	Tue,  9 Apr 2024 13:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712668993;
	bh=7SxGLOMEl/NIZezLT1wZsWVVVZ6kZmZI1q3BxM/hXrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yza+R/efqfMzJXuaKvHTy/xH5WuJk9MVyjFKexp2bijV7avliKF3gyvQmSSU3Qyex
	 dnWYwnJbCUsDOGq79KyHqggbyvtRSp6wgJepe9+oyPzJ6CJK7sNxItXoGPuoE1FLj7
	 wWh1NNaaMiVHPUn3KwcZqI8qmdq5I4M9odDIxWig=
Date: Tue, 9 Apr 2024 15:23:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v4 08/27] serial: core: Provide low-level
 functions to lock port
Message-ID: <2024040900-pavestone-flagman-fbf9@gregkh>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-9-john.ogness@linutronix.de>

On Wed, Apr 03, 2024 at 12:17:10AM +0206, John Ogness wrote:
> It will be necessary at times for the uart nbcon console
> drivers to acquire the port lock directly (without the
> additional nbcon functionality of the port lock wrappers).
> These are special cases such as the implementation of the
> device_lock()/device_unlock() callbacks or for internal
> port lock wrapper synchronization.
> 
> Provide low-level variants __uart_port_lock_irqsave() and
> __uart_port_unlock_irqrestore() for this purpose.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/serial_core.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

