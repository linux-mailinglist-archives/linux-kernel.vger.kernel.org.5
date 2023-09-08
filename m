Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790A8798077
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbjIHCTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjIHCTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:19:42 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78EFD1BD5;
        Thu,  7 Sep 2023 19:19:35 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(696440:0:AUTH_RELAY)
        (envelope-from <chiaen_wu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 08 Sep 2023 10:19:13 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 8 Sep
 2023 10:19:13 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 8 Sep 2023 10:19:13 +0800
Date:   Fri, 8 Sep 2023 10:19:13 +0800
From:   ChiaEn Wu <chiaen_wu@richtek.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <error27@gmail.com>
Subject: Re: [PATCH] power: supply: mt6370: Fix missing error code in
 mt6370_chg_toggle_cfo()
Message-ID: <20230908021913.GB3115@linuxcarl2.richtek.com>
References: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
 <cd6eea67-df0f-08b1-61cd-57a3b4f9cf0d@collabora.com>
 <1092ffb3-0238-4dc0-baf3-344a653fca3f@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1092ffb3-0238-4dc0-baf3-344a653fca3f@kadam.mountain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:08:17PM +0300, Dan Carpenter wrote:

[...]

> > > diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
> > > index f27dae5043f5..a9641bd3d8cf 100644
> > > --- a/drivers/power/supply/mt6370-charger.c
> > > +++ b/drivers/power/supply/mt6370-charger.c
> > > @@ -324,7 +324,7 @@ static int mt6370_chg_toggle_cfo(struct mt6370_priv *priv)
> > >   	if (fl_strobe) {
> > >   		dev_err(priv->dev, "Flash led is still in strobe mode\n");
> > > -		return ret;
> > > +		return -EINVAL;
> > 
> > I think that returning 0 here was intentional, but I agree on a return ret
> > here being both confusing and wrong.
> 
> If it's a success path then probably we should remove the dev_err().
> 

Hi all,
Sorry for the late reply!

I agree with the first half of Angelo's statement, I did make the
mistake on this 'return ret'.
What I was trying to say is that you should not to toggle cfo function
when the FLED of MT6370 is still in "strobe mode".

Therefore, I think the change of Harshit's patch is correct.
It should be 'return -EINVAL' or 'return -EPERM' here.

Thanks!


Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>


Best regards,
ChiaEn Wu
