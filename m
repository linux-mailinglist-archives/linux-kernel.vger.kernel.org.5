Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3DE809ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573116AbjLHEIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:08:06 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6A1716;
        Thu,  7 Dec 2023 20:08:12 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1rBS9Z-008Ijk-He; Fri, 08 Dec 2023 12:07:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:08:03 +0800
Date:   Fri, 8 Dec 2023 12:08:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, alobakin@pm.me, tj@kernel.org,
        masahiroy@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/octeontx2: By default allocate one CPT LF per CPT
 VF
Message-ID: <ZXKWo66iNvgpjaJ5@gondor.apana.org.au>
References: <20231129154133.1529898-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129154133.1529898-1-bbhushan2@marvell.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:11:33PM +0530, Bharat Bhushan wrote:
> There are limited number CPT LFs (example 64 LFs on cn10k) and
> these LFs are allocated/attached to CPT VF on its creation.
> cptpf sysfs parameter "kvf_limits" defines number of CPT LFs
> per CPT VF. Default "kvf_limits" is initialized to zero and if
> kvf_limits is zero then number of LF allocated are equal to
> online cpus in system.
> 
> For example on 24 core system, 24 CPT LFs will be attached per VF.
> That means no CPT LF available when creating more than 2 CPT VFs
> on system which have total 64 LFs. Although VFs gets created but
> no LF attached to it.
> 
> There seems no reason to default allocate as many LFs as many
> online cpus in system. This patch initializes "kvf_limits" to
> one to limit one LF allocated per CPT VF. "kvf_limits" can
> be changed in range of 1 to number-of-online-cpus via sysfs.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 1 +
>  drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
