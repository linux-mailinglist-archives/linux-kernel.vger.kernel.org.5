Return-Path: <linux-kernel+bounces-148391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA0F8A81E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011401F216B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC813C8FD;
	Wed, 17 Apr 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jl2tWzvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAD13C80B;
	Wed, 17 Apr 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352716; cv=none; b=fLPe2izSDo5oFmZo3K5HUZELzobDGqPrAEYYyp7agRruYbWQJZjiTrHAwZL0ELSeEcSmHu7ZDQrXbyKo4I6Wje0n7YhF4QRKcVn+KFA+dsJ7xYvYFgCeY+c/QPd282GfYqxnJETNyRxSJgvNqAnnIgz4LxFiXZrQsP4twACa32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352716; c=relaxed/simple;
	bh=IZUgiSBdQAoQRubBCT3/2bhNxeEj1vM1SZLMwCmRNlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUoenf6x//URUvgl0/utzhf9Zq3jG8vb9bHE51tUwXGep7I/fBJDcWRRRBVWAoMjh0JBpdEzGO4K/Yl+eU4WB/J87m+GBtoORa6+AQW+k9TYrla35tR2L9C/DtkYuR5hIsz5+47HqBfK1HexHJa7SDu/pW+QzPhzZ9iUF6x35lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jl2tWzvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921B4C072AA;
	Wed, 17 Apr 2024 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713352716;
	bh=IZUgiSBdQAoQRubBCT3/2bhNxeEj1vM1SZLMwCmRNlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jl2tWzvtLLhYJalpZ3HzCMpIgbKmpZI78SNAtmX4yBb56A0Il+1sjaMAtFEoz8z4u
	 Cwc/OsdHtaHm3kSTmlGafIeub4CqfdxONCwkEHakH0TpIKV1VvyFDHCiuKdCBLUXLb
	 PTFf3E+SEBvHBXCgWG56vOgdIk46OWnrL7lloKOg=
Date: Wed, 17 Apr 2024 13:18:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 4/8] serial: exar: add optional board_init function
Message-ID: <2024041750-register-exterior-087a@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <cd710c68b6bc84efda3a57a1e91a1191d51fccb5.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd710c68b6bc84efda3a57a1e91a1191d51fccb5.1713270624.git.pnewman@connecttech.com>

On Tue, Apr 16, 2024 at 08:55:31AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> - Add an optional "board_init()" function pointer to struct
> exar8250_board which is called once during probe prior to setting up
> the ports.
> 
> - Fix several "missing identifier name" warnings from checkpatch in
> struct exar8250_platform and struct exar8250_board:
> 
> WARNING: function definition argument <arg> should also have an
> identifier name
> 
> - Fix warning from checkpatch:
> WARNING: please, no space before tabs
> + * 0^I^I2 ^IMode bit 0$
> 
> Changes in v3:
>  - Renamed board_setup to board_init.
>  - Changed pci_err to dev_err_probe
>  - Added note above about checkpatch fixes
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 388dd60ad23a..cf7900bd2974 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -133,7 +133,7 @@
>   *
>   * MPIO		Port	Function
>   * ----		----	--------
> - * 0		2 	Mode bit 0
> + * 0		2	Mode bit 0

This change isn't related to the exar8250_board change, right?

Just keep exar8250_board change as one patch, and the coding style
warning fixups as one for the very end, after you add all of your new
functionality.

thanks,

greg k-h

