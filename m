Return-Path: <linux-kernel+bounces-118621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FFD88BD5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D9F1C35460
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB055C2C;
	Tue, 26 Mar 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ga9ido2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94025535CF;
	Tue, 26 Mar 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444362; cv=none; b=BwC+NrfMs5fMKN4NKBdM6A14nwwYKMXjZZh6au7D8XaCl9/TCaGKhK2coOOvZum6X793wc5J7NZtlOcsobCT/sWf7IrAYY7C5vJ4TMytye5pWhe4kweaVEJoaFbx+f4iqrYN3lv6O6VtoJSUIdSSKJ7veu/74q37434sEX7DA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444362; c=relaxed/simple;
	bh=t58JdC2b/HPnLyTDAhREExcio11Vu5aF7Lgh9dnHC+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb5/IpdNWsDfu9E2ULWxV6HvZVDjSbhwzbFxl+fJJ3SkedVHs+S0IlcXfXdToriG528zz2mXJFeq3mSb5drwq2dVJHjk+xqOCActx/+MdBHO00AyJ6DWhQUH76zpEbo8+Subd/xBi6haGzj5BJGheWSgAn3ZpsMhPn1Zqn4Reg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ga9ido2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F9C433F1;
	Tue, 26 Mar 2024 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711444362;
	bh=t58JdC2b/HPnLyTDAhREExcio11Vu5aF7Lgh9dnHC+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ga9ido2GsoMbBulZG1R5S05bpShG4kiY0CpzVj5Mh6TPPrtrRjbmT/Ot6hS1ZR9tT
	 3hlFiSxqowAQHZU/0SqNy5sF1xUUY8O1s8DmXp0XnZEZFgBJ0DkVz6SpxzdIjsS/zX
	 UDn13hXs0z3AOdtrj1y5TIxM7jqf/buHECKPDN9E=
Date: Tue, 26 Mar 2024 10:12:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavan Holla <pholla@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH 1/3] usb: typec: ucsi: Provide interface for UCSI
 transport
Message-ID: <2024032603-tactful-exes-f2d0@gregkh>
References: <20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org>
 <20240325-public-ucsi-h-v1-1-7c7e888edc0a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-public-ucsi-h-v1-1-7c7e888edc0a@chromium.org>

On Mon, Mar 25, 2024 at 11:37:28PM +0000, Pavan Holla wrote:
> The ucsi.h include can be used by driver implementations that
> provide transport for UCSI commands.
> 
> Signed-off-by: Pavan Holla <pholla@chromium.org>
> ---
>  MAINTAINERS              |  1 +
>  include/linux/usb/ucsi.h | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..e799d67a8fa5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22987,6 +22987,7 @@ F:	Documentation/ABI/testing/sysfs-class-typec
>  F:	Documentation/driver-api/usb/typec.rst
>  F:	drivers/usb/typec/
>  F:	include/linux/usb/typec.h
> +F:	include/linux/usb/ucsi.h
>  
>  USB TYPEC INTEL PMC MUX DRIVER
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> diff --git a/include/linux/usb/ucsi.h b/include/linux/usb/ucsi.h
> new file mode 100644
> index 000000000000..3ec1db968070
> --- /dev/null
> +++ b/include/linux/usb/ucsi.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

No copyright line?  I think your employer would not like it if they saw
that :(

Please get review from some internal-to-google developers before
submitting your next version of this series.

thanks,

greg k-h

