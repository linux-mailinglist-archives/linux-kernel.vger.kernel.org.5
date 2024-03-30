Return-Path: <linux-kernel+bounces-125780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5102892C05
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331C2B22A99
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8D3BBD8;
	Sat, 30 Mar 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FSD7a9sF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B6EAC6;
	Sat, 30 Mar 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815809; cv=none; b=C9gAiyZ4SVMZ6sQvuim/8Cqs6cvjbnROuM8VO83z9lq8lfttuh49YX/hZ6WgKQ8GarOz6OsuaqLT9hA2Jbl3zaqg8KFgARPvi83X8o71wbEHq2JH0Ylbn6ySoTFMk/NkuxgOeTtpYeZnY78ibMzPBPX5fuhw2R66a7bQZfh4trA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815809; c=relaxed/simple;
	bh=93WNuwk3VTBSvncEyTnCrtuYdQBLXJkUB4WCK8FF828=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS70nVeQT/+xfn2EAsm1XCxzwGsfa25cYVDbzqfXNB6MiD/1f0bJIU0GXUtrVtYpZcpCxGuPyr4i8HKJsdc3125DzhQPVK9lLidKnvquJqBaaF0ZQfN5ncTrHKmomgOUniqQiWDPVaGJI1qmvghND20CnrCKa4r7zKs+54yLbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FSD7a9sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCEEC433C7;
	Sat, 30 Mar 2024 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711815809;
	bh=93WNuwk3VTBSvncEyTnCrtuYdQBLXJkUB4WCK8FF828=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSD7a9sFgat2J0L6llbULnXvE/xkOzoZqwX8thp9cFGRcrfse7mnPND4++lR6KzZx
	 Udiy7sQGsJpNegIJbS87pheVpgT7QHwjxFBgmeMTNK6ddzjSaT2maVG1nqmadwPaZd
	 YVfmGPERWzzqnl9u3CvkLSykpUNyhskG2ZYsEDs0=
Date: Sat, 30 Mar 2024 17:23:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: Bluetooth broken for some people with 6.8.2 [Was: [PATCH 6.8
 308/715] Bluetooth: hci_core: Cancel request on command timeout]
Message-ID: <2024033018-speller-supremacy-5436@gregkh>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-309-sashal@kernel.org>
 <bf267566-c18c-4ad9-9263-8642ecfdef1f@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf267566-c18c-4ad9-9263-8642ecfdef1f@leemhuis.info>

On Sat, Mar 30, 2024 at 03:59:22PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 24.03.24 23:28, Sasha Levin wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > 
> > [ Upstream commit 63298d6e752fc0ec7f5093860af8bc9f047b30c8 ]
> > 
> > If command has timed out call __hci_cmd_sync_cancel to notify the
> > hci_req since it will inevitably cause a timeout.
> > 
> > This also rework the code around __hci_cmd_sync_cancel since it was
> > wrongly assuming it needs to cancel timer as well, but sometimes the
> > timers have not been started or in fact they already had timed out in
> > which case they don't need to be cancel yet again.
> > 
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Hey stable team, I wonder if it might be wise to pick up 1c3366abdbe884
> ("Bluetooth: hci_sync: Fix not checking error on
> hci_cmd_sync_cancel_sync") from next
> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1c3366abdbe884)
> for the next releases of all series that a few days ago received
> 63298d6e752fc0 ("Bluetooth: hci_core: Cancel request on command timeout").
> 
> The latter patch sadly on quite a few systems causes a Oops due to a
> NULL pointer dereference and breaks Bluetooth. This was reported for
> mainline here (yes, coincidentally it was reported by yours truly):
> https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/
> 
> Now that the patch landed in 6.8.2 it seems to happen there as well
> (guess in 6.7 and others, too), as can be seen from this bug report
> where multiple people already joined:
> https://bugzilla.kernel.org/show_bug.cgi?id=218651
> 
> The fix mentioned above is on the way to Linus, but due to unlucky
> timing missed this weeks network pull, hence will likely only reach
> mainline next Thursday. But the fix afaics has a stable commit id, so
> might be worth picking up soon for the stable releases to fix the
> regression quickly.

Now queued up, thanks for letting us know.

greg k-h

