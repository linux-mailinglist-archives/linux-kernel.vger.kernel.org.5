Return-Path: <linux-kernel+bounces-97537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A521E876BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B38A1F21D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE35BAE3;
	Fri,  8 Mar 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa9WULFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19D26AD7;
	Fri,  8 Mar 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929156; cv=none; b=fKqZ88XV3zLijiKAx4JlYkcWjdLpOvBOE3DINuMOTErxU067EFGuz7JQIKmnmthoWIIqzlPSLoQBU/wfWMTtIioATbkl+IjDZTTJk+YlDqTEuEPJi0ANRMdb8BEdDGadzgro0FIHXlkb9Zc4bsAf9cgZW8vLI7mrUlFhQrsAs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929156; c=relaxed/simple;
	bh=l2cUl9gunXO/uQogDSHExXcrnnTLLkpspxEvydZvLQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIryaJa8JK1cwWi2zc6lpSsmWGG3R1+VvJhdoC6zkz5GrI/nqN/s9+/lcJds+5mGFu1nPGrVRVQvl4A+yC1GXt1/94qLm6KNoiobWpdcdRWY/8D7K5sCsCLfZgm/6+UoNC6XQodzx0ZLeZRxanEDNfaZIPbAbWzJvI/MZIpA7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa9WULFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993B2C433C7;
	Fri,  8 Mar 2024 20:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709929156;
	bh=l2cUl9gunXO/uQogDSHExXcrnnTLLkpspxEvydZvLQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xa9WULFONf0umk5tj4E6x3LwcgLAgRnSYAO/piMN4LNSxqecZp3MXjV59yfHDqlq4
	 /iY8n6DGxi6wCXmuIgFQ2hCNrC9FGZqn+w5TZO7E/SuZo7JlQE7ds3E10FolAmq5yK
	 fveb/5hNURQnqBZcK2gAISWjhAuwR+nbdP65WOkLSF1oQLqa+LqoOeabDDNt/XLv2i
	 yto8wQJhhZ24V+ThZfW4M7a2J2qsfvzJLMKNqzUeiAuriZRJXRw5+m5kkZD89PTgy0
	 HG8gwTwiBxJFvioXdafVICuPENDYMcpI5TSUmVWqTuWY0I+k1bNVgJunF0HvWvVnUh
	 RbHPfMrWrY3gw==
Date: Fri, 8 Mar 2024 20:19:11 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Felix Manlunas <felix.manlunas@cavium.com>,
	Satanand Burla <satananda.burla@cavium.com>,
	Raghu Vatsavayi <raghu.vatsavayi@cavium.com>,
	Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] liquidio: Fix potential null pointer dereference
Message-ID: <20240308201911.GB603911@kernel.org>
References: <20240307092932.18419-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307092932.18419-1-amishin@t-argos.ru>

On Thu, Mar 07, 2024 at 12:29:32PM +0300, Aleksandr Mishin wrote:
> In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
> but then it is unconditionally passed to skb_add_rx_frag() which could
> lead to null pointer dereference.
> Fix this bug by moving skb_add_rx_frag() into conditional scope.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1f233f327913 (liquidio: switchdev support for LiquidIO NIC)

A correct format for the tag above is:

Fixes: 1f233f327913 ("liquidio: switchdev support for LiquidIO NIC")

> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

I guess this code is never hit.
But I agree this should be fixed.

Reviewed-by: Simon Horman <horms@kernel.org>

