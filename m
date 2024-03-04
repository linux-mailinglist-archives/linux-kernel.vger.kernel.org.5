Return-Path: <linux-kernel+bounces-90102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B586FA64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD8628167C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0E12E4E;
	Mon,  4 Mar 2024 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxuI2eHH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB2B667;
	Mon,  4 Mar 2024 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535658; cv=none; b=RO/FqCzxVRb7JvW5LB9GlvoQLRJMVOcmSDN0yyEHRXlACqIUnuiaBDHlQ1RF62SK8zmnd7ccCpMOqViJy/jGEQJ+LRNE1fhi2LuiTfcFmLqe01Cc+UGCdDV848mgLCL7aoTLJ9I9BtlbuPz4LqFH/AV5d5FAyNoemNJ7t+I4aOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535658; c=relaxed/simple;
	bh=+6O1b61eegcauwvncVdJAGt41wHdeb1LoXWkjLcqFoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbXxrGogjKz785tt+KA2AXaUAcWDQwEeu26zZdJHx9whgYmIRGKnhS2b0y7+KwdCEd0zFKCY8OyLFYuoeNV6269QRE3pSF98uQD8/A9LCK51cvkVoJVnJyKs6n08sCqKBwuUu15ziToFnlRw+0GSaUTH6KSelgMnOnnnDBwyyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxuI2eHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E26C433F1;
	Mon,  4 Mar 2024 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709535658;
	bh=+6O1b61eegcauwvncVdJAGt41wHdeb1LoXWkjLcqFoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxuI2eHHYYG49CuvPpfxTZ4Lym5ZGcUhVYM77yOxy0x9oL1Q+CbpyB7FXUCq77XyD
	 LxbM2dHSvTuLkvWcrcx8SBt7yL1lfP6xhMS++RyJyMSqDQgWi8r1BSQNygoB7brDT5
	 WWHar8t2Qrf1cvtd8e7eiIoJZz2TBZxFvtXK8iks=
Date: Mon, 4 Mar 2024 07:58:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH regression fix] misc: lis3lv02d_i2c: Fix regulators
 getting en-/dis-abled twice on suspend/resume
Message-ID: <2024030432-deploy-tingle-f2bb@gregkh>
References: <20240220190035.53402-1-hdegoede@redhat.com>
 <1d8226cd-df43-4ef6-8425-2db01d513b32@leemhuis.info>
 <d2465271-1e4b-4bae-9399-4d49d3938048@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2465271-1e4b-4bae-9399-4d49d3938048@leemhuis.info>

On Fri, Mar 01, 2024 at 06:20:52AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 27.02.24 17:25, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 20.02.24 20:00, Hans de Goede wrote:
> >> When not configured for wakeup lis3lv02d_i2c_suspend() will call
> >> lis3lv02d_poweroff() even if the device has already been turned off
> >> by the runtime-suspend handler and if configured for wakeup and
> >> the device is runtime-suspended at this point then it is not turned
> >> back on to serve as a wakeup source.
> >>
> >> [...]
> >>
> >> Fixes: b1b9f7a49440 ("misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback")
> >> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >> Closes: https://lore.kernel.org/regressions/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
> >> Cc: stable@vger.kernel.org
> >> Cc: regressions@lists.linux.dev
> > 
> > Paul, did you maybe test this? I suppose Greg had no time to review this
> > yet due to all the CVE stuff and stable tree maintenance; but with a bit
> > of luck a "Tested-by" from your side might motivate him or somebody else
> > to look into this.
> 
> Hmmm, Greg seems to be pretty busy with other stuff. Hans, is there
> maybe someone we can motivate into reviewing this to make it easier for
> Greg to pick this up and send it to Linus before -rc8/the final?
> 
> Sure, it's "just" a warning fix, still would have been nice to get this
> into -rc7. But I guess time has already run out on that. :-/

Sorry for the delay, this ended up at the bottom of my pile.  I'll pick
it up now...

greg k-h

