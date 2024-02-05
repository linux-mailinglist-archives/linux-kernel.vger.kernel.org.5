Return-Path: <linux-kernel+bounces-53689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620EA84A633
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927BA1C252B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7852194634;
	Mon,  5 Feb 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snqSwbkF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041CA172ECC;
	Mon,  5 Feb 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159849; cv=none; b=Chk79gMoG8EIT4PlaWLv4wiRCffPFqF3sYfQhATjTxsyoa+M8mt1dfvThzbJVIYZkQhTgXMwDljCYeN/hAc3iUhZC4CY7e5Q1zVg/jb66KWJTXgFe3HZCDfOdfmK6K/HsxOsrIN/3CIw83+qswETQDHcAMiohBPbohsKQ2piSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159849; c=relaxed/simple;
	bh=lE5hwhPwL9fmh995uPn3W/2zYsVXs5rlxJNIrnK0Bsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk5R0k5EuT3GVPUbCnK9VlgAHrgvpFeY6AadmqS71dxcoYu5iLhafoeNibwqLSUDzQl/n2suM/FuT0EG9mj4lR/AYdu+9MQue/fYEPjs530PUFOOa2owOoxco0KOzKjBM2TpbGouKS2gcSa2tjiUBwMppdxZed2nycuTavI1ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snqSwbkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88941C4167D;
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

