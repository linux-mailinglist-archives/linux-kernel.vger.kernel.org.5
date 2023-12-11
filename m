Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295C680DB16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjLKTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbjLKTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF0CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702324132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEGu5Pqve0aT3zGM/NWkBL3jW0pZ4kUH+m9rr+P8JqA=;
        b=K9lASk5BTVoLhP7jcslyZXa6BIXTZwsg6vKAh9H37nd9b7d7e81kD0+stmcbFY9wd1spS3
        19fDcZqK+nl1Tm3/bPNIc13LOecIvzpiXfagK3bdzCB2wccZiF1GHdWjWAkZqLqkoYDv/7
        Av5aNgTwPNdq7Pu6ms8mM/+h4KU1nWQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-yhcYFG6SMQSYm_emxMXRjA-1; Mon, 11 Dec 2023 14:48:50 -0500
X-MC-Unique: yhcYFG6SMQSYm_emxMXRjA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-db410931c23so5047551276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324130; x=1702928930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEGu5Pqve0aT3zGM/NWkBL3jW0pZ4kUH+m9rr+P8JqA=;
        b=MR6VVmWsz7p6+JP4S0Mv214RycjXMBR/XWN2docTYWXSblM/IDblRKVIcHZVJc9qoU
         CYx7wGCTVJOhzud3dEWeKUAGdXDUe0oHXGQwTx6xLD48+Sh9Va1jcln+ju7V3TysErxK
         hNh8nUeYPEfsE3mgU9q6CKdRtep6hVdAZ9nPQ0h0GGbaDGkVRaWCi4YMpHqkuloW98Jo
         L5+j0MLnXZXQ5oVSA00hfReX9yyf2QT0kKBH6AQuPZHBgn93YI0FAZ0hU+JEd8jZlifh
         5eqW/9ejrTAgE0DSejf6cmKtYO/xWJk6toFuraK+/n8vwZxDtSjo4QvPxMTB5hdIdM8p
         GVBQ==
X-Gm-Message-State: AOJu0YxP1yhAGJb0whlMool9EJAiVm1/LZY1qG26tgxIMuacrY7gTtK+
        vzOn/XfzeOAGhvJX6yFZT184uE8qt2i7Zvs6a9DmjiXpfk6YbcuyVgz6ZoQlcOw+hDQsXizrrqv
        2k+wbuiWucFKhkYCijsbPoOjV
X-Received: by 2002:a05:6902:248:b0:db5:4669:fdb1 with SMTP id k8-20020a056902024800b00db54669fdb1mr2857463ybs.39.1702324130036;
        Mon, 11 Dec 2023 11:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMzXiz7DxmAMKunWzpipPJqY65gNgsQH47Q99/oPZT0u0DHwZNoplAe6V+UQ1a5fGUPA4YiQ==
X-Received: by 2002:a05:6902:248:b0:db5:4669:fdb1 with SMTP id k8-20020a056902024800b00db54669fdb1mr2857455ybs.39.1702324129663;
        Mon, 11 Dec 2023 11:48:49 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id p5-20020a05621415c500b0067ac2df0199sm3527653qvz.128.2023.12.11.11.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:48:49 -0800 (PST)
Date:   Mon, 11 Dec 2023 13:48:47 -0600
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
Message-ID: <slq3uvpe424lxksgc2ho4q5apon6yqyvmq3ubpmx3z5ln5yhqf@klnkglqb6o6r>
References: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
 <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
 <hxds75erxqcfkufxnfbyo2up4b4jeicmi3f5xr6qlb3yf7fe76@4byeq62jhu4o>
 <hgz3pt625kggix6kzincohw7kr2okcumrwfkmjgiauw2yvhrzt@ekeygo4b7k3b>
 <h5ucipgjtsesrz3jyul5xohu4pqom56v6ayx7aonnfesret3ht@wmblmndj6zir>
 <hpqssnt7odmuuyhsljuqovmwatdjz4s6kix6abq7lrvyciawy5@5ypscmmivnmh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hpqssnt7odmuuyhsljuqovmwatdjz4s6kix6abq7lrvyciawy5@5ypscmmivnmh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 08:27:46PM +0300, Serge Semin wrote:
