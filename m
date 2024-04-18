Return-Path: <linux-kernel+bounces-149574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F638A92FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287081F2284E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278E6A8AE;
	Thu, 18 Apr 2024 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pcNxOxQU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B0657D4;
	Thu, 18 Apr 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421513; cv=none; b=d8RA0IziRD/A5keUJqUUrh3/n5X72IICdlFqr7UO4fJVdKaLJqLQk1VauBjkG1An+/KwrNXgHB6WOv1d29yhj4iq8rPvq/ZVl61oWGDTYeTwT9F6rz2L6Ix5YJH62WA5h9QIHtFPQAG9JtNpkERSEYz2vdwSr688DdN1eMXT3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421513; c=relaxed/simple;
	bh=vDQURt8jUcoEu7p3MgkJ/YfbZZ7dGBBc9Y+bdKLdgMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQDg2Lmz0IFMKuHXWg5N+0hAWgynX4Oeydx1uIOxb5c0kqWakML3MiPXM7imlnn846+39pv0m0oVeUETW/UfNV6a67/L/QUinvt1hnHv/grsIW+0uae529gwztX3LGQvt6mGZh+QQhRv4KRFtJgj8wikVF+2x3bNT/rLN0J8dh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pcNxOxQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BE7C113CC;
	Thu, 18 Apr 2024 06:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713421513;
	bh=vDQURt8jUcoEu7p3MgkJ/YfbZZ7dGBBc9Y+bdKLdgMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcNxOxQUeXRdsv8plZja/MnVFXoiCyL2n3IsKs0Rx4V7rFnNux7GYHFdguphb/Mdz
	 gKvKlvpz7wfsFP68tFDD9eSEmtw+jNtUjdEz7/a9Lud4QadBoWxzx2gaIk3uFHhYvb
	 RijE/PXWdGQoNR+cViU8g79FKHzjlv5SVJTQRtgE=
Date: Thu, 18 Apr 2024 08:25:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 0/7] serial: exar: add Connect Tech serial cards to
 Exar driver
Message-ID: <2024041801-earthlike-drastic-076a@gregkh>
References: <cover.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713382717.git.pnewman@connecttech.com>

On Wed, Apr 17, 2024 at 04:31:22PM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Hello,
> These patches add proper support for most of Connect Tech's (CTI) Exar
> based serial cards. Previously, only a subset of CTI's cards would work
> with the Exar driver while the rest required the CTI out-of-tree driver.
> These patches are intended to phase out the out-of-tree driver.
> 
> I am new to the mailing lists and contributing to the kernel so please
> let me know if I have made any mistakes or if you have any feedback.
> 
> Changes in v2:
> - Put missing PCI IDs in 8250_exar.c instead of pci_ids.h
> - Split large patch into smaller ones
> 
> Changes in v3:
> - Refactored patches to be easier to follow (based on feedback of v2)
> - Patch specific changes listed in corresponding patch
> 
> Changes in v4:
> - Rebased to tty-testing branch
> - Removed v3 patch 8/8, "bug" didn't happen in current driver
> - Patch specific changes listed in corresponding patch
> 
> Thank you,
> 
> Parker Newman (7):
>   serial: exar: remove old Connect Tech setup
>   serial: exar: added a exar_get_nr_ports function
>   serial: exar: add optional board_init function
>   serial: exar: moved generic_rs485 further up in 8250_exar.c
>   serial: exar: add CTI cards to exar_get_nr_ports
>   serial: exar: add CTI specific setup code
>   serial: exar: fix checkpach warnings
> 
>  drivers/tty/serial/8250/8250_exar.c | 981 ++++++++++++++++++++++++++--
>  1 file changed, 916 insertions(+), 65 deletions(-)

Nice, compared to your first version, this is less code overall in this
file:
   1 file changed, 1019 insertions(+), 70 deletions(-)

so the review process helped!

All now applied to my tree, thanks for the revisions.  And a follow-on
patch to fix up the kbuild warning would be appreciated.

thanks,

greg k-h

