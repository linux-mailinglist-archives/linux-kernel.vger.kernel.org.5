Return-Path: <linux-kernel+bounces-53284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19084A30D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697F2286B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C364F8BB;
	Mon,  5 Feb 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZrZtegeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376954F616;
	Mon,  5 Feb 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159775; cv=none; b=ukfcxJtkQXaV0q5x30t2KPEQcHT709zoHVoZ9Be3QEM9H6IFFIl/JLm65ZHFV6qQCQxM73RrPwF5mXJ6dS0EEyohg4MSqpR36AtAwRg966PIiAyUJKh3cCqdLoJ6BHuOUKyWdUkSFZjqHkA6/eoq8ktDTR394gttZ3Dbi9cd3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159775; c=relaxed/simple;
	bh=ahF3cXBPBvE5YZU15bdesla+Jh6D/oIfrgvYM6Qeb0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZwS2BFdf479a40HuOl1Qa9dOJjGfsSfmqNQzSm9yEBt9KzvRqi54nF6091Ef66Q7od/IH2NC4NHW0ThCbDwE8TmkBXsL5G++y8Q1mzNqVj5ZiqqwTxFSoSLvOyCFYBiSmUbqmkK0Eeek/bO3wtBPtrJmL6W90+yoMsGlSlVgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZrZtegeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DC6C433F1;
	Mon,  5 Feb 2024 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159774;
	bh=ahF3cXBPBvE5YZU15bdesla+Jh6D/oIfrgvYM6Qeb0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrZtegeBayuKkF0bB0DxpdnHBuUK5zGgzGoIb6Mt3pBKch+121QLo9D7o4H5CPP/W
	 VhAhLuX5WWtR5WOQ5kk2dJ2MgpY3oecsqYCNFeGOskL5kNO9U4F93yQ4gpZmSwYfn/
	 dZj/3y0WcAmjMWGfDgCXwHGiPOQRCoi0BfcH5NaY=
Date: Mon, 5 Feb 2024 04:45:59 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcma: make bcma_bus_type const
Message-ID: <2024020554-caption-elite-ba36@gregkh>
References: <20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net>

On Sun, Feb 04, 2024 at 05:57:23PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the bcma_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

