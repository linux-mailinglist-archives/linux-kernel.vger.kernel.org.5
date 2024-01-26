Return-Path: <linux-kernel+bounces-39881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2771D83D6F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8541C295D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901425FBB1;
	Fri, 26 Jan 2024 09:05:26 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE025FB84;
	Fri, 26 Jan 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259926; cv=none; b=jhm13Fg72ld1nBZRQhXcyitG2vYxhfVSxaD4/YIh/CezyxiVUJ/o8FUPG7N+8jm9INyAXNL9n8O4SsAub2dQ17aD+yR3ic+uYftIqt/0X+O7Xzgn5uljPcJER6owKwcDm2lWtbrBpyxDhH/Hgv8EqY9M0gTvTAs96ER0MMZganI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259926; c=relaxed/simple;
	bh=9fFOopVdKAjV1by1QMH5ucZbA1hAWe+Zz5PTAY9LHIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1VYkabOOI+pvDhSAG5zo7Hgtx6qHu3Ung5oLgy/nda6Ptk+TxQ/502Uss3mPZ5n11oqjCX8DNCRT+v6HSEUZrxoBDmlZc+tVMhovXfXIbkCgBltoAtH7VJjQx6TILGPpcJK33No5kLPervnxWpEd96zMymIlNKJhhOu5+HX28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI9G-006Es7-Vz; Fri, 26 Jan 2024 17:05:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:05:31 +0800
Date: Fri, 26 Jan 2024 17:05:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wenkai Lin <linwenkai6@hisilicon.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	liulongfang@huawei.com, fanghao11@huawei.com, acc@openeuler.org
Subject: Re: [PATCH] crypto: hisilicon - Fix smp_processor_id() warnings
Message-ID: <ZbN128cDR4qisFha@gondor.apana.org.au>
References: <20240119081107.5306-1-linwenkai6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119081107.5306-1-linwenkai6@hisilicon.com>

On Fri, Jan 19, 2024 at 04:11:07PM +0800, Wenkai Lin wrote:
> Switch to raw_smp_processor_id() to prevent a number of
> warnings from kernel debugging. We do not care about
> preemption here, as the CPU number is only used as a
> poor mans load balancing or device selection. If preemption
> happens during an encrypt/decrypt operation a small performance
> hit will occur but everything will continue to work, so just
> ignore it. This commit is similar to e7a9b05ca4
> ("crypto: cavium - Fix smp_processor_id() warnings").
> 
> [ 7538.874350] BUG: using smp_processor_id() in preemptible [00000000] code: af_alg06/8438
> [ 7538.874368] caller is debug_smp_processor_id+0x1c/0x28
> [ 7538.874373] CPU: 50 PID: 8438 Comm: af_alg06 Kdump: loaded Not tainted 5.10.0.pc+ #18
> [ 7538.874377] Call trace:
> [ 7538.874387]  dump_backtrace+0x0/0x210
> [ 7538.874389]  show_stack+0x2c/0x38
> [ 7538.874392]  dump_stack+0x110/0x164
> [ 7538.874394]  check_preemption_disabled+0xf4/0x108
> [ 7538.874396]  debug_smp_processor_id+0x1c/0x28
> [ 7538.874406]  sec_create_qps+0x24/0xe8 [hisi_sec2]
> [ 7538.874408]  sec_ctx_base_init+0x20/0x4d8 [hisi_sec2]
> [ 7538.874411]  sec_aead_ctx_init+0x68/0x180 [hisi_sec2]
> [ 7538.874413]  sec_aead_sha256_ctx_init+0x28/0x38 [hisi_sec2]
> [ 7538.874421]  crypto_aead_init_tfm+0x54/0x68
> [ 7538.874423]  crypto_create_tfm_node+0x6c/0x110
> [ 7538.874424]  crypto_alloc_tfm_node+0x74/0x288
> [ 7538.874426]  crypto_alloc_aead+0x40/0x50
> [ 7538.874431]  aead_bind+0x50/0xd0
> [ 7538.874433]  alg_bind+0x94/0x148
> [ 7538.874439]  __sys_bind+0x98/0x118
> [ 7538.874441]  __arm64_sys_bind+0x28/0x38
> [ 7538.874445]  do_el0_svc+0x88/0x258
> [ 7538.874447]  el0_svc+0x1c/0x28
> [ 7538.874449]  el0_sync_handler+0x8c/0xb8
> [ 7538.874452]  el0_sync+0x148/0x180
> 
> Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 2 +-
>  drivers/crypto/hisilicon/zip/zip_main.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

