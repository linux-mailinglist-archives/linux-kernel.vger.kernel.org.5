Return-Path: <linux-kernel+bounces-161052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EFC8B4675
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107B12860AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FAD4F201;
	Sat, 27 Apr 2024 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tze2SrNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087F4EB5F;
	Sat, 27 Apr 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714224695; cv=none; b=MU6uYnZl5lNxqmcGcqi6v6XPvXzrUBTQe1euUkM4rgbdApT2SCI8cYf4PS3i2O57+l0QozUotheKLSgYOtjz7J2lReCbRphaFDKISPOx8V9KjWoVREdNprZnocamdL1akBWU8rus3pBxvDXKdNiilkiPYWnHPRTRXQ4+OP59dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714224695; c=relaxed/simple;
	bh=tnm5KkPb4FdfDcHUzOfR0PM2z3QBCBSBw6ifiMIT4QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANg7ISkzAwP5kJYjRWeGuwkOYLB3BXv9LI3O4pF5hbV5vs3V3XiLlZ15FZes0RnA7vgSxH6TQISGR3jR/60Ug4WOPxiub5Fd+TpmT60e3rnWfYV2dys1B4tuB+1KYglkpE/hp6c3ksuDKCKlV77Qs6jeSQwAEY/k+oxWCBfAZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tze2SrNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FE5C113CE;
	Sat, 27 Apr 2024 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714224694;
	bh=tnm5KkPb4FdfDcHUzOfR0PM2z3QBCBSBw6ifiMIT4QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tze2SrNKoSjoGSWiX0bMeNtF1iovTM8KoqE79ZgXLWfB1Pk6j7ug26D5+JdTbtJm/
	 vJrZpWjejVOtkOwupyuybGyNN68MPdvUmT91g0Gz+aZxmg6FE9agC4hgf446ZBfcEg
	 m93a0tSl/bMGGiS2QzMe7aKU1zLQOuwI4Jt+GSUj8Oze801MPzEWik0oo9Iyuk6ju5
	 IMXsdX5Dm/qfyWZJAexfuhTgyKSI4EheB5874133nEv/ktD2eVA5b4aStnNfQ9BCoA
	 tchfo7ebvkSs6cH9IxuoJDSGeljfgIYm8OfXM8p/f555WfeZmg+RTBYC+1bZbtwu4u
	 9enwGNY//VqrA==
Date: Sat, 27 Apr 2024 14:31:29 +0100
From: Simon Horman <horms@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Tanmay Patil <t-patil@ti.com>,
	=?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	Roger Quadros <rogerq@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, s-vadapalli@ti.com,
	srk@ti.com, danishanwar@ti.com, r-gunasekaran@ti.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw-qos: Add support
 to taprio for past base_time
Message-ID: <20240427133129.GI516117@kernel.org>
References: <20240425103142.1999123-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425103142.1999123-1-c-vankar@ti.com>

On Thu, Apr 25, 2024 at 04:01:42PM +0530, Chintan Vankar wrote:
> From: Tanmay Patil <t-patil@ti.com>
> 
> If the base-time for taprio is in the past, start the schedule at the time
> of the form "base_time + N*cycle_time" where N is the smallest possible
> integer such that the above time is in the future.
> 
> Signed-off-by: Tanmay Patil <t-patil@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>


