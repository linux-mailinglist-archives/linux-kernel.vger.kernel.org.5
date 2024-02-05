Return-Path: <linux-kernel+bounces-53661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1684A616
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123BE28CC96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7BD18EF8D;
	Mon,  5 Feb 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtlkKLuj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34516FA33;
	Mon,  5 Feb 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159846; cv=none; b=sEcdQAtFXpprQq9X6VHZ9lvIfPwjZ4Hg+SABbwZX4P/vF1vgM3i3DhAfHzQOtxxFQwnHe4rI7jxDGOwHSpGerpjcShgj3tRx49A2jkw7vJxLiG25FXCnB4ur6OYcTxSrhy+n43zlzLMRUgJVJ+hiqR6O7DDGyE6AAOkgqlMocNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159846; c=relaxed/simple;
	bh=sZ9TJFqD7g8XKsIhoCMPXGeKJUZSP50HX1EyzPXNSyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRoW9dXF5emQ5m1cNkZcu0qwGFtW6iSSJI4it6eIxMbo/V39+Grl5cHuokaMv+vaeyB+mvkTPtyY14AQl2XQdpNwV3Z0+YP9oo34NKD6qIbfXE61ayPXEYIFuAACXXAFF/29SEmbWiQXWCNBf8MM3I1memMTj+bAnNOBXDfdN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtlkKLuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65916C43601;
	Mon,  5 Feb 2024 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159845;
	bh=sZ9TJFqD7g8XKsIhoCMPXGeKJUZSP50HX1EyzPXNSyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtlkKLujrdzq7hd2i5q7nuQZaCAczw7YI2FOpAZULNBGOZeHyq+FZ3WdtnQDVEwlx
	 lmk0gQlQBI0gJMm46GjfSoZJyqEch1fLPqcqVYRFu7bUShUrX2k5o93uJCNsP1/E28
	 FbrdHr5oEtsXVztHKZdZFicUC60Ss6xV82Ez9qGY=
Date: Mon, 5 Feb 2024 04:50:59 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: sunxi-rsb: make sunxi_rsb_bus const
Message-ID: <2024020550-stipulate-washbasin-42a4@gregkh>
References: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>

On Sun, Feb 04, 2024 at 12:56:44PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the sunxi_rsb_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

