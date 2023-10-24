Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE07D5341
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbjJXNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343546AbjJXNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:53:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D9B30ED
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:49:07 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qvHm2-0007R6-1x; Tue, 24 Oct 2023 15:48:46 +0200
Message-ID: <9c1c9408-88ac-4ade-b8ec-2ae5d8922cac@pengutronix.de>
Date:   Tue, 24 Oct 2023 15:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
From:   Johannes Zink <j.zink@pengutronix.de>
Subject: BUG: stmmac: Timeout accessing MAC_VLAN_Tag_Filter when EEE is
 enabled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

for a vanilla kernel version 6.5.2 I observed the following behaviour on an 
i.MX8MP-EVK:

root@<redacted>:~# ethtool -s eth1 autoneg on speed 100 duplex full
root@<redacted>:~# ethtool --show-eee eth1
EEE settings for eth1:
         EEE status: enabled - inactive
         Tx LPI: disabled
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  100baseT/Full
         Link partner advertised EEE link modes:  Not reported
root@<redacted>:~# ip link add link eth1 name eqos.5 type vlan id 5
RTNETLINK answers: Device or resource busy
root@<redacted>:~# dmesg | tail -n 1
[  819.085069] imx-dwmac 30bf0000.ethernet eth1: Timeout accessing 
MAC_VLAN_Tag_Filter
root@<redacted>:~# ip link show dev eqos.5@eth1
Device "eqos.5@eth1" does not exist.
root@<redacted>:~# ethtool --set-eee eth1 eee off
root@<redacted>:~# ethtool --show-eee eth1
EEE settings for eth1:
         EEE status: disabled
         Tx LPI: disabled
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  Not reported
         Link partner advertised EEE link modes:  Not reported
root@<redacted>:~# ip link add link eth1 name eqos.5 type vlan id 5
root@<redacted>:~# ip link show dev eqos.5 

5: eqos.5@eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode 
DEFAULT group default qlen 1000
     link/ether 00:04:9f:07:9c:42 brd ff:ff:ff:ff:ff:ff

The same holds for removing VLANs when EEE is enabled:

(after reboot)
root@<redacted>:~# ethtool --set-eee eth1 eee off
root@<redacted>:~# ip link add link eth1 name eqos.5 type vlan id 5
root@<redacted>:~# ethtool --set-eee eth1 eee on
root@<redacted>:~# ip link del link eth1 name eqos.5 type vlan id 5
root@beluga-1311a8001168e9dc:~# dmesg | tail -n2
[  240.918085] imx-dwmac 30bf0000.ethernet eth1: Timeout accessing 
MAC_VLAN_Tag_Filter
[  240.925827] imx-dwmac 30bf0000.ethernet eth1: failed to kill vid 0081/5

Which is even a bit more concerning, because there is no error reported to 
userspace, only a netdev_err print to the kernel log

In my debugging session I found that this behaviour is only linked to EEE being 
enabled or disabled.
On 1Gbps links, the eee-broken-1000t property is set for the ethphy node, which 
is why the behaviour usually does not occur for 1GBps (which is probably the 
most common usecase).

Maybe someone on this list has more insight in the inner workings of the 
dwmac/stmmac/eqos and could point out how to fix this issue, I'd be happy to 
send patches and fix it. Also, maybe someone has other implementations at hand 
and can check if this can be reproduced

Do you deem disabling EEE while setting the VLAN up a valid workaround or 
should we rather add a warning when the timeout occurs and EEE is still enabled?

Best regards
Johannes

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
