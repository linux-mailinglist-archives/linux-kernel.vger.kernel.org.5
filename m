Return-Path: <linux-kernel+bounces-161113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7088B4747
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D3F2823E1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74836143899;
	Sat, 27 Apr 2024 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHCEljvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588514291B;
	Sat, 27 Apr 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714239451; cv=none; b=nnn6JnU9EkiZcaCrrPp17bAki66Df2gnbU+WhEGLfIYdBgcGaCEL6Dt/GvK549PQ8Qer0SByBvGYYtSCxXCEu98X7OzKlAPTSEXj9+7wwZquxnGCFzQ/iZAa8drk+9oJnu6D8tGAi/FiBko0RssJAoyvQkMWPw6bluVmr7dBVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714239451; c=relaxed/simple;
	bh=v3A5I2iKcvchcPCEsiVEPV7u7yJjxNcjlmWIz4YEh+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba4qkE4vplJOlzm5JKitv4PjYOxTKeZTw7zSVB4XPWIxbkD9ieFHqaL8YIfck+VQJpU2V2QwCh8dfaLkeR+yuOIIOwFDLzrMrC34lTx4bekNFYaxCfhmbdEN/i8HwNHpjB0Q8+po0uHG2YcVfhZ0LStCVIQpz6lHvxXpvnS7pBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHCEljvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AA0C113CE;
	Sat, 27 Apr 2024 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714239450;
	bh=v3A5I2iKcvchcPCEsiVEPV7u7yJjxNcjlmWIz4YEh+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHCEljvllKci2t/pLjtPYZ61jZNVAjTDiz93yUN28rpG3xQz0pPlDuYp6lT3tehsH
	 DCIr+BkQMi4JRCCbMW5zWuMSesX//tfwYzgWyftt6QKbuiN1MeMJGjTf4ZJOKxhJWX
	 16xo3zJUUVDGVu8Rn8yaqLNyA98e8v/y94tQHB6UpWzYodw4oS3P8ne1Q06ecXz3OK
	 nWx1a3PImtwpCl6MWIYMR/5lds4DS2uZJZGYko/jgig6IEbPlRIfd6cScAGieXTXN6
	 WN6o9PukmW+d/5ScBu60nICEFjLXvg/oi8cz9DVmRrWqHMDvJhl6dCkn04+uaZGPsL
	 96hIKQd8oYgYg==
Date: Sat, 27 Apr 2024 18:37:25 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net 2/4] net: qede: use return from
 qede_parse_flow_attr() for flower
Message-ID: <20240427173725.GB2323996@kernel.org>
References: <20240426091227.78060-1-ast@fiberby.net>
 <20240426091227.78060-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426091227.78060-3-ast@fiberby.net>

On Fri, Apr 26, 2024 at 09:12:24AM +0000, Asbjørn Sloth Tønnesen wrote:
> In qede_add_tc_flower_fltr(), when calling
> qede_parse_flow_attr() then the return code
> was only used for a non-zero check, and then
> -EINVAL was returned.
> 
> qede_parse_flow_attr() can currently fail with:
> * -EINVAL
> * -EOPNOTSUPP
> * -EPROTONOSUPPORT
> 
> This patch changes the code to use the actual
> return code, not just return -EINVAL.
> 
> The blaimed commit introduced these functions.
> 
> Only compile tested.
> 
> Fixes: 2ce9c93eaca6 ("qede: Ingress tc flower offload (drop action) support.")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


