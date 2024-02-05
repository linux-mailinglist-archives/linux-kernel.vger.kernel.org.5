Return-Path: <linux-kernel+bounces-53290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AD84A314
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F9B28C15
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939DD537E1;
	Mon,  5 Feb 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j41rL2l+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F42524DB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159778; cv=none; b=plANRdoEaTcCM45ozd6tp5JLKtoFGzjEUnC3hpfSegMsCiaXxA0eww8epuBeXf6eGY7RuPHYufPLMJPa6SOZ5hsxOdVgTyvHO5lpPH2+ECCoKnwoUFcTq8D/VFhZdRpATSy5qyvMXXv1YnicfHw1cWS3jvrWU8HI+vAsSnQQeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159778; c=relaxed/simple;
	bh=GVKi1NLjhuwl9NmLvmjqEi6i5Z0SknV8fkWJ8W0RoMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYVelL1HDoHFg7Lg+/zzR9EKf5QYqOvjMI421hKIme9t4DzRFvRIMgvdRmYTb5KpLSXXyKVJPRAsGqN3tJkR6k1x4r75Rabkc+visls35N26Zm2UMK9DQfumhuH8FXaAwwxgJRFRs1zvDsdnL8EetPtUdwUH0f4CLS2zyunOtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j41rL2l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9CAC433A6;
	Mon,  5 Feb 2024 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159778;
	bh=GVKi1NLjhuwl9NmLvmjqEi6i5Z0SknV8fkWJ8W0RoMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j41rL2l+BP84DkcNmaFTEHJSFpRg2NCvwBXAKf9FA9dKVS4TvSyLFtT74X4EQhIZo
	 ztHh8B7g0uwYg10FnL0RD4nSJssaJKZtchW+qHY8CnPMVs5Ygmkf/UzmdcVNl+92f5
	 tYZ+DJ4zpULaTn7ZJgop3HyD4xEKxKHGC29Bc62w=
Date: Mon, 5 Feb 2024 04:46:08 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: make w1_bus_type const
Message-ID: <2024020502-liver-wrench-2e45@gregkh>
References: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>

On Sun, Feb 04, 2024 at 05:55:22PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the w1_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/w1/w1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

