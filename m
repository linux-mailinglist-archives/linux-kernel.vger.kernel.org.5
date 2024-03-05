Return-Path: <linux-kernel+bounces-92430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A427872010
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5CAB21366
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47A85C65;
	Tue,  5 Mar 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mv/7ew43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBE85645;
	Tue,  5 Mar 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645160; cv=none; b=k7yICnulDX26Woku98Xrk5NiSLZQ4yPCXd5v5BOociKSA6fHGIrXXt/SXrqNgJbsj6o6X9pZnjgMohjL3KzhoRsU8XHkAkAeeEhzQFGECSD5RlrotARBLZhjNo3mZB3ir9+PG9bT+rH2jMHe4KIn5Xk146tQAl1jxg8x5lFjaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645160; c=relaxed/simple;
	bh=qGUY1dxiZirRGSYHab1JAkhMGDJpARkMldpVYyOZWJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIjqGekwug37oM/1HuUJxaMzn+Jg5ajUdh7WFz6YD/E8+ZlT/SBLJR/t/HdQwcUnreKQlinSqSpRN3tG2rrNcJRqvyW4+cMB5Rr933e/VsW/E6t4ju80AeZHROTZL6GsCHCutBvOmP/dixnpteVKgPHCYK1fSzl37xvX1v8mKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mv/7ew43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61595C433C7;
	Tue,  5 Mar 2024 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709645159;
	bh=qGUY1dxiZirRGSYHab1JAkhMGDJpARkMldpVYyOZWJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mv/7ew43kGKZfV6Z49esHWEbBa1oKgnsWW1B4+H2IITQG67n7G6Ij+is7AO4J7SqU
	 FQV680h4TdMx7AP/lBCrzLDXMVWnguNQP+HKRtqJZnds1ZYSrVyQlb18wwqQ8vsn+p
	 C1qdeOzt+sbS6Zj8dDEOZK8SwXR9CDnuLD1GCYCs=
Date: Tue, 5 Mar 2024 13:25:55 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc: oneukum@suse.com, stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, WeitaoWang@zhaoxin.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] USB:UAS:return ENODEV when submit urbs fail with
 device not attached
Message-ID: <2024030530-trinity-triangle-c334@gregkh>
References: <20240229193349.5407-1-WeitaoWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229193349.5407-1-WeitaoWang-oc@zhaoxin.com>

On Fri, Mar 01, 2024 at 03:33:49AM +0800, Weitao Wang wrote:
> In the scenario of entering hibernation with udisk in the system, if the
> udisk was gone or resume fail in the thaw phase of hibernation. Its state
> will be set to NOTATTACHED. At this point, usb_hub_wq was already freezed
> and can't not handle disconnect event. Next, in the poweroff phase of
> hibernation, SYNCHRONIZE_CACHE SCSI command will be sent to this udisk
> when poweroff this scsi device, which will cause uas_submit_urbs to be
> called to submit URB for sense/data/cmd pipe. However, these URBs will
> submit fail as device was set to NOTATTACHED state. Then, uas_submit_urbs
> will return a value SCSI_MLQUEUE_DEVICE_BUSY to the caller. That will lead
> the SCSI layer go into an ugly loop and system fail to go into hibernation.
> 
> On the other hand, when we specially check for -ENODEV in function
> uas_queuecommand_lck, returning DID_ERROR to SCSI layer will cause device
> poweroff fail and system shutdown instead of entering hibernation.
> 
> To fix this issue, let uas_submit_urbs to return original generic error
> when submitting URB failed. At the same time, we need to translate -ENODEV
> to DID_NOT_CONNECT for the SCSI layer.
> 
> Suggested-by: Oliver Neukum <oneukum@suse.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
> v2->v3
>  - Modify the description of this patch.
>  - An error is returned directly when submitting URB fails.

This change breaks the build, please be more careful:

drivers/usb/storage/uas.c: In function ‘uas_submit_urbs’:
drivers/usb/storage/uas.c:559:21: error: unused variable ‘urb’ [-Werror=unused-variable]
  559 |         struct urb *urb;
      |                     ^~~


thanks,

greg k-h

