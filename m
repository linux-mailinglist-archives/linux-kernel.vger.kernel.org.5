Return-Path: <linux-kernel+bounces-69740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CBE858DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E3E1C2107D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB91CD28;
	Sat, 17 Feb 2024 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSQ1PPzE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9B1CABA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708157634; cv=none; b=Zcc+6LIepd9+siFgPH8ajNLzRmbgPUXqH4+jY/IAyfn6IPuB5RUJa1OzPCGlNKDLzoGy02pSAuhc9MW2PumY3+7fYVjtouAkoE3bqRZndIz3tgcG73OEYZLiSMS8wbwKup5kPzTf9Y2LY4hK6p0wcdeupA6/pH9Qn3yBKrB22X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708157634; c=relaxed/simple;
	bh=CEV0GAwlNnqfAjykp4IK9n4NFhtb0MDhdCn646Civqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/dq5ZTLiXp7d1pKyp4kWTYO3eO3xgSvK/XOrMcLF4mCjzCkfRJP5Wh2f4OV7IGHt/+B3IrSCr5o+FigGny2RNC3WvpnzknN0YmyFFsJ4KbxxQtHYSCZNrU6n+WyPdUQTUIgFyhLJciRbdS9yqz3IHZLu/zpBOwBngUF/XZlbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NSQ1PPzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99053C433F1;
	Sat, 17 Feb 2024 08:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708157634;
	bh=CEV0GAwlNnqfAjykp4IK9n4NFhtb0MDhdCn646Civqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSQ1PPzEcOFaYuZ7KxU23OKA1QrgG1M18oGywN4ZSEs06HkZsd6g53VFH9knGq5pH
	 oAuiTiOyaJkzqGrhaV4BNEKM7B30FC6Yj40nSIlpe/v2WcSAYOALExqGYIWHHe3CsJ
	 Gil+WN7oXxfv2nbiSDKFbnJGymJQJBVAMtAjynpU=
Date: Sat, 17 Feb 2024 09:13:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K dpi driver
Message-ID: <2024021713-corrode-landline-e186@gregkh>
References: <MW4PR18MB5244844411A57790287068E5A64E2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240216103225.1255684-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216103225.1255684-1-vattunuru@marvell.com>

On Fri, Feb 16, 2024 at 02:32:25AM -0800, Vamsi Attunuru wrote:
> Adds a driver for Marvell CN10K DPI(DMA Engine) device's physical function
> which initializes DPI DMA hardware's global configuration and enables
> hardware mailbox channels between physical function (PF) and it's virtual
> functions (VF). VF device drivers (User space drivers) use this hw mailbox
> to communicate any required device configuration on it's respective VF
> device. Accordingly, this DPI PF driver provision the VF device resources.
> 
> At the hardware level, the DPI physical function (PF) acts as a management
> interface to setup the VF device resources, VF devices are only provisioned
> to handle or control the actual DMA Engine's data transfer capabilities.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
> 
> Changes V1 -> V2:
> - Fixed return values and busy-wait loops
> - Merged .h file into .c file
> - Fixed directory structure
> - Removed module params
> - Registered the device as misc device

Why register as a misc device if you don't actually use it at all?  That
feels pointless and extra code and confusion for everyone as you have
created a device node in the system that will just fail all operations
made on it.

confused,

greg k-h

