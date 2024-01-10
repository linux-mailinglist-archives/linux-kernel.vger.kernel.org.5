Return-Path: <linux-kernel+bounces-22022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC782980C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C431F25952
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0D41231;
	Wed, 10 Jan 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TPKcTdCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C77405C3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20765C433F1;
	Wed, 10 Jan 2024 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704884013;
	bh=/gtYX8mXBGgfAkKkC9Bg9SFkM4OtGu+xiXM4tOha8R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPKcTdCdHN41Io1cHaOKZLmHCHgvFHEoizHeLT4DB0pI1suksWRDcqwHA5hvyBnfI
	 XTkZUwBsJu/6w6Im3bb4jzK7vj0b0w0iWx35MD7Qit3Mbqoq+bn9MXxzOgG9Q4KS7y
	 dLWI0Chei44HRbbp8wTs9VOHtEz+A1df3Wrhs8WY=
Date: Wed, 10 Jan 2024 11:53:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kovalev@altlinux.org
Cc: bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
	arnd@arndb.de, linux-kernel@vger.kernel.org, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org
Subject: Re: [PATCH 0/1] misc/vmw_vmci: fix filling of the msg and
 msg_payload in dg_info struct
Message-ID: <2024011055-phrasing-activity-0ea9@gregkh>
References: <20240110104042.31865-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240110104042.31865-1-kovalev@altlinux.org>

On Wed, Jan 10, 2024 at 01:40:41PM +0300, kovalev@altlinux.org wrote:
> Warning detected by tracking mechanisms __fortify_memcpy_chk, added 2021-=
04-20.
> The proposed patch (PATCH 1/1) introduces changes to meet the new require=
ments.
>=20
> The reproducer (repro.c) was generated using the syzkaller program and mi=
nimized
> (Thanks Alexander Ofitserov <oficerovas@altlinux.org>):
>=20
> #define _GNU_SOURCE
>=20
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>=20
> uint64_t r[1] =3D {0xffffffffffffffff};
>=20
> int main(void)
> {
>         syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0u=
l);
>         memset((void *)0x20000000ul, 0x0, 0x1000000ul);
>=20
>         intptr_t res =3D 0;
>         res =3D syscall(__NR_socket, 0x28ul, 2ul, 0);
>         if (res !=3D -1)
>                 r[0] =3D res;
>         *(uint16_t*)0x20000000 =3D 0x28;
>         *(uint16_t*)0x20000002 =3D 0;
>         *(uint32_t*)0x20000004 =3D 1;
>         *(uint32_t*)0x20000008 =3D 2;
>         *(uint32_t*)0x2000000c =3D 0;
>         syscall(__NR_connect, r[0], 0x20000000ul, 0x10ul);
>=20
>         // struct msghdr*
>         // 0x20000440ul - 0x20000447ul - msg_name
>         // 0x20000448ul - 0x20000449ul - msg_len
>         // 0x20000450ul - ptr to msg_iov
>         // 0x20000458ul - msg_iovlen
>         *(uint64_t*)0x20000450 =3D 0x20000400;
>         *(uint8_t*)0x20000448 =3D 0xFF;
>         *(uint64_t*)0x20000458 =3D 1;
>         *(uint64_t*)0x20000460 =3D 0x20010000;
>         *(uint64_t*)0x20000468 =3D 0;
>=20
>         // 0x20000400 - ptr to iov_base
>         // 0x20000408 - iov_len
>         *(uint64_t*)0x20000400 =3D 0x20000900;
>         strcpy((char *)0x20000900, "AAAAAA");
>         *(uint64_t*)0x20000408 =3D 0x10000;
>=20
>         syscall(__NR_sendmsg, r[0], 0x20000440ul, 0ul);
>         return 0;
> }
>=20
> $ gcc repro.c -o repro
> $ ./repro
>=20
> # dmesg (linux kernel 6.6.6):
> -----
> [   38.036309] Guest personality initialized and is inactive
> [   38.036380] VMCI host device registered (name=3Dvmci, major=3D10, mino=
r=3D122)
> [   38.036381] Initialized host personality
> [   38.037987] NET: Registered PF_VSOCK protocol family
> [   38.073027] ------------[ cut here ]------------
> [   38.073034] memcpy: detected field-spanning write (size 65560) of sing=
le field "&dg_info->msg" at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size=
 24)
