Return-Path: <linux-kernel+bounces-120505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2788D87E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A7E1C25D03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66F2C68E;
	Wed, 27 Mar 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJvuwsGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04AD23D7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527201; cv=none; b=bN+JoIFfnEXFXHXD4PPnuWNdceG4WUocfKSMzFbQoPnMUSd8po4k91sQ48/vjNn88Q3wz1G89mA/5THNI8VVqItDVasgGyWsFHKFAk1xTsAjThGED+PB8dhR9Kur2U7GGaHsfT+UqoFJQsR9IfVYZGU859PTzqr+bupqK0G9BIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527201; c=relaxed/simple;
	bh=yCP1CH96izi8owCfv8mH8fThqtiNs2POCXAO4ghwBkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB1NuDFVUAEVL6wX2TcsvmcltgDUzTYvhIjj6Q5qWEXHLlXt+4oGE5B8N2szJgeXVBHq2lFKz7Coq3j1orfCqWUkIAfYCWiLkGSlg9KF5/md/l8TT/IhxaBLbKAyxHbYqqc5TUCovGGK7sKFeLioKsI5JxScuGF/ady532amVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJvuwsGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A3C433F1;
	Wed, 27 Mar 2024 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711527200;
	bh=yCP1CH96izi8owCfv8mH8fThqtiNs2POCXAO4ghwBkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJvuwsGflB9Wy6Ac5P5GkjUjzMXqdcfxA5m+JWio120YrCJ6xvm46zoD1YXoikF4M
	 IDdzC80maw5AFzm29iVSSRpYgn7sPUqU/wmW6zhHQvQxa1448qr9Ua6ahA/4weaEcs
	 y2qQSCSUFRjFfyTUDv+9CHuWk1DOqxNMHeEiQs14=
Date: Wed, 27 Mar 2024 09:13:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 0/7] Soundwire: clean up sysfs group creation
Message-ID: <2024032742-armless-cage-7c6c@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <ZbpFTyW9UCZdCs_v@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbpFTyW9UCZdCs_v@matsya>

On Wed, Jan 31, 2024 at 06:34:15PM +0530, Vinod Koul wrote:
> On 30-01-24, 10:46, Greg Kroah-Hartman wrote:
> > Note, this is a redone version of a very old series I wrote back in
> > 2022:
> > 	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org
> > but everyone has forgotten about it now, and I've reworked it, so I'm
> > considering it a "new" version, and not v2.
> > 
> > Here's a series that adds the functionality to the driver core to hide
> > entire attribute groups, in a much saner way than we have attempted in
> > the past (i.e. dynamically figuring it out.)  Many thanks to Dan for
> > this patch.  I'll also be taking this into my driver-core branch and
> > creating a stable tag for anyone else to pull from to get it into their
> > trees, as I think it will want to be in many for this development cycle.
> > 
> > After the driver core change, there's cleanups to the soundwire core for
> > how the attribute groups are created, to remove the "manual" creation of
> > them, and allow the driver core to create them correctly, as needed,
> > when needed, which makes things much smaller for the soundwire code to
> > manage.
> 
> The series lgtm, having the core handle these would be good. I will wait
> couple of days for people to test this and give a t-b and apply.
> I hope it is okay if patch1 goes thru sdw tree?

patch 1 is now in Linus's tree, so the remaining ones can go through the
your tree now if you want.  Or I can resend them if needed, just let me
know.

thanks,

greg k-h

