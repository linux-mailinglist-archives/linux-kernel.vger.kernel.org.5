Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4400C7781FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjHJUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjHJUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C70F2712
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691698419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+r56t3s1kQWK8kt8Jy4XEcKaftYVcIdjxsSpjYz1P5c=;
        b=cvLR2EZWjUGU0nkGJ5mv1uJ12RPNhRec+74/VBlh5jPh8Q1EcecP5Z7Y2VAhO7SYAXbA2u
        4bGqxl5u62Reh8G3p3p3jb8d2lj3rCBP9Pira+7k3gyEYUgBaZ7GGY5o3jjPNgAPUP9DR9
        00GVlM3gbjV1f1cuWzxNifcdS3ypwwY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-ffZCiKw_PCKwQgE__ZhdrA-1; Thu, 10 Aug 2023 16:13:38 -0400
X-MC-Unique: ffZCiKw_PCKwQgE__ZhdrA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fedf8472bso15359351cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698417; x=1692303217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r56t3s1kQWK8kt8Jy4XEcKaftYVcIdjxsSpjYz1P5c=;
        b=bKQKvqHnmhE4aLiRfm1TDHZNbmAfAEUz4OgtzlyzQzqH1inO1tTwiAxnzPKZBSzz6v
         8InC/WdbCwbsKS9dEpGf04Yu2lFEPNnWp4MU68pQnsiyHIJOmaafYRY5G2j0MomCG+B7
         HlAYaB1aS4SmGys6LLlJpRa+GDoZQpEZzWD5X70imcNxN8apjNjZ0G89fm1gVR3n172x
         gU8gfyigXfO0mB9LpmXlHX/u5SYkMPVcVh+tXl0FqorjFDmf/SqixVgF7wl7MzHXwXFW
         W+3AcY2E7ZUYLnCF+sS+JnPQ6XMoXdA4zN6s3f74RArxoVY9VqPUeom6P+QNxtUKW97R
         jD8A==
X-Gm-Message-State: AOJu0YydRymRSUW8FD7UwS45oS+9I4hCgeNZbpRt1PV2B4d6TiuqAT56
        mZ3tH1/dzYwOaIggygvI29g879aWJ+CwNTIMwvy377bLt5sc9PLD7GDV+mg2JNvouWekBMGkMu3
        I9yS7uU8H5U06aivc8+kJTUhs
X-Received: by 2002:ac8:7dc1:0:b0:406:8bc4:2530 with SMTP id c1-20020ac87dc1000000b004068bc42530mr5219632qte.43.1691698417364;
        Thu, 10 Aug 2023 13:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKTzKCd2z8Ms3vp2vzj84CZ85ZAldrpdKTbL/uZZd4q88+UU0E8JPW2ch0tmersN+0Xl1xOQ==
X-Received: by 2002:ac8:7dc1:0:b0:406:8bc4:2530 with SMTP id c1-20020ac87dc1000000b004068bc42530mr5219609qte.43.1691698417081;
        Thu, 10 Aug 2023 13:13:37 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8714a000000b003f3937c16c4sm720285qtp.5.2023.08.10.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:13:36 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:13:34 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 0/9] arm64: dts: qcom: enable EMAC1 on sa8775p
Message-ID: <j57dowviaas552jt6fdynyowkwm6j6xjc5ixjdk2v4nn4doibn@qnr47drkhljp>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:09:00AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This series contains changes required to enable EMAC1 on sa8775p-ride.
> This iteration no longer depends on any changes to the stmmac driver to
> be functional. It turns out I was mistaken in thinking that the two
> MACs' MDIO masters share the MDIO clock and data lines. In reality, only
> one MAC is connected to an MDIO bus and it controlls PHYs for both MAC0
> and MAC1. The MDIO master on MAC1 is not connected to anything.
> 

I've taken this for a quick (disconnected from network) spin, and things
work as expected without having anything plugged in.

I'm trying to get someone to plug it in so I can test that networking
actually works, but the interesting bit is the phy/mdio bit here, and
that's at least working ok I can tell. The rest is boilerplate similar
to the other MAC instance which works fine.

Removing the driver results in the following oops, but that's already
discussed[0] and is independent of the devicetree description:

I'd add a test tag but I want to wait for some network traffic tests
before I do such. I wouldn't wait on picking it up just because of
that though.

[0] https://lore.kernel.org/netdev/ZNKLjuxnR2+V3g1D@shell.armlinux.org.uk/

