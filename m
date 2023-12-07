Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F011580966D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444122AbjLGXHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjLGXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:07:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C951710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701990450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVM1WmJwjQIszb+XLXzan7QiLivbxv0y5A1QhrsixGY=;
        b=CvyKPJcD3GBjwcui2Ijk0kvJ2V+47M2DpYeBD5vZJnHiFQIWv64D4MA/QNhqY+eAZqZpX/
        0YRLQz7UHj1tUZT6GPh9z+vsDf3tJ3OXcWjpapbUMW/77riCrceJbOa+LEF6CT/e6Z6Mcy
        Z5+SfS4glykTGpxpcM94r40cD5c9p8Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-8kNBQv11PkiX0xbrHk0Euw-1; Thu, 07 Dec 2023 18:07:27 -0500
X-MC-Unique: 8kNBQv11PkiX0xbrHk0Euw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4257b29b96aso17774731cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990447; x=1702595247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVM1WmJwjQIszb+XLXzan7QiLivbxv0y5A1QhrsixGY=;
        b=jkvv9Nq/f2BtbUTIrtI2TRJZIiU0IkoyUw7owuiITqHZ3Z9T4JJfhIUE9xUE6Qp0qA
         +5ySu9QXbefY+zuCqTkSHJ8ZXWKHcHo0DIVu4TfwTsL+Lh5FmsoElX4LvnW0NRJgZCJD
         CZwJkXJu7qCLdOtVXTviXBEfbAwQl1iUU6kUMnbH4B0o3PAYc+BUaGKGQscisAmzfNMS
         JtbJ1cuYtE5qNO9M1EKYbTxflO36mCe6BsR/CTulere774TZFqJ8OgW842ORh+O9h63J
         ZmYx7WnAco8qp9ZR1PgfD1S7KqpSIOvtXJGblwA7YSO6e1wFVNPs+0TFGwpv+13W0lZz
         B0ew==
X-Gm-Message-State: AOJu0YzQt+VoY9wWgWQxWHunDygXw3t7Hxp85uL6f75J9CWWOdtSl6Sl
        sXTfIvC5tP5b1A6VGjxLsvRq2EBiniCpv8yxTS0mIiKMIX+lZHtLIbfd03+mR2wZvgjRlyWW7+a
        uxdNCVeEoPYeZcIiSBhywqV0d
X-Received: by 2002:a05:622a:1a0c:b0:417:fd7e:2154 with SMTP id f12-20020a05622a1a0c00b00417fd7e2154mr4335058qtb.9.1701990447263;
        Thu, 07 Dec 2023 15:07:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELEnmaKlLkEXPtsoU1QDWmch2MnIAl4zsRZz3furlGlXRAjnhjBjwRDw+3e9RFT1Hd9Ndx5A==
X-Received: by 2002:a05:622a:1a0c:b0:417:fd7e:2154 with SMTP id f12-20020a05622a1a0c00b00417fd7e2154mr4335040qtb.9.1701990447010;
        Thu, 07 Dec 2023 15:07:27 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id t18-20020ac865d2000000b00423829b6d91sm294156qto.8.2023.12.07.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:07:26 -0800 (PST)
Date:   Thu, 7 Dec 2023 17:07:24 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <hxds75erxqcfkufxnfbyo2up4b4jeicmi3f5xr6qlb3yf7fe76@4byeq62jhu4o>
References: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
 <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 01:16:12AM +0300, Serge Semin wrote:
> On Thu, Dec 07, 2023 at 03:12:40PM -0600, Andrew Halaney wrote:
> > The stmmac_dt_phy() function, which parses the devicetree node of the
> > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > fixed-link means in relation to the MAC's MDIO bus. This results in
> > a MDIO bus being created in situations it need not be.
> > 
> > Currently a MDIO bus is created if the description is either:
> > 
> >     1. Not fixed-link
> >     2. fixed-link but contains a MDIO bus as well
> > 
> > The "1" case above isn't always accurate. If there's a phy-handle,
> > it could be referencing a phy on another MDIO controller's bus[1]. In
> > this case currently the MAC will make a MDIO bus and scan it all
> > anyways unnecessarily.
> > 
> > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > be created and scanned for a phy. This case can also be inferred from
> > the platform description by not having a phy-handle && not being
> > fixed-link. This hits case "1" in the current driver's logic.
> > 
> > Let's improve the logic to create a MDIO bus if either:
> > 
> 
> >     - Devicetree contains a MDIO bus
> >     - !fixed-link && !phy-handle (legacy handling)
> 
> If what you suggest here is a free from regressions semantics change
> (really hope it is) I will be with both my hands for it. This will
> solve the problem we have with one of our device which doesn't have
> SMA interface (hardware designers decided to save ~4K gates of the
> chip area) but has a PHY externally attached to the DW XGMAC<->XPCS
> interface. PHY is accessible via a GPIO-based MDIO bus. BTW having no
> SMA interface available on a DW *MAC device but creating the MDIO-bus
> on top of the non-existent SMA CSRs anyway causes having _32_ dummy
> PHYs created with zero IDs.

I hope it is regression free! I have tested both the [1] and [2] cases
(I hacked up the devicetree for [1] to make it look like [2]) without
any issue.

Sorry, I don't have any docs for stmmac hardware so this might be
answered in there (or just common net knowledge that I can't find
online)... what's SMA stand for? I assume it's the MDIO interface.

I agree though, if you have a phy-handle and no mdio node in your
devicetree this patch series should bail out without registering a bus
in stmmac_mdio_register().

> 
> > 
> > Below upstream devicetree snippets can be found that explain some of
> > the cases above more concretely.

<snip>

> > -	if (mdio) {
> > -		plat->mdio_bus_data =
> > -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> > -				     GFP_KERNEL);
> 
> > +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> > +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> > +	 * described assume this is the case since there must be something
> > +	 * connected to the MAC.
> > +	 */
> > +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> > +	if (legacy_mdio)
> > +		dev_info(dev, "Deprecated MDIO bus assumption used\n");
> > +
> > +	if (plat->mdio_node || legacy_mdio) {
> > +		plat->mdio_bus_data = devm_kzalloc(dev,
> 
> Special thanks for adding the comment above this code. It will really
> save time of figuring out why MDIO-bus needs to be created anyway.
> 
> > +						   sizeof(struct stmmac_mdio_bus_data),
> 
> Should v4 is required I would suggest to change this to
> sizeof(*plat->mdio_bus_data).
> 
> Anyway feel free to add:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> -Serge(y)

Sure I will spin v4 to pick that up, thanks for catching it. I'll also
improve the motivation in the commit message a hair more per Andrew
Lunn's request over here on v2 (and will hold off a little bit just to
make sure reviews come in before a respin):

    https://lore.kernel.org/netdev/e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch/

Thanks,
Andrew

