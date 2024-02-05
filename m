Return-Path: <linux-kernel+bounces-53597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AAF84A5D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC91C24FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632EA182380;
	Mon,  5 Feb 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6mBj4p0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D52159C8F;
	Mon,  5 Feb 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159838; cv=none; b=UD/tLXPeX4wsDVr7lq2dxp/7Ww69JrEs/4+9+MoIj8AuT4GI5HdajYMVSyuZf8E6cAL4IYMh8iqJFi8M/2M94DO71c07IwLgs/CBv+AsEwYBrCoy9t11Q3ElYuL7q7NRRnvKvKF6g+tyZSee04YoC5pvx2A4X6vhjV9zneb8iXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159838; c=relaxed/simple;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETMfla1PC7xOURVwbUGxuX3suPT5Sun4bcEXUM761ySKpEnOnmsvkaGaRCg5YpI/e35jNaSpjiA3VTh4lLbAHRRs0zyNlCu6ipXbuh5/pk0pkYFIVu0z4RwTq/GPbb1KcGuiBEmTmdXPNCzEFAQnZfH3PWzNucQhQDAUMNmQjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6mBj4p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C0C433C7;
	Mon,  5 Feb 2024 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159838;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6mBj4p0eZ8ZO5IHwibE7/ibG4dpevzChSRCkLFui91PHFomONcpj+dbRWmqf8syP
	 j0tVZyOzcCeSTHxpuWTMEDbgrjOzgXg1Ovcq6T3q5iggY+yN8PNSUT2ttUn8TmziJa
	 m70tmYSIyQNbzkPaIHXGZbLoSsv1pywfjTd+lcuQ=
Date: Mon, 5 Feb 2024 04:50:30 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: coreboot: make coreboot_bus_type const
Message-ID: <2024020511-confound-chirping-38f7@gregkh>
References: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>

On Sun, Feb 04, 2024 at 01:10:18PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the coreboot_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