> [   38.073103] WARNING: CPU: 9 PID: 3976 at drivers/misc/vmw_vmci/vmci_da=
tagram.c:237 vmci_datagram_dispatch+0x378/0x3c0 [vmw_vmci]
> [   38.073135] Modules linked in: vsock_loopback vmw_vsock_virtio_transpo=
rt_common vmw_vsock_vmci_transport vsock vmw_vmci ccm rfcomm cmac algif_has=
h algif_skcipher af_alg af_packet qrtr bnep uvcvideo btusb uvc btrtl videob=
uf2_vmalloc videobuf2_memops btintel videobuf2_v4l2 btbcm btmtk usbhid vide=
odev bluetooth videobuf2_common mc ecdh_generic joydev snd_sof_pci_intel_tg=
l snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation cor=
etemp snd_sof_intel_hda_mlink intel_uncore_frequency soundwire_cadence inte=
l_uncore_frequency_common intel_tcc_cooling snd_sof_intel_hda snd_sof_pci x=
86_pkg_temp_thermal snd_sof_xtensa_dsp intel_powerclamp snd_sof snd_sof_uti=
ls snd_soc_hdac_hda kvm_intel snd_hda_ext_core snd_soc_acpi_intel_match snd=
_soc_acpi snd_hda_codec_hdmi soundwire_bus snd_soc_core kvm hid_multitouch =
nls_utf8 snd_hda_codec_realtek hid_generic snd_compress nls_cp866 ac97_bus =
iwlmvm spi_pxa2xx_platform 8250_dw iTCO_wdt snd_pcm_dmaengine irqbypass dw_=
dmac snd_hda_codec_generic vfat rtsx_pci_sdmmc intel_pmc_bxt
> [   38.073247]  crct10dif_pclmul fat ledtrig_audio snd_hda_intel crc32_pc=
lmul mei_hdcp iTCO_vendor_support mmc_core intel_rapl_msr crc32c_intel snd_=
intel_dspcfg mac80211 ghash_clmulni_intel snd_intel_sdw_acpi sha512_ssse3 s=
ha256_ssse3 snd_hda_codec sha1_ssse3 aesni_intel processor_thermal_device_p=
ci processor_thermal_device snd_hda_core crypto_simd processor_thermal_rfim=
 intel_lpss_pci i2c_hid_acpi ucsi_acpi cryptd libarc4 iwlwifi pcspkr xhci_p=
