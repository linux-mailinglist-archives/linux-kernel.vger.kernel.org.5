Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D714976566D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjG0Ovt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjG0Ovr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93368F2;
        Thu, 27 Jul 2023 07:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2525C61E93;
        Thu, 27 Jul 2023 14:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2F5C433C7;
        Thu, 27 Jul 2023 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690469505;
        bh=s1VVaYegFm6vNu7SJpIYS1RfGm4Sdgis0eGoHqKbqXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpUzgVJ+DGM/krJdfj7dyUfMPQE77VbmBYNRZJReCMO+B4kJEqZhDY5CdBngpHrQh
         CTCNV3QxqgO8aTwR8tgYJo5yJ0OjJ1JTC8XYnoexe15EfeGZF7ax9bBc8SibsCSkP7
         fZZfzp4ziVGlvGMkMyyP8N1Dw17ceiqPpZ7R75AFBPLXsDRUxitloLsdHH1Sn11M2N
         20gugXwjmTx1RONoXq+Wqz6/+1Xs+ARTb90HjuKizSlvgLiGFF26wkTI1Lm7AXunyX
         xAopRBGuptnY/NOIIf9Hjd4KYZTP2InzDETBpj4MrFeQf2lldBrcVvko5+Dp4bu7y5
         gPUNQjZVCCXVQ==
Date:   Thu, 27 Jul 2023 07:51:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "zzzzTilki, zzzzIbrahim" <Ibrahim.Tilki@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831
 Regulator Support
Message-ID: <20230727145143.GB2013261@dev-arch.thelio-3990X>
References: <20230717050736.10075-1-okan.sahin@analog.com>
 <20230717050736.10075-3-okan.sahin@analog.com>
 <20230718155502.GA3542993@dev-arch.thelio-3990X>
 <20230726161033.GA1102409@dev-arch.thelio-3990X>
 <PH7PR03MB739122A373964651D995EA5AE701A@PH7PR03MB7391.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB739122A373964651D995EA5AE701A@PH7PR03MB7391.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:34:44AM +0000, Sahin, Okan wrote:
> >On Tue, Jul 18, 2023 at 08:55:02AM -0700, Nathan Chancellor wrote:
> >
> ><snip>
> >
> >> > +static struct regulator_desc max77857_regulator_desc = {
> >> > +	.ops = &max77857_regulator_ops,
> >> > +	.name = "max77857",
> >> > +	.linear_ranges = max77857_lin_ranges,
> >> > +	.n_linear_ranges = ARRAY_SIZE(max77857_lin_ranges),
> >> > +	.vsel_mask = 0xFF,
> >> > +	.vsel_reg = MAX77857_REG_CONT2,
> >> > +	.ramp_delay_table = max77857_ramp_table[0],
> >> > +	.n_ramp_values = ARRAY_SIZE(max77857_ramp_table[0]),
> >> > +	.ramp_reg = MAX77857_REG_CONT3,
> >> > +	.ramp_mask = GENMASK(1, 0),
> >> > +	.ramp_delay = max77857_ramp_table[0][0],
> >>
> >> This breaks the build with GCC 5.x through 7.x:
> >>
> >>   drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not
> >constant
> >>     .ramp_delay = max77857_ramp_table[0][0],
> >>                   ^~~~~~~~~~~~~~~~~~~
> >>   drivers/regulator/max77857-regulator.c:312:16: note: (near initialization for
> >'max77857_regulator_desc.ramp_delay')
> >>
> >> and clang:
> >>
> >>   drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not a
> >compile-time constant
> >>     312 |         .ramp_delay = max77857_ramp_table[0][0],
> >>         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
> >>   1 error generated.
> >>
> >> This relies on a GCC 8.x+ change that accepts more things as
> >> compile-time constants, which is being worked on in clang
> >>
> >(https://urldefense.com/v3/__https://reviews.llvm.org/D76096__;!!A3Ni8CS0y2Y!7B
> >eWxuzHgLzOprQA_madbvdR7hd0ZgmS73lUlDbgoxWUFWdDSIRXLnhyqLeRhu3uTaqpS
> >kzZKwc5pHA$ ). Since the kernel supports older
> >> compilers, this will have to be worked around somehow. Perhaps a define
> >> that can be used in both places?
> >
> >Was there any update on this? I do not mind sending a patch for this
> >myself if I have some sort of guidance on how you would prefer for this
> >to be fixed, should you be too busy to look into it.
> >
> >Cheers,
> >Nathan
> 
> Hi Nathan,
> 
> I thought that I should fix this issue after merging main branch that's why I did not send patch.

That is an understandable position but no, this issue should be fixed
before this change makes its way to Linus, not after.

> I sent patch v3 so should I send new patch as v4?

No, you should checkout Mark's branch that contains your patch and send
a new patch on top of it just fixing this issue, like the other two
patches that have already touched this driver:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/log/?h=for-6.6

https://git.kernel.org/broonie/regulator/c/2920e08bef609c8b59f9996fd6852a7b97119d75
https://git.kernel.org/broonie/regulator/c/541e75954cadde0355ce7bebed5675625b2943a8

There are GCC 7.x and earlier toolchains at
https://kernel.org/pub/tools/crosstool/ and LLVM toolchains at
https://kernel.org/pub/tools/llvm/ should need to reproduce and verify
the fix.

Cheers,
Nathan
