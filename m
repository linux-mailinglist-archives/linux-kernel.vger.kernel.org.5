Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C280E95E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjLLKmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:42:36 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF899;
        Tue, 12 Dec 2023 02:42:42 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ca208940b3so69289211fa.1;
        Tue, 12 Dec 2023 02:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702377760; x=1702982560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPX5j6dhcCUNdh2wc/s2iB4qltUUion4giKuNF8IGv0=;
        b=Myr0pVUqAv9XSQSFG+//10BAAJd6scvF1D8kDQtk9TbS4fKfObM+F2gW6VDl6c6tHN
         NnhRRrvVjirbfI734UDJ1rocAHCNk+YYoIMprwRXco9igRihpH+u7sTQemIKuSIfv025
         Qp46alvSlVxP7CDXb/ecqSTZRy8OT/8D3h0JQeiNN0E2RfoxwG2yqXk03K6bJ57YqGxe
         XFr8sMsIOHKZuNebYlPyXEoN78CK7X5uA/WVggDf1lzUUVe7q+fVV9ulGRdB89pXnTck
         BIwalCRMjXbYGADlBGMFEf9k7K4bYICJINpBVsGewSpfYMc727P5ekgnj4BYOSa/p5fT
         cNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377760; x=1702982560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPX5j6dhcCUNdh2wc/s2iB4qltUUion4giKuNF8IGv0=;
        b=AjZLugw6rEWHAz7VfbmnEtMRPbg8AgtXpprOX1KP+iQFOgYsZMrLh2SIeN1R/6VfQ2
         mgYS0aHYd7JhTB6JIT8buxIATZ79khqFdm0zpnUvoCdwa36XMtv0uzIj1jCSgLQ31iP0
         6WTbVLy9KkOw5Z//D2PYTt5M7laBPmwgnEXj6jXHz94lr+rXme6fTIa6B702kZ5HcTYx
         0PJG3pbuq5JlywYB7QeZrKgsYir1q9wQMiFtkW/Hli8I38s1TNDRd+JdvcEs22yHWZRA
         W0vOgalJF081UlY/+iw8Q2ccWzOSCzw+EBUQPOM5rP5G8oZhYRZ6PU8dPhfvYUy87va1
         pA9g==
X-Gm-Message-State: AOJu0Yx62/1C+9bwysQcPhe9Du8IFP6uMqSPc/RPscVHsoua20oL917e
        VMYZMhHpqUvSdcA4UZYEuQi88EbNXwU=
X-Google-Smtp-Source: AGHT+IFZ52J21yKKkOIHpx/PeVrb5JNgIxJ89VAsV8oZh2io5NnN/NJhi5Fjc3bC9NI+fB9k4lQFGw==
X-Received: by 2002:a2e:a7d3:0:b0:2cb:2c91:d5d0 with SMTP id x19-20020a2ea7d3000000b002cb2c91d5d0mr2520112ljp.19.1702377760302;
        Tue, 12 Dec 2023 02:42:40 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b002ca0217f327sm1443551ljo.65.2023.12.12.02.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:42:39 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:42:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
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
Message-ID: <4e42erte4zvx77vgj77kcal2ss4nma3ggm3wa6wssleuubtzit@gbkbbudjfwhz>
References: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
 <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
 <hxds75erxqcfkufxnfbyo2up4b4jeicmi3f5xr6qlb3yf7fe76@4byeq62jhu4o>
 <hgz3pt625kggix6kzincohw7kr2okcumrwfkmjgiauw2yvhrzt@ekeygo4b7k3b>
 <h5ucipgjtsesrz3jyul5xohu4pqom56v6ayx7aonnfesret3ht@wmblmndj6zir>
 <hpqssnt7odmuuyhsljuqovmwatdjz4s6kix6abq7lrvyciawy5@5ypscmmivnmh>
 <slq3uvpe424lxksgc2ho4q5apon6yqyvmq3ubpmx3z5ln5yhqf@klnkglqb6o6r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slq3uvpe424lxksgc2ho4q5apon6yqyvmq3ubpmx3z5ln5yhqf@klnkglqb6o6r>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:48:47PM -0600, Andrew Halaney wrote:
> On Mon, Dec 11, 2023 at 08:27:46PM +0300, Serge Semin wrote:
> > On Fri, Dec 08, 2023 at 10:50:29AM -0600, Andrew Halaney wrote:
> > > On Fri, Dec 08, 2023 at 06:07:06PM +0300, Serge Semin wrote:
> > > > On Thu, Dec 07, 2023 at 05:07:24PM -0600, Andrew Halaney wrote:
> > > > > On Fri, Dec 08, 2023 at 01:16:12AM +0300, Serge Semin wrote:
> > > > > > On Thu, Dec 07, 2023 at 03:12:40PM -0600, Andrew Halaney wrote:
> > > > > > > The stmmac_dt_phy() function, which parses the devicetree node of the
> > > > > > > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > > > > > > fixed-link means in relation to the MAC's MDIO bus. This results in
> > > > > > > a MDIO bus being created in situations it need not be.
> > > > > > > 
> > > > > > > Currently a MDIO bus is created if the description is either:
> > > > > > > 
> > > > > > >     1. Not fixed-link
> > > > > > >     2. fixed-link but contains a MDIO bus as well
> > > > > > > 
> > > > > > > The "1" case above isn't always accurate. If there's a phy-handle,
> > > > > > > it could be referencing a phy on another MDIO controller's bus[1]. In
> > > > > > > this case currently the MAC will make a MDIO bus and scan it all
> > > > > > > anyways unnecessarily.
> > > > > > > 
> > > > > > > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > > > > > > be created and scanned for a phy. This case can also be inferred from
> > > > > > > the platform description by not having a phy-handle && not being
> > > > > > > fixed-link. This hits case "1" in the current driver's logic.
> > > > > > > 
> > > > > > > Let's improve the logic to create a MDIO bus if either:
> > > > > > > 
> > > > > > 
> > > > > > >     - Devicetree contains a MDIO bus
> > > > > > >     - !fixed-link && !phy-handle (legacy handling)
> > > > > > 
> > > > > > If what you suggest here is a free from regressions semantics change
> > > > > > (really hope it is) I will be with both my hands for it. This will
> > > > > > solve the problem we have with one of our device which doesn't have
> > > > > > SMA interface (hardware designers decided to save ~4K gates of the
> > > > > > chip area) but has a PHY externally attached to the DW XGMAC<->XPCS
> > > > > > interface. PHY is accessible via a GPIO-based MDIO bus. BTW having no
> > > > > > SMA interface available on a DW *MAC device but creating the MDIO-bus
> > > > > > on top of the non-existent SMA CSRs anyway causes having _32_ dummy
> > > > > > PHYs created with zero IDs.
> > > > > 
> > > > 
> > > > > I hope it is regression free! I have tested both the [1] and [2] cases
> > > > > (I hacked up the devicetree for [1] to make it look like [2]) without
> > > > > any issue.
> > > > > 
> > > > 
> > > > I doubt you could have tested it on all the possible hardware the
> > > > STMMAC driver supports. The problem is that the DT-bindings thing is a
> > > > kind of contract which can't be changed that easily. It's like ABI but
> > > > for the hardware description so the kernel would bootup correctly on
> > > > the platforms with the old DT blobs. But if the change isn't that
> > > > critical, if the device-tree sources in the kernel fit to the updated
> > > > semantics, if the networking subsystem maintainers aren't against it
> > > > and I guess with the Rob, Krzysztof or Conor blessing (at least it
> > > > won't hurt to add them to the Cc-list together with the devicetree
> > > > mailing-list), then it will likely be accepted.
> > > 
> > 
> > > To be clear, I don't think we're violating the dt-binding ABI contract
> > > here. My intention is that all the existing use cases continue to work,
> > > and this just improves one use case. I did a write up
> > > over on v2 about the use cases I see and the current logic vs what
> > > changes with this patch series:
> > > 
> > >     https://lore.kernel.org/netdev/plvbqgi2bwlv5quvpiwplq7cxx6m5rl3ghnfhuxfx4bpuhyihl@zmydwrtwdeg6/
> > > 
> > > Please comment if you think I have broken some backwards
> > > compatibility.
> > 
> > To shortly sum up so I didn't miss something. Current semantics of the
> > MDIO-bus registration is:
> > if !fixed-link || mdio_node_present
> >     create MDIO-bus
> > and the semantics of the PHY auto-probe (legacy) is:
> > if !(fixed-link || mdio_node_present || phy_node_present)
> >     auto-probe PHY
> 

> I think phy_node_present doesn't belong in the current view of the
> semantics for PHY auto-probe (legacy). This devicetree would trigger a
> PHY auto-probe/scan on ethernet0's MAC's MDIO bus:
> 
> 	random-mdio-bus {
> 		rgmii_phy: phy@0 {
> 		};
> 	};
> 
> 	ethernet0 {
> 		phy-handle = <&rgmii_phy>;
> 	};

