Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3826277471F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjHHTJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjHHTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A02FA33
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA1D6252E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B39C433C7;
        Tue,  8 Aug 2023 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691499091;
        bh=EWUqpZCKZdwIVysQ6q1Mj38r80ICMLLITjJUiOe7WMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=un801rC+Af7YqhsjrOLMkOX8I/aX+LSLRRjHePeETFvtImh5PoMVEMJPiTTZNOmu2
         88ekXr+zS9Mtie1l1vzQ/2/g+4BijxUW3f4weNENl0aX+ehztReFJoEGxNS17vV0xj
         mimQVEQw95kYrrSIwxrn1QXgAelMMK7BOWpifpXF+GU8Z10wZ3+nSTlNY4KroNpzNv
         X2rNNhJKVBqwVqS0V242epdr+dSwPhnl0d6Wa30bN6GFVJCEjRV1NSL7QcyRfHKyPs
         4YoItf4PliHyl2JR0zgRUeQTvI/L+eueesheeHVL9VAn+dZ6WecuHBC459XaGN8KE1
         U6lMpG979jiMQ==
Date:   Tue, 8 Aug 2023 14:51:25 +0200
From:   Simon Horman <horms@kernel.org>
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Jacob.e.keller@intel.com, przemyslawx.patynowski@intel.com,
        kamil.maziarz@intel.com, dawidx.wesierski@intel.com,
        mateusz.palczewski@intel.com, slawomirx.laba@intel.com,
        norbertx.zulinski@intel.com, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] ice: Fix NULL pointer deref during VF reset
Message-ID: <ZNI6TdaxrBnsbnC4@vergenet.net>
References: <20230807094831.696626-1-poros@redhat.com>
 <20230807094831.696626-3-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230807094831.696626-3-poros@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:48:31AM +0200, Petr Oros wrote:
> During stress test with attaching and detaching VF from KVM and
> simultaneously changing VFs spoofcheck and trust there was a
> NULL pointer dereference in ice_reset_vf that VF's VSI is null.
>=20
> More than one instance of ice_reset_vf() can be running at a given
> time. When we rebuild the VSI in ice_reset_vf, another reset can be
> triaged from ice_service_task. In this case we can access the currently
> uninitialized VSI and couse panic. The window for this racing condition

nit: couse -> cause

> has been around for a long time but it's much worse after commit
> 227bf4500aaa ("ice: move VSI delete outside deconfig") because
> the reset runs faster. ice_reset_vf() using vf->cfg_lock and when
> we move this lock before accessing to the VF VSI, we can fix
> BUG for all cases.
>=20
> Panic occurs sometimes in ice_vsi_is_rx_queue_active() and sometimes
> in ice_vsi_stop_all_rx_rings()
>=20
> With our reproducer, we can hint BUG:
> ~8h before commit 227bf4500aaa ("ice: move VSI delete outside deconfig").
> ~20m after commit 227bf4500aaa ("ice: move VSI delete outside deconfig").
> After this fix we are not able to reproduce it after ~48h
>=20
> There was commit cf90b74341ee ("ice: Fix call trace with null VSI during
> VF reset") which also tried to fix this issue, but it was only
> partially resolved and the bug still exists.
>=20
> [ 6420.658415] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [ 6420.665382] #PF: supervisor read access in kernel mode
> [ 6420.670521] #PF: error_code(0x0000) - not-present page
> [ 6420.675659] PGD 0
> [ 6420.677679] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 6420.682038] CPU: 53 PID: 326472 Comm: kworker/53:0 Kdump: loaded Not t=
ainted 5.14.0-317.el9.x86_64 #1
> [ 6420.691250] Hardware name: Dell Inc. PowerEdge R750/04V528, BIOS 1.6.5=
 04/15/2022
