Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABC8777F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjHJRsM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjHJRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:48:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C822702;
        Thu, 10 Aug 2023 10:48:08 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qU9lI-0001Ve-W7; Thu, 10 Aug 2023 19:47:53 +0200
Date:   Thu, 10 Aug 2023 19:47:52 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chieh-Min Wang <chiehminw@synology.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        LimeTech <tomm@lime-technology.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Netfilter <netfilter-devel@vger.kernel.org>,
        Netfilter Core Team <coreteam@netfilter.org>
Subject: Re: Fwd: kernel: WARNING: CPU: 0 PID: 16269 at
 net/netfilter/nf_conntrack_core.c:1210
Message-ID: <20230810174752.GH3325@breakpoint.cc>
References: <dd576088-2d95-4ab4-30a3-a9a132d7a9fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dd576088-2d95-4ab4-30a3-a9a132d7a9fa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Hi,
> 
> I notice a bug report on Bugzilla [1]. Quoting from it:
>
> > This call trace occurs consistently when using the docker macvlan driver where the bridge's parent is a Linux bridge.
> > 
> > Below is the typical configuration of br0 and docker macvlan
> > 
> > # commands to configure eth0 / br0 (br0 uses dhcp to obtain IP address)
> > ip link add name br0 type bridge stp_state 0 forward_delay 0 nf_call_iptables 1 nf_call_ip6tables 1 nf_call_arptables 1
> > ip link set br0 up
> > ip link set eth0 down
> > ip -4 addr flush dev eth0
> > ip -6 addr flush dev eth0
> > ip link set eth0 promisc on master br0 up
> > 
> > # command to configure docker macvlan network on br0
> > docker network create -d macvlan --subnet=10.0.101.0/24 --gateway=10.0.101.1 --aux-address=server=10.0.101.13 -o parent=br0 br0
> > 
> > We are currently running 6.1.43 kernel but this issue has been happening with all previous kernels for a least a couple of years now.  For example:
> > https://www.spinics.net/lists/netfilter/msg59040.html
> > 
> > Also syzbot detected this same issue in 6.5.0-rc2
> > https://www.spinics.net/lists/netfilter-devel/msg81831.html
> > 
> > Finally we also tried creating a vhost interface attached to br0 and then set that as the docker macvlan "parent" - same result.
> > 
> > 
> > Aug  8 10:06:51 ODROID kernel: ------------[ cut here ]------------
> > Aug  8 10:06:51 ODROID kernel: WARNING: CPU: 0 PID: 16269 at net/netfilter/nf_conntrack_core.c:1210 __nf_conntrack_confirm+0xa4/0x2b0 [nf_conntrack]
> > Aug  8 10:06:51 ODROID kernel: Modules linked in: xt_CHECKSUM ipt_REJECT nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle vhost_net tun vhost vhost_iotlb tap xt_nat xt_tcpudp veth xt_conntrack nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xfs cmac cifs asn1_decoder cifs_arc4 cifs_md4 oid_registry dns_resolver md_mod zfs(PO) zunicode(PO) zzstd(O) zlua(O) zavl(PO) icp(PO) zcommon(PO) znvpair(PO) spl(O) tcp_diag inet_diag emc2103 iptable_nat xt_MASQUERADE nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 wireguard curve25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 ip6_udp_tunnel udp_tunnel libchacha ip6table_filter ip6_tables iptable_filter ip_tables x_tables efivarfs af_packet 8021q garp mrp macvlan bridge stp llc bonding tls r8125(O) intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 iosf_mbi drm_buddy
> > Aug  8 10:06:51 ODROID kernel: aesni_intel i2c_algo_bit ttm drm_display_helper crypto_simd drm_kms_helper cryptd mei_hdcp mei_pxp nvme rapl i2c_i801 sr_mod input_leds intel_cstate drm i2c_smbus cdrom nvme_core joydev led_class video wmi intel_gtt ahci agpgart backlight libahci mei_me intel_pmc_core i2c_core syscopyarea sysfillrect mei sysimgblt fb_sys_fops thermal fan button unix [last unloaded: r8125(O)]
> > Aug  8 10:06:51 ODROID kernel: CPU: 0 PID: 16269 Comm: kworker/u8:0 Tainted: P           O       6.1.43-Unraid #2
> > Aug  8 10:06:51 ODROID kernel: Hardware name: HARDKERNEL ODROID-H2/ODROID-H2, BIOS 5.13 04/27/2020
> > Aug  8 10:06:51 ODROID kernel: Workqueue: events_unbound macvlan_process_broadcast [macvlan]
> > Aug  8 10:06:51 ODROID kernel: RIP: 0010:__nf_conntrack_confirm+0xa4/0x2b0 [nf_conntrack]
> > Aug  8 10:06:51 ODROID kernel: Code: 44 24 10 e8 e2 e1 ff ff 8b 7c 24 04 89 ea 89 c6 89 04 24 e8 7e e6 ff ff 84 c0 75 a2 48 89 df e8 9b e2 ff ff 85 c0 89 c5 74 18 <0f> 0b 8b 34 24 8b 7c 24 04 e8 18 dd ff ff e8 93 e3 ff ff e9 72 01
> > Aug  8 10:06:51 ODROID kernel: RSP: 0018:ffffc90000003d98 EFLAGS: 00010202
> > Aug  8 10:06:51 ODROID kernel: RAX: 0000000000000001 RBX: ffff88814a7ac400 RCX: 9c0c70d57470940d
> > Aug  8 10:06:51 ODROID kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88814a7ac400
> > Aug  8 10:06:51 ODROID kernel: RBP: 0000000000000001 R08: 2fcce5ef4761f5d5 R09: 28e40e9ae48c7a5f
> > Aug  8 10:06:51 ODROID kernel: R10: f5516b05dfc149e9 R11: ffffc90000003d60 R12: ffffffff82a11d00
> > Aug  8 10:06:51 ODROID kernel: R13: 0000000000011231 R14: ffff88814c989d00 R15: 0000000000000000
> > Aug  8 10:06:51 ODROID kernel: FS:  0000000000000000(0000) GS:ffff88846fc00000(0000) knlGS:0000000000000000
> > Aug  8 10:06:51 ODROID kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Aug  8 10:06:51 ODROID kernel: CR2: 0000000000537d30 CR3: 000000018567a000 CR4: 0000000000350ef0
> > Aug  8 10:06:51 ODROID kernel: Call Trace:
> > Aug  8 10:06:51 ODROID kernel: <IRQ>
> > Aug  8 10:06:51 ODROID kernel: ? __warn+0xab/0x122
> > Aug  8 10:06:51 ODROID kernel: ? report_bug+0x109/0x17e
> > Aug  8 10:06:51 ODROID kernel: ? __nf_conntrack_confirm+0xa4/0x2b0 [nf_conntrack]
> > Aug  8 10:06:51 ODROID kernel: ? handle_bug+0x41/0x6f
> > Aug  8 10:06:51 ODROID kernel: ? exc_invalid_op+0x13/0x60
> > Aug  8 10:06:51 ODROID kernel: ? asm_exc_invalid_op+0x16/0x20
> > Aug  8 10:06:51 ODROID kernel: ? __nf_conntrack_confirm+0xa4/0x2b0 [nf_conntrack]
> > Aug  8 10:06:51 ODROID kernel: ? __nf_conntrack_confirm+0x9e/0x2b0 [nf_conntrack]
> > Aug  8 10:06:51 ODROID kernel: ? nf_nat_inet_fn+0x60/0x1a8 [nf_nat]
> > Aug  8 10:06:51 ODROID kernel: nf_conntrack_confirm+0x25/0x54 [nf_conntrack]
> > Aug  8 10:06:51 ODROID kernel: nf_hook_slow+0x3a/0x96
> > Aug  8 10:06:51 ODROID kernel: ? ip_protocol_deliver_rcu+0x164/0x164
> > Aug  8 10:06:51 ODROID kernel: NF_HOOK.constprop.0+0x79/0xd9
> > Aug  8 10:06:51 ODROID kernel: ? ip_protocol_deliver_rcu+0x164/0x164
> > Aug  8 10:06:51 ODROID kernel: __netif_receive_skb_one_core+0x77/0x9c
> > Aug  8 10:06:51 ODROID kernel: process_backlog+0x8c/0x116
> > Aug  8 10:06:51 ODROID kernel: __napi_poll.constprop.0+0x28/0x124
> > Aug  8 10:06:51 ODROID kernel: net_rx_action+0x159/0x24f
> > Aug  8 10:06:51 ODROID kernel: __do_softirq+0x126/0x288
> > Aug  8 10:06:51 ODROID kernel: do_softirq+0x7f/0xab
> > Aug  8 10:06:51 ODROID kernel: </IRQ>
> > Aug  8 10:06:51 ODROID kernel: <TASK>
> > Aug  8 10:06:51 ODROID kernel: __local_bh_enable_ip+0x4c/0x6b
> > Aug  8 10:06:51 ODROID kernel: netif_rx+0x52/0x5a
> > Aug  8 10:06:51 ODROID kernel: macvlan_broadcast+0x10a/0x150 [macvlan]
> > Aug  8 10:06:51 ODROID kernel: ? _raw_spin_unlock+0x14/0x29
> > Aug  8 10:06:51 ODROID kernel: macvlan_process_broadcast+0xbc/0x12f [macvlan]
> > Aug  8 10:06:51 ODROID kernel: process_one_work+0x1a8/0x295
> > Aug  8 10:06:51 ODROID kernel: worker_thread+0x18b/0x244
> > Aug  8 10:06:51 ODROID kernel: ? rescuer_thread+0x281/0x281
> > Aug  8 10:06:51 ODROID kernel: kthread+0xe4/0xef
> > Aug  8 10:06:51 ODROID kernel: ? kthread_complete_and_exit+0x1b/0x1b
> > Aug  8 10:06:51 ODROID kernel: ret_from_fork+0x1f/0x30
> > Aug  8 10:06:51 ODROID kernel: </TASK>
> > Aug  8 10:06:51 ODROID kernel: ---[ end trace 0000000000000000 ]---
> 
> See Bugzilla for the full thread.
> 
> AFAIK, this is manifestation of earlier syzbot report [2] that haven't
> seen any response yet.

