Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B6776704
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHISOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHISOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C13B1736
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691604848;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPP+Fdm0cNTtBrBBcBMXznMsFi1kjHj1ezLmuwph1b0=;
        b=CJTVcmYaJ3oTSEN+FuzYvOsqeOpU4xcBiz53E3LexjUEUpawe8CqzPaAzthFOjlPM3b6dI
        9BFWpphoE9Xa7/zyIjs6h8ML+iVa1S+rLXEehs+WvGxIG0DUbBpuEdjC5WQalOh7lNKSt3
        JBEBOVwBfHespHwX7+4g6HSivgBT2rw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-trUs-whBPy2QYkwHnNfSyg-1; Wed, 09 Aug 2023 14:14:06 -0400
X-MC-Unique: trUs-whBPy2QYkwHnNfSyg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe4f953070so132685e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 11:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604845; x=1692209645;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPP+Fdm0cNTtBrBBcBMXznMsFi1kjHj1ezLmuwph1b0=;
        b=Ub/RG6oHGeUll6dP/ShFXGV3IXmzpgrjceUT1cxYjiV3teO56+av89lYIcXr1R9hK4
         vER+/JqXs03B8AjiJA68tcJ7wxYNYx5l+Z/uNPm/LIcrUKwjRvDexqrKos66VBi+B1Iu
         8/lT5oagPHZQTbO8I1zFyffA26yMSdAED1HKzbTvv4x0+/YWzLxycERUYAqjv9k4U4aJ
         WgUyzVwJFbX1DG4KJPwMuXw77seai8EYqiAOGPsFi0REUl8p8zETmPHM69QOk0jZcT1Y
         P44TN772m9e3OtM8C8jaXZ4Pe0dSQqM2UEW9FdFFxldRJ6H8opALb+DFxbj2y7Mr54GS
         4XyA==
X-Gm-Message-State: AOJu0YwDmG5J8gvTTAEZgSyFk9ww0w43MSe9Jm1e/BwEEAKFYYn/x4jr
        2Bq1jy5wvQYfMbp1UkK9Z3trhtBQ6V8dPVnE99rBLUG5Mtf9FBGC9hIW5zhC1/K4QzIfe89DKE+
        31nPXYk/3kR1oGjVDvV5Ltu61
X-Received: by 2002:a05:600c:21c2:b0:3fb:d1c1:9b79 with SMTP id x2-20020a05600c21c200b003fbd1c19b79mr2588447wmj.30.1691604845148;
        Wed, 09 Aug 2023 11:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZe0bFIzNVq4ZBjzjVIXsuERyGYkUF+ykuIUX6S/WcMzpxR3XehE6+gMx66vCh95cB+a1Rig==
X-Received: by 2002:a05:600c:21c2:b0:3fb:d1c1:9b79 with SMTP id x2-20020a05600c21c200b003fbd1c19b79mr2588433wmj.30.1691604844784;
        Wed, 09 Aug 2023 11:14:04 -0700 (PDT)
Received: from [192.168.2.56] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c290900b003fe539b83f2sm2637931wmd.42.2023.08.09.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:14:04 -0700 (PDT)
Message-ID: <8028675970aba3f0e412a6a154b907729dda0684.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net 2/2] ice: Fix NULL pointer deref
 during VF reset
From:   Petr Oros <poros@redhat.com>
Reply-To: poros@redhat.com
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org
Cc:     slawomirx.laba@intel.com, przemyslawx.patynowski@intel.com,
        kamil.maziarz@intel.com, jesse.brandeburg@intel.com,
        norbertx.zulinski@intel.com, dawidx.wesierski@intel.com,
        edumazet@google.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Aug 2023 20:14:03 +0200
In-Reply-To: <7cf9f840-f47c-bc79-6c14-9f1997a21c5a@intel.com>
References: <20230807094831.696626-1-poros@redhat.com>
         <20230807094831.696626-3-poros@redhat.com>
         <7cf9f840-f47c-bc79-6c14-9f1997a21c5a@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Przemek Kitszel p=C3=AD=C5=A1e v =C4=8Ct 01. 01. 1970 v 00:00 +0000:
