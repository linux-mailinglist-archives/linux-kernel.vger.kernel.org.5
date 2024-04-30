Return-Path: <linux-kernel+bounces-164724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6648B81BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78891F2434A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9AA1A38CE;
	Tue, 30 Apr 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZJq9Jij"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F548F6E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510950; cv=none; b=lfR0jt6v8YEUuj/gg8MM4BsLTWMmKNQZW/mDUrQtPAVtRUNH212h8jlSF3xwEMDX/BJBGiAUFQqb+UjeBdwGSiYPJ3WWlLbFnGHqjEa+AzHOH4fiUPM93TGggruEUlJycJtumKnG8NW2A4RxjWXexD6aKAgzd8CTJQGr3HPPcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510950; c=relaxed/simple;
	bh=3IlPfAdOypj2yDjXEHZcjOeySFUVY2FLG7qTyvYeviw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DRuJ3Sir8fLSobft1vQXt1rL6CxHN1EWiVWepfwjTfasUurVu1pqryZqGDqsPwzopMeQwJOVupJ7i7wvcHlsL74lFIbmstHNOTb2sqHz7yrV2z2HRIyz0moRMsO+CDJ+GPO0Sn13wEGnhS7aHScKjEa5eJ3bgESyJAQfouiT7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZJq9Jij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714510948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GEXNjb7aeNcvCnxPKRJWZCd/nJbe22HDnX8o5WGN7ew=;
	b=XZJq9Jija1ZcEwtbPnbJydjphpHT4v4VPtkJ2uzwjCGOtfKXJsx6cz7z9PGjq3nykjExle
	a6pUjVysi/4671JG+CxkUEFnKA30i+8GQ+RVe3Ja91/dIsrBXKsQDN+ibIS468Pu2wiWI+
	4fKVrxLSBlmkTmqqOoEGN8plLDzCX1U=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-P4pE7omEPxqM9fcg5pvpfw-1; Tue, 30 Apr 2024 17:02:26 -0400
X-MC-Unique: P4pE7omEPxqM9fcg5pvpfw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed4298be66so4326771b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714510944; x=1715115744;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEXNjb7aeNcvCnxPKRJWZCd/nJbe22HDnX8o5WGN7ew=;
        b=WRY93sFS0lB73WqSeUj+1IcCxJumkKIMAJs1mW2HALsDKzjgCSmyur6vIBS/+xWVur
         3vzx28GEuyQSvXnjbx1+bQ6LM/wQua0DP+6YiEd1VXmfBzmLTWXHws8OuOFt0EBbmixi
         5OS9cfruYg61ujH31ZrXUHKENvzySt6saJ1oNvy5VcbxZrMC3dn16U7nhKa0ZizV9RPu
         TCWywlducLZNQxDXSzaxl0i3G3LVbUOjluwE4Vds34KADjaCBQ7Ct/K1ZEpL4seBgEel
         vJt3LtWol4so0L5w18zPeh3TaZo7Vdwi6/GiLnKvFVlEw/5W0KOgaNHyj+hyJ3NOiV++
         bkwg==
X-Gm-Message-State: AOJu0Yx8qsHU6y7ONId5lyBp5+O/nfZv6XpHiDpzK/NOkEK4ZrHGOPi6
	pRYIOYOiHackRuUSErq3VnPr0Wu3/GlXt4tkr78tJSNt5yNCRRGmwyVzPGYIn9AZPIhRCfZDMHd
	Q0w/TXW9ec5oEaneWeeO25V0Ndbe+1qOegZB1LQJlzGvF5QJzWUitzznEe32yFVpTOeGoYRPGkW
	2nXsAmu0HQ6fqZTnmLKT5hSpGESo+mBBx9dnse6rmcauknhA==
X-Received: by 2002:a05:6a20:9192:b0:1a7:6262:1dd1 with SMTP id v18-20020a056a20919200b001a762621dd1mr1261000pzd.51.1714510943826;
        Tue, 30 Apr 2024 14:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCRcUNpm+xZQh5a6xxgdrE7aGEQmRLABr6Gp4YxdclyZ03Q2COt1Nwd0VZF7JFkFyG2Zg9Cg==
X-Received: by 2002:a05:6a20:9192:b0:1a7:6262:1dd1 with SMTP id v18-20020a056a20919200b001a762621dd1mr1260940pzd.51.1714510943135;
        Tue, 30 Apr 2024 14:02:23 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id lo8-20020a056a003d0800b006ed4823671csm22223770pfb.15.2024.04.30.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:02:22 -0700 (PDT)
Date: Tue, 30 Apr 2024 16:02:19 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk
Subject: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've been taking a look at the following error message:

    qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)

end1 is using a phy on the mdio bus of end0, not on its own bus. Something
like this devicetree snippet highlights the relationship:

    // end0
    &ethernet0 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy0>;

            mdio {
                    compatible = "snps,dwmac-mdio";
                    sgmii_phy0: phy@8 {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0x8>;
                            device_type = "ethernet-phy";
                    };

                    sgmii_phy1: phy@a {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0xa>;
                            device_type = "ethernet-phy";
                    };
            };
    };

    // end1
    &ethernet1 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy1>;
    };

Basically, NetworkManager is setting both interfaces to up, and end1's
phy doesn't seem to be ready when ndo_open() runs, returning
-ENODEV in phylink_fwnode_phy_connect() and bubbling that back up. This doesn't
happen very often, but by shoving things into the initramfs or anything to
speed up probe/ndo_open() it's easier to reproduce. Delaying probe()
of end0 and then setting end1 up is another easy way to reproduce.

