Return-Path: <linux-kernel+bounces-12926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC5081FCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F1A1F21972
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567491FB6;
	Fri, 29 Dec 2023 03:28:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571E17D8;
	Fri, 29 Dec 2023 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rJ3Xj-00FG2T-5H; Fri, 29 Dec 2023 11:28:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Dec 2023 11:28:26 +0800
Date: Fri, 29 Dec 2023 11:28:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: WangJinchao <wangjinchao@xfusion.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Tim Chen <tim.c.chen@linux.intel.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Subject: Re: [PATCH v2] crypto:tcrypt: add script tcrypt_speed_compare.py
Message-ID: <ZY482sGYU+4s8eJj@gondor.apana.org.au>
References: <202312182113+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312182113+0800-wangjinchao@xfusion.com>

On Mon, Dec 18, 2023 at 09:15:01PM +0800, WangJinchao wrote:
> Create a script for comparing tcrypt speed test logs.
> The script will systematically analyze differences item
> by item and provide a summary (average).
> This tool is useful for evaluating the stability of
> cryptographic module algorithms and assisting with
> performance optimization.
> 
> Please note that for such a comparison, stability depends
> on whether we allow frequency to float or pin the frequency.
> 
> The script produces comparisons in two scenes:
> 
> 1. For operations in seconds
> ================================================================================
> rfc4106(gcm(aes)) (pcrypt(rfc4106(gcm_base(ctr(aes-generic),ghash-generic))))
>                          encryption
> --------------------------------------------------------------------------------
> bit key | byte blocks | base ops    | new ops     | differ(%)
> 160     | 16          | 66439       | 63063       | -5.08
> 160     | 64          | 62220       | 57439       | -7.68
> ...
> 288     | 4096        | 15059       | 16278       | 8.09
> 288     | 8192        | 9043        | 9526        | 5.34
> --------------------------------------------------------------------------------
> average differ(%s)    | total_differ(%)
> --------------------------------------------------------------------------------
> 5.70                  | -4.49
> ================================================================================
> 
> 2. For avg cycles of operation
> ================================================================================
> rfc4106(gcm(aes)) (pcrypt(rfc4106(gcm_base(ctr(aes-generic),ghash-generic))))
>                          encryption
> --------------------------------------------------------------------------------
> bit key | byte blocks | base cycles | new cycles  | differ(%)
> 160     | 16          | 32500       | 35847       | 10.3
> 160     | 64          | 33175       | 45808       | 38.08
> ...
> 288     | 4096        | 131369      | 132132      | 0.58
> 288     | 8192        | 229503      | 234581      | 2.21
> --------------------------------------------------------------------------------
> average differ(%s)    | total_differ(%)
> --------------------------------------------------------------------------------
> 8.41                  | -6.70
> ================================================================================
> 
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> ---
>  MAINTAINERS                                 |   6 +
>  tools/crypto/tcrypt/tcrypt_speed_compare.py | 190 ++++++++++++++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100755 tools/crypto/tcrypt/tcrypt_speed_compare.py

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