> On 8/7/23 11:48, Petr Oros wrote:
> > During stress test with attaching and detaching VF from KVM and
> > simultaneously changing VFs spoofcheck and trust there was a
> > NULL pointer dereference in ice_reset_vf that VF's VSI is null.
> >=20
> > More than one instance of ice_reset_vf() can be running at a given
> > time. When we rebuild the VSI in ice_reset_vf, another reset can be
> > triaged from ice_service_task. In this case we can access the
> > currently
> > uninitialized VSI and couse panic. The window for this racing
> > condition
> > has been around for a long time but it's much worse after commit
> > 227bf4500aaa ("ice: move VSI delete outside deconfig") because
> > the reset runs faster. ice_reset_vf() using vf->cfg_lock and when
> > we move this lock before accessing to the VF VSI, we can fix
> > BUG for all cases.
> >=20
> > Panic occurs sometimes in ice_vsi_is_rx_queue_active() and
> > sometimes
> > in ice_vsi_stop_all_rx_rings()
> >=20
> > With our reproducer, we can hint BUG:
>=20
> s/hint/hit/
>=20
> > ~8h before commit 227bf4500aaa ("ice: move VSI delete outside
> > deconfig").
> > ~20m after commit 227bf4500aaa ("ice: move VSI delete outside
> > deconfig").
> > After this fix we are not able to reproduce it after ~48h
> >=20
> > There was commit cf90b74341ee ("ice: Fix call trace with null VSI
> > during
> > VF reset") which also tried to fix this issue, but it was only
> > partially resolved and the bug still exists.
> >=20
> > [ 6420.658415] BUG: kernel NULL pointer dereference, address:
> > 0000000000000000
> > [ 6420.665382] #PF: supervisor read access in kernel mode
> > [ 6420.670521] #PF: error_code(0x0000) - not-present page
> > [ 6420.675659] PGD 0
> > [ 6420.677679] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [ 6420.682038] CPU: 53 PID: 326472 Comm: kworker/53:0 Kdump: loaded
> > Not tainted 5.14.0-317.el9.x86_64 #1
> > [ 6420.691250] Hardware name: Dell Inc. PowerEdge R750/04V528, BIOS
> > 1.6.5 04/15/2022
> > [ 6420.698729] Workqueue: ice ice_service_task [ice]
> > [ 6420.703462] RIP: 0010:ice_vsi_is_rx_queue_active+0x2d/0x60 [ice]
> > [ 6420.705860] ice 0000:ca:00.0: VF 0 is now untrusted
> > [ 6420.709494] Code: 00 00 66 83 bf 76 04 00 00 00 48 8b 77 10 74
> > 3e 31 c0 eb 0f 0f b7 97 76 04 00 00 48 83 c0 01 39 c2 7e 2b 48 8b
> > 97 68 04 00 00 <0f> b7 0c 42 48 8b 96 20 13 00 00 48 8d 94 8a 00 00
> > 12 00 8b 12 83
> > [ 6420.714426] ice 0000:ca:00.0 ens7f0: Setting MAC
> > 22:22:22:22:22:00 on VF 0. VF driver will be reinitialized
> > [ 6420.733120] RSP: 0018:ff778d2ff383fdd8 EFLAGS: 00010246
> > [ 6420.733123] RAX: 0000000000000000 RBX: ff2acf1916294000 RCX:
> > 0000000000000000
> > [ 6420.733125] RDX: 0000000000000000 RSI: ff2acf1f2c6401a0 RDI:
> > ff2acf1a27301828
> > [ 6420.762346] RBP: ff2acf1a27301828 R08: 0000000000000010 R09:
> > 0000000000001000
> > [ 6420.769476] R10: ff2acf1916286000 R11: 00000000019eba3f R12:
> > ff2acf19066460d0
> > [ 6420.776611] R13: ff2acf1f2c6401a0 R14: ff2acf1f2c6401a0 R15:
> > 00000000ffffffff
> > [ 6420.783742] FS:=C2=A0 0000000000000000(0000)
> > GS:ff2acf28ffa80000(0000) knlGS:0000000000000000
> > [ 6420.791829] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 6420.797575] CR2: 0000000000000000 CR3: 00000016ad410003 CR4:
> > 0000000000773ee0
> > [ 6420.804708] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [ 6420.811034] vfio-pci 0000:ca:01.0: enabling device (0000 ->
> > 0002)
> > [ 6420.811840] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [ 6420.811841] PKRU: 55555554
> > [ 6420.811842] Call Trace:
> > [ 6420.811843]=C2=A0 <TASK>
> > [ 6420.811844]=C2=A0 ice_reset_vf+0x9a/0x450 [ice]
> > [ 6420.811876]=C2=A0 ice_process_vflr_event+0x8f/0xc0 [ice]
> > [ 6420.841343]=C2=A0 ice_service_task+0x23b/0x600 [ice]
> > [ 6420.845884]=C2=A0 ? __schedule+0x212/0x550
> > [ 6420.849550]=C2=A0 process_one_work+0x1e2/0x3b0
> > [ 6420.853563]=C2=A0 ? rescuer_thread+0x390/0x390
> > [ 6420.857577]=C2=A0 worker_thread+0x50/0x3a0
> > [ 6420.861242]=C2=A0 ? rescuer_thread+0x390/0x390
> > [ 6420.865253]=C2=A0 kthread+0xdd/0x100
> > [ 6420.868400]=C2=A0 ? kthread_complete_and_exit+0x20/0x20
> > [ 6420.873194]=C2=A0 ret_from_fork+0x1f/0x30
> > [ 6420.876774]=C2=A0 </TASK>
> > [ 6420.878967] Modules linked in: vfio_pci vfio_pci_core
> > vfio_iommu_type1 vfio iavf vhost_net vhost vhost_iotlb tap tun
> > xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4
> > nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
> > nf_defrag_ipv4 nft_counter nf_tables bridge stp llc sctp
> > ip6_udp_tunnel udp_tunnel nfp tls nfnetlink bluetooth mlx4_en
> > mlx4_core rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd
> > grace fscache netfs rfkill sunrpc intel_rapl_msr intel_rapl_common
> > i10nm_edac nfit libnvdimm ipmi_ssif x86_pkg_temp_thermal
> > intel_powerclamp coretemp irdma kvm_intel i40e kvm iTCO_wdt dcdbas
> > ib_uverbs irqbypass iTCO_vendor_support mgag200 mei_me ib_core
> > dell_smbios isst_if_mmio isst_if_mbox_pci rapl i2c_algo_bit
> > drm_shmem_helper intel_cstate drm_kms_helper syscopyarea
> > sysfillrect isst_if_common sysimgblt intel_uncore fb_sys_fops
> > dell_wmi_descriptor wmi_bmof intel_vsec mei i2c_i801 acpi_ipmi
> > ipmi_si i2c_smbus ipmi_devintf intel_pch_thermal acpi_power_meter
> > pcspk
> > =C2=A0 r
> >=20
> > Fixes: efe41860008e ("ice: Fix memory corruption in VF driver")
> > Fixes: f23df5220d2b ("ice: Fix spurious interrupt during removal of
> > trusted VF")
> > Signed-off-by: Petr Oros <poros@redhat.com>
>=20
> Thank you for all of your testing efforts, detailed explanation,
> and the fix!
>=20
> Is there anything interesting about your setup/methodology?
> (Asking rather to explore and extend our tests, no doubts here :)

This test is part of our QE test suite. There are a large number of
"cfg stress" tests.
I can't explain all the tests, but this one in particular just created
2 threads.
One attaching/detaching VF from VM and the other sets VF parameters in
a loop (trust, spoof check, mac addr) This causes concurrent access to
resources during reset. ice/iavf are very sensitive to this type of
stress ;)=20

We also using LNST, but it currently catches other types of bugs.

>=20
> > ---
> > =C2=A0 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 15 ++++++++-------
> > =C2=A0 1 file changed, 8 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > index 294e91c3453ccd..ea3310be8354cf 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > @@ -612,11 +612,17 @@ int ice_reset_vf(struct ice_vf *vf, u32
> > flags)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & ICE_VF_RESET_LOC=
K)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mutex_lock(&vf->cfg_lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0lockdep_assert_held(&vf->cfg_lock);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ice_is_vf_disabled(=
vf)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0vsi =3D ice_get_vf_vsi(vf);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!vsi) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev_dbg(dev, "VF is already removed\n");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =
=3D -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto o=
ut_unlock;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, vf-
> > >vf_id);
> > =C2=A0=20
> > @@ -625,14 +631,9 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(dev, "VF is already disabled, there is n=
o
> > need for resetting it, telling VM, all is fine %d\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
vf->vf_id);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out_unlock;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & ICE_VF_RESET_LOC=
K)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mutex_lock(&vf->cfg_lock);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0lockdep_assert_held(&vf->cfg_lock);
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Set VF disable bit s=
tate here, before triggering reset
> > */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_bit(ICE_VF_STATE_DI=
S, vf->vf_states);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ice_trigger_vf_reset(vf=
, flags & ICE_VF_RESET_VFLR, false);
>=20

