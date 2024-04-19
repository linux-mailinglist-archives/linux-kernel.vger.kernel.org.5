Return-Path: <linux-kernel+bounces-151402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAAA8AAE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F90CB215E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6890E8562C;
	Fri, 19 Apr 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7LUn++p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC483CC7;
	Fri, 19 Apr 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529471; cv=none; b=fE+l3m5SCT9yFDIxkaAsAgoITffRZZZq29vWLhQLm/OztaCl5SBjVtGKfd1G/1KXJhtXOqKr/G2VbqapXWkIb99w+lQgsPka349VKbK0+y/VNYwx7RnBCSMCI88OODFo+A3Nq2MnyTfcQk+PGm0JW02A8i3kIzltbSoongbx/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529471; c=relaxed/simple;
	bh=9JTSsWm1K62tYGrE1nBFe9mpRq0VD9xLFH7y6OnAceY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0SGE9uPscjRj/ZnoDvk9cI7cz7tNp1j99tZd/OzwxFODq1DPsagb/V6mvGVcQw09VhCO2StJko/CHEiX7ZVYfi5PIzQdX/e0VV/VaVbdt1rRQt51pvbowkRt4rPRYLWLdTn0aBDvIRNcR6Lu02tKygX+XBtwz7sC0/uMqDerFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7LUn++p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD7C072AA;
	Fri, 19 Apr 2024 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713529470;
	bh=9JTSsWm1K62tYGrE1nBFe9mpRq0VD9xLFH7y6OnAceY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7LUn++pkPWWuEd8URSIf9iYGDkurnOLYf+e2+z0eY4H17G6NHaxsmfEKgnpOnMkf
	 bxDLdDFqDnHBercvQlqHSX4suliyLwQps2JzV7JzIbyVGA7aNyGgC7r2gpdR72cwoq
	 fHDjZwKQ3PZ0b+L+tjY/Tp8WVLkuoXgZxRq0gy7LQWCXO/CK7alsYtwhKpeyhryxSD
	 r5gYuOdMWB2Zglf2K7QsLaeebaMotBMGua9QJiTQhZB5TOGjo4StG2WcSW+7ayrzYd
	 3GR3aPAQw7r/hPoUwmUJLICxZ9keNo5jzEHy5RnantnDFXa2978SRPcOXREfQaA592
	 GwvFCW1Iu30Gg==
Date: Fri, 19 Apr 2024 13:24:25 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next] net/mlx5e: flower: check for unsupported
 control flags
Message-ID: <20240419122425.GW3975545@kernel.org>
References: <20240417135110.99900-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417135110.99900-1-ast@fiberby.net>

On Wed, Apr 17, 2024 at 01:51:09PM +0000, Asbjørn Sloth Tønnesen wrote:
> Use flow_rule_is_supp_control_flags() to reject filters with
> unsupported control flags.
> 
> In case any unsupported control flags are masked,
> flow_rule_is_supp_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


