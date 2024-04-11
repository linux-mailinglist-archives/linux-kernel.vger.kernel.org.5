Return-Path: <linux-kernel+bounces-140327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86208A12D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D81F223D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F9F1487C3;
	Thu, 11 Apr 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIA/LJI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95D2EAE5;
	Thu, 11 Apr 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834390; cv=none; b=OBcA4tOlNyqhWdGeXv670lFt9hq9jTSmH8K5pLPqHWEq0CmLbWAAfcu2hiTIki3MQipXR7HxTr1QMWM2cisXMiJs3dumkyazF4CyXxKJFmjhfCsYZzZYy1NvcnDgeppAr3niTNEXhaocJcMAi6YNqL+r+dO+HYDipUQjw9/jj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834390; c=relaxed/simple;
	bh=4+EX1O3OUBUt+DgU/WACpEoYvw2h6K4uULYp0k19JXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbbQRbWoRxZORrWayAIRmdl7lH4Vd9WEH56yKGdJigJQxnWfI8etg/MIdlAL0Jjs+di/b7/VEcK7jyv/T5mS2XxFcg7FKWeWyV2uqiHAF+segJxt+7tE7SxfR9rzwnkMq69DPJn0G2CUEmRjR3JFbSPeq3U0c8wk273asm4TwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIA/LJI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349BDC433F1;
	Thu, 11 Apr 2024 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712834389;
	bh=4+EX1O3OUBUt+DgU/WACpEoYvw2h6K4uULYp0k19JXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIA/LJI+zJdGrQ27WbXTxnj3Drl45G+ckOWj7QXHJ28hohyQsquVOW4Eh5+nSGZ7S
	 /tIDg8nTcBfX5rJn6Xrk94BMTYC2te0jIWhkhPPC1p8rAq+psDMICVUV3lqd8McVxH
	 YYmZtr7yZa/qdnGKj/2u5/lT5s2aQkpyQhm8z294=
Date: Thu, 11 Apr 2024 13:19:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Rankin <rankincj@gmail.com>
Cc: Linux Stable <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
Message-ID: <2024041125-surgery-pending-cd06@gregkh>
References: <CAK2bqV+kpG5cm5py24TusikZYO=_vWg7CVEN3oTywVhnq1mhjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK2bqV+kpG5cm5py24TusikZYO=_vWg7CVEN3oTywVhnq1mhjQ@mail.gmail.com>

On Thu, Apr 11, 2024 at 11:38:36AM +0100, Chris Rankin wrote:
> The SCSI sg driver oopsed on my 6.8.4 kernel, and I noticed that a
> patch (presumably) to fix this was pulled from 6.8.5. However, I also
> noticed this email:

Was that a warning or a real crash?

> >> Reverted this patch and I couldn't see the reposted warning.
> >> scsi: sg: Avoid sg device teardown race
> >> [ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]
> >
> > Fix is here:
> >
> > https://git.kernel.org/mkp/scsi/c/d4e655c49f47
> 
> Is this unsuitable for 6.8.6 please?

Is it in Linus's tree yet?

thanks,

greg k-h

