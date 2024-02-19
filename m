Return-Path: <linux-kernel+bounces-71012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1737859F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9026F1F242B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD6C22EF7;
	Mon, 19 Feb 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oe+zO1fV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9082261B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334083; cv=none; b=Q+/uQ4OlrZ4ztQ5dyCge9YQjCUKmHTmOO2hTfu642WfAdPYGoGSgZn+7JBwjVQMbZFTovTwq4n31/7CUQwQUj4TkaSFdLGf2iWgSXjEueT38VCC89UHhW8/EcUfdqYbPl7qGl/mLql3BAiB9uZeGreoTk906/2kU+5sqkm6MKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334083; c=relaxed/simple;
	bh=VCKAtpOd/fjfAzdbE/niK7IcHM9NBG1I650lCX7hD20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prMV8yXL3WjDIm8n02QxIeAY61HttqH+5X1Y4xafsK1ndEiruWFqaf8vq38gGXNKdfT6/TitFIiiKnF1DRHDxCMtqpGmMaj3yup2WeY0EYm/9sLSjaX4is2JQeDXR3a23+WTWAxuYSkLPlTrzH/d8wC0ayMBd2Gku7+MnsIJ3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oe+zO1fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3200C433C7;
	Mon, 19 Feb 2024 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708334083;
	bh=VCKAtpOd/fjfAzdbE/niK7IcHM9NBG1I650lCX7hD20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oe+zO1fVZWSqzHim8jtCkhO6zE+QZZ4RAnQCODyglQiDOfKXztAGBLhvPwNhyTpD3
	 +ZfKPxRBtW02yD8Uo89QWN9RZ6lzTdtddzw1wO2TYcO2m53+CmK9X/b+M1ekImrJOf
	 IhHd8iB7SKNJ+ZWwzlYYqo1F9Q87eMp+ujylglN0=
Date: Mon, 19 Feb 2024 10:14:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?6ZmI6aqP?= <chenjun102@huawei.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, xuqiang36@huawei.com
Subject: Re: [PATCH v2] irqchip/mbigen: Fix incorrect null pointer check
Message-ID: <2024021928-engulf-diffusive-d451@gregkh>
References: <20240219085314.85363-1-chenjun102@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219085314.85363-1-chenjun102@huawei.com>

On Mon, Feb 19, 2024 at 04:53:14PM +0800, 陈骏 wrote:
> From: Chen Jun <chenjun102@huawei.com>
> 
> bus_get_dev_root returns sp->dev_root set in subsys_register.
> And subsys_register is not called by platform_bus_init.
> 
> For platform_bus_type, bus_get_dev_root always returns NULL.
> This makes mbigen_of_create_domain always return -ENODEV.
> 
> Fixes: fea087fc291b ("irqchip/mbigen: move to use bus_get_dev_root()")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---


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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

