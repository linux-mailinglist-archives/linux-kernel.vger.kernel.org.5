Return-Path: <linux-kernel+bounces-16522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8FE823FA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543521C23E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A1320DDE;
	Thu,  4 Jan 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMjHZb6m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09D210E6;
	Thu,  4 Jan 2024 10:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FBDC433C7;
	Thu,  4 Jan 2024 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704365048;
	bh=qWsGozCds69J55V51Nw4hD1uUMdPFMjkgJ1PBcIhjgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMjHZb6mp3VNQWhgL7u1SLUA7jbXoufPhqEHJX4wQcR0p9TMY1NIx/8zupxZRg52y
	 SwoDPZXGMjTrRVKW4rw5vV95sZNNRcfwh/zH8I7ZYpCKy+xyrTIw9iiB3LbqGctTXn
	 /eNbmLbZMadipsd+K87D+da4qZCogQ97M49Q2MtI=
Date: Thu, 4 Jan 2024 11:44:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Prevent null pointer dereference in
 update_port_device_state
Message-ID: <2024010447-sprite-shelter-0743@gregkh>
References: <20240104102616.20120-1-quic_ugoswami@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104102616.20120-1-quic_ugoswami@quicinc.com>

On Thu, Jan 04, 2024 at 03:56:16PM +0530, Udipto Goswami wrote:
> Currently,the function update_port_device_state gets the usb_hub from
> udev->parent by calling usb_hub_to_struct_hub.
> However, in case the actconfig or the maxchild is 0, the usb_hub would
> be NULL and upon further accessing to get port_dev would result in null
> pointer dereference.

Is this true for any real (or fake) hardware?

> 
> Fix this by introducing an if check after the usb_hub is populated.
> 
> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>

Any specific reason you don't want this backported to the stable kernels
that include the commit you marked this as a fix for?

As my bot says:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

thanks,

greg k-h

