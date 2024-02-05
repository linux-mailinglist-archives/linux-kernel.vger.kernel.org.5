Return-Path: <linux-kernel+bounces-53465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF5F84A459
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47439287A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E781420A7;
	Mon,  5 Feb 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kuVtu3T9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F2135A5C;
	Mon,  5 Feb 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159822; cv=none; b=fzU2qarirB2CNig9Jri3BvtiITIu/Qd3pzjk4wJVib4yDC/KxQTkELWI+3uXYmwrvkhqwoOxC/QPI91lDrCYNkJqlvYelYFrnQ+sd/jy+l07FIsQSw0P3eB/2C5kpEGz/X2dAvpzQYccIgCbtnXl11WpDiP2vDsU7fsTQw/7iUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159822; c=relaxed/simple;
	bh=r76aFwVlhx0f6YcO/hvdE8UgF2/b55hZ9n+gn3+rVR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfHJMJ/abhs8n4u43BJtmEkZ+1FCxMFzjJ/WSQplkre8XJwvghqd8K4LiBOzwiHh85U87fBwbfJdjJ760ATF+LMwOoJ/ho0YNplV/uvjfRt4hUYTojSnA1Ph9+m9VxI5+aSrSYo3WGPth6EjjpwPfYGJFVBAhzNFm0XEL9ZmMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kuVtu3T9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3979BC433B1;
	Mon,  5 Feb 2024 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159821;
	bh=r76aFwVlhx0f6YcO/hvdE8UgF2/b55hZ9n+gn3+rVR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuVtu3T9O9CIPHyw33GhhyB3qES1zln91hsN3uFYOPcjddK3JGn1cG+v75IimLA5p
	 p4EZoEhbt144naEm+pn875/zhFYfA2iRwxYMe+pZP5uqK8gc9fI74qKwjw6Flw9fLv
	 Zw5llLI8cvznhqMk+A2Hxiw3byN8I7VL9fHzuswk=
Date: Mon, 5 Feb 2024 04:49:11 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: gameport: make gameport_bus const
Message-ID: <2024020506-update-hardiness-cfc6@gregkh>
References: <20240204-bus_cleanup-input-v1-1-74c2438801cf@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-input-v1-1-74c2438801cf@marliere.net>

On Sun, Feb 04, 2024 at 04:56:34PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the gameport_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

