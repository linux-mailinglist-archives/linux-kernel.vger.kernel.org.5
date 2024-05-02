Return-Path: <linux-kernel+bounces-166801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CC68B9FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734251C21EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442AB16FF3E;
	Thu,  2 May 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDXFXq4m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143D16FF47
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671816; cv=none; b=h6puOcMb+3BQmIV/O44VPzcfbwC0by2cMf8AFZY5zmCk4g4Nue00IvQ9E4W4poNEmmFzaQa8sE5b8z5GvX2QV+tsiWD36qk+ryJuD1xJrKtB/tPGQiL027rHO+E4bFOpM1ZkQ2oKgjspulFC4zuyWO49gmWOLEOyEPCrjt6UJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671816; c=relaxed/simple;
	bh=BTonqLlp1+hA4HRasHO3qaD2tXdZWBRRufyu1d/2Vrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZrdQvdy4k3h7RhwuxpiZfruQMPPpqb3T028yc/bXF8DNYfi/zJmLkmxnONx0rzWiazs846mXoWqcCXssMyyntHf6IYVBsJMlwWL6gR3RmaeK+X4Gm4gB8m7/HOlvLfbiaiDRWpcyKE4dDuGCzkUh8Q46tu5ev6zloP1hY0PjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDXFXq4m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714671813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biQjiZPx65qbOD6D6VaTZ+h64lgoGF2JeVbk4Q+BuGU=;
	b=EDXFXq4mXUMKutilrV46ad4vl1EJjwGE1rlG3z7gayv9Tiekk+30RTtabH/p1Uma8zcuid
	EvA3Gw1uO2xtHCX8UC4XTPniU8jZObS0B/n41epte0gajCyGwjDwYMp5bQEBTNaKf6i6s9
	oOz5vjIFGRan5CiR/nrBUs+bY9GreFA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-IMSezCCMNni_FDIJmRdndA-1; Thu, 02 May 2024 13:43:31 -0400
X-MC-Unique: IMSezCCMNni_FDIJmRdndA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c8641af4a3so5971848b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671811; x=1715276611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biQjiZPx65qbOD6D6VaTZ+h64lgoGF2JeVbk4Q+BuGU=;
        b=qwgnx6OzN13ukPd6866kuuRWYl53YKcBKEuZS0XMyC7Wy7gWn6nEktxw3RqGwJ8qEW
         +MJmB/KKBOXWPy7rKe3v0H1MXbfSADZPX099Xm9XVVk0SyGK3ptUb5T7n9IFDr+4H53b
         aBoGcDT/Yq+AV4BQLmY5U0SUJwFSTd4N845R2PtH0hkN4Dy2VsackwBS4bqz7caY6k51
         bGcV5+sbXzfbMRCiMlDLgyKPyCM11f/CpDnk4g6tCQQGuslScSpbVu9aMFYche+dUtER
         fq4nUj9ucBghAaDO9acQM5FFZV0ubX3R27EwW0ntOlvlGOmUG47XL+ZFXEYD9bZ1esXS
         rOnQ==
X-Gm-Message-State: AOJu0Yw+gA2LgSRu4r3sqcNhjWMIFTQVdCxoiY7iRCMPzK/EsPs2jDed
	lR/eD9Ojt3Py5G08vGbgmMqDR+Z/prADufdMHnoIsasZkmUIF0MLIFpOiqwvYUpu07fvqAVq3KW
	r6FkcKsfgIiVq88d5PkDb3OuTzGMJe0SuNZRhoLsE+Q1oSXxn6XCn+s/HN/Xmog==
X-Received: by 2002:a05:6808:6d0:b0:3c6:4c9:9888 with SMTP id m16-20020a05680806d000b003c604c99888mr606594oih.17.1714671810661;
        Thu, 02 May 2024 10:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHeNxxXZ5GpltdHGAc4EEJ37718DEsnhA0sWqp7JLAjgKy6V4de2gRO/UWS+OfFXOwvMUz8A==
X-Received: by 2002:a05:6808:6d0:b0:3c6:4c9:9888 with SMTP id m16-20020a05680806d000b003c604c99888mr606553oih.17.1714671810133;
        Thu, 02 May 2024 10:43:30 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id eh5-20020a056808274500b003c74a4685e0sm213282oib.55.2024.05.02.10.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:43:29 -0700 (PDT)
