Return-Path: <linux-kernel+bounces-53469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D934984A45F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DB91C23994
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA0145320;
	Mon,  5 Feb 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p9a7LHER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9A136641;
	Mon,  5 Feb 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159822; cv=none; b=As8yJkx8l1ZJni64JGLuRizYYjqCfBKe3gA5+S7ijOMvn25q2WFyjVs1CGgVn2aSmxMbP+t32hAXo48AO/5ZhZA7nT5yqAlT7fD0TzHZI3HtvQaAnI+rhJJqhxyBgadOjJdHrKGCSdSnb6eBQKcXHie/LXQcKdbypjNt4usIBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159822; c=relaxed/simple;
	bh=r76aFwVlhx0f6YcO/hvdE8UgF2/b55hZ9n+gn3+rVR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfHJMJ/abhs8n4u43BJtmEkZ+1FCxMFzjJ/WSQplkre8XJwvghqd8K4LiBOzwiHh85U87fBwbfJdjJ760ATF+LMwOoJ/ho0YNplV/uvjfRt4hUYTojSnA1Ph9+m9VxI5+aSrSYo3WGPth6EjjpwPfYGJFVBAhzNFm0XEL9ZmMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p9a7LHER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1496C43399;
	Mon,  5 Feb 2024 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159822;
	bh=r76aFwVlhx0f6YcO/hvdE8UgF2/b55hZ9n+gn3+rVR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9a7LHERAiyCtAIL3HMvi1hYqBXGtexL14bxhhccANy57OTwBBtKnlWJaXEDco/er
	 2ZeRQekiq0bKJo0aXdetJR+OPWaCmFFBhGF2Kl69uRQEm9T4ZBl/VffnH343cZyyj+
	 MsVS41/8dAe06JefiYGmCsL0erheMbE7ZRN3Lxd4=
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

