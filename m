Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966D87983F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbjIHIZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjIHIZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:25:40 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF80173B;
        Fri,  8 Sep 2023 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gY8pEmTJXtv0dZXhERhTMp3aYH17SPJkChNTv4UmRQ4=;
  b=LeTIGAwi1VAW5MN0IgTVK3AyllpkDb36k0TRwKVJ6qHjrjArO6FDgV9A
   MFl+q1+Ws1s+6mm6ROcsvuiwuemuiOmF38jkJb2DTjcNefFmP4rtxDwie
   OMtO/c2KywOJoPQDtl2lHkfNjjE0+w93pAe/0UiMmgPpWpbg+YrTItHfL
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,236,1688421600"; 
   d="scan'208";a="65421870"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 10:25:35 +0200
Date:   Fri, 8 Sep 2023 10:25:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
cc:     Liam Girdwood <lgirdwood@gmail.com>,
        kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] ASoC: rsnd: add missing of_node_put
In-Reply-To: <874jk55heh.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <6348f825-645b-14ed-31e-7ef7f607a29@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr> <20230907095521.14053-11-Julia.Lawall@inria.fr> <874jk55heh.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Sep 2023, Kuninori Morimoto wrote:

>
> Hi Julia
>
> Thank you for the patch
>
> > for_each_child_of_node performs an of_node_get on each
> > iteration, so a break out of the loop requires an
> > of_node_put.
> >
> > This was done using the Coccinelle semantic patch
> > iterators/for_each_child.cocci
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  sound/soc/sh/rcar/core.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff -u -p a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
> > --- a/sound/soc/sh/rcar/core.c
> > +++ b/sound/soc/sh/rcar/core.c
> > @@ -1303,6 +1303,7 @@ audio_graph:
> >  		if (i >= RSND_MAX_COMPONENT) {
> >  			dev_info(dev, "reach to max component\n");
> >  			of_node_put(node);
> > +			of_node_put(ports);
> >  			break;
> >  		}
> >  	}
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> I noticed that existing "of_node_put(node)" itself is not needed.
> We can remove it, and I will post the patch next week.

Oops, indeed the better way to make the change would have been to convert
node to ports.  It's just a copy paste error with respect to the code
above the audio_graph label.  Do you want me to send this change instead?

julia

>
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto
>
