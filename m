Return-Path: <linux-kernel+bounces-151407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4440D8AAE70
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0669A282031
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6E85653;
	Fri, 19 Apr 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vig2AR6j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D185656;
	Fri, 19 Apr 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529812; cv=none; b=kVad5udjXPdz2xQH/Nl1C1JsRvpajFCoNr+fLYlzmdX4MA5SNe9av2o8CMAwszsoCqY7JU6X7yD3+zorHBwCXD2fcqtJsu4qiYR9LWMzEDVmch74GExHuvyP7R6q5hsyZodzD3Q33Uklqd13T6AFiJ5M4JDSp/u0WZPpjM+eMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529812; c=relaxed/simple;
	bh=VeN/kN2AbD4PeQX7ZuRMsohc9478jy4azX325WAmLTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMLos/lSeM/NDcML35VuogwA0FFKqsrgehsnxrX5z3ocWOS1QneDywI+R0w7wl1hrM+aTPdhGPC0KE9Q5NE7lUOrPA98Lkleki3gSKvh8F7cKtax24IITFU3Ppr6BqIO+KQ1EWDL2ejqh1tYE40VZNXojjkhYps9me+GRNlQkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vig2AR6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559A1C3277B;
	Fri, 19 Apr 2024 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713529812;
	bh=VeN/kN2AbD4PeQX7ZuRMsohc9478jy4azX325WAmLTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vig2AR6jsAssAqTEKgUhXAXyzbWAjmRcSglKCpSEvnJ6B9jbXRSWLX62NIBLrqM4l
	 jFAbSz/9TIkO7oVNlq3kIiOXrTDq9ANvAuu8ok3F9hPw0Eya8w//68RJiWdfFt+yhL
	 /T0bpCr3kHHYmKOV5/ZXVl/mFzLMKzZM+bFdUzthCTO/QzAMfi+sjZZ8Tr51frKFIP
	 1JJI3ofGhn/fdXPL+NECCUgP0z1U1MqCmxHCqdXeJGdukjdMybZ6d8DnRImDFtY9mA
	 YRp3uoLM6W/lVrjY380MJvT4mf80XKDf1VBAHCjNe7f/Z7Tz0NKQd0unE+x7VEdJyK
	 UGHq3c6x3QbGg==
Date: Fri, 19 Apr 2024 13:30:07 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: flower: validate
 control flags
Message-ID: <20240419123007.GA3975545@kernel.org>
References: <20240418161821.189263-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418161821.189263-1-ast@fiberby.net>

On Thu, Apr 18, 2024 at 04:18:15PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


