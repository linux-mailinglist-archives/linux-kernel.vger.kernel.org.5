Return-Path: <linux-kernel+bounces-144807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2578A4AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33F81C218E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE83BBD7;
	Mon, 15 Apr 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFhDwcgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA543A1B9;
	Mon, 15 Apr 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171387; cv=none; b=KOtWTS+0If+PLFudLwIR5aOo4qBWQE9nxTg4kIduEfEjXHTUwZvq1H+0Tl2WiVvuR+po2zr4cPmO8pj74pDYC93Y0lkIYtJDwEWEwjIwQRrnykxQjJt7Qc+FI3q1rC9DN5e5LunpEPm0AHNjrNuNOlbX9LW7WzJdlzgFT5km83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171387; c=relaxed/simple;
	bh=xWZtjC+LQfFxNMLejVEiu5/vf0PJkwCqqsJP733tOOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvwJyfHH2yhDXTlUNiuqLBrtZpPdlGViEcyiXhLA0Y5xk3X0SsSVjSvMuAnLVUX1spHjA2V/VGNm40C7+x8YLurb+GDUjTqoQUgH1IQchJLR7CB3nl859fjpQnzC3YNMktKMUKKFiaQRxWdm4QiDViSPVaPmzHPfmqnVSyel3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFhDwcgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2129DC113CC;
	Mon, 15 Apr 2024 08:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713171387;
	bh=xWZtjC+LQfFxNMLejVEiu5/vf0PJkwCqqsJP733tOOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFhDwcgj7mJNrdS4Avb1A4655SIRw512jZx0p+Si/0YEJHhNyB4JiGp9LVuS0ETPr
	 CuB3LYCGQEAPbx/TUri5NtyDkktkk+zX4EadcA0TYcI+AMn6u7JuJbW7UjbMvlSCPS
	 Hkq8+zUuAVEJwR2GivqSOR1CFoXX8P+q5jCJMMk+7WpLCaUukU3KcrnhvUOBcgBJwl
	 1T8fl/M/hFfBmGAxaszp3aAExgc29dS80XsEp6kiEjZoiZCXrZbzDHkS63HldraQq5
	 QP0eASsxdNxF8nHrPwBvxefpEHeEr5iYPdrrKxnL1/mS/sUf3eqlBeb+yUu3MXj2IE
	 PmMdDdX5KcmKw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwI8W-000000007Yv-3xrJ;
	Mon, 15 Apr 2024 10:56:25 +0200
Date: Mon, 15 Apr 2024 10:56:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/52] USB: serial: store owner from modules with
 usb_serial_register_drivers()
Message-ID: <ZhzruFpJPfORWqYv@hovoldconsulting.com>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
 <20240328-module-owner-usb-serial-v1-1-bc46c9ffbf56@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-module-owner-usb-serial-v1-1-bc46c9ffbf56@linaro.org>

On Thu, Mar 28, 2024 at 11:05:39PM +0100, Krzysztof Kozlowski wrote:
> Modules registering driver with usb_serial_register_drivers() might
> forget to set .owner field.  The field is used by some of other kernel
> parts for reference counting (try_module_get()), so it is expected that
> drivers will set it.
> 
> Solve the problem by moving this task away from the drivers to the core
> amba bus code, just like we did for platform_driver in

"amba"

> commit 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/usb/serial/usb-serial.c | 12 +++++++-----
>  include/linux/usb/serial.h      |  7 +++++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
> index f1e91eb7f8a4..a659f2096a1a 100644
> --- a/drivers/usb/serial/usb-serial.c
> +++ b/drivers/usb/serial/usb-serial.c
> @@ -1459,17 +1459,18 @@ static void usb_serial_deregister(struct usb_serial_driver *device)
>  }
>  
>  /**
> - * usb_serial_register_drivers - register drivers for a usb-serial module
> + * __usb_serial_register_drivers - register drivers for a usb-serial module
>   * @serial_drivers: NULL-terminated array of pointers to drivers to be registered
> + * @owner: owning module/driver

Just "module"

>   * @name: name of the usb_driver for this set of @serial_drivers
>   * @id_table: list of all devices this @serial_drivers set binds to
>   *
>   * Registers all the drivers in the @serial_drivers array, and dynamically
>   * creates a struct usb_driver with the name @name and id_table of @id_table.
>   */
> -int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
> -				const char *name,
> -				const struct usb_device_id *id_table)
> +int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
> +				  struct module *owner, const char *name,
> +				  const struct usb_device_id *id_table)

Johan

