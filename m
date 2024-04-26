Return-Path: <linux-kernel+bounces-159812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD88B3469
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F841C22066
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CEC13F45D;
	Fri, 26 Apr 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVtdD0Xk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE087EF;
	Fri, 26 Apr 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124805; cv=none; b=cdWCaGSM1xxh6oe8w6pzrSaVRL2GlEqhOZ9F/q3Pxl+j2FFKptkkcIfGdiqhQfqJ8BqovL16FdeURmPfHkMtILlCrPQi1jfRM2QHnkpd5OB1fLi6a+Qd2G7A35Eyn/uGfJNAhrAnagAxkxlZn5m7Q+YPNKYA5ykSjEbPuUk7JBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124805; c=relaxed/simple;
	bh=90NGaBLm7Se4rX1TNIozUbVaVlDmswf15kUidTKUIFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrjyjiqcoD+WmQHDPwwzCZooy3rv/+o/JXR4/d04ioW3vWfZ3G1e/gawp6qZE4UCqe/xORfV5eyYtw3PmlXpHkOrMj7uX3Cn1Xk5owxDYSN2K5u4NoobGJuFZ+Dr2Hw9dVGGsFxAAXTOW/v184PRlvtirULDqVWxSD4vhLr1KqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVtdD0Xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0DFC113CE;
	Fri, 26 Apr 2024 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714124804;
	bh=90NGaBLm7Se4rX1TNIozUbVaVlDmswf15kUidTKUIFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVtdD0Xk9KJ0NfMOmrDoqnEnptccdnifYdVr5dOgIZ9ahufdaomPqVDFDbOnM2Adc
	 GKa063kslt7zVXHH/QZb1smV6TpnxOsEpQuYvqmFR8OBeDoGjL9ND20S1Fr0TM0BE+
	 dg2OOAnbddQIFyM1t5WYVQKfpCFKQTyAbXb1XTdUed2fvpLUp+iGev7zBqnyNgIEVO
	 Eb/7qSPwJXSP0rveXiwV47t7PCtr+ZIhAUAsmdA22dGQJRjnv08PNLTFNw0WRkXLKD
	 HvQ5FzlvfTI+qB1+giEnbNXeZIKFm6SPsyldIsO8gws4VgB14EH/+tnLw9bk+MM0kQ
	 b3kQtquZz7Uig==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s0IAH-000000001uE-3UdV;
	Fri, 26 Apr 2024 11:46:45 +0200
Date: Fri, 26 Apr 2024 11:46:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] usb: dwc3: core: Fix compile warning on s390 gcc in
 dwc3_get_phy call
Message-ID: <Zit4BfDgDpZDEVxp@hovoldconsulting.com>
References: <20240426050512.57384-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426050512.57384-1-quic_kriskura@quicinc.com>

On Fri, Apr 26, 2024 at 10:35:12AM +0530, Krishna Kurapati wrote:
> Recent commit introduced support for reading Multiport PHYs and
> while doing so iterated over an integer variable which runs from
> [0-254] in the worst case scenario. But S390 compiler treats it as a
> warning and complains that the integer write to string can go to 11
> characters. Fix this by modifying iterator variable to u8.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Fixes: 30a46746ca5a ("usb: dwc3: core: Refactor PHY logic to support Multiport Controller")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404241215.Mib19Cu7-lkp@intel.com/
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 4dc6fc79c6d9..719305ab86c0 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1449,7 +1449,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  	struct device_node	*node = dev->of_node;
>  	char phy_name[9];
>  	int ret;
> -	int i;
> +	u8 i;

Perhaps unsigned int would have been better, but this should work too
(the broken compiler did get the upper bound right).

I assume you did not install a cross-compiler and tried to reproduce the
bogus warning?

In any case, if we want to suppress that bogus W=1 warning, this looks
good to me:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

