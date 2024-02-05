Return-Path: <linux-kernel+bounces-53446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A4384A432
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6500B293BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AF13A861;
	Mon,  5 Feb 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZLI2HJ9o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF31332AB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159818; cv=none; b=d9rcsFFNdvR5MQJMStjH9MH8cwNp/GEqQXPmV/4wo2b3JHYU7Rl5GAHqYx3FGgxuyZ4fme9tZGPHW2R76UU7helnOrdcaMGbrG2BhLRCqc6ls+59gGQU+8z/aCZBvLCfhDJpzYRzArL3uDbs4FNwgUpxwN1L+kuRrTfkOCdoufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159818; c=relaxed/simple;
	bh=mAFr7rgIiDDs3owlqHD04xWyLOAFyYWies7SJEVVNg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUK1oej8BfO4MjnQ1tVxavLlTXr7ywSk9T30OiuJN46cTk0PTZIVt7ZAurrYs9JUXcQ9ETt1FCXD/GY+AFR2pRjl35fjVdPJALOKYzTYF/DCRjVQImtNEITDp3jvLxU7f9ZmQPkAf0tevIRWVcp1Dp0oDmkgJe2kvb3uwtot7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZLI2HJ9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C5BC433B2;
	Mon,  5 Feb 2024 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159818;
	bh=mAFr7rgIiDDs3owlqHD04xWyLOAFyYWies7SJEVVNg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLI2HJ9ohu8l09Iy/TXE0GRxZ32gCpMTZ3YvrTKRo6j3f/pV9yNbFN5SOFQQO5Tve
	 byfAx2tTGX2xoez4kPuW9XeX4MI4bjEdWs4MZAaE3Y38j5ju8m+7nUlaZDAk9Azozr
	 28t2b9jPP0/mukWl0OFcbr6zb+aqDKy3irPZpVpc=
Date: Mon, 5 Feb 2024 04:48:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mcb: make mcb_bus_type const
Message-ID: <2024020553-overtly-overreact-ed57@gregkh>
References: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>

On Sun, Feb 04, 2024 at 05:03:10PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mcb_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

