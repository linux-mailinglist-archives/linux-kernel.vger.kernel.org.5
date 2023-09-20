Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966637A778C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjITJaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjITJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:30:42 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B9D9;
        Wed, 20 Sep 2023 02:30:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58162E0015;
        Wed, 20 Sep 2023 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695202232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRsjF3ZsI6skt5kshYvuqos8ZR+vrYu2G0yFq6mynuo=;
        b=KXTPoMu03uZGq75hrW7mMTRi86wRm+y6XEOdV3KTGlKmjO4xLicAY8Sn93ObuLzTNWnWEC
        7FMjjX4SH5ULx+sSrkt2me3djgfCsz5ckQm1s5+mh39Ls80z+2+k6mjp1UIHpnqdfxuK9l
        3WTNGnNFj0CKDjgq8H97vE6U8A0bGTQz0IoBudf4WdiJeeFr4vEnz3ZpGRsEQk41vm1qra
        G/GKr1+A6YHHYTKIwP37L/QeOfLKSmdX9VFLmaLADLKFNR6qWtI2m02KTmrLuXjLPaBQy7
        Jc6liGruNi6RWiSMVRz57b0El4vvShFogf+ksdg2pA+iloqrfory++Vf6tCzvQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>, Andrew Lunn <andrew@lunn.ch>
Cc:     kernel-janitors@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] soc: dove: add missing of_node_put
In-Reply-To: <20230907095521.14053-8-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
 <20230907095521.14053-8-Julia.Lawall@inria.fr>
Date:   Wed, 20 Sep 2023 11:30:30 +0200
Message-ID: <87jzslfayx.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <Julia.Lawall@inria.fr> writes:

> for_each_available_child_of_node performs an of_node_get
> on each iteration, so a break out of the loop requires an
> of_node_put.
>
> This was done using the Coccinelle semantic patch
> iterators/for_each_child.cocci
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied on mvebu/arm

Thanks,

Gregory
>
> ---
>  drivers/soc/dove/pmu.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff -u -p a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -410,13 +410,16 @@ int __init dove_init_pmu(void)
>  		struct pmu_domain *domain;
>  
>  		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> -		if (!domain)
> +		if (!domain) {
> +			of_node_put(np);
>  			break;
> +		}
>  
>  		domain->pmu = pmu;
>  		domain->base.name = kasprintf(GFP_KERNEL, "%pOFn", np);
>  		if (!domain->base.name) {
>  			kfree(domain);
> +			of_node_put(np);
>  			break;
>  		}
>  
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
