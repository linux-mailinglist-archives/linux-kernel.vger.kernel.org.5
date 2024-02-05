Return-Path: <linux-kernel+bounces-53687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DE84A630
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76DF2906B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5278A193EE6;
	Mon,  5 Feb 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snqSwbkF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD521726D5;
	Mon,  5 Feb 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159848; cv=none; b=NLTO/GjJOmhIlwY5BrBMZGe/hjBvmKTm1r/3s6z1DVK6xegy8kHV3QLS+JyOtxLOiElVrrJCCpW8am+oK7KXQuVjOdAAc4lSqH7oX4jdFzF6Y8D4rWdtI6xZtiudmfZRz0EvV21/S8MosLeKFp23WUJO39A8Sk2yw0Plz4FPl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159848; c=relaxed/simple;
	bh=lE5hwhPwL9fmh995uPn3W/2zYsVXs5rlxJNIrnK0Bsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMxaETT4e30Zs7Qvo3j5lIg6ryZQIyC5NWDjauzjw1uSNIOZ6oeAM7XkQLclL68ydUz4oPq7dvN4zfD2vPy9+eP+cVx5mP3nCU9LHSld21gqVA1Z7fLyYpSXxnF+DKN8p8SFYvYajdhhBYkGuKJ719ttksTG5uaz0bluLvlzMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snqSwbkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DFDC43143;
	Mon,  5 Feb 2024 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159848;
	bh=lE5hwhPwL9fmh995uPn3W/2zYsVXs5rlxJNIrnK0Bsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snqSwbkFoG3IE3u5R6ZuZGjsCrya9ixTszmxievLUy+kdBOINouw5OvP7Wz+Q/rnM
	 YdCbTuyg+xEoJmoJWdRyeO3vdBwcLKtktVgwvhOlTdlJmc7jdDn1/zeqJR5FwPti3o
	 8ZazDKHCChx7m9ag6jiAQnSkA2LLx3B6UATvbJ8k=
Date: Mon, 5 Feb 2024 04:51:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: rbd: make rbd_bus_type const
Message-ID: <2024020509-splatter-unframed-4960@gregkh>
References: <20240204-bus_cleanup-block-v1-1-fc77afd8d7cc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-block-v1-1-fc77afd8d7cc@marliere.net>

On Sun, Feb 04, 2024 at 12:31:42PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the rbd_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