> [ 6420.698729] Workqueue: ice ice_service_task [ice]
> [ 6420.703462] RIP: 0010:ice_vsi_is_rx_queue_active+0x2d/0x60 [ice]
> [ 6420.705860] ice 0000:ca:00.0: VF 0 is now untrusted
> [ 6420.709494] Code: 00 00 66 83 bf 76 04 00 00 00 48 8b 77 10 74 3e 31 c=
0 eb 0f 0f b7 97 76 04 00 00 48 83 c0 01 39 c2 7e 2b 48 8b 97 68 04 00 00 <=
0f> b7 0c 42 48 8b 96 20 13 00 00 48 8d 94 8a 00 00 12 00 8b 12 83
> [ 6420.714426] ice 0000:ca:00.0 ens7f0: Setting MAC 22:22:22:22:22:00 on =
VF 0. VF driver will be reinitialized
> [ 6420.733120] RSP: 0018:ff778d2ff383fdd8 EFLAGS: 00010246
> [ 6420.733123] RAX: 0000000000000000 RBX: ff2acf1916294000 RCX: 000000000=
0000000
> [ 6420.733125] RDX: 0000000000000000 RSI: ff2acf1f2c6401a0 RDI: ff2acf1a2=
7301828
> [ 6420.762346] RBP: ff2acf1a27301828 R08: 0000000000000010 R09: 000000000=
0001000
> [ 6420.769476] R10: ff2acf1916286000 R11: 00000000019eba3f R12: ff2acf190=
66460d0
> [ 6420.776611] R13: ff2acf1f2c6401a0 R14: ff2acf1f2c6401a0 R15: 00000000f=
fffffff
> [ 6420.783742] FS:  0000000000000000(0000) GS:ff2acf28ffa80000(0000) knlG=
S:0000000000000000
> [ 6420.791829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6420.797575] CR2: 0000000000000000 CR3: 00000016ad410003 CR4: 000000000=
0773ee0
> [ 6420.804708] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 6420.811034] vfio-pci 0000:ca:01.0: enabling device (0000 -> 0002)
> [ 6420.811840] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 6420.811841] PKRU: 55555554
> [ 6420.811842] Call Trace:
> [ 6420.811843]  <TASK>
> [ 6420.811844]  ice_reset_vf+0x9a/0x450 [ice]
> [ 6420.811876]  ice_process_vflr_event+0x8f/0xc0 [ice]
> [ 6420.841343]  ice_service_task+0x23b/0x600 [ice]
> [ 6420.845884]  ? __schedule+0x212/0x550
> [ 6420.849550]  process_one_work+0x1e2/0x3b0
> [ 6420.853563]  ? rescuer_thread+0x390/0x390
> [ 6420.857577]  worker_thread+0x50/0x3a0
> [ 6420.861242]  ? rescuer_thread+0x390/0x390
> [ 6420.865253]  kthread+0xdd/0x100
> [ 6420.868400]  ? kthread_complete_and_exit+0x20/0x20
> [ 6420.873194]  ret_from_fork+0x1f/0x30
> [ 6420.876774]  </TASK>
> [ 6420.878967] Modules linked in: vfio_pci vfio_pci_core vfio_iommu_type1=
 vfio iavf vhost_net vhost vhost_iotlb tap tun xt_CHECKSUM xt_MASQUERADE xt=
_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_con=
ntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables bridge stp llc s=
ctp ip6_udp_tunnel udp_tunnel nfp tls nfnetlink bluetooth mlx4_en mlx4_core=
 rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache net=
fs rfkill sunrpc intel_rapl_msr intel_rapl_common i10nm_edac nfit libnvdimm=
 ipmi_ssif x86_pkg_temp_thermal intel_powerclamp coretemp irdma kvm_intel i=
40e kvm iTCO_wdt dcdbas ib_uverbs irqbypass iTCO_vendor_support mgag200 mei=
_me ib_core dell_smbios isst_if_mmio isst_if_mbox_pci rapl i2c_algo_bit drm=
_shmem_helper intel_cstate drm_kms_helper syscopyarea sysfillrect isst_if_c=
ommon sysimgblt intel_uncore fb_sys_fops dell_wmi_descriptor wmi_bmof intel=
_vsec mei i2c_i801 acpi_ipmi ipmi_si i2c_smbus ipmi_devintf intel_pch_therm=
al acpi_power_meter pcspkr
>=20
> Fixes: efe41860008e ("ice: Fix memory corruption in VF driver")
> Fixes: f23df5220d2b ("ice: Fix spurious interrupt during removal of trust=
ed VF")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

