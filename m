Return-Path: <linux-kernel+bounces-53671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0284A621
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA72E28EFFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912E190F28;
	Mon,  5 Feb 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHpdkH9t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA92171120;
	Mon,  5 Feb 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159847; cv=none; b=u4reFT7oE3CHTMvaNkcERhG9yORd9412Ou4rCpm1NpgFasrvOU1lsQ6rebvGu8qIVGr96FWyYBgA0HaXtfsI5VyTDyhuXbgCGlMb9GQepymzULJCGlP1RZBHB3+2tUbZfYpTr8qqoDzazrfGG28ZzcDBZB3YstBnbs8mlhv+M0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159847; c=relaxed/simple;
	bh=sZ9TJFqD7g8XKsIhoCMPXGeKJUZSP50HX1EyzPXNSyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCzhU3cwPrqKjor4FnAwvwhMAwj7Kp4E/BXiWO8aep1yA3au4xorbgJA9Hwg6tPk2PXLDCVhtfwqRR4dK1uhMGxQboPzCoEzcrQhkx0Hl7IN6OQd7do1S0QPAVG7I0sFPpLnY7wgBvHh2a8QcDsQzMA2vlYAmSGSosSshwp6vVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHpdkH9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516BCC4167D;
	Mon,  5 Feb 2024 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159846;
	bh=sZ9TJFqD7g8XKsIhoCMPXGeKJUZSP50HX1EyzPXNSyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zHpdkH9tm8WostZu5lmM6WB2VwoNZ0UEpObwBtu9ud8yyVHaWsR5+2FJVl0kuQzUd
	 8EaJsGQM2/w1xHmXPr4cRM8vzB6shJum5prsZNMd2mizXYO0EceNGAgZdGB81DLmTa
	 kpisenFadMCwYzb+eDkwWstnvi88GqO67pf9ymvk=
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

