Return-Path: <linux-kernel+bounces-62254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B989851D94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7F61F23CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB8745BF9;
	Mon, 12 Feb 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ey2NMHq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321F4C99;
	Mon, 12 Feb 2024 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764810; cv=none; b=AWylv5fT2bv8XRbXtShoTZj4xnCgBl1RNniMHUd4bMYVKnYoGxunNmMIygYUMnIuGOYmRDJ5NvEpqad0PWqlmONUlrxrhjHEVrHwOxnrc8DmOkSGCanGYGWm4g0pqkzpKKu7OedFOEmUnSC9J8Ig9EYR1CmgO8GBZyeUBwwNAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764810; c=relaxed/simple;
	bh=U10PgycHW1GIVYu3rtS3Aw8K64X37bzdCMH4YrSDosI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdGhI67zDcWyjoFDA5Vb9ab/qyP/JWUN/P5LE57x7L18m8+d3GnjppvNOYFgNn8mvdMA9Gb2c9BZcdoQDmymf1qLX9ZDcOfJV70hX5a3ZtQ1tN1e9Pj8JE01fj8MFp35608FZAGf/kbta8ADWATBCx46S4bwR+VU/V8MJzWINbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ey2NMHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6D9C433C7;
	Mon, 12 Feb 2024 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707764810;
	bh=U10PgycHW1GIVYu3rtS3Aw8K64X37bzdCMH4YrSDosI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ey2NMHqa2U4WQrWZVu4RYEsBKdthlEoNX0Jhq4k5KHiA3C7xBkLsp3CrR+Wagbv7
	 KJp/XrmZvHOX48MoxykFQiZqT9roI+ps0poRun5OIDmXHl5yNd4O50qoV2ULGrXyQl
	 kLnZM+3AMUnl/itmZbPhHa5hpJWBb0kvnDCzln1s=
Date: Mon, 12 Feb 2024 20:06:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: Make scsi_bus_type const
Message-ID: <2024021237-vista-botanist-b927@gregkh>
References: <20240212-bus_cleanup-scsi2-v2-1-65004493ff09@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-bus_cleanup-scsi2-v2-1-65004493ff09@marliere.net>

On Mon, Feb 12, 2024 at 03:38:37PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the scsi_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
> Changes in v2:
> - Improved changelog to remove the word "Now".
> - Removed unrelated whitespace cleanup.
> - Link to v1: https://lore.kernel.org/r/20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

