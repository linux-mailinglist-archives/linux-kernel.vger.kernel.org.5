Return-Path: <linux-kernel+bounces-53286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34C84A310
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF8B27F8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B85027C;
	Mon,  5 Feb 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndC4fOfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE350247;
	Mon,  5 Feb 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159776; cv=none; b=BbllyHATSG8BLXibxQ5bRmzWm9tDjTIePEjOR3gQ6/mBKvwE8lEYv25yfCFYQrUfszCgYW0kjaqwv4rMb0b7EoMBf+Ka530YzzgY/CFUZOZWje43W4Xxk4SEN5ICB0f7ag5wQRVVIfpPj3ZHcJ3Ocxy/38jF8zLXJNJsW7NNHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159776; c=relaxed/simple;
	bh=ahF3cXBPBvE5YZU15bdesla+Jh6D/oIfrgvYM6Qeb0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8TVzr+vlJ3eqpspkGnegQZOAUc8Wuy8lXY2dAbF3WrAnomXNPj+8wJpcCyo87o24CcjlOf0YNsSf1BUDpuqE4FeWSU3CBzgrG2mn4SSxS+3kmepNWWYA0StErpckMUKTuV5+ufQesZ28NJ1cUQkp6tHF7HoCJ/XJelHlJqxYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndC4fOfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619B3C433C7;
	Mon,  5 Feb 2024 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159775;
	bh=ahF3cXBPBvE5YZU15bdesla+Jh6D/oIfrgvYM6Qeb0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndC4fOfG+vIwp84oVqpsJtSprhqWeafWi+QA/15KdoSMdb7LpSIxF8iUjgHL7oz6f
	 BeTltkEoHLfIiXUXncsNOoIzKjZUeYDvO1JxVRHB2vYHTzo+a+3Pxqv58tJOrAy2xw
	 gHtOvxZ/A3iIVE46r9+a522svPfBBUBg/CJl8+fI=
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

