Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A045771D67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjHGJt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHGJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951F10CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691401723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6FLaF/tuMkmWKXbbq159vzqpGYVrDE6F2OX13lKGxo=;
        b=bS+3fhkLCsmV5VMinkvfqL5BBV5n00T536DOD6BqQhESesWwvL40pMOu+vS22UDa+zSTjd
        q+C3xJ3Sc8DTyG7/S1dCXf8tdmOd480ZhUa2ipRCRt2Oywol+B49sMkDdch8g9l6wguNQp
        GxoR6z6hlmVQDFi0z++UGs2M1vwPdLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-1ItAMbWeOo2IYJ1EjEEd2Q-1; Mon, 07 Aug 2023 05:48:39 -0400
X-MC-Unique: 1ItAMbWeOo2IYJ1EjEEd2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA43823D61;
        Mon,  7 Aug 2023 09:48:39 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.226.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0988E1121314;
        Mon,  7 Aug 2023 09:48:36 +0000 (UTC)
From:   Petr Oros <poros@redhat.com>
To:     netdev@vger.kernel.org
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Jacob.e.keller@intel.com,
        przemyslawx.patynowski@intel.com, kamil.maziarz@intel.com,
        dawidx.wesierski@intel.com, mateusz.palczewski@intel.com,
        slawomirx.laba@intel.com, norbertx.zulinski@intel.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] ice: Fix NULL pointer deref during VF reset
Date:   Mon,  7 Aug 2023 11:48:31 +0200
Message-ID: <20230807094831.696626-3-poros@redhat.com>
In-Reply-To: <20230807094831.696626-1-poros@redhat.com>
References: <20230807094831.696626-1-poros@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During stress test with attaching and detaching VF from KVM and
simultaneously changing VFs spoofcheck and trust there was a
NULL pointer dereference in ice_reset_vf that VF's VSI is null.

More than one instance of ice_reset_vf() can be running at a given
time. When we rebuild the VSI in ice_reset_vf, another reset can be
triaged from ice_service_task. In this case we can access the currently
uninitialized VSI and couse panic. The window for this racing condition
has been around for a long time but it's much worse after commit
227bf4500aaa ("ice: move VSI delete outside deconfig") because
the reset runs faster. ice_reset_vf() using vf->cfg_lock and when
we move this lock before accessing to the VF VSI, we can fix
BUG for all cases.

Panic occurs sometimes in ice_vsi_is_rx_queue_active() and sometimes
in ice_vsi_stop_all_rx_rings()

With our reproducer, we can hint BUG:
~8h before commit 227bf4500aaa ("ice: move VSI delete outside deconfig").
~20m after commit 227bf4500aaa ("ice: move VSI delete outside deconfig").
After this fix we are not able to reproduce it after ~48h

There was commit cf90b74341ee ("ice: Fix call trace with null VSI during
VF reset") which also tried to fix this issue, but it was only
partially resolved and the bug still exists.

[ 6420.658415] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[ 6420.665382] #PF: supervisor read access in kernel mode
[ 6420.670521] #PF: error_code(0x0000) - not-present page
[ 6420.675659] PGD 0
[ 6420.677679] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 6420.682038] CPU: 53 PID: 326472 Comm: kworker/53:0 Kdump: loaded Not tai=
nted 5.14.0-317.el9.x86_64 #1
[ 6420.691250] Hardware name: Dell Inc. PowerEdge R750/04V528, BIOS 1.6.5 0=
4/15/2022
[ 6420.698729] Workqueue: ice ice_service_task [ice]
[ 6420.703462] RIP: 0010:ice_vsi_is_rx_queue_active+0x2d/0x60 [ice]
[ 6420.705860] ice 0000:ca:00.0: VF 0 is now untrusted
[ 6420.709494] Code: 00 00 66 83 bf 76 04 00 00 00 48 8b 77 10 74 3e 31 c0 =
eb 0f 0f b7 97 76 04 00 00 48 83 c0 01 39 c2 7e 2b 48 8b 97 68 04 00 00 <0f=
> b7 0c 42 48 8b 96 20 13 00 00 48 8d 94 8a 00 00 12 00 8b 12 83
[ 6420.714426] ice 0000:ca:00.0 ens7f0: Setting MAC 22:22:22:22:22:00 on VF=
 0. VF driver will be reinitialized
