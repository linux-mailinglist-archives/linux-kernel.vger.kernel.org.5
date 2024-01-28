Return-Path: <linux-kernel+bounces-41482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511283F290
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254571F22BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52141109;
	Sun, 28 Jan 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABrX08xz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF875639;
	Sun, 28 Jan 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401916; cv=none; b=eV6uCh7ayzipOqEiOmVCBxgfuBR3EcAF5uLfOoO9v1/w59CkcnTWwVszZeruzuyMfu4u+2rMvcM/noFmOhUNjTe1X7gKVV0V3NLrOK7vzK69hVeL8FvayZmmRjFAhFlQrgzc6O7F+RujxMDzK7cKPtooZc2G422EDkU6sf2tUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401916; c=relaxed/simple;
	bh=qlP6n9v3TH0FxuwrZQvfnV/2QUxKUnDCrI81F/8GsXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Miu/dJiS1FqKzqsGWfMUu88suW5/fDlbjLHwKcBj0gI39OgK02jLDBjvc1OJlZRpowWGQP7b3U3fprKnX6mlYI0AEnR0zSCJvU5bcu2tPTTVXlxFl/liRqxHwmTo9DbAoPLBq7o9/W0TufPQV4gaRCbFTt0YUZBifmzwOzQdTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABrX08xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0F0C433C7;
	Sun, 28 Jan 2024 00:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706401915;
	bh=qlP6n9v3TH0FxuwrZQvfnV/2QUxKUnDCrI81F/8GsXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABrX08xzseQcFjvDZHmY30jsyrZJPBNn+8+2nR822eGRHkvcYPI2OxYb61Ap/Fllj
	 3Ksd7FopmLxZgkJdfxb2WrfGMBaEAOcpYQ/am0vYjXTwbaSzMS4zI4hnRLKAJofsSo
	 begEJdfVeevxp3Lr3gHKbUTzo+RNrkhjsj2QXvyg=
Date: Sat, 27 Jan 2024 16:31:54 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	software@gaisler.com
Subject: Re: [PATCH] usb: uhci-grlib: Explicitly include
 linux/platform_device.h
Message-ID: <2024012740-amaretto-unvarying-465a@gregkh>
References: <20240122082225.984523-1-andreas@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122082225.984523-1-andreas@gaisler.com>

On Mon, Jan 22, 2024 at 09:22:25AM +0100, Andreas Larsson wrote:
> This fixes relying upon linux/of_platform.h to include
> linux/platform_device.h, which it no longer does, thereby fixing
> compilation problems like:
> 
> In file included from drivers/usb/host/uhci-hcd.c:850:
> drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_probe':
> drivers/usb/host/uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'
>    92 |  struct device_node *dn = op->dev.of_node;
>       |                             ^~
> 
> Fixes: 0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.h")

I don't see this commit id in Linus's tree, where is it?

thanks,

greg k-h

