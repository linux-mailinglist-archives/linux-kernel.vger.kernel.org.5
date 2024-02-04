Return-Path: <linux-kernel+bounces-51774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB57848F29
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1FD1C20ECD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD022EEF;
	Sun,  4 Feb 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jea6hCph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7522627;
	Sun,  4 Feb 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063067; cv=none; b=g957X3Uh8RlpuUpKKXmc6awhtzgzlgOGN671tiIHadI8jTxav6TOqmufRdJUdngluqenipEBuVbmcwK662xk5OuoJc52ZUB/12kfVBvwBmkOLP3YAYwMr9hPPNheCbiKQKG84oYg9Tc27c8Dx0L6oYC1n9/36KrQPNlHXGKVY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063067; c=relaxed/simple;
	bh=LRijgti7aCfqqhry0DrIHo3sdwceLTI/+tRVfIFGyj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4IRWCJyqVPXgdgbo3N35DpSZVUXLd2L/muRecv7xhB0iNRMI/g3b5uRHZEghjKF/ZqRO5TnmoPzXZ6cSUXMSAnOHSuDSpFQjf81e0F/b/9JQq1ZURSAcm1Y9NcoGjGIL5ruEhDyoI6DbYTpMi8cwKYO0uLGRRDC7KnrNX9pFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jea6hCph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BA0C433F1;
	Sun,  4 Feb 2024 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707063067;
	bh=LRijgti7aCfqqhry0DrIHo3sdwceLTI/+tRVfIFGyj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jea6hCph33Xo/XNyOeiEKtbLTRTE+04foM6E6QIOfSlxQSi7K2DhL3QHywMqhZezA
	 NNyIBfMlbPO4YwSZlejqglyGfkYsavK6H/KZ/bt+79x20FLriuqXq8jClJD7f6uazi
	 IeC7IAd43otO8a6hRBsk9+twJYlBeAqCWSunLmeIpTimJop5DFI40LZQCs26v9N2u2
	 LNZVooERoJfLS3Ys5x5CF6QOqa1mZejJftvIecgOS6WvjaKL0NxEF6KyUvnz4n5WXL
	 CqBgjN95VY8A7oRSHatSRTa9oG+YxOETIRmyvKbxcOoo5oD/capkysUjtbjpE/5B+d
	 y9w43ZCRjrZdg==
Date: Sun, 4 Feb 2024 16:10:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Message-ID: <20240204161054.7d952a6f@jic23-huawei>
In-Reply-To: <20240204134415.7dad8b66@jic23-huawei>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
	<20240127160405.19696-5-petre.rodan@subdimension.ro>
	<20240127165948.518a9ca0@jic23-huawei>
	<20240204134415.7dad8b66@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Feb 2024 13:44:15 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 27 Jan 2024 16:59:48 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sat, 27 Jan 2024 18:03:58 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Add triggered buffer feature.
> > > 
> > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>    
> > 
> > Rest of series looks fine to me, but I'll leave it on list for
> > a few days at least for others to comment.  
> 
> Applied to the togreg branch of iio.git and initially pushed out
> as testing for 0-day to take a look-see at it!
Dropped as comments came in from Andy.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> 
> 


