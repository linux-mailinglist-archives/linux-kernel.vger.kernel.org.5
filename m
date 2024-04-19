Return-Path: <linux-kernel+bounces-151075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B058AA8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6073DB2175F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9D93B298;
	Fri, 19 Apr 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G73PF3DZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793F9473;
	Fri, 19 Apr 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509860; cv=none; b=KUqzSZvUX62GJ02J5L8yzhcOmHCxMBuCvE9zUQWhs+YAN3mhhRORUt0kBn1hsRTQw7hOmGUIZH8wIdh0Hu20SoQDpM1y9rHMHH+JkfgwmD5BqJZBhboUdasLPMBKCAnIr97GxrxBEsS+fya8jiI9GQZtXd+zUH4NtW2m3yQvhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509860; c=relaxed/simple;
	bh=+eVbhLKdd12afcAaFTAUixJ7Mdsd0KE+6tiTWIf9nQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKBYbuqzuKemVAM2Tk8ta0uFgCOmqOWSJxbC/Q6fVtvKXTq8GzxcFzAWlH/LAxYP93yG1WLZym07VUPNrHe6qNq8Q6b18nj3OnGgdv3kPk/ZrM674YNeLp7F3X9kcvpkOxoUk3rYHSDcV18fA52qXeTNL9UQpYd79b0uV6h3udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G73PF3DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4A4C072AA;
	Fri, 19 Apr 2024 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713509859;
	bh=+eVbhLKdd12afcAaFTAUixJ7Mdsd0KE+6tiTWIf9nQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G73PF3DZ9uBe2Q7UY9+7NESw+CwCfdkknQNkkRYaweJgjXBLjs1kb6WoVPRz85heL
	 k9/s1DR3xnbdtoQRqZxK5XTKOpw35OpFk1oaSRfy1DNq2KIMs2bEJf7+/YInxKUNjo
	 Q1LmkfpBNDDvLb8t2ptc8SUbXPK+ov/CUR4pob9Q=
Date: Fri, 19 Apr 2024 08:57:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 4/4] serial: exar: change port_type ternary line
 wrapping
Message-ID: <2024041954-tarot-obtrusive-7a97@gregkh>
References: <cover.1713452766.git.pnewman@connecttech.com>
 <0081b6a7bbe1ad6ce114132f9ee86677a761de6d.1713452766.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0081b6a7bbe1ad6ce114132f9ee86677a761de6d.1713452766.git.pnewman@connecttech.com>

On Thu, Apr 18, 2024 at 11:36:31AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Change line wrapping of ternary operators in
> cti_get_port_type_xr17c15x_xr17v25x() for better readability.
> 
> Old example:
> 
> 	port_type = port_num == 0 ?
> 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> 
> New:
> 	port_type = port_num == 0 ? CTI_PORT_TYPE_RS232 :
> 				CTI_PORT_TYPE_RS422_485;
> 
> Based on feedback from:
> Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 10725ad0f3ef..a76b4e5bab4e 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -741,19 +741,19 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
>  		break;
>  	// 1x RS232, 1x RS422/RS485
>  	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
> -		port_type = port_num == 0 ?
> -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		port_type = port_num == 0 ? CTI_PORT_TYPE_RS232 :
> +					CTI_PORT_TYPE_RS422_485;

I missed this the first time, PLEASE never use ? : unless you have to.
Spell it out and use an if statement, the compiler doesn't care, and you
write code for people to read it first, cpus second.  So this should
look like:
		if (port_num)
			port_type = CTI_PORT_TYPE_RS422_485;
		else
			port_type = CTI_PORT_TYPE_RS232;

Much simpler and easier to understand when you look at this in 10 years
and try to scan to figure out what went wrong with the logic here...

thanks,

greg k-h

