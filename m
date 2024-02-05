Return-Path: <linux-kernel+bounces-53691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B584A637
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44450290932
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C9194E20;
	Mon,  5 Feb 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KxrEQzzt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63740173654;
	Mon,  5 Feb 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159849; cv=none; b=IpjNX7VqURK9x5S4h2AXOmVcafmSGeYqeNO6oub2GHqrDPZdT9HH5FphzzKBl4DY8I7gzHOnXkbDkoLulDg8Nmr3BqcuElivd8S1FVYqdCLR93ho7GWp32YAgThgclVgCIgh5b5jP5H5VRyCker18vixj5kuIrNJ8NuvFpEeozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159849; c=relaxed/simple;
	bh=lE5hwhPwL9fmh995uPn3W/2zYsVXs5rlxJNIrnK0Bsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk5R0k5EuT3GVPUbCnK9VlgAHrgvpFeY6AadmqS71dxcoYu5iLhafoeNibwqLSUDzQl/n2suM/FuT0EG9mj4lR/AYdu+9MQue/fYEPjs530PUFOOa2owOoxco0KOzKjBM2TpbGouKS2gcSa2tjiUBwMppdxZed2nycuTavI1ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KxrEQzzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC66C41639;
	Mon,  5 Feb 2024 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159849;
	bh=lE5hwhPwL9fmh995uPn3W/2zYsVXs5rlxJNIrnK0Bsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxrEQzzt7jRf2mzEYTC2oqGCAIw/4bV7fvZX54drm8bp0gabzLql9L82b9rhVB7Is
	 F3fSLsuNLrgZJJaU54XC2M/xHqKRutz2pY5ns9zZMsXe3hmw65oCvHcWhZ8cd8s3B+
	 njeKxGAoP9h+jzuAyp+zcvsvoCBf88S2d+/ppzsw=
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

