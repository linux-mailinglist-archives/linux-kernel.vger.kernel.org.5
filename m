Return-Path: <linux-kernel+bounces-64022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323085390F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0651F24750
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075876087F;
	Tue, 13 Feb 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iSw/j0qz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3460887
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846874; cv=none; b=q7C4JAXpvGvw8tomwIe0x7AXQgJZzdFOYaywNptJ2t/ospBR4JK6nF/6iBkc1qptRTikCtXQ5v6GQa5MDUTz8GFUeQkRpsBL8ETLoYy3pxdKT5eagsHq1tGk2t90exEl6wwytGgejWrnUOJMooiG2PUCz+BgxS5fdjqag5K07S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846874; c=relaxed/simple;
	bh=WnODBy2blzmvHngQHmpNZHGvdFgTs41XisKkWph97Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyNgM1Sog68iHz8H4OaDxjmonwMNJS/drTKWFf9wL7WgoKfLrC5yh977P9+M8om+k/glbaKgYL0GTKXcR3ZCOVYTUmh8EThvCfW70hUGFH8rTtZ9kj+Eomyr5B2vC0sq1UcNiEfNcqRzZhYO7Ai1O8aOP/Vg7h4BdFkMyb/M87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iSw/j0qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A7CC433C7;
	Tue, 13 Feb 2024 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846873;
	bh=WnODBy2blzmvHngQHmpNZHGvdFgTs41XisKkWph97Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSw/j0qzVZoz123K4d83INZXOgYL315dEeYNvgQ6MtQd1ACqYe3363pMlaSUfCRFM
	 0TkSlmnqlSKdxGbejWYdKr0sl77xF1LQfyMYkiNq48Va+T0y3ZmiISUH1sacAM/onD
	 hYXdSWKDdZWD/IKtbhw9E4OiAAR9UW7vCxSVhSHs=
Date: Tue, 13 Feb 2024 18:28:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: make tee_bus_type const
Message-ID: <2024021315-barstool-viper-6229@gregkh>
References: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>

On Tue, Feb 13, 2024 at 11:46:25AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the tee_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

