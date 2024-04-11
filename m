Return-Path: <linux-kernel+bounces-139932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A88A0940
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E82284034
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66A1448CC;
	Thu, 11 Apr 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC4+KI11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10631448E7;
	Thu, 11 Apr 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819242; cv=none; b=OC6hlXx2V+Z6kZ8bG8I2jb4ZanRIZnSgCI0oZ+v/E1WjsZCU8H1xqaePWmL8DEZA5R8O3FQw8Ce3gjs/STl4KWttgpJTMy95D+c9750pI2PXCEp6uMQvCKm8Xdq8sru/LgnY7uyaNn3u2N+4aMX2uDmIAzkM1RxjcevQ4y1YyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819242; c=relaxed/simple;
	bh=gtxWxgfoNim3AH2pc/GfSs//7Xc2MyiStzhd8defvEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/h5qs0vuXCyy6VqSpIlaveH3y6tbcgPiEbmHNExiNg9brnjyEyoJ4ZMkfJDgYMM70e5P6P6q4OPJaimIcb107KjPdmDKDIqwIu3vWPjqRxJiqfch7kX8QfzKQiZNWav1c4p2nUny3xlBoryoL81sfeAxPr8SsYN34Q+NQxLp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC4+KI11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE4AC43390;
	Thu, 11 Apr 2024 07:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819242;
	bh=gtxWxgfoNim3AH2pc/GfSs//7Xc2MyiStzhd8defvEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hC4+KI11LWiwoN7PZTy0sMWyVSOca1J3JKoDWDwXF2cEtyKTQi40uRspBuy4KOH0H
	 UyH1mg+uDv2CCnT7TQ1gDO5J79/slkGiF3pbq/EEdTArXb7LfDxRSNnYS69fNUQbWn
	 C/pCLacdFizTFB1GAXTa194BR46Q7YGft+9D2tQd7pHqEh4lIOOAaPvNvShVafgx2F
	 XuotdbILz25O2lLZ8dQqKUwNdblhKbA/p+N6HbC+sWczhpmy14jqWcom3hQAdhujZN
	 6ere1jBZADM03M7zvgM37XheNdgeHvTM3dSH1nr3zM47Su9i76KbHQj9fBPJk9UTl/
	 TzIOcHDfWMJfA==
Date: Thu, 11 Apr 2024 08:07:18 +0100
From: Lee Jones <lee@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
Message-ID: <20240411070718.GD6194@google.com>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>

On Wed, 03 Apr 2024, Ben Greear wrote:

> On 4/2/24 10:38, Ben Greear wrote:
> > On 4/2/24 09:37, Ben Greear wrote:
> > > Hello,
> > > 
> > > Sometime between rc1 and today's rc2, my system quit booting.
> > > I'm not seeing any splats, it just stops.  Evidently before
> > > sysrq is enabled.
> > > 
> > > [  OK  ] Started Flush Journal to Persistent Storage.
> > > [  OK  ] Started udev Coldplug all Devices.
> > >           Starting udev Wait for Complete Device Initialization...
> > > [  OK  ] Listening on Load/Save RF …itch Status /dev/rfkill Watch.
> > > [  OK  ] Created slice system-lvm2\x2dpvscan.slice.
> > >           Starting LVM2 PV scan on device 8:19...
> > >           Starting LVM2 PV scan on device 8:3...
> > > [  OK  ] Started Device-mapper event daemon.
> > > iwlwifi 0000:04:00.0: WRT: Invalid buffer destination: 0
> > > sysrq: This sysrq operation is disabled.
> > > 
> > > I can start a bisect, but in case anyone knows the answer already, please let me know.
> > > 
> > > Thanks,
> > > Ben
> > > 
> > 
> > So, deadlock I guess....

Does this help you in any way?

https://lore.kernel.org/all/bbcdbc1b-44bc-4cf8-86ef-6e6af2b009c3@gmail.com/

-- 
Lee Jones [李琼斯]

