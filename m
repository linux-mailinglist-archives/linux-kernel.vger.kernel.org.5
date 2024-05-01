Return-Path: <linux-kernel+bounces-165155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2445F8B88C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E7E1F22CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7895754FB1;
	Wed,  1 May 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oa9qVzoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874064F881
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560506; cv=none; b=CpdXESKLz18JJHGb5oQIu+A4OG7ZJdlYyp1BeWBtLKmlDG6xbo6Ljq82b1lQP8NjW2xnz8jpuNQ0gKLz7hPGZplpur1rvXXVZU1qp3UnmNpG2qYqMVqOach1TUVeCG2/FZXBPiD/Tg7LGclqjJbsLrjEOxxLw+StWq1K6rPb++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560506; c=relaxed/simple;
	bh=u8/DS5GSXb3ZHLL3dhK/g3K2193p6Ah5X4cQgkYEVvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlJhCbGWTMgzBoYWt/kS1s7y6BfL0wU7bkmo6DFVXR4a3PwO0j5OEB0uSmFrRnjrYr2YY/I/uUU0skuPJwLZuqiFC9o5P50ORd6ZAlB2dbz6gqWn/veLL96akDCrUpURxvE+mFzfzfS5HuSa0lsjyaEyk5m2XVqHN1FRjpfae/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oa9qVzoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F983C113CC;
	Wed,  1 May 2024 10:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714560506;
	bh=u8/DS5GSXb3ZHLL3dhK/g3K2193p6Ah5X4cQgkYEVvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oa9qVzoJg94MPJEDY0dfV9floXpjMGW0z4sXguE5d0R8sjNxiTuUqzP8qQCFxZKPa
	 JUM5bpJBZUTdLQeAXlOWw/ABWPzDo0yuYjqvMhFJNSijox2dtghOjqEkwIepAp1Ghw
	 mUO8MJEEQzy5jePKJG0jB0T/EBl6e1QmkS3LX0OU=
Date: Wed, 1 May 2024 12:48:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: sudeep.holla@arm.com, javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
	rafael@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2 v3] drivers: use __free attribute instead of
 of_node_put()
Message-ID: <2024050102-reshuffle-licking-f84e@gregkh>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240501094313.407820-3-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501094313.407820-3-vincenzo.mezzela@gmail.com>

On Wed, May 01, 2024 at 11:43:13AM +0200, Vincenzo Mezzela wrote:
> Introduce the __free attribute for scope-based resource management.
> Resources allocated with __free are automatically released at the end of
> the scope. This enhancement aims to mitigate memory management issues
> associated with forgetting to release resources by utilizing __free
> instead of of_node_put().
> 
> The declaration of the device_node used within the do-while loops is
> moved directly within the loop so that the resource is automatically
> freed at the end of each iteration.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
>  drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 30 deletions(-)

How was all of this tested?

thanks,

greg k-h

