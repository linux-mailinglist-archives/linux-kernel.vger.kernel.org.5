Return-Path: <linux-kernel+bounces-4359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF013817C00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D4FB21E96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127942361;
	Mon, 18 Dec 2023 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aAaNF9Gx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488511DA27;
	Mon, 18 Dec 2023 20:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334CAC433C8;
	Mon, 18 Dec 2023 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702931626;
	bh=1boN5Sa2fUXDliSwKANgC1UGa1HVdAijXd4ulUQ0DyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAaNF9Gx2Igc9pGydY/HVX8/niCAp/y8J6soYiRlBqHvz6ef3trhhtli1TY5Bzixi
	 r6AnWQjNFJM22dYsi5hAK6S8kRQkGmthuXOk5SIU2ijj3crz9aQLKcwb/KshhymRgC
	 4cQPUkKDO4yVthjmRJdnG+hWJ7XPELNqR4uz11fU=
Date: Mon, 18 Dec 2023 21:33:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
Message-ID: <2023121829-zealous-prissy-99cc@gregkh>
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218202809.84253-3-marpagan@redhat.com>

On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
> This patch tentatively set the owner field of fpga_manager_ops to
> THIS_MODULE for existing fpga manager low-level control modules.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/altera-cvp.c             | 1 +
>  drivers/fpga/altera-pr-ip-core.c      | 1 +
>  drivers/fpga/altera-ps-spi.c          | 1 +
>  drivers/fpga/dfl-fme-mgr.c            | 1 +
>  drivers/fpga/ice40-spi.c              | 1 +
>  drivers/fpga/lattice-sysconfig.c      | 1 +
>  drivers/fpga/machxo2-spi.c            | 1 +
>  drivers/fpga/microchip-spi.c          | 1 +
>  drivers/fpga/socfpga-a10.c            | 1 +
>  drivers/fpga/socfpga.c                | 1 +
>  drivers/fpga/stratix10-soc.c          | 1 +
>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
>  drivers/fpga/tests/fpga-region-test.c | 1 +
>  drivers/fpga/ts73xx-fpga.c            | 1 +
>  drivers/fpga/versal-fpga.c            | 1 +
>  drivers/fpga/xilinx-spi.c             | 1 +
>  drivers/fpga/zynq-fpga.c              | 1 +
>  drivers/fpga/zynqmp-fpga.c            | 1 +
>  18 files changed, 18 insertions(+)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..aeb913547dd8 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>  	.write_init	= altera_cvp_write_init,
>  	.write		= altera_cvp_write,
>  	.write_complete	= altera_cvp_write_complete,
> +	.owner		= THIS_MODULE,

Note, this is not how to do this, force the compiler to set this for you
automatically, otherwise everyone will always forget to do it.  Look at
how functions like usb_register_driver() works.

Also, are you _sure_ that you need a module owner in this structure?  I
still don't know why...

thanks,

greg k-h

