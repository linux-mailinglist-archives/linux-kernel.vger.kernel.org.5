Return-Path: <linux-kernel+bounces-73973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA785CE33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1BA284867
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD32836A;
	Wed, 21 Feb 2024 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/6HpPzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C12F36;
	Wed, 21 Feb 2024 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483466; cv=none; b=BmvWfEfzZW2hQBf/TWpKQlfLvrDQa677MzBPwTcWx1xBP+HaRQZhqbaesD8nNCJnETndUi3jZKsltIlI7z4WFXwlsdjNWhHY2L/IsJxpe3/aJGHefbhxKYbt9Ru7UB3TgvB92w869qasiIqVRG3rUQvongfyhvHRz8MTiNJ93SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483466; c=relaxed/simple;
	bh=8a1OrPvpvJAvQeZbo8+FjNLm+ecYqk/MacrjDuZM+Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sml68nq0kTwJ2962ivh0r+4yTSEBcs3hZcIdlgkAg4qXbzD25SFtKgaTsePX2fAQTu9QxFXB7iB3dMtbwa1ukp2Dj3p6MVQdJDhwcwukzTuG6nQOt73sWkVcqwCHsXxVW1mXp0smOKAa/bvPpXpCfvbMEw2d0MOKUftug6lcvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/6HpPzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49149C433C7;
	Wed, 21 Feb 2024 02:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708483465;
	bh=8a1OrPvpvJAvQeZbo8+FjNLm+ecYqk/MacrjDuZM+Tw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H/6HpPzn2pbHe6jrtJIyM/fQDgqYAcGhrA6eayhy4AkhH+lD3bNTWLk3Um3Y9ol/r
	 2So1twZPhhU3gEXHjO/651aihjO9eBgLvLIXcTv8LH0tYqgP7ORkSRMSJeFBE3vdsv
	 cSSABiJ0lfBlOKT7/DoYGq7Mj6Vw4lWXrzPyx6K0GjIFJctV2F+cyzxUDkbZy1PL2g
	 CiMvafFmCxOnlSbzw0u7wbXG9fpy+xXVlRbrq+YR/vJsc5y//EKiOuXxhAC85To9DC
	 pKnThz7B8X8ZYWsUdE//XJxWupmdjyMtm9cmrOCDEOQ1UNuiHyQ2fsUzUYpLvxQl7s
	 iqhbj8q348ejw==
Message-ID: <8afe7956-8f29-49e8-a59f-7e6b4136fa1d@kernel.org>
Date: Tue, 20 Feb 2024 19:44:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: copy routing table more efficiently in
 rt_dst_clone
Content-Language: en-US
To: Oliver Crumrine <ozlinuxc@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <xlabdyc4izitfdfpuoy2p2hi3abiq4mrrgizdqz45k7xeftbsg@ee6jgncdaqg7>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <xlabdyc4izitfdfpuoy2p2hi3abiq4mrrgizdqz45k7xeftbsg@ee6jgncdaqg7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/24 6:35 AM, Oliver Crumrine wrote:
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 16615d107cf0..ebb17c3a0dec 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1664,22 +1664,8 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
>  			   rt->dst.flags);
>  
>  	if (new_rt) {
> +		*new_rt = *rt;

rtable is a container of dst_entry, so this is copying those fields as well.

pw-bot: reject


