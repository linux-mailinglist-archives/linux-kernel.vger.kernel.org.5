Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852D763C09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGZQKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGZQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88924E69;
        Wed, 26 Jul 2023 09:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1177161B98;
        Wed, 26 Jul 2023 16:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA26C433C8;
        Wed, 26 Jul 2023 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387835;
        bh=qhh+3j8N6q6NVAAvJRPIR8+pO3TF/9D0pqLuDATiMAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbLIuZJ5cKJWKw0PxRddMDu7C0WukuzT1O2DRtIHr+Lx+bT/vQNcoohdpANr+yqhL
         NA7jomWdrEr/qLXCoFD28mKU9qXAY0YyPUeLiqhK8u/vuAgkFT0MXPsW5LjISoI06Y
         dfSGQQTeQAwh7lAbJ9YnKgx856uZhZy4BoVm4ahnJYXM+1lM+Hy6IjLD4Xta26OUrw
         eGV+1VESWYE4NcGq3NbRJuwKKWqtUmUQuPgzbt96mVeytVTclTlMHbHgO5Dp6S0tQd
         4cKgIqQ4BwrA8wnKlcTa5j2bFjRC9nsrTDJKYRx6IGm/ij9D3Vd2cSXypGYJSmr/QV
         IJrpU4ESz9g3w==
Date:   Wed, 26 Jul 2023 09:10:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Message-ID: <20230726161033.GA1102409@dev-arch.thelio-3990X>
References: <20230717050736.10075-1-okan.sahin@analog.com>
 <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718155502.GA3542993@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Okan,

On Tue, Jul 18, 2023 at 08:55:02AM -0700, Nathan Chancellor wrote:

<snip>

> > +static struct regulator_desc max77857_regulator_desc = {
> > +	.ops = &max77857_regulator_ops,
> > +	.name = "max77857",
> > +	.linear_ranges = max77857_lin_ranges,
> > +	.n_linear_ranges = ARRAY_SIZE(max77857_lin_ranges),
> > +	.vsel_mask = 0xFF,
> > +	.vsel_reg = MAX77857_REG_CONT2,
> > +	.ramp_delay_table = max77857_ramp_table[0],
> > +	.n_ramp_values = ARRAY_SIZE(max77857_ramp_table[0]),
> > +	.ramp_reg = MAX77857_REG_CONT3,
> > +	.ramp_mask = GENMASK(1, 0),
> > +	.ramp_delay = max77857_ramp_table[0][0],
> 
> This breaks the build with GCC 5.x through 7.x:
> 
>   drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not constant
>     .ramp_delay = max77857_ramp_table[0][0],
>                   ^~~~~~~~~~~~~~~~~~~
>   drivers/regulator/max77857-regulator.c:312:16: note: (near initialization for 'max77857_regulator_desc.ramp_delay')
> 
> and clang:
> 
>   drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not a compile-time constant
>     312 |         .ramp_delay = max77857_ramp_table[0][0],
>         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> This relies on a GCC 8.x+ change that accepts more things as
> compile-time constants, which is being worked on in clang
> (https://reviews.llvm.org/D76096). Since the kernel supports older
> compilers, this will have to be worked around somehow. Perhaps a define
> that can be used in both places?

Was there any update on this? I do not mind sending a patch for this
myself if I have some sort of guidance on how you would prefer for this
to be fixed, should you be too busy to look into it.

Cheers,
Nathan
