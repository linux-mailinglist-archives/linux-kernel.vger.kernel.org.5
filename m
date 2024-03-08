Return-Path: <linux-kernel+bounces-97268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E888767EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFCF284F28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940341F947;
	Fri,  8 Mar 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="upMoiqbj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1A25761;
	Fri,  8 Mar 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913765; cv=none; b=fVs1XmIMiYr4/DCt5oq3KJ4bdfe68Xy9muDxusvwwyFI+5A5KKjYZGguyXvhHd4fudXz2j7YMW39GQ4diSi56tcUk41WDWSMh7cN5PbGqAlhd2+WPhKqFYlPXdZ4pXGst9ijKfSAHKOeaovI4IhAenDmTg52vE58jc9r/l46deY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913765; c=relaxed/simple;
	bh=yHTthNwyTUv2I71NwpMbdXccCnNpCImTtO6f6Zu64KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzHz0tg1WkuSdfk1ZVgMau01fV4z8x2Zkyb3Q+pQw3YKy/lbNoCw52KIhWDYfNG8hkRlWgddLvLg5ACGR68BspcCjWOc49Xz04UlvJx/HiOoJfeZG3S4GKaOjPEpaoycAlKwtdIqLdXDj5LtrmHVjaFLq4mYcKAvsmQgx1N9j2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=upMoiqbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E9AC433C7;
	Fri,  8 Mar 2024 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709913765;
	bh=yHTthNwyTUv2I71NwpMbdXccCnNpCImTtO6f6Zu64KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upMoiqbjKBtzUQIhbF3jilnuI7FX3eS/heyhKo0bUnVUMKKWDR1BCkps2W3xOTYUq
	 z2dh7pUw1rr+GDnOEpetkijbtrOVtynLzV4PdC+MNAyKEtmynT74vouWcvEj0Z/4Vs
	 jy/TwXFuyatxYjo+lo3BIQsi0ymhxXhF8ibaz5Tw=
Date: Fri, 8 Mar 2024 16:02:41 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Robert Frohl <rfrohl@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: CVE-2023-52496: mtd: maps: vmu-flash: Fix the (mtd core) switch
 to ref counters
Message-ID: <2024030853-upstate-unsaid-62c6@gregkh>
References: <20240229155245.1571576-37-lee@kernel.org>
 <27febaac-ebee-4e49-99ac-68dd9ceca60b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27febaac-ebee-4e49-99ac-68dd9ceca60b@suse.com>

On Fri, Mar 08, 2024 at 11:26:54AM +0100, Robert Frohl wrote:
> Hi all,
> 
> > but let's just fix the build for now.
> 
> Reads like it is only a build fix, does it really need a CVE ?

You're a bit late:
	https://lore.kernel.org/all/2024030813-subscribe-smasher-aeca@gregkh/
:)

Already revoked, thanks for the review!

greg k-h

