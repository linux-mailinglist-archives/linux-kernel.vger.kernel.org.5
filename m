Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB097C780D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442704AbjJLUrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbjJLUrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:47:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DFEBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:47:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D11C433C7;
        Thu, 12 Oct 2023 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143662;
        bh=aRI71YpV2+d2IfU0eZ+HabZAmiGR+yyp2A4+ZTsQCm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwW6XONp9+IMeAdLC1MyMWFkTL/L1Hr+ur2t+B5NP0UUDc9ONKaqHTzvv0oxqvS9/
         /jXz/mBCECQ846jut7nzwMpEVmoV4xcaSarxfTXPF9zQUCeLVeXpWbQSGeWElukxpH
         hmK9Xu879p9WIcxTglg170fsF1NK+WWmRk+1etdS2+gsznWZdx4SghDduB8FUkFTTI
         D5aLPEDFrX/Ew+4GELA8rAyIl0CXXsS9jBSxEzf4TvcKz0L3tTGLy3DfL+c4iBoH8Y
         V9I7A1mtfNwuYaOTFpgho6RY5aglBHpgGTC2DZO9Cw9eDAHayKrqnTF0tLqIkf0Fdz
         OpimIrub0090Q==
Received: (nullmailer pid 1712886 invoked by uid 1000);
        Thu, 12 Oct 2023 20:47:39 -0000
Date:   Thu, 12 Oct 2023 15:47:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: sound-card-common: List DAPM
 endpoints ignoring system suspend
Message-ID: <20231012204739.GA1706264-robh@kernel.org>
References: <20231011114759.1073757-1-chancel.liu@nxp.com>
 <f639c88d-371a-4c72-a906-47d643b24ca8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f639c88d-371a-4c72-a906-47d643b24ca8@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:21:33PM +0100, Mark Brown wrote:
> On Wed, Oct 11, 2023 at 07:47:58PM +0800, Chancel Liu wrote:
> 
> > +  lpa-widgets:
> > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > +    description: |
> > +      A list of DAPM endpoints which mark paths between these endpoints should
> > +      not be disabled when system enters in suspend state. LPA means low power
> > +      audio case. For example on asymmetric multiprocessor, there are Cortex-A
> 
> I suspect that the DT maintainers would prefer that this description be
> workshopped a bit to remove the Linux specifics.

And Cortex A/M specifics if this is a common binding.


>  I think the key thing
> here is that these are endpoints that can be active over suspend of the
> main application processor that the current operating system is running
> (system DT stuff is an interesting corner case here...), and the example
> is probably a bit specific.  Other bindings use "audio sound widgets"
> rather than "DAPM widgets".
> 
> We also shouldn't see that these endpoints "should not be disabled"
> since that implies that they should be left on even if they aren't
> active which isn't quite the case, instead it's that we can continue
> playing an audio stream through them in suspend.

This seems like one of those things that everyone has/does, and everyone 
handles it a bit differently. I applaud trying to do something common, 
but it isn't really common until we have multiple users.

Rob
