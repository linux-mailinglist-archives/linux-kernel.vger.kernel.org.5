Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5839D7719EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjHGGDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjHGGDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF6E8;
        Sun,  6 Aug 2023 23:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4063614E9;
        Mon,  7 Aug 2023 06:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75FBC433C7;
        Mon,  7 Aug 2023 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691388190;
        bh=09gq1J3wu5mz6mn/mbDgk+ZY0UDTgJ1jv/VLd+e3cgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AybSpeNdqOce4lOfkYJrgVxRRlUBShWl8dyg7+25SBKUKm5OF0UO88LdwuGow8V6D
         eV9EAFSQYTv2pnF5ga49wibyZXXJ+R3EG2XIrbnVMc8pl5hPfeGqk52JPe4RYsyFHT
         I+5R37aNnFq3wZhcCSxDYTYVtqwIADvUIu1PD/K8=
Date:   Mon, 7 Aug 2023 08:03:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Huang Rui <ray.huang@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>
Subject: Re: Fwd: CFI violation when reading amd_pstate/status
Message-ID: <2023080743-amendable-moonlit-15b7@gregkh>
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 06:55:49AM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a bug report on Bugzilla [1]. Quoting from it:
>=20
> > On kernel 6.4.7, with amd_pstate=3Dactive, with a Ryzen 7700X
> > I get a Clang CFI violation when reading /sys/devices/system/cpu/amd_ps=
tate/status
> >=20
> > This is reproduceable with every read, I have only tried with amd_pstat=
e=3Dactive
> >=20
> > With the following CFI and Clang configs, Clang 16.0.6
> > CONFIG_CFI_CLANG=3Dy
> > CONFIG_CFI_PERMISSIVE=3Dy
> > CONFIG_LTO_CLANG=3Dy
> > CONFIG_LTO_CLANG_THIN=3Dy
> >=20
> > Below is the full call trace, let me know if you need a trace with debu=
g info.
> >=20
> > [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show_sta=
tus+0x0/0x70; expected type: 0x8651b1de)
> > [ 4947.849358] WARNING: CPU: 2 PID: 16519 at dev_attr_show+0x24/0x60
> > [ 4947.849360] Modules linked in: binfmt_misc nf_conntrack_netbios_ns n=
f_conntrack_broadcast wireguard curve25519_x86_64 libcurve25519_generic ip6=
_udp_tunnel udp_tunnel snd_seq_dummy snd_hrtimer snd_seq rfcomm joydev uhid=
 xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack=
_tftp nft_fib_inet nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_reject_inet nf_rej=
ect_ipv6 nf_reject_ipv4 nft_reject nft_ct nft_chain_nat bridge 8021q mrp ga=
rp stp llc nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangl=
e ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_=
ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set nfne=
tlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_=
tables bnep vfat fat amdgpu snd_hda_codec_realtek snd_hda_codec_generic snd=
_hda_codec_hdmi snd_hda_intel mt7921e vfio_pci intel_rapl_msr mt7921_common=
 intel_rapl_common mt76_connac_lib edac_mce_amd vfio_pci_core mt76 vfio_iom=
mu_type1 vfio kvm_amd iommufd iommu_v2 snd_usb_audio
> > [ 4947.849379]  snd_intel_dspcfg gpu_sched snd_intel_sdw_acpi mac80211 =
drm_suballoc_helper snd_usbmidi_lib i2c_algo_bit drm_ttm_helper snd_hda_cod=
ec btusb ttm btrtl libarc4 btmtk snd_hda_core snd_rawmidi kvm snd_seq_devic=
e drm_display_helper btintel snd_hwdep mc btbcm irqbypass cfg80211 cec snd_=
pcm asus_nb_wmi bluetooth eeepc_wmi snd_timer asus_wmi drm_kms_helper ledtr=
ig_audio sparse_keymap snd gpio_amdpt platform_profile gpio_generic drm_bud=
dy rfkill soundcore rapl i2c_piix4 wmi_bmof pcspkr k10temp lm92 nct6775_cor=
e hwmon_vid fuse loop dm_crypt crct10dif_pclmul polyval_clmulni polyval_gen=
eric ghash_clmulni_intel nvme sp5100_tco ccp r8169 nvme_core nvme_common vi=
deo wmi sunrpc
> > [ 4947.849398] CPU: 2 PID: 16519 Comm: cat Tainted: P                  =
 6.4.7-gentoo-dist-hardened #1

Can't do much about this kernel, we don't know what's really in it,
sorry.

greg k-h
