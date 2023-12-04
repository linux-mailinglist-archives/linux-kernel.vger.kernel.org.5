Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493F1802C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjLDHfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjLDHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:35:17 -0500
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869913A;
        Sun,  3 Dec 2023 23:35:16 -0800 (PST)
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:51574 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1rA3U3-0006P5-EC by authid <merlins.org> with srv_auth_plain; Sun, 03 Dec 2023 23:35:15 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1rA3U3-0003TY-8g; Sun, 03 Dec 2023 23:35:15 -0800
Date:   Sun, 3 Dec 2023 23:35:15 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ilw@linux.intel.com
Cc:     "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Thinkpad P17 keep hanging in ipv6_addrconf addrconf_verify_work
 / netlink in 6.4 and 6.6
Message-ID: <20231204073515.GA9208@merlins.org>
References: <20231202171326.GB24486@merlins.org>
 <20231204004003.GB29484@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204004003.GB29484@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, I thought that maybe my custom built kernel had options that somehow
made P17 unhappy, and went to a stock debian kernel.
It's not really looking better with that kernel unfortunately :-/

Still seems unhappy with networking, first wireless and then ethtool.
Adding wireless lists to Cc just in case

iwlwifi 0000:09:00.0: vgaarb: pci_notify
iwlwifi 0000:09:00.0: runtime IRQ mapping not provided by arch
iwlwifi 0000:09:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:09:00.0: enabling bus mastering
iwlwifi 0000:09:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
iwlwifi 0000:09:00.0: PCI dev 2725/0020, rev=0x420, rfid=0x10d000
iwlwifi 0000:09:00.0: vgaarb: pci_notify
iwlwifi 0000:09:00.0: api flags index 2 larger than supported by driver
iwlwifi 0000:09:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
iwlwifi 0000:09:00.0: loaded firmware version 83.e8f84e98.0 ty-a0-gf-a0-83.ucode op_mode iwlmvm
iwlwifi 0000:09:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
iwlwifi 0000:09:00.0: WRT: Invalid buffer destination


[  645.687194] wlp9s0: deauthenticated from e0:63:da:28:03:67 (Reason: 2=PREV_AUTH_NOT_VALID)
[  726.049654] INFO: task NetworkManager:3108 blocked for more than 120 seconds.
[  726.049659]       Tainted: G     U             6.6-amd64 #1 Debian 6.6.3-1~exp1
[  726.049660] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  726.049661] task:NetworkManager  state:D stack:0     pid:3108  ppid:1      flags:0x00000002
[  726.049664] Call Trace:
[  726.049665]  <TASK>
[  726.049667]  __schedule+0x3da/0xb20
[  726.049673]  schedule+0x5e/0xd0
[  726.049674]  schedule_preempt_disabled+0x15/0x30
[  726.049676]  __mutex_lock.constprop.0+0x39a/0x6a0
[  726.049680]  ? nl80211_prepare_wdev_dump+0x14e/0x210 [cfg80211]
[  726.049720]  nl80211_prepare_wdev_dump+0x86/0x210 [cfg80211]
[  726.049744]  nl80211_dump_station+0x80/0x290 [cfg80211]
[  726.049770]  ? load_balance+0x2e7/0xf50
[  726.049774]  genl_dumpit+0x33/0x90
[  726.049777]  netlink_dump+0x126/0x320
[  726.049779]  __netlink_dump_start+0x1d6/0x290
[  726.049781]  genl_family_rcv_msg_dumpit+0x9c/0x100
[  726.049783]  ? __pfx_genl_start+0x10/0x10
[  726.049784]  ? __pfx_genl_dumpit+0x10/0x10
[  726.049786]  ? __pfx_genl_done+0x10/0x10
[  726.049788]  genl_rcv_msg+0x146/0x2c0
[  726.049789]  ? __pfx_nl80211_dump_station+0x10/0x10 [cfg80211]
[  726.049814]  ? __pfx_genl_rcv_msg+0x10/0x10
[  726.049816]  netlink_rcv_skb+0x58/0x110
[  726.049818]  genl_rcv+0x28/0x40
[  726.049819]  netlink_unicast+0x1a3/0x290
[  726.049821]  netlink_sendmsg+0x254/0x4d0
[  726.049822]  ____sys_sendmsg+0x396/0x3d0
[  726.049825]  ? copy_msghdr_from_user+0x7d/0xc0
[  726.049827]  ___sys_sendmsg+0x9a/0xe0
[  726.049829]  __sys_sendmsg+0x7a/0xd0
[  726.049832]  do_syscall_64+0x5d/0xc0
[  726.049834]  ? syscall_exit_to_user_mode+0x2b/0x40
[  726.049836]  ? do_syscall_64+0x6c/0xc0
[  726.049838]  ? syscall_exit_to_user_mode+0x2b/0x40
[  726.049839]  ? do_syscall_64+0x6c/0xc0
[  726.049840]  ? do_syscall_64+0x6c/0xc0
[  726.049842]  ? syscall_exit_to_user_mode+0x2b/0x40
[  726.049843]  ? do_syscall_64+0x6c/0xc0
[  726.049844]  ? do_syscall_64+0x6c/0xc0
[  726.049846]  ? do_syscall_64+0x6c/0xc0
[  726.049847]  ? do_syscall_64+0x6c/0xc0
[  726.049848]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  726.049851] RIP: 0033:0x7fc8077fe9bd
[  726.049853] RSP: 002b:00007fff76dbfaa0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
[  726.049854] RAX: ffffffffffffffda RBX: 0000557620cd2c10 RCX: 00007fc8077fe9bd
[  726.049855] RDX: 0000000000000000 RSI: 00007fff76dbfaf0 RDI: 000000000000000b
[  726.049856] RBP: 00007fff76dbfaf0 R08: 0000000000000000 R09: 0000000000000300
[  726.049857] R10: 0000000000000000 R11: 0000000000000293 R12: 00007fff76dbfbd0
[  726.049857] R13: 0000557620d1afe0 R14: 00007fff76dbfe00 R15: 0000557620d1f290
[  726.049858]  </TASK>
[  726.049964] INFO: task ethtool:19081 blocked for more than 120 seconds.
[  726.049966]       Tainted: G     U             6.6-amd64 #1 Debian 6.6.3-1~exp1
[  726.049967] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  726.049967] task:ethtool         state:D stack:0     pid:19081 ppid:19032  flags:0x00004002
[  726.049969] Call Trace:
[  726.049969]  <TASK>
[  726.049970]  __schedule+0x3da/0xb20
[  726.049972]  schedule+0x5e/0xd0
[  726.049973]  schedule_preempt_disabled+0x15/0x30
[  726.049975]  __mutex_lock.constprop.0+0x39a/0x6a0
[  726.049977]  ? igc_tsn_reset+0x3f6/0x5a0 [igc]
[  726.049984]  igc_resume+0xfe/0x200 [igc]
[  726.049989]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[  726.049992]  __rpm_callback+0x41/0x170
[  726.049996]  rpm_callback+0x35/0x70
[  726.049997]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[  726.049999]  rpm_resume+0x56e/0x7b0
[  726.050001]  ? __nla_parse+0x24/0x30
[  726.050003]  ? netdev_get_by_name+0x84/0xa0
[  726.050005]  __pm_runtime_resume+0x4b/0x80
[  726.050007]  ethnl_ops_begin+0x2d/0xb0
[  726.050009]  ethnl_default_set_doit+0xaf/0x190
[  726.050011]  genl_family_rcv_msg_doit+0xef/0x150
[  726.050013]  genl_rcv_msg+0x1b3/0x2c0
[  726.050015]  ? __pfx_ethnl_default_set_doit+0x10/0x10
[  726.050016]  ? __pfx_genl_rcv_msg+0x10/0x10
[  726.050018]  netlink_rcv_skb+0x58/0x110
[  726.050020]  genl_rcv+0x28/0x40
[  726.050021]  netlink_unicast+0x1a3/0x290
[  726.050022]  netlink_sendmsg+0x254/0x4d0
[  726.050024]  __sys_sendto+0x1f6/0x200
[  726.050026]  __x64_sys_sendto+0x24/0x30
[  726.050028]  do_syscall_64+0x5d/0xc0
[  726.050030]  ? __count_memcg_events+0x42/0x90
[  726.050032]  ? count_memcg_events.constprop.0+0x1a/0x30
[  726.050034]  ? handle_mm_fault+0xa2/0x360
[  726.050036]  ? do_user_addr_fault+0x30f/0x660
[  726.050038]  ? exit_to_user_mode_prepare+0x40/0x1e0
[  726.050040]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  726.050042] RIP: 0033:0x7f70c0329a23
[  726.050043] RSP: 002b:00007ffe81df3af8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  726.050044] RAX: ffffffffffffffda RBX: 000055d840dcf430 RCX: 00007f70c0329a23
[  726.050045] RDX: 0000000000000030 RSI: 000055d840dd1510 RDI: 0000000000000003
[  726.050045] RBP: 0000000000000002 R08: 00007f70c0403be0 R09: 000000000000000c
[  726.050046] R10: 0000000000000000 R11: 0000000000000202 R12: 000055d840dbf340
[  726.050047] R13: 000055d840dd14d0 R14: 000055d83f301400 R15: 000055d840dbf330
[  726.050048]  </TASK>


