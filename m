Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96C380EEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376687AbjLLO2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376605AbjLLO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75714E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702391320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sic7JgTbCqXENzuaXidvmcJDkf8Pxtwv2IpV4/8llXA=;
        b=hrXg1Qz2qMriIzzDLT0EsESX/OqA3/o0ZhbZiH+ntnvNebIQpWuf+gcjg2eJqbBBcMFl9H
        QXPoWaF1XEncqvDNQfo6GZ9wlfwTrsERE8O3LQVgkSYZr1rj/VtkCc21Z6bT7TIDnmHGrE
        Z0O1H4aPEs4cgbupVw2TpWYf/XH0j+0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-QJACo1pDP0GLWdWP7oQvOg-1; Tue, 12 Dec 2023 09:28:39 -0500
X-MC-Unique: QJACo1pDP0GLWdWP7oQvOg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a940dcd1aso78706986d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391319; x=1702996119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sic7JgTbCqXENzuaXidvmcJDkf8Pxtwv2IpV4/8llXA=;
        b=hZX2oOYxxVsSehrkgr0FchC+PN0vShkpOnWfsmrQXsyMYsPQhRMkpLeH/CMwYrmd1Z
         G5D51pqeWlcu76OPhANJuKfEHsbgSTisAh0rCO6Gz5chQbZeJhJ7nzCuitTzPZytUfHx
         wKZBhDx+k/cS+LO7lJQfBtKDi9ufXm0Bnwvmq3V2DjSAU8W21cXydd7bEQKJhyNEhqeL
         CHNgYq9gWwhkwSo5ldh3v3slm8nfsnJT1wDjhKxwjKnwl4ajgKkn7LdX6nkYYNtwQ/zH
         TxP2MA4Dc/ROVGcZdQsWqXlfkREWXtEcze27OekUgjgLA06oBQAWkBtbJ0u70dmfXEPk
         D3PA==
X-Gm-Message-State: AOJu0YxXbABLJcNQdngWXsCpqRZuY7MErv/YyjPoWCRGhdXwScjqdwdk
        yu7ai/P5qHiDsZltkNe8SdL8uDfdN94tA70WBYDdVuyIyitkWx/lmJhpDkqCdgCFG7khKnE2R1N
        i5a56kl9ZqinfZMpH5FlXyEfZ
X-Received: by 2002:a05:6214:c25:b0:67a:a721:830b with SMTP id a5-20020a0562140c2500b0067aa721830bmr7837479qvd.101.1702391318784;
        Tue, 12 Dec 2023 06:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHOEPNqyZdk9QNuyLbwX1ImY1txSg6BBuVoLWOx94ej3ijMZxTQS0qC/sSDGxEP2PvMWaFUg==
X-Received: by 2002:a05:6214:c25:b0:67a:a721:830b with SMTP id a5-20020a0562140c2500b0067aa721830bmr7837469qvd.101.1702391318451;
        Tue, 12 Dec 2023 06:28:38 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id jr12-20020a0562142a8c00b0067a14d996e9sm4231045qvb.1.2023.12.12.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:28:37 -0800 (PST)
Date:   Tue, 12 Dec 2023 08:28:35 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
Message-ID: <d7vwj7p55ig7fjste3ctqwpccuoowh2ryqnmcxq3qqrn6exzjd@z5mbsitxbupk>
References: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
 <ggbqvhdhgl6wmuewqtwtgud7ubx2ypmnb3p6p6w7cy37mnnyxn@2eqd63s2t5ii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ggbqvhdhgl6wmuewqtwtgud7ubx2ypmnb3p6p6w7cy37mnnyxn@2eqd63s2t5ii>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:59:25PM +0300, Serge Semin wrote:
> On Mon, Dec 11, 2023 at 03:31:17PM -0600, Andrew Halaney wrote:
> > Many hardware configurations have the MDIO bus disabled, and are instead
> > using some other MDIO bus to talk to the MAC's phy.
> > 
> > of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> > gracefully instead of failing to probe the MAC.
> > 
> > Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > index fa9e7e7040b9..a39be15d41a8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > @@ -591,7 +591,13 @@ int stmmac_mdio_register(struct net_device *ndev)
> >  	new_bus->parent = priv->device;
> >  
> >  	err = of_mdiobus_register(new_bus, mdio_node);
> > -	if (err != 0) {
> > +	if (err) {
> > +		if (err == -ENODEV) {
> > +			/* The bus is disabled in the devicetree, that's ok */
> > +			mdiobus_free(new_bus);
> > +			return 0;
> > +		}
> > +
> >  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
> >  		goto bus_register_fail;
> >  	}
> 
> This can be implemented a bit simpler, more maintainable and saving
> one indentations level:
> 
> 	err = of_mdiobus_register(new_bus, mdio_node);
> 	if (err == -ENODEV) {
> 		err = 0;
> 		dev_warn(dev, "MDIO bus is disabled\n");

Thanks for all your reviews, I agree this is cleaner!

I'm going to opt to use dev_info() here as this isn't something that's
wrong, just worth noting.

> 		goto bus_register_fail;
> 	} else if (err) {
>   		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
>   		goto bus_register_fail;
> 	}
> 
> -Serge(y)
> 
> > 
> > ---
> > base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
> > change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a
> > 
> > Best regards,
> > -- 
> > Andrew Halaney <ahalaney@redhat.com>
> > 
> 

