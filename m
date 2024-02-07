Return-Path: <linux-kernel+bounces-56986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D059784D250
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B72728419A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4D86AF9;
	Wed,  7 Feb 2024 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZVMCdkl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772982D97;
	Wed,  7 Feb 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334906; cv=none; b=J50iAYJk/+QqhNyXyjbFtzbs5FRSz8NLXsV6voD7zThK78KLcNpDa7hngQPbiiE4aEX0yVfu4yOwcVLWdbKpum+PIJ3puU0+FiKPGu13jZcWKQOt8X75G1eGpSprPkTEfR/yDe0Cxz+jLv7AWnUwl580TY9QUzoNxNCPkS/eAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334906; c=relaxed/simple;
	bh=qklZB0bLC2a5JgC1IlNtz4oyZOfriDxJVVLL7P91U0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeZ00I7iG/drqnUcCQUUeEz1JA0elWTCqaaVcbOoD6sykmF5+c/TWNng8mSDthPdpCth1apEFlx46pTBgMt3kVWXxYUjEPFWzniTl3/34tQsU41J1FtcvdbUeEq0u+4V4D0nOWm42qhLFy8drYQE+b9uKentG8S4u7EsdNaQsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZVMCdkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6540C433F1;
	Wed,  7 Feb 2024 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707334906;
	bh=qklZB0bLC2a5JgC1IlNtz4oyZOfriDxJVVLL7P91U0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZVMCdklIIZ6bIHoB1raFtdfESX/bA8benswxm5LvjTcUpNxjGzZ0DBnYY6sTgbXD
	 AauUh3g9dIjGdC6tuLeVLIBjP3bJG3MnOkqOoF84KxdEh21jjxcThIa/zRAjbY4O6m
	 JfheDHfyNpmB8s9DKQpe+F9RQtDXFuIhAQtF6WYepIDZutFlzlDnb4Bc4YtOS/NPax
	 cBzgg9h8ciFPFmahE/ouXKvBudAatqPOGGfEl8CTNNG33rS67h0hlwc2niesD6AX/S
	 3Ko/JZ8lxBc+788Bu6nNRhXdnLlvxYg3g0aaR4Psmv56a1xpIR7YHm+dZQ+8lITFWX
	 oAgKyRXNP1D1A==
Date: Wed, 7 Feb 2024 11:41:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gerhard
 Engleder <gerhard@engleder-embedded.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tsnep: Use devm_platform_get_and_ioremap_resource() in
 tsnep_probe()
Message-ID: <20240207114144.25e82d30@kernel.org>
In-Reply-To: <29e9dc0f-5597-4fee-be5c-25a5ab4fe2dc@web.de>
References: <29e9dc0f-5597-4fee-be5c-25a5ab4fe2dc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 13:54:24 +0100 Markus Elfring wrote:
> A wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source code.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

applied, thanks!
-- 
pw-bot: accept

