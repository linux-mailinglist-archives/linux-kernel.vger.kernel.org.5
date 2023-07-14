Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533CF75450B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGNWkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGNWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551135B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689374360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/7QRsG7VMgpCtW8aCf88ACfGWjhwUEcpv469HHRgOI=;
        b=JMwBmx50dd2q5hPG6sY5AIk48hzREDoTXKxb0uItvHfFFWekKlA8tKUVP13roCDr3uiH1p
        ZnOBWeUlNFWsqFT0nDNvAq4oNFB+M21mBvgxtKnWbukyysor3E0p+nveJb+T6puHEAI7YL
        AapEHF7GUlxmqL2LBcOwvmL1L5RqdjM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-L1uOGhSdPQ-jiPi7DjOJOg-1; Fri, 14 Jul 2023 18:39:19 -0400
X-MC-Unique: L1uOGhSdPQ-jiPi7DjOJOg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b87d141149so3822165a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374358; x=1691966358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/7QRsG7VMgpCtW8aCf88ACfGWjhwUEcpv469HHRgOI=;
        b=ctCbYIBmp5y7SCxqp0DV+LC8Gr3ChOLFxkC4l6s2c4alU7wmkdp6I8ZxnbEZweulmV
         tgz0jXfuznx2u8++GMcuGKZkiSP7q+6wGWG9Nv/OSGDKVkCcL99vbTN7+HLHUbilWUBy
         MCT4WXxARQnXA5+Bk6GEKRfsmrAvtS9fcoIFJaWC3xJJFcZprGgX99WBC/kF1mLjVxr/
         FAsVLO1q7dM6hynxOdJ4JXNbPaHYDTKm66qnMQL8FbrCCFSbCZkLYUnDFdcDgpRh67xv
         444Wb14zmCYksdeZmjZYhmoEn8v+cckaEtiEVBCle7sjehKQ7VL9Yb6uWpHi4xEADyaG
         8Gyw==
X-Gm-Message-State: ABy/qLYdASoZCPBeVyKQsAJxikB0NkYhxqgBKzD+uuEkBGxLPzuC/uOf
        wHpJgSjmquP+9r6uJz8Y0ivd1reOOmx7DvzLJ7mi1xDc+xJtToq1YqkwRauIUNvd+HgoJ5+PYqZ
        moyNLWGr9VsCUnvE5LqZLjp/F
X-Received: by 2002:a05:6870:3452:b0:1b4:7353:bba6 with SMTP id i18-20020a056870345200b001b47353bba6mr7350784oah.44.1689374358417;
        Fri, 14 Jul 2023 15:39:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGjfS8pSABZlYzgkNkVzYzDjPoSh3mvMe8xoTt6ts91yhdDqXKxDz1dEruBrVUkovoiv2RPdQ==
X-Received: by 2002:a05:6870:3452:b0:1b4:7353:bba6 with SMTP id i18-20020a056870345200b001b47353bba6mr7350764oah.44.1689374358119;
        Fri, 14 Jul 2023 15:39:18 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id ec42-20020a0568708c2a00b001b3f0afda0fsm4489026oab.30.2023.07.14.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:39:17 -0700 (PDT)
Date:   Fri, 14 Jul 2023 17:39:15 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Prasad Sodagudi <quic_psodagud@quicinc.com>
Cc:     "Ninad Naik (QUIC)" <quic_ninanaik@quicinc.com>,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Parikshit Pareek (QUIC)" <quic_ppareek@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        "Prasanna Kumar (QUIC)" <quic_kprasan@quicinc.com>
Subject: Re: FW: [PATCH] pinctrl: qcom: Add intr_target_width to define
 intr_target_bit field width
Message-ID: <20230714223915.4q3pmbqxajkjtltb@halaney-x13s>
References: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
 <p5vyji2weclwgshyxbf2evzpzefckzyecjnoada7dvzbuenxsb@55abp36rrbub>
 <BY5PR02MB6339C6B8A53C5D0CB55E58B7C034A@BY5PR02MB6339.namprd02.prod.outlook.com>
 <d43a0ce0-c915-a5d2-1d01-549ae08c678e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43a0ce0-c915-a5d2-1d01-549ae08c678e@quicinc.com>
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

On Fri, Jul 14, 2023 at 02:04:05PM -0700, Prasad Sodagudi wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Halaney <ahalaney@redhat.com>
> > Sent: Friday, July 14, 2023 11:17 AM
> > To: Ninad Naik (QUIC) <quic_ninanaik@quicinc.com>
> > Cc: andersson@kernel.org; agross@kernel.org; konrad.dybcio@linaro.org; linux-arm-msm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-kernel@vger.kernel.org; Parikshit Pareek (QUIC) <quic_ppareek@quicinc.com>; Prasad Sodagudi <psodagud@quicinc.com>; Prasanna Kumar (QUIC) <quic_kprasan@quicinc.com>
> > Subject: Re: [PATCH] pinctrl: qcom: Add intr_target_width to define intr_target_bit field width
> > 
> > WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> > 
> > On Fri, Jul 14, 2023 at 11:40:09AM +0530, Ninad Naik wrote:
> > > SA8775 and newer target have added support for an increased number of
> > > interrupt targets. To implement this change, the intr_target field,
> > > which is used to configure the interrupt target in the interrupt
> > > configuration register is increased from 3 bits to 4 bits.
> > > 
> > > In accordance to these updates, a new intr_target_width member is
> > > introduced in msm_pingroup structure. This member stores the value of
> > > width of intr_target field in the interrupt configuration register.
> > > This value is used to dynamically calculate and generate mask for
> > > setting the intr_target field. By default, this mask is set to 3 bit
> > > wide, to ensure backward compatibility with the older targets.
> > > 
> > > Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