Date: Thu, 2 May 2024 12:43:27 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com
Subject: Re: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <ykdqxnky7shebbhtucoiokbews2be5bml6raqafsfn4x6bp6h3@nqsn6akpajvp>
References: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
 <ZjFl4rql0UgsHp97@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjFl4rql0UgsHp97@shell.armlinux.org.uk>

On Tue, Apr 30, 2024 at 10:42:58PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 30, 2024 at 04:02:19PM -0500, Andrew Halaney wrote:
> > Basically, NetworkManager is setting both interfaces to up, and end1's
> > phy doesn't seem to be ready when ndo_open() runs, returning
> > -ENODEV in phylink_fwnode_phy_connect() and bubbling that back up. This doesn't
> 
> Let's get something clear - you're attributing phylink to this, but this
> is not the case. phylink doesn't deal directly with PHYs, it makes use
> of phylib for that, and merely passes back to its caller whatever status
> it gets from phylib. It's also not fair to attribute this to phylib as
> we will see later...

Sorry for the delay, I wanted to try and test with some extra logs in
the legit setup (not my "simulate via EPROBE_DEFER delays" approach)
which is tedious with the initramfs (plus I wasted time failing to
ftrace some stuff :P) to reconvince me of old notes. Thanks for the
explanation above on the nuances between phylink and phylib, I really
appreciate it.

> 
> There are a few reasons for phylink_fwnode_phy_connect() would return
> -ENODEV:
> 
> 1) fwnode_get_phy_node() (a phylib function) returning an error,
> basically meaning the phy node isn't found. This would be a persistent
> error, so unlikely to be your issue.
> 
> 2) fwnode_phy_find_device() (another phylib function) not finding the
> PHY device corresponding to the fwnode returned by the above on the
> MDIO bus. This is possible if the PHY has not been detected on the
> MDIO bus, but I suspect this is not the cause of your issue.

So I think we're in this case. I added some extra logs to see which
of the cases we were hitting, as well as some extra logs in phy creation
code etc to come to that conclusion:

    # end1 probe start (and finish)
    [    1.424099] qcom-ethqos 23000000.ethernet: Adding to iommu group 2
    ...
    [    1.431267] qcom-ethqos 23000000.ethernet: Using 40/40 bits DMA host/device width

    # end0 probe start
    [    1.440517] qcom-ethqos 23040000.ethernet: Adding to iommu group 3
    ...
    [    1.443502] qcom-ethqos 23040000.ethernet: Using 40/40 bits DMA host/device width

    # end0 starts making the mdio bus, and phy devices
    [    1.443537] qcom-ethqos 23040000.ethernet: Before of_mdiobus_reg

    # create phy at addr 0x8, end0's phy
    [    1.450118] Starting phy_create_device for addr: 8

    # NetworkManager up'ed end1! and again. But the device we're needing
    # (0xa) isn't created yet
    [    1.459743] qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
    ...
    [    1.465168] Failed at fwnode_phy_find_device
    [    1.465174] qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)
    [    1.473687] qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
    ...
    [    1.477637] Failed at fwnode_phy_find_device
    [    1.477643] qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)

    # device created for 0x8, probe it
    [    1.531617] Ending phy_create_device for addr: 8
    [    1.627462] Marvell 88E1510 stmmac-0:08: Starting probe
    [    1.627644] hwmon hwmon0: temp1_input not attached to any thermal zone
    [    1.627650] Marvell 88E1510 stmmac-0:08: Ending probe

    # device created for 0xa, probe it
    [    1.628992] Starting phy_create_device for addr: a
    [    1.632615] Ending phy_create_device for addr: a
    [    1.731552] Marvell 88E1510 stmmac-0:0a: Starting probe
    [    1.731732] hwmon hwmon1: temp1_input not attached to any thermal zone
    [    1.731738] Marvell 88E1510 stmmac-0:0a: Ending probe

    # end0 is done probing now
    [    1.732804] qcom-ethqos 23040000.ethernet: After of_mdiobus_reg
    [    1.820725] qcom-ethqos 23040000.ethernet end0: renamed from eth0

    # NetworkManager up's end0
    [    1.851805] qcom-ethqos 23040000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
    ...
    [    1.914980] qcom-ethqos 23040000.ethernet end0: PHY [stmmac-0:08] driver [Marvell 88E1510] (irq=233)
    ...
    [    1.939432] qcom-ethqos 23040000.ethernet end0: configuring for phy/sgmii link mode
    ...
    [    4.451765] qcom-ethqos 23040000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx

