Return-Path: <linux-kernel+bounces-118543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF588BC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21852E3A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592D137751;
	Tue, 26 Mar 2024 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yiw52Iex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F1128392;
	Tue, 26 Mar 2024 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441771; cv=none; b=s3P4zlvPPx2u/LPHy9pdJjYOUseANqWxxRTx+Y1+zhzIa0/Om7kRNl706myqYvwVibUNEy1Uer7rCuZj9wcY53SPq2Lh7aYI69PtPmq8xlxA6uHwXwYSR3TQXWcYbgBwH4hXcMOhQsslYc54Y4UYW11cFdVM1DJ7+Tvr+QVPFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441771; c=relaxed/simple;
	bh=vc6aHwbmE8151ViOOvewkuy6wUpc4nRDbj3fGQOqXjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahUvdsOSKa2qhj5WCHasdHN4JUQ87qGUU40A8x2ujYqGWUHKK7LjMEdSf+9mJsWG8YktDQceq3YEnmzfvLCzYm+Y199D2a6KIRMXSKqJ2HSCV+KbDJDmTQ0/BWdH47DZKKgq56MRD7fqysfTUc80J4RtTLgDcxx2JEksng40LBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yiw52Iex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A20C43390;
	Tue, 26 Mar 2024 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711441770;
	bh=vc6aHwbmE8151ViOOvewkuy6wUpc4nRDbj3fGQOqXjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yiw52Iex+DY8QVYZBLDZNupvVNNxIO8UwjXZQSs5aUlErpuObEkNzjng5zswV2+0N
	 HBQLQxLmby2tKrf0aNryUXGbUwGTj48gMTaW5ZLytaYvBFUb7g1gQdZaPphm5wVjNo
	 cxx5K/JTyUAAGb59Yeam7+lKOxMLqgio6xM92pus=
Date: Tue, 26 Mar 2024 09:29:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavan Holla <pholla@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH] usb: typec: ucsi: Wait 20ms before retrying reset
Message-ID: <2024032624-subtitle-crisped-f4f1@gregkh>
References: <20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org>

On Mon, Mar 25, 2024 at 09:19:43PM +0000, Pavan Holla wrote:
> The PPM might take time to process reset. Allow 20ms for the reset to
> complete before issuing another reset.
> 
> Signed-off-by: Pavan Holla <pholla@chromium.org>

What commit id does this fix?  Does it need to go to older kernels?

> ---
> There is a 20ms delay for a reset retry to complete. However, the first
> reset attempt is expected to complete immediately after an async write
> of the reset command. This patch adds 20ms between the async write and
> the CCI read that expects the reset to be complete. The additional delay
> also allows the PPM to settle after the first reset, which seems to be
> the intention behind the original 20ms delay ( kernel v4.14 has a comment
> regarding the same )

Why was the comment removed in newer kernels?

Where does the magic 20ms number come from?  What about systems that do
not need that time delay, did things just slow down for them?

thanks,

greg k-h

