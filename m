Return-Path: <linux-kernel+bounces-71744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC885A9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1601F21C62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625A4594B;
	Mon, 19 Feb 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6uvawix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE544C70;
	Mon, 19 Feb 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363161; cv=none; b=eI8G+beuqTaSr7ywlUakxTmBfKSg/WocIKeAA1ZnFNNSJKhb/kkFUEC7VhU/0lTZsCCP+LZA+J7nLF6J1UtiPcZ3iEgtOngtYvhuDedonzoTmQylXtecBoblrmB6CvOlzlaSKN8CvkUUWUfKeZ5Ov59sTKN1l8KpiWalPpIA9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363161; c=relaxed/simple;
	bh=6JXZWExM5zRAitroyxUGPwJV90fJfV2ON2sr9M8S0mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3kMP4akg8P86imyCQys36Pa0FPbBeAn4iwtk8amBIlAGziw61DM4hCtPMrhdPWi9j35ms8h2N8QeWA274gsu2SgIcKdjcMoiG1DHyLK2R35ce24cpAcTcpJRQEpsRekP/D0IStzmF4vXP88ougmsEc43pzt0+oIHyYLqqVSiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6uvawix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3647AC433F1;
	Mon, 19 Feb 2024 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708363161;
	bh=6JXZWExM5zRAitroyxUGPwJV90fJfV2ON2sr9M8S0mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6uvawixlaFBjUq1IQMwYzKZIjt9Eywp0GmxEDsidINoTfYEUVjIr9EzIjpE+89SP
	 RtZPgnDEkAvt/hTOTObZHCYflata7pRnZVE7h8Rlk5HOexV2y5DM+DPv2VY2Q9IybC
	 h/BOog0wGukp2bzI5CP1tyC5FZsD/F23zEJbocaWLzspbMQJcQL+fsgrAI4F0BQiWR
	 7PPiPDtRGISQXd68efdyrXwQKdgR4TAwK3shDGi1wzulx5iIDeVhYg+WxlCK25iOpa
	 O7VtgenW15VmCNXQ/zrQoRfZ957j9fySDZO3gSB4ZXEZMB+fizAJHHGr7y1RydbqgH
	 xdanfUqYnhLHw==
Date: Mon, 19 Feb 2024 17:17:46 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netfilter: x_tables: Use unsafe_memcpy() for 0-sized
 destination
Message-ID: <20240219171746.GI40273@kernel.org>
References: <20240216233128.work.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216233128.work.366-kees@kernel.org>

On Fri, Feb 16, 2024 at 03:31:32PM -0800, Kees Cook wrote:
> The struct xt_entry_target fake flexible array has not be converted to a
> true flexible array, which is mainly blocked by it being both UAPI and
> used in the middle of other structures. In order to properly check for
> 0-sized destinations in memcpy(), an exception must be made for the one
> place where it is still a destination. Since memcpy() was already
> skipping checks for 0-sized destinations, using unsafe_memcpy() is no
> change in behavior.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Simon Horman <horms@kernel.org>