My question after looking around for a while, is what is the expectation
of userspace in this situation?

NetworkManager retries 4 times right now (tunable via autoconnect-retries setting),
and if you're lucky that's good enough. You could tell it to retry infinitely,
that should get me out of my bind at least, but it's not an amazing solution.

I'm used to dealing with deferral issues in probe() callbacks, but
to me it seems that phylink and netdev sort of move the phy part of the problem
till later (so you don't get the kernel retrying for you, etc, like you do
with deferred probes) when you ndo_open(). I guess the logic there is that
the phys could be hot pluggable, so with phylink we delay getting at them
until ndo_open()? I also guess if the mac is going to create an mdio bus
with phys off of it that also gets dicey as the phy could -EPROBE_DEFER
when you're trying to probe the mac and confirm its phy is ready..

Is retrying the correct solution here from userspace, or am I missing something?
I thought the "does not support carrier detection" below might be my ticket out
of this, but I can still reproduce it even after patching[0] to make that work.
I guess NetworkManager still brings the device up, but doesn't "activate" the
connection until the carrier detect stuff is done.

[0] https://lore.kernel.org/netdev/20240429-stmmac-no-ethtool-begin-v1-1-04c629c1c142@redhat.com/

Thanks,
Andrew

Some logs to illustrate the issue with a little more context (without
the patch in [0], in the end that doesn't help):

[    1.541839] fedora kernel: qcom-ethqos 23000000.ethernet end1: renamed from eth0
[    1.545750] fedora NetworkManager[407]: <info>  [1709251201.1647] device (eth0): driver '(null)' does not support carrier detection.
[    1.545826] fedora NetworkManager[407]: <info>  [1709251201.1657] device (eth0): driver 'unknown' does not support carrier detection.
[    1.545854] fedora NetworkManager[407]: <info>  [1709251201.1660] manager: (eth0): new Ethernet device (/org/freedesktop/NetworkManager/Devices/2)
[    1.545880] fedora NetworkManager[407]: <info>  [1709251201.1678] device (eth0): interface index 2 renamed iface from 'eth0' to 'end1'
[    1.551721] fedora NetworkManager[407]: <info>  [1709251201.1794] device (end1): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
[    1.554944] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
[    1.555962] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
[    1.557711] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
[    1.558721] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
[    1.560297] fedora kernel: qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)
[    1.573664] fedora NetworkManager[407]: <info>  [1709251201.2013] device (end1): state change: unavailable -> disconnected (reason 'none', sys-iface-state: 'managed')
[    1.574344] fedora NetworkManager[407]: <info>  [1709251201.2020] policy: auto-activating connection 'Wired Connection' (bfe920e8-6031-4129-bf5c-78198427076a)
[    1.574733] fedora NetworkManager[407]: <info>  [1709251201.2024] device (end1): Activation: starting connection 'Wired Connection' (bfe920e8-6031-4129-bf5c-78198427076a)
[    1.578589] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
[    1.579351] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
[    1.580102] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
[    1.578337] fedora NetworkManager[407]: <info>  [1709251201.2027] device (end1): state change: disconnected -> prepare (reason 'none', sys-iface-state: 'managed')
[    1.578404] fedora NetworkManager[407]: <info>  [1709251201.2030] manager: NetworkManager state is now CONNECTING
[    1.578431] fedora NetworkManager[407]: <info>  [1709251201.2033] device (end1): state change: prepare -> config (reason 'none', sys-iface-state: 'managed')
[    1.580965] fedora kernel: qcom-ethqos 23000000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
[    1.582390] fedora kernel: qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)
[    1.593993] fedora NetworkManager[407]: <info>  [1709251201.2217] device (end1): state change: config -> failed (reason 'config-failed', sys-iface-state: 'managed')
[    1.648395] fedora NetworkManager[407]: <info>  [1709251201.2220] manager: NetworkManager state is now DISCONNECTED
[    1.648634] fedora NetworkManager[407]: <warn>  [1709251201.2222] device (end1): Activation: failed for connection 'Wired Connection'
[    1.648926] fedora NetworkManager[407]: <info>  [1709251201.2224] device (end1): state change: failed -> disconnected (reason 'none', sys-iface-state: 'managed')
[    1.649179] fedora NetworkManager[407]: <info>  [1709251201.2233] manager: startup complete
[    1.834016] fedora NetworkManager[407]: <info>  [1709251201.4617] device (eth0): driver '(null)' does not support carrier detection.
[    1.836553] fedora NetworkManager[407]: <info>  [1709251201.4624] device (eth0): driver 'unknown' does not support carrier detection.
[    1.836628] fedora NetworkManager[407]: <info>  [1709251201.4627] manager: (eth0): new Ethernet device (/org/freedesktop/NetworkManager/Devices/3)
[    1.896859] fedora kernel: qcom-ethqos 23040000.ethernet end0: renamed from eth0
[    1.902243] fedora NetworkManager[407]: <info>  [1709251201.5299] device (eth0): interface index 3 renamed iface from 'eth0' to 'end0'
[    1.911400] fedora kernel: qcom-ethqos 23040000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
[    1.909632] fedora NetworkManager[407]: <info>  [1709251201.5357] device (end0): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')