So end1 is up'ed before end0 can finish making its mdio bus / phy
devices, and therefore we fail to find it. I can easily simulate this
situation as well by -EPROBE_DEFER'ing end0 for say 10 seconds.


In playing around with this I also discovered that if end1's marvell
phy -EPROBE_DEFERs for a bit, up'ing end1 results in matching against the Generic PHY
driver, so then things don't work network wise. That's a similar topic, but
probably should be discussed separately?
Mentioning it now before I forget though. Here's some logs:

    # Probe end1
    [    8.245164] qcom-ethqos 23000000.ethernet: Adding to iommu group 8
    ...
    [    8.377010] qcom-ethqos 23000000.ethernet: Using 40/40 bits DMA host/device width

    # Probe end0
    [    8.396919] qcom-ethqos 23040000.ethernet: Adding to iommu group 9
    ...
    [    8.513481] qcom-ethqos 23040000.ethernet: Using 40/40 bits DMA host/device width
    [    8.521475] qcom-ethqos 23040000.ethernet: Before of_mdiobus_reg
    [    8.529283] Starting phy_create_device for addr: 8
    [    8.553872] Ending phy_create_device for addr: 8
    [    8.714637] Marvell 88E1510 stmmac-0:08: Ending probe
    [    8.721627] Starting phy_create_device for addr: a
    [    8.729064] Ending phy_create_device for addr: a
    [    8.898759] qcom-ethqos 23040000.ethernet: After of_mdiobus_reg
    ...

    # NetworkManager ups end0
    [    9.028419] qcom-ethqos 23040000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
    ...
    [    9.092839] net end0: Before phylink_fwnode_phy_connect
    [    9.164375] qcom-ethqos 23040000.ethernet end0: PHY [stmmac-0:08] driver [Marvell 88E1510] (irq=280)
    [    9.174201] net end0: After phylink_fwnode_phy_connect
    ...

    # NetworkManager ups end1, get the Generic PHY instead of marvell...
    [    9.257364] qcom-ethqos 23040000.ethernet end0: configuring for phy/sgmii link mode
    ...
    [    9.317542] net end1: Before phylink_fwnode_phy_connect
    [    9.404384] qcom-ethqos 23000000.ethernet end1: PHY [stmmac-0:0a] driver [Generic PHY] (irq=POLL)
    [    9.414730] net end1: After phylink_fwnode_phy_connect
    ...
    [    9.509450] qcom-ethqos 23000000.ethernet end1: configuring for phy/sgmii link mode

    # end0 comes up, end1 doesn't due to the wrong phy being selected here
    [   11.672223] qcom-ethqos 23040000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/tx

> 
> 3) phy_attach_direct() (another phylib function) returning an error.
> This function calls phy_init_hw() which will attempt to talk to the
> hardware, and if that returns an error, it will be propagated up.
> 
> (3) is the most likely scenario given your quoted DT description. I
> suspect that the stmmac/qcom-ethqos driver is what's at fault here.
> 
> Your DT description shows that the PHYs are on one MDIO bus owned by
> one of the network interfaces. I suspect if that network interface
> is down, then the MDIO bus is not accessible.
> 
> Therefore, when you attempt to open the _other_ network interface,
> accesses to its PHY fail with -ENODEV and that gets propagated all
> the way back up.
> 
> What's more is if you did manage to get that network interface up
> (because the one with the MDIO bus on was up) then if you take
> that interface down, you'll end up with a phy_error() splat from
> phylib because the PHY it was using has become inaccessible.
> 
> Basically, the network driver is buggy for this PHY setup. If a
> MDIO bus contains devices that are not owned by the network device
> owning that MDIO bus, then the MDIO bus _must_ be prepared to handle
> MDIO bus accesses _at_ _any_ _time_. This clearly is not the case
> here.

As far as I can tell, at least from the "link up/down" perspective, any
combo works. If I boot (without NetworkManager doing things), I can
play around with any combo of link up and down without any noticeable
issue.

> 
> It could also be the case that if the driver is using runtime PM,
> that when the network interface is runtime-PM suspended, it causes
> MDIO bus accesses to fail... that would be very chaotic though.
> 
> In any case, I'm going to say... I don't think this is a phylink nor
> phylib issue, but a buggy network driver thinking that it has the
> right to shutdown MDIO bus access depending on its network interface
> state.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 