ci processor_thermal_mbox intel_lpss ideapad_laptop i2c_hid xhci_pci_renesa=
s i2c_i801 mei_me typec_ucsi snd_hwdep idma64 processor_thermal_rapl typec =
sparse_keymap wmi_bmof tiny_power_button cfg80211 snd_pcm i2c_smbus platfor=
m_profile rtsx_pci xhci_hcd mei virt_dma intel_rapl_common thermal hid role=
s fan button int3403_thermal battery rfkill int340x_thermal_zone int3400_th=
ermal acpi_thermal_rel intel_pmc_core pinctrl_tigerlake acpi_pad ac sch_fq_=
codel vboxvideo drm_vram_helper drm_ttm_helper vboxsf vboxguest snd_seq_mid=
i snd_seq_midi_event snd_seq snd_rawmidi snd_seq_device
> [   38.073342]  snd_timer snd soundcore msr fuse dm_mod efi_pstore efivar=
fs ip_tables x_tables autofs4 i915 hwmon i2c_algo_bit drm_buddy ttm evdev d=
rm_display_helper input_leds serio_raw cec rc_core intel_gtt video wmi
> [   38.073375] CPU: 9 PID: 3976 Comm: eee.out Not tainted 6.6.6-un-def-al=
t1 #1
> [   38.073381] Hardware name: LENOVO 82X8/LNVNB161216, BIOS LTCN30WW 11/0=
8/2023
> [   38.073384] RIP: 0010:vmci_datagram_dispatch+0x378/0x3c0 [vmw_vmci]
> [   38.073405] Code: 38 fd ff ff 80 3d 5c 96 00 00 00 75 87 48 c7 c2 58 0=
b 6b c1 4c 89 ee 48 c7 c7 a0 0b 6b c1 c6 05 42 96 00 00 01 e8 18 c0 a1 c5 <=
0f> 0b e9 63 ff ff ff e8 1c 5e 65 c6 83 cd ff e9 fe fc ff ff f0 ff
> [   38.073410] RSP: 0018:ffffc9000279fb58 EFLAGS: 00010246
> [   38.073415] RAX: 0000000000000000 RBX: ffff88811a9c0000 RCX: 000000000=
0000000
> [   38.073418] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [   38.073421] RBP: ffff888165540000 R08: 0000000000000000 R09: 000000000=
0000000
> [   38.073423] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88816=
5540030
> [   38.073425] R13: 0000000000010018 R14: ffff8881090a2a00 R15: ffff88811=
a9c0018
> [   38.073428] FS:  00007f3a36bec580(0000) GS:ffff8882a7a40000(0000) knlG=
S:0000000000000000
> [   38.073432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   38.073435] CR2: 000055b6120cf008 CR3: 000000010db62000 CR4: 000000000=
0750ee0
> [   38.073438] PKRU: 55555554
> [   38.073440] Call Trace:
> [   38.073446]  <TASK>
> [   38.073448]  ? vmci_datagram_dispatch+0x378/0x3c0 [vmw_vmci]
> [   38.073467]  ? __warn+0x7d/0x130
> [   38.073482]  ? vmci_datagram_dispatch+0x378/0x3c0 [vmw_vmci]
> [   38.073503]  ? report_bug+0x17e/0x1b0
> [   38.073514]  ? handle_bug+0x60/0xb0
> [   38.073523]  ? exc_invalid_op+0x13/0x70
> [   38.073531]  ? asm_exc_invalid_op+0x16/0x20
> [   38.073540]  ? vmci_datagram_dispatch+0x378/0x3c0 [vmw_vmci]
> [   38.073559]  ? vmci_datagram_dispatch+0x378/0x3c0 [vmw_vmci]
> [   38.073577]  vmci_transport_dgram_enqueue+0xb5/0x150 [vmw_vsock_vmci_t=
ransport]
> [   38.073596]  vsock_dgram_sendmsg+0xcf/0x180 [vsock]
> [   38.073618]  ____sys_sendmsg+0x376/0x3b0
> [   38.073629]  ? copy_msghdr_from_user+0x6d/0xb0
> [   38.073635]  ___sys_sendmsg+0x86/0xe0
> [   38.073642]  ? filemap_map_pages+0x423/0x570
> [   38.073653]  ? vmci_resource_add+0xde/0x170 [vmw_vmci]
> [   38.073674]  ? __pfx_vmci_transport_recv_dgram_cb+0x10/0x10 [vmw_vsock=
_vmci_transport]
> [   38.073689]  ? do_fault+0x296/0x470
> [   38.073697]  __sys_sendmsg+0x57/0xb0
> [   38.073704]  do_syscall_64+0x59/0x90
> [   38.073711]  ? count_memcg_events.constprop.0+0x3a/0x70
> [   38.073717]  ? handle_mm_fault+0x9e/0x300
> [   38.073724]  ? do_user_addr_fault+0x33d/0x680
> [   38.073733]  ? sched_clock+0xc/0x30
> [   38.073740]  ? get_vtime_delta+0xf/0xc0
> [   38.073750]  ? ct_kernel_exit.isra.0+0x71/0x90
> [   38.073759]  ? __ct_user_enter+0x5a/0xd0
> [   38.073765]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   38.073771] RIP: 0033:0x7f3a36b0cd49
> [   38.073776] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 70 0d 00 f7 d8 64 89 01 48
> [   38.073780] RSP: 002b:00007ffea38c4a08 EFLAGS: 00000217 ORIG_RAX: 0000=
00000000002e
> [   38.073784] RAX: ffffffffffffffda RBX: 000055b6120ce2d0 RCX: 00007f3a3=
6b0cd49
> [   38.073787] RDX: 0000000000000000 RSI: 0000000020000440 RDI: 000000000=
0000003
> [   38.073790] RBP: 00007ffea38c4a20 R08: 00007ffea38c4b10 R09: 00007ffea=
38c4b10
> [   38.073792] R10: 00007ffea38c4b10 R11: 0000000000000217 R12: 000055b61=
20ce060
> [   38.073795] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [   38.073799]  </TASK>
> [   38.073801] ---[ end trace 0000000000000000 ]---
> -----
>=20
> To assess the performance losses when using a new patch, the kernel was b=
uilded with the
> patch below and the reproducer was launched several times:
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmc=
i/vmci_datagram.c
> index 6d42f3b99c6f46..b078364d5c9b23 100644
> --- a/drivers/misc/vmw_vmci/vmci_datagram.c
> +++ b/drivers/misc/vmw_vmci/vmci_datagram.c
> @@ -234,6 +234,17 @@ static int dg_dispatch_as_host(u32 context_id, struc=
t vmci_datagram *dg)
> =20
>                         dg_info->in_dg_host_queue =3D true;
>                         dg_info->entry =3D dst_entry;
> +                       u32 i;
> +                       printk("memcpy: init i=3D%d\n",i);
> +                       for(i=3D0; i<1000000000;i++){
> +                               memcpy(&dg_info->msg, dg, 24);
> +                       }
> +                       printk("memcpy: old i=3D%d\n",i);
> +                       for(i=3D0; i<1000000000;i++){
> +                               memcpy(&dg_info->msg, dg, 12);
> +                               memcpy(dg_info->msg_payload, VMCI_DG_PAYL=
OAD(dg), 12);
> +                       }
> +                       printk("memcpy: new i=3D%d\n",i);
>                         memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
>                         if (dg->payload_size) {
>                                 memcpy(dg_info->msg_payload, VMCI_DG_PAYL=
OAD(dg), dg->payload_size);
>=20
> =3D=3D=3D=3D=3D=3D=3D
> Reproducing
> =3D=3D=3D=3D=3D=3D=3D
> # dmesg -w
> ----
> [  181.415379] Guest personality initialized and is inactive
> [  181.415659] VMCI host device registered (name=3Dvmci, major=3D10, mino=
r=3D122)
> [  181.415665] Initialized host personality
> [  181.422766] NET: Registered PF_VSOCK protocol family
> [  181.468022] memcpy: init i=3D0
> [  183.020694] memcpy: old i=3D1000000000
> [  184.572458] memcpy: new i=3D1000000000
> [  196.009873] memcpy: init i=3D0
> [  197.562651] memcpy: old i=3D1000000000
> [  199.118132] memcpy: new i=3D1000000000
> [  206.543691] memcpy: init i=3D0
> [  208.781697] memcpy: old i=3D1000000000
> [  211.020229] memcpy: new i=3D1000000000
> ----
>=20
> $ node=20
> Welcome to Node.js v16.19.1.
> Type ".help" for more information.
> > 183.020694 - 181.468022 //old
> 1.5526720000000012
> > 184.572458 - 183.020694 // new
> 1.55176400000002
> >
> > 197.562651 - 196.009873 // old
> 1.5527779999999893
> > 199.118132 - 197.562651 // new
> 1.5554810000000145
> >
> > 208.781697 - 206.543691 // old
> 2.238006000000013=20
> > 211.020229 - 208.781697 // new
> 2.238531999999992
> >
>=20
> Based on a rather primitive performance assessment, the results do not di=
ffer
> much, and given the loss of warning output in a one-time function call, t=
he
> difference will be significant.
>=20
> [PATCH 1/1] misc/vmw_vmci: fix filling of the msg and msg_payload in dg_i=
nfo struct
>=20

How is this different from the previously submitted patch series fo this
issue:
	https://lore.kernel.org/r/20240105164001.2129796-1-harshit.m.mogalapalli@o=
racle.com

thanks,

greg k-h

