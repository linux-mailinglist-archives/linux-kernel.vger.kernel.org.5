Return-Path: <linux-kernel+bounces-53289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBC84A313
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2832810F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F9524BD;
	Mon,  5 Feb 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLOga8F3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3D51021
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159777; cv=none; b=gqGZXfxlBN5zGeKTzwOr3Ozeb/q9HjU3veg8NnQ3aGMpryrwoe88BoTNNoUZjYVbLqRw6jbBn6ZFkapTg8UlRJr97fZ7BjADaf0ETJOU2F8rwq1X4ejPhFDsXAjjl6J9v+nG/yc3s2J6sTC8HHKcao/ILH44hJfkjHvYmbWBwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159777; c=relaxed/simple;
	bh=GVKi1NLjhuwl9NmLvmjqEi6i5Z0SknV8fkWJ8W0RoMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLsQsbNAhmUKb51+ELcer62aUEJXk+1e0/W9YXfiOti/WB6X+l5qA1s/8LorYcyHjyqClZh66yZ8QwnJnp7iC915UlTFGiJS7bjzIlkXmZ+LiUDY6Z6/nHKjNsYCQhRIi7p57yyir9UEvTBnSLAUlfDl5aXfUlPfFcwEaxCw0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLOga8F3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6D8C43394;
	Mon,  5 Feb 2024 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159777;
	bh=GVKi1NLjhuwl9NmLvmjqEi6i5Z0SknV8fkWJ8W0RoMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLOga8F3n0183OSTxmqJMuQ+kGNW5JDsftAHUki7v63uPWKINKupSYCgVLUg8DzZF
	 kCgwBLRPnNib42WxZYpittu77oqncBWQ0O/vPnKdoookcOnaVFBLhT95qsLh5DRYIj
	 C3Ub6z0IKOdP76KVb8pStCBeZxyIHuJtANn3t+Mw=
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

