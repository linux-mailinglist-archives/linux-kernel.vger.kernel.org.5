Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2FB7B607B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjJCFoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjJCFox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:44:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FDBB3;
        Mon,  2 Oct 2023 22:44:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29246C433C7;
        Tue,  3 Oct 2023 05:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696311890;
        bh=TaZguEXQKjSyHnAA74xfdT5k4Fyw6T4I2L535UsMZOQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Oh8mIWoYdcBvLrHp+irD9zsUljjwD3BOI5QjL/ZqAV6DWIHPKSRsG0CWXO3492MrJ
         WwR5pZBA5YgtC/KfkEF8sIqz1I3K0IUlEyLmVNaf40Y8DrhCrbDEFG4oaXgdic4DGg
         dxPK83/RQWn5CrN+/HVyKDpXQH7tkXaK3LoCOzm2A20eENtKr+6SaWMirT1wRXpw5+
         whladzHvzb4Qb+eaE+YzLiBLCzg7gDV8UdMbg7Dxc0Vq1M/ku8id4II+QEKo9WPOvS
         dL0yg7YJ4Do9t/MBPiV+IJEIrrWRTGU9ooSmKIYCVzqTVPVx+VR2J4n0OiQkBa9rpy
         p1F7oVYVdttdg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     enc0der <enc0der@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Gaul <gaul@gaul.org>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B8rn?= Mork <bjorn@mork.no>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
        <ZRj_ovMi-Xbb8i-D@debian.me>
        <CAEXpi5RiLbma5cb-ctEvvb7LGRn78VTOh5HDmreC2hYgtBEQog@mail.gmail.com>
        <3d246a72-2755-484f-8274-0c61fc185592@gmail.com>
Date:   Tue, 03 Oct 2023 08:47:00 +0300
In-Reply-To: <3d246a72-2755-484f-8274-0c61fc185592@gmail.com> (Bagas Sanjaya's
        message of "Sun, 1 Oct 2023 12:53:22 +0700")
Message-ID: <878r8ki7fv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>> These are the drivers being loaded:
>> 
>> rt2800usb              36864  0
>> rt2x00usb              24576  1 rt2800usb
>> rt2800lib             122880  1 rt2800usb
>> rt2x00lib              77824  3 rt2800usb,rt2x00usb,rt2800lib
>> mac80211              811008  3 rt2x00lib,rt2x00usb,rt2800lib
>> cfg80211              724992  2 rt2x00lib,mac80211
>> 
>
> I don't see rt2800usb module in the mainline kernel. Is it out-of-tree?
> (no wonder why it taints your kernel)

I'm guessing it's this driver:

drivers/net/wireless/ralink/rt2x00/Makefile:obj-$(CONFIG_RT2800USB)                     += rt2800usb.o

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