[ 6420.733120] RSP: 0018:ff778d2ff383fdd8 EFLAGS: 00010246
[ 6420.733123] RAX: 0000000000000000 RBX: ff2acf1916294000 RCX: 00000000000=
00000
[ 6420.733125] RDX: 0000000000000000 RSI: ff2acf1f2c6401a0 RDI: ff2acf1a273=
01828
[ 6420.762346] RBP: ff2acf1a27301828 R08: 0000000000000010 R09: 00000000000=
01000
[ 6420.769476] R10: ff2acf1916286000 R11: 00000000019eba3f R12: ff2acf19066=
460d0
[ 6420.776611] R13: ff2acf1f2c6401a0 R14: ff2acf1f2c6401a0 R15: 00000000fff=
fffff
[ 6420.783742] FS:  0000000000000000(0000) GS:ff2acf28ffa80000(0000) knlGS:=
0000000000000000
[ 6420.791829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6420.797575] CR2: 0000000000000000 CR3: 00000016ad410003 CR4: 00000000007=
73ee0
[ 6420.804708] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 6420.811034] vfio-pci 0000:ca:01.0: enabling device (0000 -> 0002)
[ 6420.811840] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 6420.811841] PKRU: 55555554
[ 6420.811842] Call Trace:
[ 6420.811843]  <TASK>
[ 6420.811844]  ice_reset_vf+0x9a/0x450 [ice]
[ 6420.811876]  ice_process_vflr_event+0x8f/0xc0 [ice]
[ 6420.841343]  ice_service_task+0x23b/0x600 [ice]
[ 6420.845884]  ? __schedule+0x212/0x550
[ 6420.849550]  process_one_work+0x1e2/0x3b0
[ 6420.853563]  ? rescuer_thread+0x390/0x390
[ 6420.857577]  worker_thread+0x50/0x3a0
[ 6420.861242]  ? rescuer_thread+0x390/0x390
[ 6420.865253]  kthread+0xdd/0x100
[ 6420.868400]  ? kthread_complete_and_exit+0x20/0x20
[ 6420.873194]  ret_from_fork+0x1f/0x30
[ 6420.876774]  </TASK>
[ 6420.878967] Modules linked in: vfio_pci vfio_pci_core vfio_iommu_type1 v=
fio iavf vhost_net vhost vhost_iotlb tap tun xt_CHECKSUM xt_MASQUERADE xt_c=
onntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables bridge stp llc sct=
p ip6_udp_tunnel udp_tunnel nfp tls nfnetlink bluetooth mlx4_en mlx4_core r=
pcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs=
 rfkill sunrpc intel_rapl_msr intel_rapl_common i10nm_edac nfit libnvdimm i=
pmi_ssif x86_pkg_temp_thermal intel_powerclamp coretemp irdma kvm_intel i40=
e kvm iTCO_wdt dcdbas ib_uverbs irqbypass iTCO_vendor_support mgag200 mei_m=
e ib_core dell_smbios isst_if_mmio isst_if_mbox_pci rapl i2c_algo_bit drm_s=
hmem_helper intel_cstate drm_kms_helper syscopyarea sysfillrect isst_if_com=
mon sysimgblt intel_uncore fb_sys_fops dell_wmi_descriptor wmi_bmof intel_v=
sec mei i2c_i801 acpi_ipmi ipmi_si i2c_smbus ipmi_devintf intel_pch_thermal=
 acpi_power_meter pcspkr

Fixes: efe41860008e ("ice: Fix memory corruption in VF driver")
Fixes: f23df5220d2b ("ice: Fix spurious interrupt during removal of trusted=
 VF")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethe=
rnet/intel/ice/ice_vf_lib.c
index 294e91c3453ccd..ea3310be8354cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -612,11 +612,17 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		return 0;
 	}
=20
+	if (flags & ICE_VF_RESET_LOCK)
+		mutex_lock(&vf->cfg_lock);
+	else
+		lockdep_assert_held(&vf->cfg_lock);
+
 	if (ice_is_vf_disabled(vf)) {
 		vsi =3D ice_get_vf_vsi(vf);
 		if (!vsi) {
 			dev_dbg(dev, "VF is already removed\n");
-			return -EINVAL;
+			err =3D -EINVAL;
+			goto out_unlock;
 		}
 		ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, vf->vf_id);
=20
@@ -625,14 +631,9 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
=20
 		dev_dbg(dev, "VF is already disabled, there is no need for resetting it,=
 telling VM, all is fine %d\n",
 			vf->vf_id);
-		return 0;
+		goto out_unlock;
 	}
=20
-	if (flags & ICE_VF_RESET_LOCK)
-		mutex_lock(&vf->cfg_lock);
-	else
-		lockdep_assert_held(&vf->cfg_lock);
-
 	/* Set VF disable bit state here, before triggering reset */
 	set_bit(ICE_VF_STATE_DIS, vf->vf_states);
 	ice_trigger_vf_reset(vf, flags & ICE_VF_RESET_VFLR, false);
--=20
2.41.0