> > 
> > Thanks for the patch. Naive question (without really reading the code), but what practical affect does this have?
> > 
> 
> Target bits configures irq destination processor on Qualcomm SoC.
> g->intr_target_kpss_val(0x3) routes the gpio IRQ to application process.
> On this SoCs target bits length is changed from 3 bits to 4 bits in hw and
> reset value of g->intr_target_reg register value is 0x1E2. So reset value of
> target bits is 0xf.  With old logic, when writing
> g->intr_target_kpss_val(0x3) value result is 0xb instead of 0x3 as top most
> bit is not getting cleared out and leading to IRQ is not getting fired on
> application processor. 0xb value is unused on current HW and IRQ would not
> be fired.
> 

Thanks all for the explanations, that makes a lot of sense.

Perhaps briefly summarizing that without this fix platforms using
more than 3 bits could fail to set/clear the remaining bits, resulting in
routing the IRQ to the wrong processor subsystem?

And with that in mind.. I think this deserves a Fixes tag:

    Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")

seems overzealous since until 8775p afaik no upstream platform would
fall in the > 3 bits category. But, it wouldn't hurt if someone was bringing
up such a platform on an LTS kernel that has this pinctrl driver.

At the very least I think:

    Fixes: 4b6b18559927 ("pinctrl: qcom: add the tlmm driver sa8775p platforms")

would be a nice addition in v2.

This definitely works, applying this patch to enable the IRQ for the ethernet
phy (posting in case I get hit by a bus this weekend, I'll spin properly
next week):

    ahalaney@halaney-x13s ~/git/linux-next (git)-[remotes/ahalaney/ethernet-phy-irq] % git show                                                                                                                                            :(
    commit c6d01507db84dcb205e2cd92fb74cdb328f6fcad (HEAD, ahalaney/ethernet-phy-irq)
    Author: Andrew Halaney <ahalaney@redhat.com>
    Date:   Fri Jul 14 16:07:01 2023 -0500

        arm64: dts: qcom: sa8775p-ride: Describe ethernet phy irq

        There's an irq hooked up, so let's describe it.

        Prior to TODO UPDATE WITH FINAL PATCH NAME
        SHA ("pinctrl: qcom: Add intr_target_width to define intr_target_bit field width")
        one would not see the IRQ fire, despite some (invasive) debugging
        showing that the GPIO was in fact asserted, resulting in the interface
        staying down.

        Now that the IRQ is properly routed we can describe it.

        Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

    diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
    index b2aa16037707..2b7ef7ad01d5 100644
    --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
    +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
    @@ -286,6 +286,8 @@ mdio {
                    sgmii_phy: phy@8 {
                            reg = <0x8>;
                            device_type = "ethernet-phy";
    +
    +                       interrupts-extended = <&tlmm 7 IRQ_TYPE_EDGE_FALLING>;
                    };
            };



Then testing without/with this pinctrl change...

Without this pinctrl change:

    [root@dhcp19-243-201 ~]# # Ethernet MAC of question
    [root@dhcp19-243-201 ~]# ls -lah /sys/class/net/eth0
    lrwxrwxrwx 1 root root 0 May 18 00:00 /sys/class/net/eth0 -> ../../devices/platform/soc@0/23040000.ethernet/net/eth0
    [root@dhcp19-243-201 ~]# ip -s link show eth0
    2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
        link/ether b2:79:1f:47:c8:45 brd ff:ff:ff:ff:ff:ff
        RX:  bytes packets errors dropped  missed   mcast
                 0       0      0       0       0       0
        TX:  bytes packets errors dropped carrier collsns
                 0       0      0       0       0       0
    [root@dhcp19-243-201 ~]# cat /proc/interrupts | grep stmmac-0
    238:          0          0          0          0          0          0          0          0   msmgpio   7 Edge      stmmac-0:08
    [root@dhcp19-243-201 ~]#

With it:

    [root@dhcp19-243-28 ~]# ls -lah /sys/class/net/eth0
    lrwxrwxrwx 1 root root 0 May 18 00:00 /sys/class/net/eth0 -> ../../devices/platform/soc@0/23040000.ethernet/net/eth0
    [root@dhcp19-243-28 ~]# ip -s link show eth0
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
        link/ether ae:27:eb:55:e4:d0 brd ff:ff:ff:ff:ff:ff
        RX:  bytes packets errors dropped  missed   mcast
            588222    9538      0      43       0       0
        TX:  bytes packets errors dropped carrier collsns
             16046     181      0       0       0       0
    [root@dhcp19-243-28 ~]# cat /proc/interrupts | grep stmmac-0
    237:          1          0          0          0          0          0          0          0   msmgpio   7 Edge      stmmac-0:08
    [root@dhcp19-243-28 ~]#

Boy can one IRQ and bit make a difference! I spent a few days trying to
understand why my forward port was failing, and this IRQ was the ultimate issue.
Thanks for the fix!

- Andrew