Em, unless I miss something, but on STMMAC it wont due to the next
statement: stmmac_mdio_register():
	if (priv->plat->phy_node || mdio_node)
		goto bus_register_done;

Note by the "PHY auto-probe (legacy)" semantics I meant the algo
implemented at the bottom of the stmmac_mdio_register() method. If no
PHY-node or MDIO-node specified it tries to find any PHY on the
DW MAC SMA MDIO bus and use it in the driver.

If what you meant was the PHY auto-probe/scan executed in the
__mdiobus_register() method, then I guess it's relevant only _if_ the
stmmac_mdio_register() method performs the legacy auto-probing too.
Yes, the MDIO/PHY subsystem _will_ scan the MDIO-bus for PHYs, but
they won't be utilized in the STMMAC driver due to the conditional
statement above. In other words I guess the scanning performed in
__mdiobus_register() will be pointless anyway in that case, since no
detected PHY-devices will be actually used afterwards.

> 
> The assumption I make in this patch is that nothing useful could be on
> ethernet0's MDIO bus, it certainly at least is not the phy the MAC uses.
> 
> > 
> > You are changing the MDIO-bus creation semantics to:
> > if !(fixed-link || phy_node_present) || mdio_node_present
> >     create MDIO-bus
> > with no change in the PHY auto-probe semantics:
> > if !(fixed-link || mdio_node_present || phy_node_present)
> >     auto-probe PHY
> 
> Unfortunately as I highlighted above this logic (while accurate to the
> patch under review) is a change from the prior logic for the "auto-probe
> PHY" case.
> 
> > 
> > So the change is that if a PHY-handle is specified the MDIO-bus won't
> > be created with the rest conditions being the same.
> > 
> > The only concern I had was the so called legacy case and a possibility
> > to have MDIO-bus with other than PHY devices. Based on the pseudo-code
> > above the former case won't be affected since having PHY-node
> > specified didn't triggered MDIO-bus auto-probe even before your
> > change. The later case concerns for instance the DW XPCS devices which
> 
> As I've realized in your response here, there is the possibility that
> something is on the MDIO bus in the ethernet0 exmpale bus above, and would
> probe, in the before handling. So I guess this isn't totally backwards
> compatible. Gah, thanks for highlighting.

AFAICS what you suggest won't break currently supported by the STMMAC
driver _platforms_. This is what actually matters. The legacy PHY
auto-probing will work as before. None of the OF-based platforms
currently expect having non-PHY devices on the bus.

> 
> I'm not sure in practice if anyone out there is really relying on that
> or not. I can get away with the "no auto-probe/scan of bus" optimization I
> really desire by describing my MDIO bus as disabled in the devicetree
> (need to send patches to do that in the dts and handle it gracefully in
> stmmac). I'm wondering if I should keep forth with this patch as is, or
> if I should keep the same logic but clean it up a bit as is done in the
> current patch... I guess probably the latter.

It's better to limit some complicated logic before somebody tries to
use it to bypass a harder but correct way of directly defining all
devices (including non-PHY ones) in dts. Seeing presumably no
currently supported platform will be broken I think you should keep
the patch as is.

-Serge(y)

> 
> > on some platforms could be found on the DW MAC MDIO bus with not
> > having PHY living on that bus. But DW XPCS auto-probing currently is
> > only supported by the non-OF platforms (it's Intel). Thus your change
> > is supposed to be safe here too.
> > 
> > So to speak AFAICS from the STMMAC MDIO OF stuff your solution isn't
> > supposed to cause regressions and break the current DTs backward
> > compatibility indeed.
> > 
> > Regarding the ideal implementation. What could be much better is to
> > implement the next semantics:
> > if SMA-capability-detected &&
> >    (!mdio_node_present || (mdio_node_present && mdio_node_enabled))
> >     create MDIO-bus
> > and preserve the PHY auto-probe semantics for backwards compatibility.
> > Regarding the SMA-capability flag, it has been presented since DW GMAC
> > v3.50, so since very much early DW MAC releases. But even for the
> > early devices I think it could be auto-detected by checking the SMA
> > CSRs writability. At least DW XGMAC AFAICS has the command CSR not
> > writable if SMA is unavailable.
> > 
> > But I guess it's a matter of another patch.
> > 
> 
> I like that logic for what it is worth, although would be unsure of
> verifying the SMA-capability-detected part of it. But I wouldn't mind
> seeing that patch :)
> 
