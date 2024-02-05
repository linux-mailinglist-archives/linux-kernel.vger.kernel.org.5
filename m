Return-Path: <linux-kernel+bounces-53675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F63E84A625
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04291C24C41
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15209191F68;
	Mon,  5 Feb 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A3IvZEL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849DE171159;
	Mon,  5 Feb 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159847; cv=none; b=uETEYkwU7rIZiV2Ec/Nb6gwV4uv7Eddg8h425gl64kjAsOu65ggT7pJzdxNXe2Clq9LQ1Pv9Cg5GrXAhizroWg1Vj6x30Vshv5RrNf6BhdOBMU5x5A4S2i0fmdbXhKSJuXy8fFfj/wT4q+N8Zafa+cJ0ZyZLxsDA682v19sbsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159847; c=relaxed/simple;
	bh=lE5hwhPwL9fmh995uPn3W/2zYsVXs5rlxJNIrnK0Bsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rliIW3t5Z13oyDLSmNHp/0RwfRGKA8eVfwdmFn/d6w3b2qQ42JziU4+6rHDrcBFc3v91Rr9+MkUyjWIFy8narJjm6qJJSZCzC40fg5n5CurWCT+hgcTVlDJIf5mWGZyLZZ9JjPpx4zh8Le4M7u0Yy/G24lWUgL7gQht1xnicub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A3IvZEL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177A6C43143;
	Mon,  5 Feb 2024 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159847;
	bh=lE5hwhPwL9fmh995uPn3W/2zYsVXs5rlxJNIrnK0Bsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3IvZEL3n6TtPUW3M39IuyR4AVXH3p48OjvuxZxtDR00mTQdvoU+knLdlCnWBK/1y
	 5BWxb5mY23CV7G7OQ51ct7cjodSjz5YAVwO7CJ/O84c5IiyKsT59KHPHiEujqEFFOY
	 IFRnZaF8DRvPTsnOM8I9upKec1sm8ALki9MS1Obg=
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

