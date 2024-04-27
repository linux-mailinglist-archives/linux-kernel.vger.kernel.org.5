Return-Path: <linux-kernel+bounces-161114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5A8B4749
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B44B1F219A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556E14389A;
	Sat, 27 Apr 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8tlWOYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BB848E;
	Sat, 27 Apr 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714239468; cv=none; b=JOOFRH0jCvfu391ecdxkIVOVm/UYNf/7ZyeQHiBp/1EwN5zOW+jOUrtOpFD4XiBIsDI3SjJJNkFFIrrmQLydQ1+uZZrWY4jTv/La60x0XX/N9DUwwKjQboSB3k6sSarLoaJSpIm+e4+vVYQlQqx9m9A3s4DiP2lzQU13+sV5iJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714239468; c=relaxed/simple;
	bh=XnNWjzxG2PKXmbkTQT5QZBRkt1BXERMEFNegj5IzWC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDB8NunV1QRcYaPglCOr4pH9mvb+vNe2rQugy5b6pMGVxZT6qTSA0rVYzCGv7RtYQwo3sfN4N3ataKbr/O7u+m7VKI3abhk7p7SwwgtBTDIHrQo7nI0L217mnHxD1mQM1gukujlbulVdhZEhbL7BRQ//0nzfewLwCCVtAmKRWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8tlWOYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BE1C113CE;
	Sat, 27 Apr 2024 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714239467;
	bh=XnNWjzxG2PKXmbkTQT5QZBRkt1BXERMEFNegj5IzWC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8tlWOYIZGeXdyzLebQmkFSKu2GO2KHYYdWaxg4JY9MIRotbGdLTVLBmA6RGS/jbc
	 tUDB/sebDS8GGjXcsoajkNrKWh2a2RO405LeuMfOW8IndnFccvVEqNsDOBP8tp19t1
	 EUL0r7kVtxwOZqOyILO/X9bXTHZoROhBEZvMBdWy4wGzAhkQO2SHwlL+KjkiRCFPhc
	 9v9BV4HekXU/t5A1RHdvK4H5Lrcauhc38N/0hYPWA2uppBOs/xAaoH9fNRvIfyBHBr
	 JE2Uvi0KBIyJ13XlLjlS3kriYfL9+5RVxjeAzHI+DL2Ev8iL0ydP+qvDkPJvTDn+c9
	 1Cy6MVlyqLfSw==
Date: Sat, 27 Apr 2024 18:37:43 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net 3/4] net: qede: use return from
 qede_parse_flow_attr() for flow_spec
Message-ID: <20240427173743.GC2323996@kernel.org>
References: <20240426091227.78060-1-ast@fiberby.net>
 <20240426091227.78060-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426091227.78060-4-ast@fiberby.net>

On Fri, Apr 26, 2024 at 09:12:25AM +0000, Asbjørn Sloth Tønnesen wrote:
> In qede_flow_spec_to_rule(), when calling
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
> The blaimed commit introduced qede_flow_spec_to_rule(),
> and this call to qede_parse_flow_attr(), it looks
> like it just duplicated how it was already used.
> 
> Only compile tested.
> 
> Fixes: 37c5d3efd7f8 ("qede: use ethtool_rx_flow_rule() to remove duplicated parser code")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


