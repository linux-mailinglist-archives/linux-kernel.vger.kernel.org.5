Return-Path: <linux-kernel+bounces-65257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22126854A36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F041F2B061
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68F53E22;
	Wed, 14 Feb 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jov0nDTC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAA53E15;
	Wed, 14 Feb 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916404; cv=none; b=OxODUT6HhnANBUR370T5jJ9gyF3ZhJ5VNms/4XYiu4R7O5gJWOPy0UJFjTBLW1Nm54ocSVDAlXQJ71EJIqzVEJ02c2+eomBC8NmSbmY3/Rf7xfB7KcAonAHNmy3A/mpVxoJlFOXHII+aVmzB5jCGTKlOx8m6ghw/K+JD9jtW/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916404; c=relaxed/simple;
	bh=sZBOA2K/u66V/tbP9HOyBgE9XI4OGN3S5NIS3T5GN5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM0WZDYrAfEzlrnvkla+H8pQ/44mCdLsNqD7/01/SbsEYasTB4fhEaCy8bHSZkfavEoxy/b3vRBiC+mzBXXPy59q+uTLZvlg0MhbVSPbgpsCu7r56mk3TBM/kpez4OU31ox5aw5oclPuntWamu0fcga5yPKjByKbj713iUY5GxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jov0nDTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AEFC43394;
	Wed, 14 Feb 2024 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707916404;
	bh=sZBOA2K/u66V/tbP9HOyBgE9XI4OGN3S5NIS3T5GN5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jov0nDTC+IaV3ySziMHJxDbaEwAjK+KwUjGV5Yci6dSIT2loUJvrzZlJwc+8mayWl
	 hW9Cyrw81K1CGu1jyG7VZHRnhSHN9LhZBr/OpPN8QpUJ+ySzwRvcI9PjPnn7UE7R+8
	 sweWlqPwSGHeYu80lf6QP1JwXyBEhwt2I1x4mCWw=
Date: Wed, 14 Feb 2024 14:13:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <quic_selvaras@quicinc.com>
Cc: tern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH] usb-storage: Add US_FL_FIX_INQUIRY quirk for Intenso
 Twist Line USB 3.2
Message-ID: <2024021402-slit-duke-7761@gregkh>
References: <20240214111721.18346-1-quic_selvaras@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214111721.18346-1-quic_selvaras@quicinc.com>

On Wed, Feb 14, 2024 at 03:17:21AM -0800, Selvarasu Ganesan wrote:
> The Intenso Twist Line USB 3.2 flash drive fails to respond to the
> INQUIRY data stage request for a 36 bulk in request from the host. This
> commit adds the US_FL_FIX_INQUIRY flag to fake the INQUIRY command for
> this device, preventing a storage enumeration failure.
> 
> USBMON log:
> ffffff8a3ee06a00 3192811972 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
> ffffff8a3ee06a00 3192862051 C Ci:2:009:0 -2 0
> ffffff8a3ee06a00 3192862185 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
> ffffff8a3ee06a00 3192912299 C Ci:2:009:0 -2 0
> ffffff8a3ee06e00 3193040068 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
> ffffff8a3ee06e00 3193040214 C Ci:2:003:0 0 4 = 880b0700
> ffffff8a3ee06e00 3193040279 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
> ffffff8a3ee06e00 3193040427 C Ci:2:002:0 0 4 = 00010000
> ffffff8a3ee06e00 3193040470 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
> ffffff8a3ee06e00 3193040672 C Ci:2:002:0 0 4 = 03050000
> ffffff892b309500 3193824092 S Ci:2:009:0 s a1 fe 0000 0000 0001 1 <
> ffffff892b309500 3193824715 C Ci:2:009:0 0 1 = 00
> ffffff892b309500 3193825060 S Bo:2:009:2 -115 31 = 55534243 01000000 24000000 80000612 00000024 00000000 00000000 000000
> ffffff892b309500 3193825150 C Bo:2:009:2 0 31 >
> ffffff8b8419d400 3193825737 S Bi:2:009:1 -115 36 <
> ffffff8a3ee06400 3194040175 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
> ffffff8a3ee06400 3194040372 C Ci:2:003:0 0 4 = 880b0700
> ffffff89bee5b100 3194040591 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
> ffffff89bee5b100 3194040681 C Ci:2:002:0 0 4 = 00010000
> ffffff89bee5b100 3194040999 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
> ffffff89bee5b100 3194041083 C Ci:2:002:0 0 4 = 03050000
> ffffff8a3ee06a00 3195040349 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
> 
> Signed-off-by: Selvarasu Ganesan <quic_selvaras@quicinc.com>
> ---
>  drivers/usb/storage/unusual_devs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index fd68204374f2..7285287ca379 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -784,6 +784,13 @@ UNUSUAL_DEV(  0x058f, 0x6387, 0x0141, 0x0141,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_MAX_SECTORS_64 ),
>  
> +/* Selvarasu Ganesan <quic_selvaras@quicinc.com> */
> +UNUSUAL_DEV(  0x058f, 0x6387, 0x0002, 0x0002,
> +		"Intenso",
> +		"Flash drive",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_FIX_INQUIRY),
> +

Shouldn't this be up an entry to keep them in sorted order?

thanks,

greg k-h