> On Fri, Dec 08, 2023 at 10:50:29AM -0600, Andrew Halaney wrote:
> > On Fri, Dec 08, 2023 at 06:07:06PM +0300, Serge Semin wrote:
> > > On Thu, Dec 07, 2023 at 05:07:24PM -0600, Andrew Halaney wrote:
> > > > On Fri, Dec 08, 2023 at 01:16:12AM +0300, Serge Semin wrote:
> > > > > On Thu, Dec 07, 2023 at 03:12:40PM -0600, Andrew Halaney wrote:
> > > > > > The stmmac_dt_phy() function, which parses the devicetree node of the
> > > > > > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > > > > > fixed-link means in relation to the MAC's MDIO bus. This results in
> > > > > > a MDIO bus being created in situations it need not be.
> > > > > > 
> > > > > > Currently a MDIO bus is created if the description is either:
> > > > > > 
> > > > > >     1. Not fixed-link
> > > > > >     2. fixed-link but contains a MDIO bus as well
> > > > > > 
> > > > > > The "1" case above isn't always accurate. If there's a phy-handle,
> > > > > > it could be referencing a phy on another MDIO controller's bus[1]. In
> > > > > > this case currently the MAC will make a MDIO bus and scan it all
> > > > > > anyways unnecessarily.
> > > > > > 
> > > > > > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > > > > > be created and scanned for a phy. This case can also be inferred from
> > > > > > the platform description by not having a phy-handle && not being
> > > > > > fixed-link. This hits case "1" in the current driver's logic.
> > > > > > 
> > > > > > Let's improve the logic to create a MDIO bus if either:
> > > > > > 
> > > > > 
> > > > > >     - Devicetree contains a MDIO bus
> > > > > >     - !fixed-link && !phy-handle (legacy handling)
> > > > > 
> > > > > If what you suggest here is a free from regressions semantics change
> > > > > (really hope it is) I will be with both my hands for it. This will
> > > > > solve the problem we have with one of our device which doesn't have
> > > > > SMA interface (hardware designers decided to save ~4K gates of the
> > > > > chip area) but has a PHY externally attached to the DW XGMAC<->XPCS
> > > > > interface. PHY is accessible via a GPIO-based MDIO bus. BTW having no
> > > > > SMA interface available on a DW *MAC device but creating the MDIO-bus
> > > > > on top of the non-existent SMA CSRs anyway causes having _32_ dummy
> > > > > PHYs created with zero IDs.
> > > > 
> > > 
> > > > I hope it is regression free! I have tested both the [1] and [2] cases
> > > > (I hacked up the devicetree for [1] to make it look like [2]) without
> > > > any issue.
> > > > 
> > > 
> > > I doubt you could have tested it on all the possible hardware the
> > > STMMAC driver supports. The problem is that the DT-bindings thing is a
> > > kind of contract which can't be changed that easily. It's like ABI but
> > > for the hardware description so the kernel would bootup correctly on
> > > the platforms with the old DT blobs. But if the change isn't that
> > > critical, if the device-tree sources in the kernel fit to the updated
> > > semantics, if the networking subsystem maintainers aren't against it
> > > and I guess with the Rob, Krzysztof or Conor blessing (at least it
> > > won't hurt to add them to the Cc-list together with the devicetree
> > > mailing-list), then it will likely be accepted.
> > 
> 
> > To be clear, I don't think we're violating the dt-binding ABI contract
> > here. My intention is that all the existing use cases continue to work,
> > and this just improves one use case. I did a write up
> > over on v2 about the use cases I see and the current logic vs what
> > changes with this patch series:
> > 
> >     https://lore.kernel.org/netdev/plvbqgi2bwlv5quvpiwplq7cxx6m5rl3ghnfhuxfx4bpuhyihl@zmydwrtwdeg6/
> > 
> > Please comment if you think I have broken some backwards
> > compatibility.
> 
> To shortly sum up so I didn't miss something. Current semantics of the
> MDIO-bus registration is:
> if !fixed-link || mdio_node_present
>     create MDIO-bus
> and the semantics of the PHY auto-probe (legacy) is:
> if !(fixed-link || mdio_node_present || phy_node_present)
>     auto-probe PHY

I think phy_node_present doesn't belong in the current view of the
semantics for PHY auto-probe (legacy). This devicetree would trigger a
PHY auto-probe/scan on ethernet0's MAC's MDIO bus:

	random-mdio-bus {
		rgmii_phy: phy@0 {
		};
	};

	ethernet0 {
		phy-handle = <&rgmii_phy>;
	};

The assumption I make in this patch is that nothing useful could be on
ethernet0's MDIO bus, it certainly at least is not the phy the MAC uses.

> 
> You are changing the MDIO-bus creation semantics to:
> if !(fixed-link || phy_node_present) || mdio_node_present
>     create MDIO-bus
> with no change in the PHY auto-probe semantics:
> if !(fixed-link || mdio_node_present || phy_node_present)
>     auto-probe PHY

Unfortunately as I highlighted above this logic (while accurate to the
patch under review) is a change from the prior logic for the "auto-probe
PHY" case.

> 
> So the change is that if a PHY-handle is specified the MDIO-bus won't
> be created with the rest conditions being the same.
> 
> The only concern I had was the so called legacy case and a possibility
> to have MDIO-bus with other than PHY devices. Based on the pseudo-code
> above the former case won't be affected since having PHY-node
> specified didn't triggered MDIO-bus auto-probe even before your
> change. The later case concerns for instance the DW XPCS devices which

As I've realized in your response here, there is the possibility that
something is on the MDIO bus in the ethernet0 exmpale bus above, and would
probe, in the before handling. So I guess this isn't totally backwards
compatible. Gah, thanks for highlighting.

I'm not sure in practice if anyone out there is really relying on that
or not. I can get away with the "no auto-probe/scan of bus" optimization I
really desire by describing my MDIO bus as disabled in the devicetree
(need to send patches to do that in the dts and handle it gracefully in
stmmac). I'm wondering if I should keep forth with this patch as is, or
if I should keep the same logic but clean it up a bit as is done in the
current patch... I guess probably the latter.

> on some platforms could be found on the DW MAC MDIO bus with not
> having PHY living on that bus. But DW XPCS auto-probing currently is
> only supported by the non-OF platforms (it's Intel). Thus your change
> is supposed to be safe here too.
> 
> So to speak AFAICS from the STMMAC MDIO OF stuff your solution isn't
> supposed to cause regressions and break the current DTs backward
> compatibility indeed.
> 
> Regarding the ideal implementation. What could be much better is to
> implement the next semantics:
> if SMA-capability-detected &&
>    (!mdio_node_present || (mdio_node_present && mdio_node_enabled))
>     create MDIO-bus
> and preserve the PHY auto-probe semantics for backwards compatibility.
> Regarding the SMA-capability flag, it has been presented since DW GMAC
> v3.50, so since very much early DW MAC releases. But even for the
> early devices I think it could be auto-detected by checking the SMA
> CSRs writability. At least DW XGMAC AFAICS has the command CSR not
> writable if SMA is unavailable.
> 
> But I guess it's a matter of another patch.
> 

I like that logic for what it is worth, although would be unsure of
verifying the SMA-capability-detected part of it. But I wouldn't mind
seeing that patch :)

