Return-Path: <linux-kernel+bounces-155342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41768AE922
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5331F2373B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E891F13AD08;
	Tue, 23 Apr 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCzceUhM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336ED137918;
	Tue, 23 Apr 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881342; cv=none; b=iquwyE0E/xcBKwuQYYR0gkCWlEYOSgU7x5gUa7xMTBna46ldDZOWsr0jiN6dpmkJOuAu2Vx6eKauNsInT3AwTC37yjzrrzy7sxa6OyIQZa4u5Iz9yV54i2i4A1xreXuML/RZP9rnRBsackRtiO/NpED6RphG32aRfRW8zPThI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881342; c=relaxed/simple;
	bh=v3Uu2KeQV+Yw17N/SD3UPuR7eFq0nCxEDfaZW3BRnzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udVDgxRwBkquyKwtskg18LpfFvw2PkKj+SuLziXoTjn8Ed6BYj4qwJXrq9tN5/LrgWuivnldFJR3SbYPOwglIbPTt5jnBW4qJUhZxM/eKOl6FsnA/yXBjJhm0XvsMqcTpoQn8BDlRh6ztlji+snNYenng4zq2GrrWLd7ckBpJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCzceUhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48225C116B1;
	Tue, 23 Apr 2024 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713881341;
	bh=v3Uu2KeQV+Yw17N/SD3UPuR7eFq0nCxEDfaZW3BRnzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCzceUhMcyoxMZCGFjFOwPv9EUco2A8w+S+Pncm7QP15DIy3hPJJ50tRxeCFOlP3J
	 4HQLfLfYt3arhkztkNiSHDBuWJUBuonH0J7T/ydNVagnKurhk6M4JHK7+tK9Ih836P
	 Y1K5+EYDeyBOoYUy33lli00zIXXNrwtwgxVcbTjYBF9ywdpk5iq0/0gNK1nGGLds5o
	 wUb6XcDxxO/5An+B+vDX11P+hW8GtAMawRTwI/8sts7ItWcaWEwvD1n0qlLmR83lMi
	 ImB/F3xz+8PqYb5fbKyISqGKcfUiLgMuRTx6QA/JD4Fr9FIxdyQ+1lRdade0yZEmd4
	 xMOf0yRt85C+g==
Date: Tue, 23 Apr 2024 15:08:57 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net-next v2] net/mlx5e: flower: check for unsupported
 control flags
Message-ID: <20240423140857.GV42092@kernel.org>
References: <20240422152728.175677-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422152728.175677-1-ast@fiberby.net>

On Mon, Apr 22, 2024 at 03:27:27PM +0000, Asbjørn Sloth Tønnesen wrote:
> Use flow_rule_is_supp_control_flags() to reject filters
> with unsupported control flags.
> 
> In case any unsupported control flags are masked,
> flow_rule_is_supp_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> Remove FLOW_DIS_FIRST_FRAG specific error message,
> and treat it as any other unsupported control flag.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


