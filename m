Return-Path: <linux-kernel+bounces-125384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E289251E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8D81F23718
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242813BAD2;
	Fri, 29 Mar 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmn7bK5p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C532C89;
	Fri, 29 Mar 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743539; cv=none; b=qkg7bZWXnaWDqWm9OMTUKldCzr+aNi+EkgMvCd0cCOINFWNv90wOE+ERbfY0DBPTauBHBaZ9F5mNf6Oxz3hsUD/Wnqcq1irchTYluVZNbYEQfBfNjMl3RXI06FFyQURD+G7Ueun+7E3NgP0JwLeziiZASuexXNS0dP6vHnpObQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743539; c=relaxed/simple;
	bh=XtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qqu4zCBTiJqgGnFdGLm/XtOGp4Us/lbdid0E7apFgBNq55apYx3ut6lCEtpoylX8bJ46arI5BqiniTPLcyz6+ZXWHLs3DnCqKNHsi8EkPv89ErnAleQGgT47rA5XApiBVz9a6chCtJtPcLnjFZbwyX4bGxsfvhhj1nWKqcr171M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmn7bK5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D45C433C7;
	Fri, 29 Mar 2024 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711743538;
	bh=XtVImmmSugd7Y+fhFyNSmTR6NDHudXo4Ksas1gA4z/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmn7bK5praEFKZSEsXD1U0+/BhIiMgbRjlqzURm8mJyxcKdG1u7nFhvjWn6vjh45L
	 4fMwTQz5BgPAhQhwxhdzDjswpLr9tfxyAozEWodJ9d27CxJ4UL4UFY8Hf3KdPpUow8
	 E8A+MEP24fcOZoxGi8rhDy8xtbiVoeUdXbHP4PlO33ntnqxcbRNqN9U47LzjpdNssC
	 YPsQGwM2m4yyhH+9eEUxcjM4Ffzgd6RloWxtSrDibmFc5c1SFjvFY0/UkKocjbZRfB
	 tH6Rp6GsCq/VsJXLXe3LZL+Iv2yl9gsZmI2qe8RWHTL8tXGuYUE5J+9mVzpCC1gcYY
	 0Sa+AbTpHn+oA==
Date: Fri, 29 Mar 2024 13:18:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329131857.730c6528@kernel.org>
In-Reply-To: <20240329170000.3241460-3-aleksander.lobakin@intel.com>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 18:00:00 +0100 Alexander Lobakin wrote:
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: warning: declaration shadows a local variable [-Wshadow]
>  1992 |         return netif_txq_maybe_stop(nq, IDPF_DESC_UNUSED(tx_q), size, size);
>       |                ^
> ./include/net/netdev_queues.h:137:11: note: expanded from macro 'netif_txq_maybe_stop'
>   137 |                         _res = netif_txq_try_stop(txq, get_desc, start_thrs); \
>       |                                ^
> ./include/net/netdev_queues.h:92:7: note: expanded from macro 'netif_txq_try_stop'
>    92 |                 int _res;                                               \
>       |                     ^
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: note: previous declaration is here
> ./include/net/netdev_queues.h:133:7: note: expanded from macro 'netif_txq_maybe_stop'
>   133 |                 int _res;                                               \
>       |                     ^
> 
> Sparse:
> 
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_res' shadows an earlier one
> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared here

I don't see these building with LLVM=1 W=12 C=1
and I really don't like complicating the code because the compiler
is stupid. Can't you solve this with some renames? Add another
underscore or something?

