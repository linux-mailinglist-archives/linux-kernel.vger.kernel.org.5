Return-Path: <linux-kernel+bounces-90942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DC87074C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3886F1C20B8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC634CB51;
	Mon,  4 Mar 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iF/urOTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC42562F;
	Mon,  4 Mar 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570185; cv=none; b=n4+mvXxvSdLuV3FWbE2psRpMTnYZrpo3uYDMthWntdWZqj2btYBRYtnOxj4T1J85wkOXmeBH26uA1xrjiPPv5YPntVMc7Lo1zYpEdJggwQskBL77bjE6xLghxEjt4Qt0doA1YIHe/OBd+gH2MBgRuRXWFOh8zpPrpUJmNyOdohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570185; c=relaxed/simple;
	bh=7M33YsntfZa4IiNprZkqRmmM+5r+jQjCaEFeJP0s3ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNq33lE1s0amrK9u5r0R6C+/8OG2I/EQq8+2m/8JeQGVZJpF1VcySpid+zz2QvSHWBG1lt86TU1TqaQxiqUFT4L6KEFAZvpPFvvKotDEuzuiLj8nViT8caUBxyHv2fu3KOhCiwpD5BOgFOyWvzE3ADD57cYmhOUas7Lc7uKzXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iF/urOTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACD0C43390;
	Mon,  4 Mar 2024 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709570185;
	bh=7M33YsntfZa4IiNprZkqRmmM+5r+jQjCaEFeJP0s3ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF/urOTz40HrKXMc+wCyCU7K3MS6wYFdCWzG2fGrbgIZSd6LSCZfC24mgfbBiEoAZ
	 m6v9cVX7vrATsDc4MB3EZ2gwAnKMb5aUW6j7xTc6LSeMyJ5Q/F+0myLq4zYFPNv4xW
	 1UUSusN1DjfOVqmq0BCrqmd43OY2A8rNSwxnQKxg=
Date: Mon, 4 Mar 2024 17:36:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sam Sun <samsun1006219@gmail.com>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>,
	hgajjar@de.adit-jv.com, quic_ugoswami@quicinc.com,
	stanley_chang@realtek.com, heikki.krogerus@linux.intel.com
Subject: Re: [Bug] INFO: task hung in hub_activate
Message-ID: <2024030428-graph-harmful-1597@gregkh>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
 <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>

On Mon, Mar 04, 2024 at 11:15:24AM -0500, Alan Stern wrote:
> Third, this must be a generic problem.  It will occur any time a sysfs
> attribute callback tries to lock its device while another process is
> trying to unregister that device.
> 
> We faced this sort of problem some years ago when we were worrying
> about "suicidal" attributes -- ones which would unregister their own
> devices.  I don't remember what the fix was or how it worked.  But we
> need something like it here.
> 
> Greg and Tejun, any ideas?  Is it possible somehow for an attribute file 
> to be removed while its callback is still running?

Yes, it's a pain, and I hate it, but I think SCSI does this somehow for
one of their attributes.  I don't remember how at the moment, and I
can't look it up (am traveling), but this should be a good hint.

thanks,

greg k-h

