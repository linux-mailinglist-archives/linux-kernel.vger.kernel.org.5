Return-Path: <linux-kernel+bounces-125635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF47B8929E4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75298B22208
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F223C126;
	Sat, 30 Mar 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fd4iIHGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE93BE49;
	Sat, 30 Mar 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789671; cv=none; b=HLLbO9961NaW5EZYEk6qep/nV5jFpy7Abgbr+bbRhTPv83ESbXm3k5dJIQN0agrD8kSj+kbdTDUNXir12mC5+kvxGX77xHhxM/JsGQnW+mtIhGDTxCMm0IMtZJpviNIUAOO01dW54Qzx9nTZ8QVxN19MNshahj8DGqOKglEh7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789671; c=relaxed/simple;
	bh=6VnmNSAGAFiLE3M8mHQeApQktGtJmpHdTqinfMWigZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VerrQpNEh3BMD2Ka/h40k5toR4uj+NTHlAwlbGWfznOQsgwiX1VNNoW/tGVCCpkkWoemPw8U5yfZqVIJ1neRs9LB/1/yeAuw3q6xP9jrkPnhs9jB7YrSjinD2VJtn8PNOMWRfdcz85cl95ofe3NuoHad23DqQpLvWfPNvBUXyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fd4iIHGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8790C433F1;
	Sat, 30 Mar 2024 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711789671;
	bh=6VnmNSAGAFiLE3M8mHQeApQktGtJmpHdTqinfMWigZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fd4iIHGGlt0NKLZmcZR62+3Pc0zvOZqU66nuSMGikimDqx0OzDoyRk2fm+MeiIeA0
	 BA643rtjLb5VEBNdWXNqw/Za/b3GIffv70C2Fv380iCd1xEv27mgDM4Be5pXjk1gkA
	 wqz1L6JOeEc4zBj7Oshe2CCTxOXsc9wXr6pyM1zY=
Date: Sat, 30 Mar 2024 10:07:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuntal Nayak <kuntal.nayak@broadcom.com>
Cc: stable@vger.kernel.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com, Yangxi Xiang <xyangxi5@gmail.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH v4.19-v5.4] vt: fix memory overlapping when deleting
 chars in the buffer
Message-ID: <2024033014-deception-cartoon-7470@gregkh>
References: <20240329191208.88821-1-kuntal.nayak@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329191208.88821-1-kuntal.nayak@broadcom.com>

On Fri, Mar 29, 2024 at 12:12:08PM -0700, Kuntal Nayak wrote:
> From: Yangxi Xiang <xyangxi5@gmail.com>
> 
> [ upstream commit 39cdb68c64d8 ]

Please use the full git id in the future, it makes it easier and our
tools want it that way so that we can tell the difference between a
"Fixes:" tag and an actual backport.  I'll go queue this up now, thanks!

greg k-h