On Sun, Dec 03, 2023 at 04:40:03PM -0800, Marc MERLIN wrote:
> I had a fully working linux system, just moved it from a thinkpad P73 to
> P17, which is obviously a new architecture.
> smpboot: CPU0: Intel(R) Xeon(R) W-11855M CPU @ 3.20GHz (family: 0x6, model: 0x8d, stepping: 0x1)
> 
> Both 6.4 and 6.6 start hanging a short time after boot in various ways.
> If I can't get this new laptop working soon-ish I'm going to have to return it, but I'm indeed wondering 
> what could be wrong.
> Unfortunately the P73 straight died, so I can't go back and forth, but I
> know both kernels and the entire user space worked fine on that system
> before it just died.
> 
> Suggestions welcome
> 
> [  363.945427] INFO: task powertop:6279 blocked for more than 120 seconds.
> [  363.945446]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  363.945452] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.945456] task:powertop        state:D stack:0     pid:6279  ppid:6267   flags:0x00004002
> [  363.945468] Call Trace:
> [  363.945473]  <TASK>
> [  363.945481]  __schedule+0xba0/0xc05
> [  363.945497]  schedule+0x95/0xce
> [  363.945504]  schedule_preempt_disabled+0x15/0x22
> [  363.945511]  __mutex_lock.constprop.0+0x18b/0x291
> [  363.945520]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [  363.945531]  igc_resume+0x18b/0x1ca [igc 1a96e277f8878a2a3c9599226acd0eeb7de577b7]
> [  363.945566]  __rpm_callback+0x7a/0xe7
> [  363.945578]  rpm_callback+0x35/0x64
> [  363.945587]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [  363.945592]  rpm_resume+0x342/0x44a
> [  363.945600]  ? __kmem_cache_alloc_node+0x123/0x154
> [  363.945614]  __pm_runtime_resume+0x5a/0x7a
> [  363.945624]  dev_ethtool+0x15a/0x24e7
> [  363.945634]  ? xa_load+0x7f/0xa1
> [  363.945642]  ? full_name_hash+0x23/0x8a
> [  363.945652]  ? dev_name_hash+0x35/0x50
> [  363.945664]  dev_ioctl+0x34b/0x464
> [  363.945674]  sock_do_ioctl+0x8f/0xd8
> [  363.945684]  sock_ioctl+0x29b/0x2c4
> [  363.945693]  ? alloc_file_pseudo+0xba/0x103
> [  363.945703]  vfs_ioctl+0x23/0x38
> [  363.945714]  __do_sys_ioctl+0x63/0x8a
> [  363.945721]  do_syscall_64+0x7e/0xa7
> [  363.945729]  ? syscall_exit_to_user_mode+0x26/0x2c
> [  363.945738]  ? do_syscall_64+0x9d/0xa7
> [  363.945744]  ? mntput_no_expire+0x4f/0x1e4
> [  363.945753]  ? rcu_segcblist_enqueue+0x12/0x37
> [  363.945765]  ? call_rcu+0xf9/0x19a
> [  363.945772]  ? syscall_exit_to_user_mode+0x26/0x2c
> [  363.945779]  ? do_syscall_64+0x9d/0xa7
> [  363.945785]  ? do_syscall_64+0x9d/0xa7
> [  363.945791]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  363.945802] RIP: 0033:0x7f7c7211cbab
> [  363.945809] RSP: 002b:00007ffca6b99f30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  363.945818] RAX: ffffffffffffffda RBX: 0000560e00113bf0 RCX: 00007f7c7211cbab
> [  363.945824] RDX: 00007ffca6b99fa0 RSI: 0000000000008946 RDI: 00000000000000b8
> [  363.945829] RBP: 00007ffca6b9a060 R08: 0000000000000008 R09: 0000000000000400
> [  363.945834] R10: 00000000000106fc R11: 0000000000000246 R12: 00000000000000b8
> [  363.945838] R13: 0000560e00116c40 R14: 00007ffca6b99fa0 R15: 0000000000000005
> [  363.945845]  </TASK>
> [  363.945850] INFO: task sudo:6879 blocked for more than 120 seconds.
> [  363.945855]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  363.945860] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.945863] task:sudo            state:D stack:0     pid:6879  ppid:5965   flags:0x00000002
> [  363.945871] Call Trace:
> [  363.945875]  <TASK>
> [  363.945879]  __schedule+0xba0/0xc05
> [  363.945888]  schedule+0x95/0xce
> [  363.945894]  schedule_preempt_disabled+0x15/0x22
> [  363.945900]  __mutex_lock.constprop.0+0x18b/0x291
> [  363.945909]  __netlink_dump_start+0x57/0x197
> [  363.945921]  rtnetlink_rcv_msg+0x14b/0x299
> [  363.945930]  ? __pfx_rtnl_dump_ifinfo+0x40/0x40
> [  363.945938]  ? __legitimize_path+0x3c/0x53
> [  363.945947]  ? __pfx_rtnl_dump_ifinfo+0x40/0x40
> [  363.945955]  ? __pfx_rtnetlink_rcv_msg+0x40/0x40
> [  363.945962]  netlink_rcv_skb+0x89/0xe3
> [  363.945975]  netlink_unicast+0x114/0x1b4
> [  363.945985]  netlink_sendmsg+0x321/0x361
> [  363.945996]  sock_sendmsg_nosec+0x46/0x70
> [  363.946004]  __sys_sendto+0xe7/0x126
> [  363.946014]  ? cgroup_rstat_updated+0x21/0xb7
> [  363.946022]  ? memcg_rstat_updated+0x16/0x62
> [  363.946031]  ? count_memcg_event_mm+0x44/0x5e
> [  363.946041]  ? handle_mm_fault+0x1f0/0x275
> [  363.946049]  __x64_sys_sendto+0x25/0x2c
> [  363.946058]  do_syscall_64+0x7e/0xa7
> [  363.946065]  ? exc_page_fault+0xff/0x123
> [  363.946073]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  363.946082] RIP: 0033:0x7f9a25947a23
> [  363.946086] RSP: 002b:00007ffddf0ee148 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> [  363.946093] RAX: ffffffffffffffda RBX: 00007ffddf0ef1a0 RCX: 00007f9a25947a23
> [  363.946098] RDX: 0000000000000014 RSI: 00007ffddf0ef1e0 RDI: 0000000000000003
> [  363.946102] RBP: 00007ffddf0ef230 R08: 00007ffddf0ef1a0 R09: 000000000000000c
> [  363.946106] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffddf0ef1e0
> [  363.946111] R13: 00007ffddf0ef338 R14: 00007ffddf0ef2a0 R15: 00007ffddf0ef448
> [  363.946118]  </TASK>
> [  484.777313] INFO: task kworker/3:1:104 blocked for more than 120 seconds.
> [  484.777333]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  484.777339] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  484.777343] task:kworker/3:1     state:D stack:0     pid:104   ppid:2      flags:0x00004000
> [  484.777357] Workqueue: ipv6_addrconf addrconf_verify_work
> [  484.777376] Call Trace:
> [  484.777381]  <TASK>
> [  484.777389]  __schedule+0xba0/0xc05
> [  484.777401]  schedule+0x95/0xce
> [  484.777408]  schedule_preempt_disabled+0x15/0x22
> [  484.777415]  __mutex_lock.constprop.0+0x18b/0x291
> [  484.777425]  addrconf_verify_work+0xe/0x20
> [  484.777435]  process_scheduled_works+0x1da/0x2e0
> [  484.777449]  worker_thread+0x1ca/0x224
> [  484.777459]  ? __pfx_worker_thread+0x40/0x40
> [  484.777470]  kthread+0xe9/0xf4
> [  484.777479]  ? __pfx_kthread+0x40/0x40
> [  484.777487]  ret_from_fork+0x21/0x38
> [  484.777495]  ? __pfx_kthread+0x40/0x40
> [  484.777507]  ret_from_fork_asm+0x1b/0x80
> [  484.777521]  </TASK>
> [  484.777526] INFO: task kworker/8:1:111 blocked for more than 120 seconds.
> [  484.777532]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  484.777536] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  484.777541] task:kworker/8:1     state:D stack:0     pid:111   ppid:2      flags:0x00004000
> [  484.777550] Workqueue: ipv6_addrconf addrconf_verify_work
> [  484.777560] Call Trace:
> [  484.777564]  <TASK>
> [  484.777568]  __schedule+0xba0/0xc05
> [  484.777576]  schedule+0x95/0xce
> [  484.777582]  schedule_preempt_disabled+0x15/0x22
> [  484.777589]  __mutex_lock.constprop.0+0x18b/0x291
> [  484.777598]  addrconf_verify_work+0xe/0x20
> [  484.777606]  process_scheduled_works+0x1da/0x2e0
> [  484.777617]  worker_thread+0x1ca/0x224
> [  484.777627]  ? __pfx_worker_thread+0x40/0x40
> [  484.777636]  kthread+0xe9/0xf4
> [  484.777644]  ? __pfx_kthread+0x40/0x40
> [  484.777652]  ret_from_fork+0x21/0x38
> [  484.777657]  ? __pfx_kthread+0x40/0x40
> [  484.777664]  ret_from_fork_asm+0x1b/0x80
> [  484.777675]  </TASK>
> [  484.777772] INFO: task powertop:6279 blocked for more than 241 seconds.
> [  484.777778]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  484.777782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  484.777786] task:powertop        state:D stack:0     pid:6279  ppid:6267   flags:0x00004002
> [  484.777794] Call Trace:
> [  484.777797]  <TASK>
> [  484.777801]  __schedule+0xba0/0xc05
> [  484.777809]  schedule+0x95/0xce
> [  484.777815]  schedule_preempt_disabled+0x15/0x22
> [  484.777821]  __mutex_lock.constprop.0+0x18b/0x291
> [  484.777829]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [  484.777840]  igc_resume+0x18b/0x1ca [igc 1a96e277f8878a2a3c9599226acd0eeb7de577b7]
> [  484.777877]  __rpm_callback+0x7a/0xe7
> [  484.777889]  rpm_callback+0x35/0x64
> [  484.777897]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [  484.777903]  rpm_resume+0x342/0x44a
> [  484.777911]  ? __kmem_cache_alloc_node+0x123/0x154
> [  484.777925]  __pm_runtime_resume+0x5a/0x7a
> [  484.777934]  dev_ethtool+0x15a/0x24e7
> [  484.777945]  ? xa_load+0x7f/0xa1
> [  484.777953]  ? full_name_hash+0x23/0x8a
> [  484.777963]  ? dev_name_hash+0x35/0x50
> [  484.777974]  dev_ioctl+0x34b/0x464
> [  484.777985]  sock_do_ioctl+0x8f/0xd8
> [  484.777994]  sock_ioctl+0x29b/0x2c4
> [  484.778003]  ? alloc_file_pseudo+0xba/0x103
> [  484.778012]  vfs_ioctl+0x23/0x38
> [  484.778023]  __do_sys_ioctl+0x63/0x8a
> [  484.778030]  do_syscall_64+0x7e/0xa7
> [  484.778039]  ? syscall_exit_to_user_mode+0x26/0x2c
> [  484.778047]  ? do_syscall_64+0x9d/0xa7
> [  484.778054]  ? mntput_no_expire+0x4f/0x1e4
> [  484.778063]  ? rcu_segcblist_enqueue+0x12/0x37
> [  484.778074]  ? call_rcu+0xf9/0x19a
> [  484.778082]  ? syscall_exit_to_user_mode+0x26/0x2c
> [  484.778089]  ? do_syscall_64+0x9d/0xa7
> [  484.778095]  ? do_syscall_64+0x9d/0xa7
> [  484.778101]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  484.778113] RIP: 0033:0x7f7c7211cbab
> [  484.778121] RSP: 002b:00007ffca6b99f30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  484.778129] RAX: ffffffffffffffda RBX: 0000560e00113bf0 RCX: 00007f7c7211cbab
> [  484.778135] RDX: 00007ffca6b99fa0 RSI: 0000000000008946 RDI: 00000000000000b8
> [  484.778140] RBP: 00007ffca6b9a060 R08: 0000000000000008 R09: 0000000000000400
> [  484.778145] R10: 00000000000106fc R11: 0000000000000246 R12: 00000000000000b8
> [  484.778150] R13: 0000560e00116c40 R14: 00007ffca6b99fa0 R15: 0000000000000005
> [  484.778157]  </TASK>
> [  484.778161] INFO: task sudo:6879 blocked for more than 241 seconds.
> [  484.778167]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  484.778171] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  484.778175] task:sudo            state:D stack:0     pid:6879  ppid:5965   flags:0x00000002
> [  484.778182] Call Trace:
> [  484.778186]  <TASK>
> [  484.778190]  __schedule+0xba0/0xc05
> [  484.778198]  schedule+0x95/0xce
> [  484.778204]  schedule_preempt_disabled+0x15/0x22
> [  484.778211]  __mutex_lock.constprop.0+0x18b/0x291
> [  484.778220]  __netlink_dump_start+0x57/0x197
> [  484.778232]  rtnetlink_rcv_msg+0x14b/0x299
> [  484.778241]  ? __pfx_rtnl_dump_ifinfo+0x40/0x40
> [  484.778249]  ? __legitimize_path+0x3c/0x53
> [  484.778259]  ? __pfx_rtnl_dump_ifinfo+0x40/0x40
> [  484.778267]  ? __pfx_rtnetlink_rcv_msg+0x40/0x40
> [  484.778274]  netlink_rcv_skb+0x89/0xe3
> [  484.778286]  netlink_unicast+0x114/0x1b4
> [  484.778297]  netlink_sendmsg+0x321/0x361
> [  484.778308]  sock_sendmsg_nosec+0x46/0x70
> [  484.778316]  __sys_sendto+0xe7/0x126
> [  484.778327]  ? cgroup_rstat_updated+0x21/0xb7
> [  484.778335]  ? memcg_rstat_updated+0x16/0x62
> [  484.778345]  ? count_memcg_event_mm+0x44/0x5e
> [  484.778355]  ? handle_mm_fault+0x1f0/0x275
> [  484.778363]  __x64_sys_sendto+0x25/0x2c
> [  484.778372]  do_syscall_64+0x7e/0xa7
> [  484.778379]  ? exc_page_fault+0xff/0x123
> [  484.778387]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  484.778396] RIP: 0033:0x7f9a25947a23
> [  484.778400] RSP: 002b:00007ffddf0ee148 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> [  484.778407] RAX: ffffffffffffffda RBX: 00007ffddf0ef1a0 RCX: 00007f9a25947a23
> [  484.778412] RDX: 0000000000000014 RSI: 00007ffddf0ef1e0 RDI: 0000000000000003
> [  484.778417] RBP: 00007ffddf0ef230 R08: 00007ffddf0ef1a0 R09: 000000000000000c
> [  484.778421] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffddf0ef1e0
> [  484.778426] R13: 00007ffddf0ef338 R14: 00007ffddf0ef2a0 R15: 00007ffddf0ef448
> [  484.778433]  </TASK>
> [  484.778439] INFO: task tlp:7221 blocked for more than 120 seconds.
> [  484.778443]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  484.778448] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  484.778452] task:tlp             state:D stack:0     pid:7221  ppid:7220   flags:0x00000002
> [  484.778458] Call Trace:
> [  484.778462]  <TASK>
> [  484.778466]  __schedule+0xba0/0xc05
> [  484.778473]  schedule+0x95/0xce
> [  484.778479]  rpm_resume+0x1a8/0x44a
> [  484.778488]  ? __pfx_autoremove_wake_function+0x40/0x40
> [  484.778501]  pm_runtime_forbid+0x3b/0x46
> [  484.778510]  control_store+0x5c/0x7c
> [  484.778521]  kernfs_fop_write_iter+0x111/0x15b
> [  484.778534]  vfs_write+0x126/0x1d6
> [  484.778542]  ksys_write+0x76/0xc3
> [  484.778549]  do_syscall_64+0x7e/0xa7
> [  484.778556]  ? handle_mm_fault+0x1f0/0x275
> [  484.778563]  ? do_user_addr_fault+0x28f/0x4fb
> [  484.778574]  ? exc_page_fault+0xff/0x123
> [  484.778581]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  484.778590] RIP: 0033:0x7f4f6f557190
> [  484.778594] RSP: 002b:00007ffebe4a8ab8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [  484.778600] RAX: ffffffffffffffda RBX: 000055805a6cfa60 RCX: 00007f4f6f557190
> [  484.778604] RDX: 0000000000000003 RSI: 000055805a6cfa60 RDI: 0000000000000001
> [  484.778609] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000073
> [  484.778614] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
> [  484.778618] R13: 0000000000000003 R14: 7fffffffffffffff R15: 0000000000000003
> [  484.778625]  </TASK>
> [  484.778631] INFO: task ifconfig:7426 blocked for more than 120 seconds.
> [  484.778636]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  484.778640] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  484.778644] task:ifconfig        state:D stack:0     pid:7426  ppid:7414   flags:0x00000002
> [  484.778650] Call Trace:
> [  484.778654]  <TASK>
> [  484.778657]  __schedule+0xba0/0xc05
> [  484.778664]  ? list_lru_add+0xdf/0xfc
> [  484.778676]  schedule+0x95/0xce
> [  484.778682]  schedule_preempt_disabled+0x15/0x22
> [  484.778689]  __mutex_lock.constprop.0+0x18b/0x291
> [  484.778697]  ? security_capable+0x3b/0x59
> [  484.778706]  devinet_ioctl+0xfe/0x5dd
> [  484.778718]  inet_ioctl+0x158/0x1b7
> [  484.778728]  ? dev_get_flags+0x4a/0x6f
> [  484.778739]  ? dev_ioctl+0x330/0x464
> [  484.778747]  ? _copy_to_user+0x15/0x3c
> [  484.778757]  ? put_user_ifreq+0x2a/0x3d
> [  484.778764]  sock_do_ioctl+0x39/0xd8
> [  484.778772]  sock_ioctl+0x29b/0x2c4
> [  484.778781]  vfs_ioctl+0x23/0x38
> [  484.778791]  __do_sys_ioctl+0x63/0x8a
> [  484.778798]  do_syscall_64+0x7e/0xa7
> [  484.778804]  ? exit_to_user_mode_prepare+0xa7/0x10e
> [  484.778813]  ? syscall_exit_to_user_mode+0x26/0x2c
> [  484.778821]  ? do_syscall_64+0x9d/0xa7
> [  484.778827]  ? exc_page_fault+0xff/0x123
> [  484.778834]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  484.778843] RIP: 0033:0x7f84e8df6bab
> [  484.778847] RSP: 002b:00007ffc9dfc4b90 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  484.778853] RAX: ffffffffffffffda RBX: 00007ffc9dfc4cd0 RCX: 00007f84e8df6bab
> [  484.778858] RDX: 00007ffc9dfc4bf0 RSI: 0000000000008914 RDI: 0000000000000003
> [  484.778863] RBP: 0000000000000003 R08: 000000000000000a R09: 0000000000000000
> [  484.778867] R10: 0000000000000011 R11: 0000000000000246 R12: 00000000fffffffe
> [  484.778872] R13: 0000000000000000 R14: 00007ffc9dfc5ed0 R15: 0000000000000064
> [  484.778879]  </TASK>
> [  605.609311] INFO: task kworker/3:1:104 blocked for more than 241 seconds.
> [  605.609331]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  605.609337] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  605.609341] task:kworker/3:1     state:D stack:0     pid:104   ppid:2      flags:0x00004000
> [  605.609355] Workqueue: ipv6_addrconf addrconf_verify_work
> [  605.609373] Call Trace:
> [  605.609378]  <TASK>
> [  605.609386]  __schedule+0xba0/0xc05
> [  605.609399]  schedule+0x95/0xce
> [  605.609405]  schedule_preempt_disabled+0x15/0x22
> [  605.609413]  __mutex_lock.constprop.0+0x18b/0x291
> [  605.609422]  addrconf_verify_work+0xe/0x20
> [  605.609432]  process_scheduled_works+0x1da/0x2e0
> [  605.609446]  worker_thread+0x1ca/0x224
> [  605.609456]  ? __pfx_worker_thread+0x40/0x40
> [  605.609467]  kthread+0xe9/0xf4
> [  605.609476]  ? __pfx_kthread+0x40/0x40
> [  605.609484]  ret_from_fork+0x21/0x38
> [  605.609492]  ? __pfx_kthread+0x40/0x40
> [  605.609500]  ret_from_fork_asm+0x1b/0x80
> [  605.609514]  </TASK>
> [  605.609519] INFO: task kworker/8:1:111 blocked for more than 241 seconds.
> [  605.609524]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> [  605.609529] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  605.609533] task:kworker/8:1     state:D stack:0     pid:111   ppid:2      flags:0x00004000
> [  605.609542] Workqueue: ipv6_addrconf addrconf_verify_work
> [  605.609552] Call Trace:
> [  605.609555]  <TASK>
> [  605.609559]  __schedule+0xba0/0xc05
> [  605.609567]  schedule+0x95/0xce
> [  605.609573]  schedule_preempt_disabled+0x15/0x22
> [  605.609580]  __mutex_lock.constprop.0+0x18b/0x291
> [  605.609588]  addrconf_verify_work+0xe/0x20
> [  605.609597]  process_scheduled_works+0x1da/0x2e0
> [  605.609608]  worker_thread+0x1ca/0x224
> [  605.609618]  ? __pfx_worker_thread+0x40/0x40
> [  605.609628]  kthread+0xe9/0xf4
> [  605.609635]  ? __pfx_kthread+0x40/0x40
> [  605.609643]  ret_from_fork+0x21/0x38
> [  605.609648]  ? __pfx_kthread+0x40/0x40
> [  605.609656]  ret_from_fork_asm+0x1b/0x80
> [  605.609666]  </TASK>
> [  605.609670] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> 
> 
> [ 1209.778101] INFO: task powertop:10833 blocked for more than 120 seconds.
> [ 1209.778120]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1209.778125] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1209.778129] task:powertop        state:D stack:0     pid:10833 ppid:10782  flags:0x00004002
> [ 1209.778140] Call Trace:
> [ 1209.778145]  <TASK>
> [ 1209.778153]  __schedule+0xba5/0xc17
> [ 1209.778172]  schedule+0x95/0xce
> [ 1209.778180]  schedule_preempt_disabled+0x15/0x22
> [ 1209.778189]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1209.778200]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [ 1209.778216]  igc_resume+0x18b/0x1ca [igc 41f81b862578375c22079f09ed112f5f87485ae7]
> [ 1209.778248]  __rpm_callback+0x7a/0xe7
> [ 1209.778258]  rpm_callback+0x35/0x64
> [ 1209.778265]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [ 1209.778273]  rpm_resume+0x342/0x44a
> [ 1209.778280]  ? __kmem_cache_alloc_node+0x133/0x160
> [ 1209.778293]  __pm_runtime_resume+0x5a/0x7a
> [ 1209.778302]  dev_ethtool+0x15a/0x2384
> [ 1209.778310]  ? acpi_evaluate_object+0x229/0x254
> [ 1209.778323]  ? cgroup_rstat_updated+0x21/0xa5
> [ 1209.778331]  ? memcg_rstat_updated+0x16/0x62
> [ 1209.778339]  ? full_name_hash+0x23/0x8a
> [ 1209.778347]  ? dev_name_hash+0x35/0x50
> [ 1209.778356]  dev_ioctl+0x34b/0x464
> [ 1209.778366]  sock_do_ioctl+0x8f/0xd8
> [ 1209.778377]  sock_ioctl+0x299/0x2c2
> [ 1209.778386]  ? alloc_empty_file+0xbe/0xd6
> [ 1209.778395]  vfs_ioctl+0x20/0x35
> [ 1209.778404]  __do_sys_ioctl+0x63/0x8a
> [ 1209.778414]  do_syscall_64+0x7e/0xa7
> [ 1209.778426]  ? __sys_socket+0x92/0xc5
> [ 1209.778435]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1209.778442]  ? do_syscall_64+0x9d/0xa7
> [ 1209.778451]  ? exit_to_user_mode_prepare+0xa2/0x109
> [ 1209.778462]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1209.778467]  ? do_syscall_64+0x9d/0xa7
> [ 1209.778475]  ? do_syscall_64+0x9d/0xa7
> [ 1209.778483]  ? do_syscall_64+0x9d/0xa7
> [ 1209.778492]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> [ 1209.778499] RIP: 0033:0x7ff94491cbab
> [ 1209.778510] RSP: 002b:00007ffcd698cc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 1209.778518] RAX: ffffffffffffffda RBX: 00005642198f8650 RCX: 00007ff94491cbab
> [ 1209.778523] RDX: 00007ffcd698ccd0 RSI: 0000000000008946 RDI: 00000000000000b8
> [ 1209.778528] RBP: 00007ffcd698cd90 R08: 0000000000000008 R09: 0000564223f48860
> [ 1209.778532] R10: 00005642198fa688 R11: 0000000000000246 R12: 00000000000000b8
> [ 1209.778536] R13: 00005642198fb6a0 R14: 00007ffcd698ccd0 R15: 0000000000000005
> [ 1209.778543]  </TASK>
> [ 1312.885534] wlp9s0: deauthenticated from e0:63:da:28:03:67 (Reason: 2=PREV_AUTH_NOT_VALID)
> [ 1330.608401] INFO: task kworker/6:0:53 blocked for more than 120 seconds.
> [ 1330.608424]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1330.608432] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1330.608437] task:kworker/6:0     state:D stack:0     pid:53    ppid:2      flags:0x00004000
> [ 1330.608453] Workqueue: ipv6_addrconf addrconf_verify_work
> [ 1330.608474] Call Trace:
> [ 1330.608480]  <TASK>
> [ 1330.608489]  __schedule+0xba5/0xc17
> [ 1330.608507]  ? set_next_entity+0x70/0xcf
> [ 1330.608521]  schedule+0x95/0xce
> [ 1330.608532]  schedule_preempt_disabled+0x15/0x22
> [ 1330.608544]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1330.608560]  addrconf_verify_work+0xe/0x20
> [ 1330.608572]  process_one_work+0x1e9/0x2dd
> [ 1330.608583]  worker_thread+0x1c2/0x24b
> [ 1330.608590]  ? __pfx_worker_thread+0x40/0x40
> [ 1330.608599]  kthread+0xe9/0xf4
> [ 1330.608610]  ? __pfx_kthread+0x40/0x40
> [ 1330.608621]  ret_from_fork+0x29/0x80
> [ 1330.608638]  </TASK>
> [ 1330.608716] INFO: task NetworkManager:3128 blocked for more than 120 seconds.
> [ 1330.608723]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1330.608729] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1330.608733] task:NetworkManager  state:D stack:0     pid:3128  ppid:1      flags:0x00000002
> [ 1330.608744] Call Trace:
> [ 1330.608749]  <TASK>
> [ 1330.608754]  __schedule+0xba5/0xc17
> [ 1330.608769]  schedule+0x95/0xce
> [ 1330.608780]  schedule_preempt_disabled+0x15/0x22
> [ 1330.608793]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1330.608812]  nl80211_prepare_wdev_dump+0x8b/0x19f [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1330.608973]  nl80211_dump_station+0x49/0x1d0 [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1330.609122]  ? __mod_lruvec_page_state+0x4c/0x86
> [ 1330.609134]  ? mod_lruvec_page_state.constprop.0+0x1c/0x2e
> [ 1330.609146]  ? __kmalloc_large_node+0xd5/0xfb
> [ 1330.609159]  ? __kmalloc_node_track_caller+0x5a/0xad
> [ 1330.609172]  ? kmalloc_reserve+0xa7/0xe2
> [ 1330.609182]  ? __alloc_skb+0xe9/0x148
> [ 1330.609195]  netlink_dump+0x143/0x2b2
> [ 1330.609210]  __netlink_dump_start+0x125/0x177
> [ 1330.609223]  genl_family_rcv_msg_dumpit+0xf1/0x110
> [ 1330.609238]  ? __pfx_genl_start+0x40/0x40
> [ 1330.609251]  ? __pfx_nl80211_dump_station+0x40/0x40 [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1330.609392]  ? __pfx_genl_parallel_done+0x40/0x40
> [ 1330.609406]  genl_rcv_msg+0x189/0x1e2
> [ 1330.609414]  ? __pfx_nl80211_dump_station+0x40/0x40 [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1330.609554]  ? __pfx_genl_rcv_msg+0x40/0x40
> [ 1330.609562]  netlink_rcv_skb+0x89/0xe3
> [ 1330.609577]  genl_rcv+0x24/0x31
> [ 1330.609589]  netlink_unicast+0x10e/0x1ae
> [ 1330.609602]  netlink_sendmsg+0x321/0x361
> [ 1330.609614]  sock_sendmsg_nosec+0x35/0x64
> [ 1330.609629]  ____sys_sendmsg+0x13e/0x1ef
> [ 1330.609642]  ___sys_sendmsg+0x76/0xb3
> [ 1330.609652]  ? __pfx_pollwake+0x40/0x40
> [ 1330.609664]  ? __fget+0x38/0x47
> [ 1330.609676]  __sys_sendmsg+0x60/0x97
> [ 1330.609688]  do_syscall_64+0x7e/0xa7
> [ 1330.609702]  ? do_syscall_64+0x9d/0xa7
> [ 1330.609713]  ? do_syscall_64+0x9d/0xa7
> [ 1330.609725]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> [ 1330.609736] RIP: 0033:0x7f8f96bfe9bd
> [ 1330.609745] RSP: 002b:00007ffd125c8b80 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> [ 1330.609756] RAX: ffffffffffffffda RBX: 00007f8f80001e30 RCX: 00007f8f96bfe9bd
> [ 1330.609764] RDX: 0000000000000000 RSI: 00007ffd125c8bd0 RDI: 000000000000000b
> [ 1330.609770] RBP: 00007ffd125c8bd0 R08: 0000000000000000 R09: 0000000000000300
> [ 1330.609776] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffd125c8cb0
> [ 1330.609782] R13: 0000562615ed8db0 R14: 00007ffd125c8ee0 R15: 0000562615ede650
> [ 1330.609790]  </TASK>
> [ 1330.609797] INFO: task wpa_supplicant:3136 blocked for more than 120 seconds.
> [ 1330.609803]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1330.609809] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1330.609813] task:wpa_supplicant  state:D stack:0     pid:3136  ppid:1      flags:0x00000002
> [ 1330.609822] Call Trace:
> [ 1330.609827]  <TASK>
> [ 1330.609832]  __schedule+0xba5/0xc17
> [ 1330.609843]  ? memcg_list_lru_alloc+0x87/0x2f8
> [ 1330.609852]  ? call_function_single_prep_ipi+0x4c/0x54
> [ 1330.609864]  ? __smp_call_single_queue+0x5d/0x8d
> [ 1330.609880]  schedule+0x95/0xce
> [ 1330.609891]  schedule_preempt_disabled+0x15/0x22
> [ 1330.609903]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1330.609917]  rtnetlink_rcv_msg+0x21f/0x299
> [ 1330.609930]  ? percpu_ref_put+0xa/0x39
> [ 1330.609942]  ? __kmem_cache_alloc_node+0x133/0x160
> [ 1330.609956]  ? __pfx_rtnetlink_rcv_msg+0x40/0x40
> [ 1330.609967]  netlink_rcv_skb+0x89/0xe3
> [ 1330.609982]  netlink_unicast+0x10e/0x1ae
> [ 1330.609993]  netlink_sendmsg+0x321/0x361
> [ 1330.610006]  sock_sendmsg_nosec+0x35/0x64
> [ 1330.610018]  __sys_sendto+0xe3/0x122
> [ 1330.610027]  ? sk_getsockopt+0x849/0xa4f
> [ 1330.610041]  ? sock_sendmsg_nosec+0x49/0x64
> [ 1330.610052]  ? __sys_sendto+0xf3/0x122
> [ 1330.610061]  ? sock_ioctl+0x299/0x2c2
> [ 1330.610074]  __x64_sys_sendto+0x25/0x2c
> [ 1330.610082]  do_syscall_64+0x7e/0xa7
> [ 1330.610094]  ? vfs_ioctl+0x20/0x35
> [ 1330.610106]  ? __do_sys_ioctl+0x63/0x8a
> [ 1330.610119]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1330.610127]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610139]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1330.610146]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610158]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1330.610165]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610177]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610188]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610200]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610212]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> [ 1330.610220] RIP: 0033:0x7fc8983298c9
> [ 1330.610226] RSP: 002b:00007ffc044ce958 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [ 1330.610234] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fc8983298c9
> [ 1330.610240] RDX: 0000000000000028 RSI: 00007ffc044ce970 RDI: 0000000000000005
> [ 1330.610246] RBP: 00007ffc044ce970 R08: 0000000000000000 R09: 0000000000000000
> [ 1330.610252] R10: 0000000000000000 R11: 0000000000000246 R12: 000055d3af3f4240
> [ 1330.610257] R13: 0000000000000000 R14: 0000000000000005 R15: 0000000000000000
> [ 1330.610265]  </TASK>
> [ 1330.610308] INFO: task kworker/7:2:9783 blocked for more than 120 seconds.
> [ 1330.610314]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1330.610319] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1330.610324] task:kworker/7:2     state:D stack:0     pid:9783  ppid:2      flags:0x00004000
> [ 1330.610334] Workqueue: ipv6_addrconf addrconf_verify_work
> [ 1330.610347] Call Trace:
> [ 1330.610351]  <TASK>
> [ 1330.610356]  __schedule+0xba5/0xc17
> [ 1330.610368]  ? set_next_entity+0x70/0xcf
> [ 1330.610379]  schedule+0x95/0xce
> [ 1330.610391]  schedule_preempt_disabled+0x15/0x22
> [ 1330.610402]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1330.610417]  addrconf_verify_work+0xe/0x20
> [ 1330.610428]  process_one_work+0x1e9/0x2dd
> [ 1330.610437]  worker_thread+0x1c2/0x24b
> [ 1330.610444]  ? __pfx_worker_thread+0x40/0x40
> [ 1330.610453]  kthread+0xe9/0xf4
> [ 1330.610463]  ? __pfx_kthread+0x40/0x40
> [ 1330.610475]  ret_from_fork+0x29/0x80
> [ 1330.610490]  </TASK>
> [ 1330.610519] INFO: task powertop:10833 blocked for more than 241 seconds.
> [ 1330.610525]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1330.610531] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1330.610535] task:powertop        state:D stack:0     pid:10833 ppid:10782  flags:0x00004002
> [ 1330.610544] Call Trace:
> [ 1330.610548]  <TASK>
> [ 1330.610554]  __schedule+0xba5/0xc17
> [ 1330.610567]  schedule+0x95/0xce
> [ 1330.610578]  schedule_preempt_disabled+0x15/0x22
> [ 1330.610590]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1330.610604]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [ 1330.610622]  igc_resume+0x18b/0x1ca [igc 41f81b862578375c22079f09ed112f5f87485ae7]
> [ 1330.610662]  __rpm_callback+0x7a/0xe7
> [ 1330.610680]  rpm_callback+0x35/0x64
> [ 1330.610689]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [ 1330.610702]  rpm_resume+0x342/0x44a
> [ 1330.610711]  ? __kmem_cache_alloc_node+0x133/0x160
> [ 1330.610725]  __pm_runtime_resume+0x5a/0x7a
> [ 1330.610735]  dev_ethtool+0x15a/0x2384
> [ 1330.610745]  ? acpi_evaluate_object+0x229/0x254
> [ 1330.610761]  ? cgroup_rstat_updated+0x21/0xa5
> [ 1330.610771]  ? memcg_rstat_updated+0x16/0x62
> [ 1330.610781]  ? full_name_hash+0x23/0x8a
> [ 1330.610792]  ? dev_name_hash+0x35/0x50
> [ 1330.610803]  dev_ioctl+0x34b/0x464
> [ 1330.610817]  sock_do_ioctl+0x8f/0xd8
> [ 1330.610829]  sock_ioctl+0x299/0x2c2
> [ 1330.610842]  ? alloc_empty_file+0xbe/0xd6
> [ 1330.610852]  vfs_ioctl+0x20/0x35
> [ 1330.610865]  __do_sys_ioctl+0x63/0x8a
> [ 1330.610878]  do_syscall_64+0x7e/0xa7
> [ 1330.610891]  ? __sys_socket+0x92/0xc5
> [ 1330.610903]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1330.610911]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610924]  ? exit_to_user_mode_prepare+0xa2/0x109
> [ 1330.610938]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1330.610945]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610957]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610968]  ? do_syscall_64+0x9d/0xa7
> [ 1330.610979]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> [ 1330.610987] RIP: 0033:0x7ff94491cbab
> [ 1330.610993] RSP: 002b:00007ffcd698cc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 1330.611001] RAX: ffffffffffffffda RBX: 00005642198f8650 RCX: 00007ff94491cbab
> [ 1330.611007] RDX: 00007ffcd698ccd0 RSI: 0000000000008946 RDI: 00000000000000b8
> [ 1330.611013] RBP: 00007ffcd698cd90 R08: 0000000000000008 R09: 0000564223f48860
> [ 1330.611019] R10: 00005642198fa688 R11: 0000000000000246 R12: 00000000000000b8
> [ 1330.611025] R13: 00005642198fb6a0 R14: 00007ffcd698ccd0 R15: 0000000000000005
> [ 1330.611033]  </TASK>
> [ 1330.611041] INFO: task ifconfig:11759 blocked for more than 120 seconds.
> [ 1330.611047]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1330.611053] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1330.611057] task:ifconfig        state:D stack:0     pid:11759 ppid:11756  flags:0x00000002
> [ 1330.611065] Call Trace:
> [ 1330.611069]  <TASK>
> [ 1330.611074]  __schedule+0xba5/0xc17
> [ 1330.611087]  schedule+0x95/0xce
> [ 1330.611098]  schedule_preempt_disabled+0x15/0x22
> [ 1330.611110]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1330.611124]  dev_ifconf+0x90/0x12b
> [ 1330.611137]  sock_ioctl+0x138/0x2c2
> [ 1330.611149]  ? exit_to_user_mode_prepare+0xa2/0x109
> [ 1330.611162]  vfs_ioctl+0x20/0x35
> [ 1330.611173]  __do_sys_ioctl+0x63/0x8a
> [ 1330.611186]  do_syscall_64+0x7e/0xa7
> [ 1330.611198]  ? do_syscall_64+0x9d/0xa7
> [ 1330.611209]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1330.611216]  ? do_syscall_64+0x9d/0xa7
> [ 1330.611229]  ? exit_to_user_mode_prepare+0xa2/0x109
> [ 1330.611240]  ? syscall_exit_to_user_mode+0x18/0x27
> [ 1330.611248]  ? do_syscall_64+0x9d/0xa7
> [ 1330.611259]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> [ 1330.611267] RIP: 0033:0x7fac049f1bab
> [ 1330.611272] RSP: 002b:00007ffdb3a713f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 1330.611279] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007fac049f1bab
> [ 1330.611285] RDX: 00007ffdb3a71450 RSI: 0000000000008912 RDI: 0000000000000004
> [ 1330.611290] RBP: 0000000000000004 R08: 00007fac04ac7290 R09: 00007fac04ac7290
> [ 1330.611296] R10: 00007fac0490b358 R11: 0000000000000246 R12: 0000000000000000
> [ 1330.611301] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fac04b28020
> [ 1330.611310]  </TASK>
> 1290]: exit on signal(15)
> [ 1438.127418] vgaarb: client 0x00000000246d3583 called 'target'
> [ 1438.127452] vgaarb: PCI:0000:00:02.0 ==> 0000:00:02.0 pdev 000000008dd45497
> [ 1438.127464] vgaarb: vgadev 000000001f7bb54d
> [ 1438.169160] vgaarb: vga_arb_release
> [ 1438.169183] i915 0000:00:02.0: vgaarb: uc->io_cnt == 0, uc->mem_cnt == 0
> [ 1439.495992] dm-2: detected capacity change from 4094509711 to 0
> [ 1451.438907] INFO: task kworker/6:0:53 blocked for more than 241 seconds.
> [ 1451.438959]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1451.438991] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1451.439021] task:kworker/6:0     state:D stack:0     pid:53    ppid:2      flags:0x00004000
> [ 1451.439062] Workqueue: ipv6_addrconf addrconf_verify_work
> [ 1451.439099] Call Trace:
> [ 1451.439114]  <TASK>
> [ 1451.439131]  __schedule+0xba5/0xc17
> [ 1451.439159]  ? set_next_entity+0x70/0xcf
> [ 1451.439185]  schedule+0x95/0xce
> [ 1451.439206]  schedule_preempt_disabled+0x15/0x22
> [ 1451.439233]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1451.439263]  addrconf_verify_work+0xe/0x20
> [ 1451.439287]  process_one_work+0x1e9/0x2dd
> [ 1451.439311]  worker_thread+0x1c2/0x24b
> [ 1451.439331]  ? __pfx_worker_thread+0x40/0x40
> [ 1451.439353]  kthread+0xe9/0xf4
> [ 1451.439375]  ? __pfx_kthread+0x40/0x40
> [ 1451.439399]  ret_from_fork+0x29/0x80
> [ 1451.439425]  </TASK>
> [ 1451.439452] INFO: task kworker/0:2:139 blocked for more than 120 seconds.
> [ 1451.439481]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1451.439511] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1451.439540] task:kworker/0:2     state:D stack:0     pid:139   ppid:2      flags:0x00004000
> [ 1451.439577] Workqueue: events linkwatch_event
> [ 1451.439602] Call Trace:
> [ 1451.439616]  <TASK>
> [ 1451.439630]  __schedule+0xba5/0xc17
> [ 1451.439655]  schedule+0x95/0xce
> [ 1451.439677]  schedule_preempt_disabled+0x15/0x22
> [ 1451.439703]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1451.439732]  linkwatch_event+0xa/0x26
> [ 1451.439753]  process_one_work+0x1e9/0x2dd
> [ 1451.439775]  worker_thread+0x1c2/0x24b
> [ 1451.439795]  ? __pfx_worker_thread+0x40/0x40
> [ 1451.439817]  kthread+0xe9/0xf4
> [ 1451.439838]  ? __pfx_kthread+0x40/0x40
> [ 1451.439861]  ret_from_fork+0x29/0x80
> [ 1451.439886]  </TASK>
> [ 1451.439944] INFO: task NetworkManager:3128 blocked for more than 241 seconds.
> [ 1451.439973]       Tainted: G     U     OE      6.4.9-amd64-preempt-sysrq-20220227 #2
> [ 1451.440004] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1451.440033] task:NetworkManager  state:D stack:0     pid:3128  ppid:1      flags:0x00000002
> [ 1451.440068] Call Trace:
> [ 1451.440082]  <TASK>
> [ 1451.440096]  __schedule+0xba5/0xc17
> [ 1451.440120]  schedule+0x95/0xce
> [ 1451.440141]  schedule_preempt_disabled+0x15/0x22
> [ 1451.440167]  __mutex_lock.constprop.0+0x18b/0x291
> [ 1451.440200]  nl80211_prepare_wdev_dump+0x8b/0x19f [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1451.440362]  nl80211_dump_station+0x49/0x1d0 [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1451.440511]  ? __mod_lruvec_page_state+0x4c/0x86
> [ 1451.440539]  ? mod_lruvec_page_state.constprop.0+0x1c/0x2e
> [ 1451.440569]  ? __kmalloc_large_node+0xd5/0xfb
> [ 1451.440595]  ? __kmalloc_node_track_caller+0x5a/0xad
> [ 1451.440623]  ? kmalloc_reserve+0xa7/0xe2
> [ 1451.440647]  ? __alloc_skb+0xe9/0x148
> [ 1451.440670]  netlink_dump+0x143/0x2b2
> [ 1451.440697]  __netlink_dump_start+0x125/0x177
> [ 1451.440723]  genl_family_rcv_msg_dumpit+0xf1/0x110
> [ 1451.440753]  ? __pfx_genl_start+0x40/0x40
> [ 1451.440777]  ? __pfx_nl80211_dump_station+0x40/0x40 [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1451.440922]  ? __pfx_genl_parallel_done+0x40/0x40
> [ 1451.440950]  genl_rcv_msg+0x189/0x1e2
> [ 1451.440971]  ? __pfx_nl80211_dump_station+0x40/0x40 [cfg80211 d0c23c84d531afea8d4a2711c5c3e691cbb9587f]
> [ 1451.441113]  ? __pfx_genl_rcv_msg+0x40/0x40
> [ 1451.441134]  netlink_rcv_skb+0x89/0xe3
> [ 1451.441160]  genl_rcv+0x24/0x31
> [ 1451.441182]  netlink_unicast+0x10e/0x1ae
> [ 1451.441206]  netlink_sendmsg+0x321/0x361
> [ 1451.441232]  sock_sendmsg_nosec+0x35/0x64
> [ 1451.441259]  ____sys_sendmsg+0x13e/0x1ef
> [ 1451.441284]  ___sys_sendmsg+0x76/0xb3
> [ 1451.441306]  ? __pfx_pollwake+0x40/0x40
> [ 1451.441330]  ? __fget+0x38/0x47
> [ 1451.441352]  __sys_sendmsg+0x60/0x97
> [ 1451.441374]  do_syscall_64+0x7e/0xa7
> [ 1451.441400]  ? do_syscall_64+0x9d/0xa7
> [ 1451.441423]  ? do_syscall_64+0x9d/0xa7
> [ 1451.441447]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> [ 1451.441474] RIP: 0033:0x7f8f96bfe9bd
> [ 1451.441496] RSP: 002b:00007ffd125c8b80 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> [ 1451.441530] RAX: ffffffffffffffda RBX: 00007f8f80001e30 RCX: 00007f8f96bfe9bd
> [ 1451.441559] RDX: 0000000000000000 RSI: 00007ffd125c8bd0 RDI: 000000000000000b
> [ 1451.441588] RBP: 00007ffd125c8bd0 R08: 0000000000000000 R09: 0000000000000300
> [ 1451.441617] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffd125c8cb0
> [ 1451.441646] R13: 0000562615ed8db0 R14: 00007ffd125c8ee0 R15: 0000562615ede650
> [ 1451.441677]  </TASK>
> [ 1451.441690] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> 
> 
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
