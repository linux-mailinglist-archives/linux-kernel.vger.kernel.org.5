Return-Path: <linux-kernel+bounces-146774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A518A6AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FD1C20FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0D012BF04;
	Tue, 16 Apr 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgfRWkUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B484A5F;
	Tue, 16 Apr 2024 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269954; cv=none; b=Cyt3fbhsNNBRGEHlMx4hHoNsi0XEX5eLJ4wr/GLW/Gdu0Ow0RClNgQe72TR8O29XZrfHfXYKTGT/ppU1AxSaZNQS0Qs/6jqYHeML+XI1HEe0pIgMZnbw0omUBQPYawNMQkvRiY6Kb/B0zS3vn9898IC9i85CzdraCKgGUo0FUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269954; c=relaxed/simple;
	bh=Kytz+UD5dTwK2Cv6gkJ/t5JrQQBUJsCTbZJPyt6gz1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKy0EOFfANUkKM61wQmSGvD/ctPXS2ieZ4bvRDH38lwYQKVJhx91T3nq8HHUfXvDIQUpfUkY9kH5n2ovF1SKfMgalCBFI0qsankzJHPH9IE9GM6vb+Hxhr53VchD/JU8aQQHUQmmFa+upH7g13SSj+R+5o8q2BPVEayutWLhKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgfRWkUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FEC2BD10;
	Tue, 16 Apr 2024 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269953;
	bh=Kytz+UD5dTwK2Cv6gkJ/t5JrQQBUJsCTbZJPyt6gz1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgfRWkUm04+Oe+cJmh3pJcySnutmqfJD5WwdEGv3DxScDd9WncSfwQfo2g0W0Wlbp
	 WrSdvkzjmB1dpfMGcJRL67+ze9o26VkVTSK2uJ4vcGNYnpaEQirSzxKibTgzY9ZLOg
	 q2l1E3Xb7Fj3HoKc8YIOc0RHZnnhwo9TSnZm5/jpkeZbLmRyJc1EOfDm4mS6chZ0CR
	 gZfzpXqYXjBOzoRgTe9F6HjLRL2EYhVVQeOp1TCoOLLMdjLT3oc/1gNSPpsNevQ8cx
	 3POspS4Y/dsZ9h3OxrcAtcnY8y7ATFZTs8SAvx0wBb954Mv7cy7WD0F+BZyter8wO+
	 eF09JssL8N++A==
Date: Tue, 16 Apr 2024 13:19:09 +0100
From: Lee Jones <lee@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
Message-ID: <20240416121909.GU2399047@google.com>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <20240411070718.GD6194@google.com>
 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>

On Mon, 15 Apr 2024, Ben Greear wrote:

> On 4/11/24 00:07, Lee Jones wrote:
> > On Wed, 03 Apr 2024, Ben Greear wrote:
> > 
> > > On 4/2/24 10:38, Ben Greear wrote:
> > > > On 4/2/24 09:37, Ben Greear wrote:
> > > > > Hello,
> > > > > 
> > > > > Sometime between rc1 and today's rc2, my system quit booting.
> > > > > I'm not seeing any splats, it just stops.  Evidently before
> > > > > sysrq is enabled.
> > > > > 
> > > > > [  OK  ] Started Flush Journal to Persistent Storage.
> > > > > [  OK  ] Started udev Coldplug all Devices.
> > > > >            Starting udev Wait for Complete Device Initialization...
> > > > > [  OK  ] Listening on Load/Save RF …itch Status /dev/rfkill Watch.
> > > > > [  OK  ] Created slice system-lvm2\x2dpvscan.slice.
> > > > >            Starting LVM2 PV scan on device 8:19...
> > > > >            Starting LVM2 PV scan on device 8:3...
> > > > > [  OK  ] Started Device-mapper event daemon.
> > > > > iwlwifi 0000:04:00.0: WRT: Invalid buffer destination: 0
> > > > > sysrq: This sysrq operation is disabled.
> > > > > 
> > > > > I can start a bisect, but in case anyone knows the answer already, please let me know.
> > > > > 
> > > > > Thanks,
> > > > > Ben
> > > > > 
> > > > 
> > > > So, deadlock I guess....
> > 
> > Does this help you in any way?
> > 
> > https://lore.kernel.org/all/bbcdbc1b-44bc-4cf8-86ef-6e6af2b009c3@gmail.com/
> > 
> Hello Lee,
> 
> I cannot see how that patch above would fix my issues since I am not using that driver,
> but possibly some similar change needs to be made to iwlwifi.
> 
> Johannes, you had another suggestion: changing iwlwifi's request_module() to request_module_nowait() in
> iwl_req_fw_callback()
> 
> Is that still best thing to try in your opinion?

I mean the general principle, rather than the exact patch.

Yes, you would need to apply it to your own use-case.

-- 
Lee Jones [李琼斯]

