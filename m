Return-Path: <linux-kernel+bounces-93660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5C98732FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1A281C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F2C5FB8C;
	Wed,  6 Mar 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DHBvkgBw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA105FB87
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718336; cv=none; b=cLnQGwcbuDBcaLNfS0p80cp1+AgIwZmnbXJ0I+Jwfp8XbKBFHtyXqymp1f2UYNt+zHlIIz6H5bSc1cuVXLafdcBsMtx07pQoBvGpJ2IFS51q0LSw5HGzMeruqmIn3EffO34/t3UFLVzbv3nXXUdHRbFgZFZZqKpyFpVALAp3cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718336; c=relaxed/simple;
	bh=jebW8we+cUG2aEk13ghQQc3XUD55Lgpy4/ET3ixo2uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkxevVxk/4cxt2PlB9eoMxMetduXgp/YO+POihBe26g5LGnsSXLYGNijCN+JddTWYRaFGTTaHJ7xn32Qqk8EZ4pzjn8lM4C17VkMaTQrB1KcXZeuBs0GbsChZnFWpz0+rjGERlSoPTatxWD7jgj0khLAGtYmTKMJ7npPf5Bx9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DHBvkgBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E659C433F1;
	Wed,  6 Mar 2024 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709718336;
	bh=jebW8we+cUG2aEk13ghQQc3XUD55Lgpy4/ET3ixo2uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHBvkgBwWqD3hMgQyCM1gAqRY5SYMmelwWoKm+8VUINZF+lf0tdHFXqRnPRa1DvMD
	 8RNNKFKyExoVg9djeiNCBAXWDgQMAJyKKLtzVySqHqogGuy2ekne1dBNvSgxW3UfE5
	 v/Dcu3bIH8Ty2G3wPj5M890sTA0oXIloRuHFZ8qw=
Date: Wed, 6 Mar 2024 09:45:33 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Robert Frohl <rfrohl@suse.de>
Cc: Red Hat Product Security <secalert@redhat.com>, security@suse.de,
	cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()
Message-ID: <2024030635-alibi-obtrusive-133e@gregkh>
References: <15436477.7601.1709663408600@app142018.ycg3.service-now.com>
 <2024030628-skyline-contently-4b85@gregkh>
 <265fb3da-8961-4f4f-8f81-c271e5aceebc@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265fb3da-8961-4f4f-8f81-c271e5aceebc@suse.de>

On Wed, Mar 06, 2024 at 10:23:37AM +0100, Robert Frohl wrote:
> On 06.03.24 10:16, Greg KH wrote:
> > On Tue, Mar 05, 2024 at 10:30:08AM -0800, Red Hat Product Security wrote:
> > > 
> > > Hello Robert,
> > >   Thank you for reaching to Red Hat Product Security.
> > >   I have reviewed the flaws, CVE-2023-1192 has the correct patch used in the reference.
> > 
> > What do you mean by "reference"?
> > 
> > CVE-2023-1192 points to a patch for a totally different filesystem
> > (ntfs3).  Will that be fixed?
> 
> This is also stated in the RH bugzilla, that the initial patch was wrong:
> https://bugzilla.redhat.com/show_bug.cgi?id=2154178#c28

Ok, so what will RH be doing here?

confused,

greg k-h

