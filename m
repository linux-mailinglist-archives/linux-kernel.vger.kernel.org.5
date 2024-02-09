Return-Path: <linux-kernel+bounces-59001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B15F684EFB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D6EB227A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BF611E;
	Fri,  9 Feb 2024 05:00:26 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7F5672;
	Fri,  9 Feb 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707454825; cv=none; b=rmX5+jh3B24UduWtvxPU/y+HYGa015mhIhV4dHrRuhheGUw67AHJqgGEjOBXX2DfkRMvHXOtnF4m8umla9FT6sGGoKci4qO1yx/FIhHJwcONiPCEqFkFzFn3k+EvyxFWxYALIVA+kVyqXOSAbrrrXOhV99vNvG3HBW1WIXG5YkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707454825; c=relaxed/simple;
	bh=AAxtKwR5nL/7ikwsUycBGgJp/IaAxr+/22LmdvwVhe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5KwTsH3g3a/ZWettTx/BuYqMuJUWWYIKYY+0N8oOqJfnUCwlpujhIbvIO+52WaoAYk9wWD7JC7HDJ7NgS4bacvXZ3+6+4S8/9BZbpuRS+LSzvdwiGX/VKYq+EEGS4k04V/2JhlX3a26Tb1BvYRIMdSyYQP1m5+Apkewe80mgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rYIzK-00BhgA-Ex; Fri, 09 Feb 2024 12:59:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Feb 2024 13:00:00 +0800
Date: Fri, 9 Feb 2024 13:00:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: quanyang.wang@windriver.com
Cc: "David S . Miller" <davem@davemloft.net>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: xilinx: call finalize with bh disabled
Message-ID: <ZcWxUMVA2LjP0/Dw@gondor.apana.org.au>
References: <20240128042906.557038-1-quanyang.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128042906.557038-1-quanyang.wang@windriver.com>

On Sun, Jan 28, 2024 at 12:29:06PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> When calling crypto_finalize_request, BH should be disabled to avoid
> triggering the following calltrace:
> 
>     ------------[ cut here ]------------
>     WARNING: CPU: 2 PID: 74 at crypto/crypto_engine.c:58 crypto_finalize_request+0xa0/0x118
>     Modules linked in: cryptodev(O)
>     CPU: 2 PID: 74 Comm: firmware:zynqmp Tainted: G           O       6.8.0-rc1-yocto-standard #323
>     Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
>     pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : crypto_finalize_request+0xa0/0x118
>     lr : crypto_finalize_request+0x104/0x118
>     sp : ffffffc085353ce0
>     x29: ffffffc085353ce0 x28: 0000000000000000 x27: ffffff8808ea8688
>     x26: ffffffc081715038 x25: 0000000000000000 x24: ffffff880100db00
>     x23: ffffff880100da80 x22: 0000000000000000 x21: 0000000000000000
>     x20: ffffff8805b14000 x19: ffffff880100da80 x18: 0000000000010450
>     x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>     x14: 0000000000000003 x13: 0000000000000000 x12: ffffff880100dad0
>     x11: 0000000000000000 x10: ffffffc0832dcd08 x9 : ffffffc0812416d8
>     x8 : 00000000000001f4 x7 : ffffffc0830d2830 x6 : 0000000000000001
>     x5 : ffffffc082091000 x4 : ffffffc082091658 x3 : 0000000000000000
>     x2 : ffffffc7f9653000 x1 : 0000000000000000 x0 : ffffff8802d20000
>     Call trace:
>      crypto_finalize_request+0xa0/0x118
>      crypto_finalize_aead_request+0x18/0x30
>      zynqmp_handle_aes_req+0xcc/0x388
>      crypto_pump_work+0x168/0x2d8
>      kthread_worker_fn+0xfc/0x3a0
>      kthread+0x118/0x138
>      ret_from_fork+0x10/0x20
>     irq event stamp: 40
>     hardirqs last  enabled at (39): [<ffffffc0812416f8>] _raw_spin_unlock_irqrestore+0x70/0xb0
>     hardirqs last disabled at (40): [<ffffffc08122d208>] el1_dbg+0x28/0x90
>     softirqs last  enabled at (36): [<ffffffc080017dec>] kernel_neon_begin+0x8c/0xf0
>     softirqs last disabled at (34): [<ffffffc080017dc0>] kernel_neon_begin+0x60/0xf0
>     ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/crypto/xilinx/zynqmp-aes-gcm.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

