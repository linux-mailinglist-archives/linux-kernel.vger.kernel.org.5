Return-Path: <linux-kernel+bounces-63261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B3852CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855301C269A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D622638;
	Tue, 13 Feb 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1bJrnhf6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0922618;
	Tue, 13 Feb 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817563; cv=none; b=ml2XW4UNc3UflbmwGAjpvhSSx97CqRA7JSlQzVmTTk6lVFfPkzGdC+zWlUESnZGlZeibulb9kYoOlfE8onXo/wpLtCfmaRWlmqH7p6FT2t94crrLizP5xrU6T4hHoamvwJewC9G4ykRVLs89EyaDHT7PgVgdkn7Grbs9npSIn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817563; c=relaxed/simple;
	bh=qFyWFT85f614iAFVoIyVBn+WeMGQK8ZHRIFpwhElMOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxE/RtqjfskAzFxj2F0xL6frdpS/XSYe40yPDzD7OH2KhYSwrqeBcVBeBB9NaC5Dai6PBMFTjA91+SkpPhXjWGJjNGh/+jH53fStg24T2J0jlycuHyQvr8uhLjjOMAQ8u1d84jBxaZZwjE9fMhKDPInQGpC3p6INO1wAp0m0FOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1bJrnhf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF90CC433C7;
	Tue, 13 Feb 2024 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707817562;
	bh=qFyWFT85f614iAFVoIyVBn+WeMGQK8ZHRIFpwhElMOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1bJrnhf67DJLiTD21dPyaLZBO99GI8qVzt0hG0n9s+xdf7+MdTft/ljiZVvgjPieW
	 26lzJ8vihGFIdd+rITru5+NP7rmbb4uJcJG65k9/cwu29rEf4a4ZEVV1ECNCoyYr/p
	 die5ImPOelWX1U4ifC9iI116QEDPjO/TKnfWKcds=
Date: Tue, 13 Feb 2024 10:45:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fsa4480: Check if the chip is really there
Message-ID: <2024021327-slapping-causing-c0ef@gregkh>
References: <20240212-topic-fs4480_check-v1-1-d9969e4d6f9a@linaro.org>
 <2024021210-bacteria-camping-7e48@gregkh>
 <99749541-25bd-4cd7-be5d-e440472c6f0f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99749541-25bd-4cd7-be5d-e440472c6f0f@linaro.org>

On Mon, Feb 12, 2024 at 01:59:42PM +0100, Konrad Dybcio wrote:
> On 12.02.2024 13:48, Greg Kroah-Hartman wrote:
> > On Mon, Feb 12, 2024 at 01:01:30PM +0100, Konrad Dybcio wrote:
> >> Currently, the driver will happily register the switch/mux devices, and
> >> so long as the i2c master doesn't complain, the user would never know
> >> there's something wrong.
> >>
> >> Add a device id check (based on [1]) and return -ENODEV if the read
> >> fails or returns nonsense.
> >>
> >> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
> >> the ID mentioned in the datasheet does indeed show up:
> >>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)
> >>
> >> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
> >>
> >> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/usb/typec/mux/fsa4480.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> >> index cb7cdf90cb0a..d622f4f3bd54 100644
> >> --- a/drivers/usb/typec/mux/fsa4480.c
> >> +++ b/drivers/usb/typec/mux/fsa4480.c
> >> @@ -13,6 +13,10 @@
> >>  #include <linux/usb/typec_dp.h>
> >>  #include <linux/usb/typec_mux.h>
> >>  
> >> +#define FSA4480_DEVICE_ID	0x00
> >> + #define DEVICE_ID_VENDOR_ID	GENMASK(7, 6)
> >> + #define DEVICE_ID_VERSION_ID	GENMASK(5, 3)
> >> + #define DEVICE_ID_REV_ID	GENMASK(2, 0)
> > 
> > Why the indent?
> 
> In many places across the kernel, bitfields or possible values of a
> register are defined with an indentation to emphasize the relation between
> the defines

Ah, that wasn't obvious here because:

> > And those are _VERY_ generic #defines, please give a better name for
> > these so you don't conflict with other stuff in the kernel accidentally.
> 
> If you don't mind them becoming very long, I can prepend them with FSA4480_,
> and I suppose shrink 'VENDOR' to "VEN" and "VERSION" to "VER" to compensate

Yes, prepend them pleaase.  And no need to shorten the word, we have
plenty of space.

thanks,

greg k-h