Because nobody knows how to fix this.
br_netfilter and conntrack are incompatible by design, and they always
have been.

Only "fixes" i see require either:

1. Give up on certain assumptions that are only true for ip/ipv6
   forwarding and add locking in nf_conntrack.

2. Place additional code in skb_clone to detect when we're shallow-copying
   unconfirmed nf_conn, complete with indirection if we detect that to
   do a full copy of skb->nf_conn (rather than a refcount increase)

3. (Not sure this works) tighter coupling in bridge_netfilter <->
   conntrack, do a full-copy nf_conn update in additional br_netfilter
   hooks.

All of these options suck.  I can't even reproduce this, not even by
adding a mavclan on top of a bridge (at the time macvlan driver
clones a broadcast, the nf_conn is already confirmed so no race possible).

I *can* see br_forward/br_flood and so on create clones with unconfirmed
entries, though, which isn't allowed from conntrack point of view.
But I can't get it to actually trigger the splat quoted above.

The setup/reproducer instructions in the BZ seem incomplete, or I'm
missing something else.

I have:

ns0, with br0 device, br_netfilter / call-iptables enabled and
nftables rules in place that cause conntrack to get enabled as well
ns1, connected to ns0 via veths, veth is a bridge port on ns0 side

I "ping -b" ipaddress of br0 from ns1 but no splat get triggered.

Ideal solution would be to remove br_netfilter from kernel, but too many
people reply on that thing.
