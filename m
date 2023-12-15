Return-Path: <linux-kernel+bounces-1259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F91814C83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CC02884EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44133A8E3;
	Fri, 15 Dec 2023 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtD0Es0O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A02FE32
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC555C433C7;
	Fri, 15 Dec 2023 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702656558;
	bh=RxoexFcGo01hQ+yyE3PtnCePfwaNbc++y3oIM5rldbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtD0Es0O5wUUdS90aWH8LEPGeialXBy/+5WZPzmSuffry5wqG91CNscPe+5rzZ4xy
	 Bl5YSNyrkT2vPp9FpR02Fleiot3DHnNvp0HJo+PPvLAlqLhm5SQMct9b3KlJpBvKLe
	 JUzuarz+vNHnHzvvkJ7dKhVW8Cizvuy85oiC8Qf8=
Date: Fri, 15 Dec 2023 17:09:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cdx: Enable COMPILE_TEST
Message-ID: <2023121551-uncommon-negation-fdda@gregkh>
References: <20231207163128.2707993-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207163128.2707993-1-robh@kernel.org>

On Thu, Dec 07, 2023 at 10:31:26AM -0600, Rob Herring wrote:
> There is no reason CDX needs to depend on ARM64 other than limiting
> visibility. So let's also enable building with COMPILE_TEST.
> 
> The CONFIG_OF dependency is redundant as ARM64 always enables it and all
> the DT functions have empty stubs.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/cdx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> index a08958485e31..7cdb7c414453 100644
> --- a/drivers/cdx/Kconfig
> +++ b/drivers/cdx/Kconfig
> @@ -7,7 +7,7 @@
>  
>  config CDX_BUS
>  	bool "CDX Bus driver"
> -	depends on OF && ARM64
> +	depends on ARM64 || COMPILE_TEST

Ok, good start, now we need to turn this into a module, what's keeping
it from being able to be built as a tristate?

thanks,

greg k-h

