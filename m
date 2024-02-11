Return-Path: <linux-kernel+bounces-60707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D459C8508BE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122361C213B7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA025A4CA;
	Sun, 11 Feb 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sixzSzbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1A59B70
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707649754; cv=none; b=UhKo5u6KxtuXzZkFx9gvV8bl2EGJ/uD509d9KhY2XN3HQGL3VI9cuvjCZFO8oFInBpb4UMpLOZV3ONZPnIKWNxVYLLW/sg3+ierorC6b7QUslBOF82Apotr5K4crnb1xoZNHsWWDaLCJLJF2kNBRkur2OP9HADROcNO4u+srRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707649754; c=relaxed/simple;
	bh=iBS+fDdmjS/STmPQWQedcnI6SAPKHM9ZdGosEUTv+Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5C+8vdFa+YS5dseTdjWRwdmWH5ZPd0U190d6uIhbxNx7OLhIhtvCPvkbv6QzJyQCJ6B+lM4eJzHQDzGHJ873ziIz4wZLLb6BGRsVOjIgl66saEsvJIcfCorcWtYSu/rcUBycBMpncs6XTx4GgXBDPejiVQCTZ8IqhGauneuwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sixzSzbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5A7C433C7;
	Sun, 11 Feb 2024 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707649753;
	bh=iBS+fDdmjS/STmPQWQedcnI6SAPKHM9ZdGosEUTv+Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sixzSzbz2gxT+mICFCdQVOUX7/T1fkOCrV60iv0TIfRF3e//jdJRXYm06KXSqSQHc
	 LgAPU6eNmrthq1IJaYMYdZSj1qMRDdCrBvg9iXUJ7kuGCSrPw0g/IB15yPfIniKHYA
	 M6O/ccbTwQxEJPCKzFWDjRcXPuvp1e1+Z9llnsIY=
Date: Sun, 11 Feb 2024 11:09:10 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Rohan <rohankollambalath@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs:Addresses null pointer dereference in
 sysfs_merge_group and sysfs_unmerge_group.
Message-ID: <2024021154-roundworm-census-3e6e@gregkh>
References: <20240208233626.657587-1-rohankollambalath@gmail.com>
 <2024020946-reexamine-unwitting-6277@gregkh>
 <CA+a0dEiZzZgsjhVRDMTyYgFWk9TwjAHeTjFphZQwvFctE9Zosg@mail.gmail.com>
 <2024021007-casually-supernova-329f@gregkh>
 <CA+a0dEjp2ExRTDZjN9z_Z12pNqHiiGkqsuTjh40TKN=W81+FWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+a0dEjp2ExRTDZjN9z_Z12pNqHiiGkqsuTjh40TKN=W81+FWw@mail.gmail.com>

On Sat, Feb 10, 2024 at 08:43:14PM +1000, Rohan wrote:
> Hey,

Please don't top-post, or send html email, as they get dropped from the
mailing lists.

> I found this bug when writing my own kernel driver. I believed the function
> wasn't explicit in stating its the requirement for the name field and made
> it easy for developers to mistake it with sysfs_create_group and cause a
> crash. I wanted to change the code for robustness purposes. Other functions
> in the same file already do this check such as sysfs_group_change_owner.

Adding documentation is great, but don't add checks that are not needed,
we require callers to set up things properly, otherwise the kernel would
be nothing but a constant set of checks for things that can never
happen.

> As for why I chose -ENOENT, I did this because it was the same error code
> returned if the group cannot be found by kernfs_find_and_get but I
> understand if this should be changed.

Yes, that is a different type of error entirely.  Just do the
documentation update, I'll gladly take that.

thanks,

greg k-h

