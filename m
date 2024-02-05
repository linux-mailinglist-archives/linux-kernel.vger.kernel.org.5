Return-Path: <linux-kernel+bounces-53396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F484A3D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC731285603
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7D12C802;
	Mon,  5 Feb 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHrsa08z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916E127B75;
	Mon,  5 Feb 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159810; cv=none; b=fxaE6F74WKaOgVIRr5YSKppNnPBtZD2Sd0mI7AfzszWK+w1dypv4K0T8oQm1d2RjO+WXeOZfHQ/bxHbix3RsCfOhtSGpl/seG8wBN7+Dk3b8APgrC/DQb3RPuZf1Y8N/9hiWV0+Bf3pXi7o6JT9R54vQ30qq7fQFEUC6oCV5FtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159810; c=relaxed/simple;
	bh=H8f1M8b6apfQrDwjE9TiNKtV/aNKPCj66fgR1fgv7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip6bFVkZnwoA0t1XdElx7AjgwsGU1EniQ1rwOW54acA+g2KJKOfwLZf3clqAUmoXKA1PP75IxaDz7Od3TPjvisbY4zHFHaDCcXcxjbkOfK7LjggddfaIuXVLE5HMr111PmubuWIwVtHz9Q6JI8aWyQQJ5I+z/0iN37O74EF2Spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHrsa08z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995ABC4166C;
	Mon,  5 Feb 2024 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159810;
	bh=H8f1M8b6apfQrDwjE9TiNKtV/aNKPCj66fgR1fgv7Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHrsa08zK8npKlhb5aDL3np8P2K8gA+eaUUUgqTHBbECBnPNjYm0Bb1Ut+Ab+VFX5
	 R3cvyn92g6yJM1TpJOpoRm565SCLJPEAPkDz+EHMcniu0Ifh/Yc23NRCQxj2aloWik
	 EMjO5jMZsupHQp/YTagzHqQUGYsq1BD91TnUtNFg=
Date: Mon, 5 Feb 2024 04:48:23 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdevsim: make nsim_bus const
Message-ID: <2024020518-reattach-linguist-c212@gregkh>
References: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>

On Sun, Feb 04, 2024 at 05:16:34PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nsim_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

