Return-Path: <linux-kernel+bounces-161073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B1E8B46BB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828981C21251
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642B23D7;
	Sat, 27 Apr 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHoB1Bdo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98275817;
	Sat, 27 Apr 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229784; cv=none; b=RujzZ0rDQzAkUmnm63byl/uWvDGeUx6v3eWTvYuVPDdeABWR5i7zk5dBpeJYlfs85nxtyUvcip36TD4oVKy7OgyAzobIk3AFsxLZ+pyJXyfNGANpkRlcbotDsGvfXUkGOxLyK4ctau6hE+I5B63IpUkk6RIY52wv+hsyN6guj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229784; c=relaxed/simple;
	bh=tKS6xrGJ1Q6azSgyWQazosphPUvdjtA4NX2ju1bSK74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0zi/dfwezcVLpJH5qEDEM1Vx00mJWVFuEE17Aq21sjJrDZC7QgYiYik+y6Wlc9hlE9pCbvGxb1uJ9XN2+X1gZqxrfA+feDEc1QRm9k6cayPbsdavWtVt+ATn8zjN2oDQ5l2shH2VjXIGYOfzJxacIbbxbcAMPiNZ4+i1nodGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHoB1Bdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17CEC113CE;
	Sat, 27 Apr 2024 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229784;
	bh=tKS6xrGJ1Q6azSgyWQazosphPUvdjtA4NX2ju1bSK74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHoB1BdoceXwUmEQxyX8i+4FOzlX0LepVXbv26RufCYZn9aNw/ZhaguAkeRIbZzKr
	 t1JblNpvmPFewskVT8w/AEgsPXdYn31KDpHgf5byGjR3WK4CQb4CHaJX4p75l9bd8l
	 /wuUY4MFSb5oZglQLz7167uE/3bJjgkK/htMj/m/87LgwM6JqcrBd1YJHBBaZOWxGh
	 d26O8DIW1aROZbytZERsS53yvqmMX26AmrDsaCedxvHIpAykm85ugrXXjZHh/Fv3JM
	 6CvEXbbkRf7TMescpl/BXFPXYIxwoRe+3GDfvqOhKAzyV/2b3hty1vJbG25e1yJFUZ
	 hQFjiUdBss/9A==
Date: Sat, 27 Apr 2024 15:56:19 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/7] i40e: Refactor argument of several
 client notification functions
Message-ID: <20240427145619.GO516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-3-ivecera@redhat.com>

On Sat, Apr 27, 2024 at 09:26:03AM +0200, Ivan Vecera wrote:
> Commit 0ef2d5afb12d ("i40e: KISS the client interface") simplified
> the client interface so in practice it supports only one client
> per i40e netdev. But we have still 2 notification functions that
> uses as parameter a pointer to VSI of netdevice associated with
> the client. After the mentioned commit only possible and used
> VSI is the main (LAN) VSI.
> So refactor these functions so they are called with PF pointer argument
> and the associated VSI (LAN) is taken inside them.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