[root@dhcp19-243-28 ~]# modprobe -r dwmac_qcom_ethqos
[ 1260.620402] qcom-ethqos 23040000.ethernet eth1: stmmac_dvr_remove: removing driver
[ 1260.655724] qcom-ethqos 23040000.ethernet eth1: FPE workqueue stop
[ 1261.034265] qcom-ethqos 23000000.ethernet eth0: stmmac_dvr_remove: removing driver
[ 1261.042108] Unable to handle kernel paging request at virtual address dead000000000122
[ 1261.050379] Mem abort info:
[ 1261.053251]   ESR = 0x0000000096000044
[ 1261.057113]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1261.062573]   SET = 0, FnV = 0
[ 1261.065712]   EA = 0, S1PTW = 0
[ 1261.068946]   FSC = 0x04: level 0 translation fault
[ 1261.073956] Data abort info:
[ 1261.076916]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[ 1261.082552]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[ 1261.087882]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1261.093338] [dead000000000122] address between user and kernel address ranges
[ 1261.100667] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
[ 1261.107096] Modules linked in: r8152 rfkill marvell dwmac_qcom_ethqos(-) qcom_pon stmmac_platform crct10dif_ce stmmac spi_geni_qcom i2c_qcom_geni phy_qcom_qmp_usb phy_qcom_sgmii_eth phy_qcom_snps_femto_v2 pcs_xpcs qcom_wdt socinfo phy_qcom_qmp_pcie fuse ufs_qcom phy_qcom_qmp_ufs
[ 1261.132407] CPU: 2 PID: 610 Comm: modprobe Not tainted 6.5.0-rc4-next-20230731-00008-g18ccccee8230 #7
[ 1261.141860] Hardware name: Qualcomm SA8775P Ride (DT)
[ 1261.147042] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1261.154185] pc : device_link_put_kref+0x44/0x110
[ 1261.158926] lr : device_link_put_kref+0xf4/0x110
[ 1261.163662] sp : ffff800082a938e0
[ 1261.167066] x29: ffff800082a938e0 x28: ffff6ec68bdc9d80 x27: 0000000000000000
[ 1261.174390] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[ 1261.181714] x23: ffff800082a93b38 x22: ffff6ec68690f2d8 x21: ffff6ec6896aed30
[ 1261.189031] x20: ffff6ec68246b830 x19: ffff6ec68246b800 x18: 0000000000000006
[ 1261.196355] x17: ffff9259b7856000 x16: ffffdc7b42e3eaec x15: 725f7276645f6361
[ 1261.203679] x14: 0000000000000000 x13: 0000000000000002 x12: 0000000000000000
[ 1261.210996] x11: 0000000000000040 x10: ffffdc7b447de0b0 x9 : ffffdc7b447de0a8
[ 1261.218321] x8 : ffff6ec680400028 x7 : 0000000000000000 x6 : 0000000000000000
[ 1261.225645] x5 : ffff6ec680400000 x4 : 00000000c0000000 x3 : ffff6ec6896ae8b0
[ 1261.232963] x2 : dead000000000122 x1 : dead000000000122 x0 : ffff6ec68246b830
[ 1261.240287] Call trace:
[ 1261.242806]  device_link_put_kref+0x44/0x110
[ 1261.247190]  device_link_del+0x30/0x48
[ 1261.251040]  phy_detach+0x24/0x15c
[ 1261.254530]  phy_disconnect+0x44/0x5c
[ 1261.258295]  phylink_disconnect_phy+0x64/0xb0
[ 1261.262764]  stmmac_release+0x58/0x2d4 [stmmac]
[ 1261.267425]  __dev_close_many+0xac/0x14c
[ 1261.271458]  dev_close_many+0x88/0x134
[ 1261.275308]  unregister_netdevice_many_notify+0x130/0x7d0
[ 1261.280852]  unregister_netdevice_queue+0xd4/0xdc
[ 1261.285682]  unregister_netdev+0x24/0x38
[ 1261.289715]  stmmac_dvr_remove+0x80/0x150 [stmmac]
[ 1261.294636]  devm_stmmac_pltfr_remove+0x24/0x48 [stmmac_platform]
[ 1261.300887]  devm_action_release+0x14/0x20
[ 1261.305090]  devres_release_all+0xa0/0x100
[ 1261.309293]  device_unbind_cleanup+0x18/0x68
[ 1261.313676]  device_release_driver_internal+0x1f4/0x228
[ 1261.319039]  driver_detach+0x4c/0x98
[ 1261.322708]  bus_remove_driver+0x6c/0xbc
[ 1261.326739]  driver_unregister+0x30/0x60
[ 1261.330772]  platform_driver_unregister+0x14/0x20
[ 1261.335603]  qcom_ethqos_driver_exit+0x18/0x1a8 [dwmac_qcom_ethqos]
[ 1261.342035]  __arm64_sys_delete_module+0x19c/0x288
[ 1261.346952]  invoke_syscall+0x48/0x110
[ 1261.350804]  el0_svc_common.constprop.0+0xc4/0xe4
[ 1261.355636]  do_el0_svc+0x38/0x94
[ 1261.359040]  el0_svc+0x2c/0x84
[ 1261.362178]  el0t_64_sync_handler+0x120/0x12c
[ 1261.366646]  el0t_64_sync+0x190/0x194
[ 1261.370413] Code: d2802441 aa1403e0 f2fbd5a1 f9000462 (f9000043) 
[ 1261.376661] ---[ end trace 0000000000000000 ]---
Segmentation fault

