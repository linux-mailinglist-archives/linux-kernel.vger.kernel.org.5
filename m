Return-Path: <linux-kernel+bounces-53538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493D84A509
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722FBB22E88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE88716431E;
	Mon,  5 Feb 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ikQn3nNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01C14A0B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159831; cv=none; b=mOpMg854onuTZ3UbsO7XU7jQlkH3UIrhRxyOSW+M4TiBxYtMqIsFBFqJSH5Z9HHMs4IMIagJGJkdo61jOwHgBaYa6Dz6ASarF79th8j5WYmZ7zXHZFxSvPhHJ7A9UNIGTbaPRShvpx0wSDQVA87/mVUF8wNbtMOCQBpQSi0Uo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159831; c=relaxed/simple;
	bh=CmfGjtjNGwPPR52pDEpS6eNjFtN2FcZ9H09650pl6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk8Gj77IY+HhSSAt5Jm7CgmIvrvBLE0JwUYSqNBE94ksDowXWp3fPdvuMhmnSK8ioCeW0uOOwmjE5mGn6S18WkUg9VWSY4ESKjpj64c/V4nZY28HAl04QDgywUYguUMM7JMiOrGv9XCkKZsMKaFy0PwLUOojXOdwTB5lOjxSoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ikQn3nNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71BAC433B1;
	Mon,  5 Feb 2024 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159831;
	bh=CmfGjtjNGwPPR52pDEpS6eNjFtN2FcZ9H09650pl6P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikQn3nNMFJ8yZZ2SUeqMxeMxYpX6THIE7po2QgUvBlrR17YGVJmKVix2JwGqycpLp
	 aFMScYdVRNUV2MYzDVbMPgIdgMVMMUezHkj1KJwXyBDXWmoOLZDbUPJh4whJVfukj1
	 DsJ2XgzEuMenFtvz69quz/FrZ8jN2NAIvH38zwFQ=
Date: Mon, 5 Feb 2024 04:49:39 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hsi: hsi_core: make hsi_bus_type const
Message-ID: <2024020532-value-coronary-03c0@gregkh>
References: <20240204-bus_cleanup-hsi-v1-1-f9318131e842@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-hsi-v1-1-f9318131e842@marliere.net>

On Sun, Feb 04, 2024 at 01:32:13PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the hsi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

