Return-Path: <linux-kernel+bounces-28546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEBA82FFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63402896E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BB79DF;
	Wed, 17 Jan 2024 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGzjk8Nv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA17491;
	Wed, 17 Jan 2024 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470299; cv=none; b=VBvR9L5EHP4W4xCYGkDYqFwDXHBo6E22o/Dj6Pis1rrIMOIr/i3Xv9H5kClZIg07d1WR1jDl1tNqLs8FbNR4OYBCOq+bGg9A1xmxCCq62uv+LpDBadiJyXa9GlsSufcSVJmn84IKSL1S8tQSr6NKW9yrV27hdbPp2UGBKVPfYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470299; c=relaxed/simple;
	bh=Su82o05XaBqUC40YgdJ7xwVTjt43pHi9mnvZ+QCuGyY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=RdWl+D2htwn8nddclprOFsQrmjDbJOiIrGSZv5n5bTfYirFBvfeW25XDz45niy2VSe7jN9cMgRDszWNhV0wIanF4i7Vimhw+/3JJsmgop62ORzS+LUpLCIqxxsml5NXPfeFaeewKGCBSh1XP743RYCqmNwlV0tX9lfyQ7/xmbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGzjk8Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04388C433C7;
	Wed, 17 Jan 2024 05:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705470298;
	bh=Su82o05XaBqUC40YgdJ7xwVTjt43pHi9mnvZ+QCuGyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yGzjk8Nvn6HLpGQZcd8X3BV7qXl0JvGnpg0CtrQSX6QgibvjsNmaKQKeHhn2/XKtY
	 OMO5hzwUCzXQlcn/36StitnapX2QKD/pzuZwJ4+17f6fhJehpYfH4F/wUXUnIJPSkX
	 JUUapQRsEZp+wyjXs+JkZxclcZxbLzWoKM/MQ8hA=
Date: Wed, 17 Jan 2024 06:44:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: ucsi_acpi: Fix command completion handling
Message-ID: <2024011745-many-quintet-b40a@gregkh>
References: <20240116224041.220740-1-lk@c--e.de>
 <20240116224041.220740-3-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116224041.220740-3-lk@c--e.de>

On Tue, Jan 16, 2024 at 11:40:40PM +0100, Christian A. Ehrhardt wrote:
> In case of a spurious or otherwise delayed notification it is
> possible that CCI still reports the previous completion. The
> UCSI spec is aware of this and provides two completion bits in
> CCI, one for normal commands and one for acks. As acks and commands
> alternate the notification handler can determine if the completion
> bit is from the current command.
> 
> The initial UCSI code correctly handled this but the distinction
> between the two completion bits was lost with the introduction of
> the new API.
> 
> To fix this revive the ACK_PENDING bit for ucsi_acpi and only complete
> commands if the completion bit matches.
> 
> Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
> NOTES:
> - I've seen real issues as a result of this.
> - UCSI implementations other than ACPI might need a similar fix.
>   I can give relevant maintainers a heads up once this is properly
>   reviewed and integrated.
> 
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

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

