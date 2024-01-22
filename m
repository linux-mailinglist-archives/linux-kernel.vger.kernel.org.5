Return-Path: <linux-kernel+bounces-34054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB2F8372CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A7B297B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88873F8E7;
	Mon, 22 Jan 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBQE1dku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259C3D553;
	Mon, 22 Jan 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951738; cv=none; b=MLImWd52MicpNQwFWkESXrSfe9K+3C2p4NU/YyiYnaXqMkyxl6qHEFspUoR1VNRTRF8ySOv2xXH+jN2DCevvxr6lOOomCuK7m3yvWFTzX25NVyPXDp8eaa5E3yvJWuko95XTlu+CARKnqDaEzmkAH92h3y/Uqv/Wr7YYlpZjFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951738; c=relaxed/simple;
	bh=afe/agwweDEq5hliJJTGqCqDN6ZjHnZaGXWvzUFYsU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn9X3eswyKfIDJgVnkCGzcJxm5JojVD8XM/lKR0OvC62MvBgRf/Z8ybG2xJt2Sm0KAHrv4DPbF+TCzN0uhiok62X/vJtDh05BBvkVyNMJaX+LLqwBQOJPxT/rDvdexzbvB16xyzxB9wzRK3l5vYGU97AGOq23PLYrgI3EYZia88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBQE1dku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB792C43394;
	Mon, 22 Jan 2024 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705951737;
	bh=afe/agwweDEq5hliJJTGqCqDN6ZjHnZaGXWvzUFYsU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBQE1dkuhEfL93TcJEEBBJ8/xouUb6xnNbHHPRX4FZpR4wORc6+Hxhwufl4uXyG9N
	 ujO909y+zv4YV89rXPmNeoC4xFjVhav9s5WneBYLNaof0vne1fiYX0rITrjJtcl+JP
	 ivaU+jwxkBOdBuHH5v3P3pgAd0Q1Yb+1KlSY8gqx2spd01xM1GJoQGQRwznIcfilWb
	 Bbfrw18WipbGdoTzVwQnY/FPDTAlbxDof+tn7lG5ZOPODSUIwR/itpsqYMtvoJAEsF
	 Yd3wHjPLZgE4QxkzF302iwZ5Ixk1ApA1Ep1c+EkNKGipVyFAR6Pnrm3vQR6kEgYIgq
	 u0ykUxtrKq9wA==
Date: Mon, 22 Jan 2024 19:28:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
 jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] adding support for Microchip PAC193X Power
 Monitor
Message-ID: <20240122192844.61b370ef@jic23-huawei>
In-Reply-To: <b7dbd5fa-b300-4d6d-b3fc-8cb8e90eefa3@roeck-us.net>
References: <20240122084712.11507-1-marius.cristea@microchip.com>
	<b7dbd5fa-b300-4d6d-b3fc-8cb8e90eefa3@roeck-us.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 06:57:32 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 1/22/24 00:47, marius.cristea@microchip.com wrote:
> > From: Marius Cristea <marius.cristea@microchip.com>
> > 
> > Adding support for Microchip PAC193X series of Power Monitor with
> > Accumulator chip family. This driver covers the following part numbers:
> >   - PAC1931, PAC1932, PAC1933 and PAC1934
> > 
> >    This device is at the boundary between IIO and HWMON (if you are
> > looking just at the "shunt resistors, vsense, power, energy"). The
> > device also has ADC internally that can measure voltages (up to 4
> > channels) and also currents (up to 4 channels). The current is measured as
> > voltage across the shunt_resistor.
> > 
> >    I have started with a simple driver (this one that is more appropriate to be
> > a HWMON) and willing to add more functionality later (like data buffering that  
> 
> Not sure I understand what you are trying to say here. This is obviously an iio
> driver, not a hwmon driver. Any hwmon related concern is irrelevant.

It's a left over comment / attempt to summarise the discussion of whether IIO
or HWMON was a better home for a driver for this device.  Based on current
feature set that's not an obvious decision, but there are other planned features
that fit better in IIO.


> 
> Guenter
> 


