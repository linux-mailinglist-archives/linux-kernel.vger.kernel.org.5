Return-Path: <linux-kernel+bounces-51702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99312848E61
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DFF2814B4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689F225DA;
	Sun,  4 Feb 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TbkBN+4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4E225B2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056696; cv=none; b=tYbw+dzGVeKKF+6xrmPZWbbSUU7Cds2xA7LWpeHVfAcurcZqrMkHOM3fUerFghfDhDOeHiMMrs9Nrl8ZM8jfTYmbUEDlyRciMBIaz3Xx1YrAPpNnTzBYBOmyQ1WTWl0cGJzr0+EJzc8LJLi2AgDYPtMxndCUvIsYL8iHlxxSmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056696; c=relaxed/simple;
	bh=H0nt3qI1t83nU7+JSx8OAbCd+boUT31iNAWXTNEOjuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvlI31plEMuuBYqPAGFGT8CuWt/Z2wsF3Obu1mj5g3eSpEFv8DAM7Yszb+X189JT1Um4V+2/vP5VsKvvN5s71JeCDhFkLKQ3OrkxgXRYA1MAwScxtLKHD0MSyRPRJcPHNuCk771WzVTtD7f1fTsTTBJDakdAQkoAitM0q5DzECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TbkBN+4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F81C43390;
	Sun,  4 Feb 2024 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707056695;
	bh=H0nt3qI1t83nU7+JSx8OAbCd+boUT31iNAWXTNEOjuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbkBN+4hQTO5HxHO6IVRW2JczE/paMHuw7THJmrA0477NIl8lWHnK3Y3QJJNU1Oux
	 xujJ/oIlHaQ7G4MwDfL3dS1/TiRg9E7ITw68MQy+xtUeqquQFaULrTkvdn3HkZnmEo
	 DqaJlr/CF30up1QbvAGNm9ZUz9hTDqcJ5Z2FDECs=
Date: Sun, 4 Feb 2024 06:24:54 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory tier: make memory_tier_subsys const
Message-ID: <2024020438-dingo-likeness-572b@gregkh>
References: <20240204-bus_cleanup-mm-v1-1-00f49286f164@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-mm-v1-1-00f49286f164@marliere.net>

On Sun, Feb 04, 2024 at 10:56:44AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the memory_tier_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  mm/memory-tiers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

