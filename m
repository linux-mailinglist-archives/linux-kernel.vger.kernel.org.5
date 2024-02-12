Return-Path: <linux-kernel+bounces-61575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80F8513CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED29C280E89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950839FFE;
	Mon, 12 Feb 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lR+S/LxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAE3A1A0;
	Mon, 12 Feb 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742117; cv=none; b=edICQQkbGDMBtTdbCEYtqljHXPOrSgufk5eTOxIweqbfd5sg1dLkuLZ7DyVSvQkkuYgVH8osdgpQPtPN7Pu4gOmbhJtWwiymz0tbhQ/eUoK2v9yzhKSOl41vqf1pWbHRaH8yh2jn7mB3gOuOpzjon+1dJMv9iSzq2bzK8t9AaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742117; c=relaxed/simple;
	bh=5P++wSu6rb8H++7C5Eq+SD+MlK7YQnTcw5tYWYdLQWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu9whhhNGVqIJ4UzWT4uSR2yvZ9JaD6oMSTBi8M/8j6kTcCc1er47FdHwVxKglSlU3elpGY8dJWKpJxdJCIMq9LoahtTdTu91uOmyLv4lphyn8TfZImwhwWFTMmuVCbRKyhw8lh9b9swxx2AzKuJF3vjwdRBE/Y2Y/lfyODOp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lR+S/LxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4600C433F1;
	Mon, 12 Feb 2024 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707742117;
	bh=5P++wSu6rb8H++7C5Eq+SD+MlK7YQnTcw5tYWYdLQWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lR+S/LxF1HlwOPrgK7e6+aARvDJoTyfQ5wH1UzbljjNecsLu0TD5YHxQZOH9qLFtN
	 relyl94NX0gV/qkNZAzaeVHZe564fMHHeqWxUgXB+Ovk7AjfmBkhIN86RdJeETGsLz
	 1muiy2dWtbTlxEA2ZPgc1TJqpW+3TtQ5nJQN/Tps=
Date: Mon, 12 Feb 2024 13:48:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fsa4480: Check if the chip is really there
Message-ID: <2024021222-dismantle-ouch-a72b@gregkh>
References: <20240212-topic-fs4480_check-v1-1-d9969e4d6f9a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-topic-fs4480_check-v1-1-d9969e4d6f9a@linaro.org>

On Mon, Feb 12, 2024 at 01:01:30PM +0100, Konrad Dybcio wrote:
> Currently, the driver will happily register the switch/mux devices, and
> so long as the i2c master doesn't complain, the user would never know
> there's something wrong.
> 
> Add a device id check (based on [1]) and return -ENODEV if the read
> fails or returns nonsense.
> 
> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
> the ID mentioned in the datasheet does indeed show up:
>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)
> 
> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
> 
> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/usb/typec/mux/fsa4480.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

