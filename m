Return-Path: <linux-kernel+bounces-161009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781AB8B45B8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C11282BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517148CC7;
	Sat, 27 Apr 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jAUeqhaf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3A481D3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216007; cv=none; b=OyCTuf1yTeDLvH//iuC3a5rvX9kwO9QNpqjNjCJcCz22F3SuP7wXJajTyXSzt/n0E+Y/E9BXemMmzXkJpHxdEmxZl4kSJLf/nM8+QgNe0SAimj5c84H5xXdIf3TAo2PxVDYOyDilcWtuBlqY2pHZhDoPlvRFXsrNo8lZAkrC+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216007; c=relaxed/simple;
	bh=SmN9vxZOsewofREEBZ/JrAcLPTz0x6zlWzel61p0MOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncL3JZhrEGk5z+8aoL9npDIQYs5UjbsPw6KdV+dJJPcV9qa/xmkV/H+XD0zj4ma+krJTQKzaE7rmkU57oXgracjurTMnuA34loZJ0RfApjdoD28EIgrNZoJuCXEZm3ZbXSh7cn5MmC3Cb48/j71cglht6MYWgmO1jToP5hz3sCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jAUeqhaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE1EC113CE;
	Sat, 27 Apr 2024 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714216006;
	bh=SmN9vxZOsewofREEBZ/JrAcLPTz0x6zlWzel61p0MOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAUeqhafAY6+CTWWcJd5qyFdhGvaZoAUJh/MIseVLjqnbSFNlW0rPgcb3USosJH92
	 8qYQXTU3utSMM/yY1QvOBBMCLaZkiTikl/E2hpyZn5x+81dtwy21Sej3yxqqPwZ1a1
	 AZ75saMwZL5NTxd94GCrng/3zLiGK6wydEHaFDN0=
Date: Sat, 27 Apr 2024 13:06:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, jerinj@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <2024042704-repugnant-extenuate-f775@gregkh>
References: <2024042501-stargazer-departure-e5b9@gregkh>
 <20240426182011.2156856-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426182011.2156856-1-vattunuru@marvell.com>

On Fri, Apr 26, 2024 at 11:20:11AM -0700, Vamsi Attunuru wrote:
> Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> function which initializes DPI DMA hardware's global configuration and
> enables hardware mailbox channels between physical function (PF) and
> it's virtual functions (VF). VF device drivers (User space drivers) use
> this hw mailbox to communicate any required device configuration on it's
> respective VF device. Accordingly, this DPI PF driver provisions the
> VF device resources.
> 
> At the hardware level, the DPI physical function (PF) acts as a management
> interface to setup the VF device resources, VF devices are only provisioned
> to handle or control the actual DMA Engine's data transfer capabilities.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
> Changes V5 -> V6:
> - Updated documentation

The documentation for where to find the userspace code needs to be in
the documentation file, not buried in a comment here in a changelog
section that will never show up anywhere.

thanks,

greg k-h

