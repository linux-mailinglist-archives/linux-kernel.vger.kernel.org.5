Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF0D7F60E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345655AbjKWN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbjKWN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:58:26 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 05:58:31 PST
Received: from mail.incertum.net (kaliadne.incertum.net [65.108.140.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617F1B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:58:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1))
        (No client certificate requested)
        by mail.incertum.net (Postfix) with ESMTPS id B419E6902028
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=incertum.net;
        s=2019; t=1700747595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qbr12/r+GUUvXPG2OVegiasrmw6Mi3PMvZlE4QMCkm4=;
        b=MlEfQCQJqO3pSWYKGenfv1q4s9F6el5OEfKkhgb5sQdmRmWG1uLAgzUT2RleTG8i9LD29k
        GfMMXkD/3vOnKu/hIcXf+Ocw3yets7ShC+Y+ZIH4g38UqgLKtjS4UBbEHE43ZoYv9L7hWh
        uCatI2ZnH8XA7guUy/q1+3YZcxe2oJk=
Received: by pharmakeia.incertum.net (Postfix, from userid 1000)
        id 959B3C3A8F; Thu, 23 Nov 2023 14:53:15 +0100 (CET)
Date:   Thu, 23 Nov 2023 14:53:15 +0100
From:   Stefan =?utf-8?Q?F=C3=B6rster?= <cite@incertum.net>
To:     linux-kernel@vger.kernel.org
Subject: bcache: kernel NULL pointer dereference since 6.1.39
Message-ID: <ZV9ZSyDLNDlzutgQ@pharmakeia.incertum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello world,

starting with kernel 6.1.39, we see the following error message with=20
heavy I/O loads. We needed to revert

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.1.39&id=3D68118c339c6e1e16ae017bef160dbe28a27ae9c8

to make sure the systems don't suddenly get stuck.

1. Kernel 6.6.2-arch1-1 on Dell Latitude:

[16816.214942] BUG: kernel NULL pointer dereference, address: 0000000000000=
080
[16816.214948] #PF: supervisor read access in kernel mode
[16816.214951] #PF: error_code(0x0000) - not-present page
[16816.214953] PGD 0 P4D 0=20
[16816.214956] Oops: 0000 [#1] PREEMPT SMP NOPTI
[16816.214960] CPU: 7 PID: 83416 Comm: bcache_gc Tainted: P           OE   =
   6.6.2-arch1-1 #1 11215f9ba7ddfb51644674a5b2ced71612c62fe9
[16816.214964] Hardware name: Dell Inc. Latitude 5431/06F77M, BIOS 1.17.0 0=
9/21/2023
[16816.214965] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
[16816.214999] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f 44 00 00 <48=
> 8b 83 80 00 00 00 48 8d ab 90 00 00 00 48 39 98 60 c3 00 00 75
[16816.215001] RSP: 0018:ffffc90021777af8 EFLAGS: 00010207
[16816.215004] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff888515c=
e0670
[16816.215006] RDX: 0000000000000000 RSI: ffff888515ce0680 RDI: 00000000000=
00000
[16816.215007] RBP: ffffc90021777bf0 R08: ffff88819476d9e0 R09: 00000000013=
ffde8
[16816.215009] R10: 0000000000000000 R11: ffffc9000061b000 R12: ffffc900217=
77e40
[16816.215010] R13: ffffc90021777bf0 R14: ffffc90021777bd8 R15: ffff8881947=
6c000
[16816.215011] FS:  0000000000000000(0000) GS:ffff88886fdc0000(0000) knlGS:=
0000000000000000
[16816.215013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16816.215015] CR2: 0000000000000080 CR3: 0000000294a20000 CR4: 0000000000f=
50ee0
[16816.215017] PKRU: 55555554
[16816.215018] Call Trace:
[16816.215021]  <TASK>
[16816.215024]  ? __die+0x23/0x70
[16816.215030]  ? page_fault_oops+0x171/0x4e0
[16816.215035]  ? __pfx_bch_ptr_bad+0x10/0x10 [bcache 33eebe64448bb81d5f2a1=
0179a48eb0a5bdb25a6]
[16816.215059]  ? exc_page_fault+0x7f/0x180
[16816.215065]  ? asm_exc_page_fault+0x26/0x30
[16816.215070]  ? btree_node_free+0xf/0x160 [bcache 33eebe64448bb81d5f2a101=
79a48eb0a5bdb25a6]
[16816.215095]  ? btree_node_free+0xa3/0x160 [bcache 33eebe64448bb81d5f2a10=
179a48eb0a5bdb25a6]
[16816.215118]  btree_gc_coalesce+0x2a7/0x890 [bcache 33eebe64448bb81d5f2a1=
0179a48eb0a5bdb25a6]
[16816.215144]  ? bch_extent_bad+0x81/0x190 [bcache 33eebe64448bb81d5f2a101=
79a48eb0a5bdb25a6]
[16816.215172]  btree_gc_recurse+0x130/0x390 [bcache 33eebe64448bb81d5f2a10=
179a48eb0a5bdb25a6]
[16816.215197]  ? btree_gc_mark_node+0x72/0x240 [bcache 33eebe64448bb81d5f2=
a10179a48eb0a5bdb25a6]
[16816.215221]  bch_btree_gc+0x4b6/0x620 [bcache 33eebe64448bb81d5f2a10179a=
48eb0a5bdb25a6]
[16816.215246]  ? __pfx_autoremove_wake_function+0x10/0x10
[16816.215250]  ? __pfx_bch_gc_thread+0x10/0x10 [bcache 33eebe64448bb81d5f2=
a10179a48eb0a5bdb25a6]
[16816.215272]  bch_gc_thread+0x139/0x190 [bcache 33eebe64448bb81d5f2a10179=
a48eb0a5bdb25a6]
[16816.215295]  ? __pfx_autoremove_wake_function+0x10/0x10
[16816.215298]  kthread+0xe5/0x120
[16816.215302]  ? __pfx_kthread+0x10/0x10
[16816.215306]  ret_from_fork+0x31/0x50
[16816.215309]  ? __pfx_kthread+0x10/0x10
[16816.215312]  ret_from_fork_asm+0x1b/0x30
[16816.215318]  </TASK>
[16816.215319] Modules linked in: bcache tun ccm rfcomm snd_seq_dummy snd_h=
rtimer snd_seq nvidia(POE) typec_displayport cmac algif_hash algif_skcipher=
 af_alg bnep hid_sensor_custom hid_sensor_hub intel_ishtp_hid snd_hda_codec=
_hdmi snd_sof_pci_intel_tgl snd_sof_intel_hda_common soundwire_intel snd_so=
f_intel_hda_mlink soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_x=
tensa_dsp snd_sof snd_sof_utils intel_uncore_frequency intel_uncore_frequen=
cy_common snd_ctl_led snd_soc_hdac_hda r8153_ecm snd_hda_ext_core iwlmvm cd=
c_ether snd_soc_acpi_intel_match usbnet snd_soc_acpi soundwire_generic_allo=
cation soundwire_bus snd_soc_core x86_pkg_temp_thermal snd_compress snd_hda=
_codec_realtek intel_powerclamp ac97_bus snd_hda_codec_generic dell_rbtn co=
retemp btusb snd_pcm_dmaengine snd_usb_audio mac80211 btrtl snd_hda_intel k=
vm_intel btintel snd_intel_dspcfg snd_intel_sdw_acpi snd_usbmidi_lib btbcm =
dell_laptop snd_ump btmtk libarc4 snd_hda_codec uvcvideo kvm snd_rawmidi bl=
uetooth snd_hda_core videobuf2_vmalloc hid_multitouch iwlwifi
[16816.215367]  dell_wmi snd_hwdep iTCO_wdt snd_seq_device uvc nls_iso8859_=
1 videobuf2_memops dell_smbios intel_pmc_bxt mei_hdcp mei_pxp spi_nor snd_p=
cm processor_thermal_device_pci r8152 videobuf2_v4l2 dell_wmi_sysman irqbyp=
ass intel_rapl_msr dcdbas vfat iTCO_vendor_support fat rapl intel_cstate in=
tel_uncore psmouse pcspkr dell_wmi_ddv firmware_attributes_class ledtrig_au=
dio videobuf2_common ucsi_acpi dell_wmi_descriptor processor_thermal_device=
 mousedev ecdh_generic snd_timer mii joydev mtd wmi_bmof e1000e cfg80211 pr=
ocessor_thermal_rfim mei_me intel_lpss_pci i2c_i801 snd processor_thermal_m=
box typec_ucsi intel_ish_ipc intel_lpss mei soundcore i2c_smbus processor_t=
hermal_rapl rfkill thunderbolt typec idma64 intel_ishtp roles intel_rapl_co=
mmon igen6_edac i2c_hid_acpi int3403_thermal i2c_hid int340x_thermal_zone i=
ntel_hid int3400_thermal acpi_thermal_rel sparse_keymap acpi_tad acpi_pad m=
ac_hid vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) v4l2loopback(OE) videodev =
mc i2c_dev crypto_user fuse loop ip_tables x_tables ext4
[16816.215420]  crc32c_generic crc16 mbcache jbd2 dm_crypt cbc encrypted_ke=
ys trusted asn1_encoder tee usbhid i915 dm_mod crct10dif_pclmul crc32_pclmu=
l crc32c_intel polyval_clmulni i2c_algo_bit polyval_generic serio_raw rtsx_=
pci_sdmmc drm_buddy gf128mul atkbd ghash_clmulni_intel ttm mmc_core sha512_=
ssse3 libps2 vivaldi_fmap intel_gtt aesni_intel nvme crypto_simd drm_displa=
y_helper video nvme_core cryptd spi_intel_pci rtsx_pci spi_intel i8042 xhci=
_pci cec nvme_common xhci_pci_renesas serio wmi
[16816.215451] CR2: 0000000000000080
[16816.215453] ---[ end trace 0000000000000000 ]---
[16816.215455] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
[16816.215478] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f 44 00 00 <48=
> 8b 83 80 00 00 00 48 8d ab 90 00 00 00 48 39 98 60 c3 00 00 75
[16816.215480] RSP: 0018:ffffc90021777af8 EFLAGS: 00010207
[16816.215481] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff888515c=
e0670
[16816.215483] RDX: 0000000000000000 RSI: ffff888515ce0680 RDI: 00000000000=
00000
[16816.215484] RBP: ffffc90021777bf0 R08: ffff88819476d9e0 R09: 00000000013=
ffde8
[16816.215486] R10: 0000000000000000 R11: ffffc9000061b000 R12: ffffc900217=
77e40
[16816.215487] R13: ffffc90021777bf0 R14: ffffc90021777bd8 R15: ffff8881947=
6c000
[16816.215488] FS:  0000000000000000(0000) GS:ffff88886fdc0000(0000) knlGS:=
0000000000000000
[16816.215490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16816.215492] CR2: 0000000000000080 CR3: 0000000294a20000 CR4: 0000000000f=
50ee0
[16816.215493] PKRU: 55555554
[16816.215494] note: bcache_gc[83416] exited with irqs disabled

2. Kernel 6.1.55 (Debian 6.1.0-13) on HPE Gen11:

[60654.670443] BUG: kernel NULL pointer dereference, address: 0000000000000=
080
[60654.677474] #PF: supervisor read access in kernel mode
[60654.682651] #PF: error_code(0x0000) - not-present page
[60654.687825] PGD 0=20
[60654.689852] Oops: 0000 [#1] PREEMPT SMP NOPTI
[60654.694240] CPU: 16 PID: 146330 Comm: bcache_gc Tainted: G        W     =
     6.1.0-13-amd64 #1  Debian 6.1.55-1
[60654.704399] Hardware name: HPE ProLiant DL380 Gen11/ProLiant DL380 Gen11=
, BIOS 1.48 10/19/2023
[60654.713071] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
[60654.718437] Code: ff 48 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc 66 66 2e =
0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f 44 00 00 <48=
> 8b 83 80 00 00 00 48 39 98 70 c3 00 00 0f 84 34 01 00 00 48 8d
[60654.737342] RSP: 0018:ff77daed34cc3b18 EFLAGS: 00010207
[60654.742604] RAX: 0000000080000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[60654.749790] RDX: 0000000000000001 RSI: ff2971b8de800690 RDI: 00000000000=
00000
[60654.756975] RBP: ff77daed34cc3c10 R08: ff2971d852dc65e0 R09: ff2971b8de8=
00000
[60654.764536] R10: 0000000000000000 R11: ff77daed34a4d000 R12: ff77daed34c=
c3e60
[60654.771987] R13: ff77daed34cc3c10 R14: ff77daed34cc3c00 R15: ff2971d8510=
96400
[60654.779410] FS:  0000000000000000(0000) GS:ff2971f7bf400000(0000) knlGS:=
0000000000000000
[60654.787784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[60654.793794] CR2: 0000000000000080 CR3: 0000000150610002 CR4: 00000000007=
71ee0
[60654.801203] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[60654.808609] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[60654.816009] PKRU: 55555554
[60654.818949] Call Trace:
[60654.821623]  <TASK>
[60654.823950]  ? __die_body.cold+0x1a/0x1f
[60654.828110]  ? page_fault_oops+0xd2/0x2b0
[60654.832352]  ? exc_page_fault+0x70/0x170
[60654.836505]  ? asm_exc_page_fault+0x22/0x30
[60654.840922]  ? btree_node_free+0xf/0x160 [bcache]
[60654.845863]  ? up_write+0x32/0x60
[60654.849396]  btree_gc_coalesce+0x2aa/0x890 [bcache]
[60654.854512]  ? bch_extent_bad+0x70/0x170 [bcache]
[60654.859452]  btree_gc_recurse+0x130/0x390 [bcache]
[60654.864475]  ? btree_gc_mark_node+0x72/0x230 [bcache]
[60654.869758]  bch_btree_gc+0x5da/0x600 [bcache]
[60654.874428]  ? cpuusage_read+0x10/0x10
[60654.878390]  ? bch_btree_gc+0x600/0x600 [bcache]
[60654.883232]  bch_gc_thread+0x135/0x180 [bcache]
[60654.887986]  ? cpuusage_read+0x10/0x10
[60654.891944]  kthread+0xe6/0x110
[60654.895290]  ? kthread_complete_and_exit+0x20/0x20
[60654.900296]  ret_from_fork+0x1f/0x30
[60654.904079]  </TASK>
[60654.906455] Modules linked in: bonding tls cfg80211 rfkill intel_rapl_ms=
r intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i1=
0nm_edac nfit binfmt_misc libnvdimm x86_pkg_temp_thermal intel_powerclamp i=
pt_REJECT nf_reject_ipv4 coretemp xt_comment nft_compat nf_tables nfnetlink=
 nls_ascii nls_cp437 kvm_intel vfat ipmi_ssif fat kvm irqbypass ghash_clmul=
ni_intel sha512_ssse3 sha512_generic aesni_intel crypto_simd cryptd mgag200=
 drm_shmem_helper pmt_telemetry pmt_crashlog rapl intel_cstate acpi_ipmi ev=
dev intel_sdsi pmt_class idxd hpwdt mei_me isst_if_mbox_pci isst_if_mmio dr=
m_kms_helper intel_uncore pcspkr isst_if_common mei watchdog hpilo i2c_algo=
_bit ipmi_si idxd_bus acpi_tad intel_vsec sg acpi_power_meter button ipmi_d=
evintf ipmi_msghandler loop fuse efi_pstore drm configfs efivarfs ip_tables=
 x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic xor raid6_p=
q zstd_compress libcrc32c crc32c_generic ses enclosure bcache sd_mod scsi_t=
ransport_sas dm_mod nvme
[60654.906508]  nvme_core xhci_pci t10_pi megaraid_sas ehci_pci xhci_hcd eh=
ci_hcd crc64_rocksoft crc64 tg3 crc_t10dif scsi_mod usbcore crct10dif_gener=
ic crc32_pclmul crc32c_intel crct10dif_pclmul libphy scsi_common usb_common=
 crct10dif_common wmi
[60655.017712] CR2: 0000000000000080
[60655.021262] ---[ end trace 0000000000000000 ]---
[60655.173744] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
[60655.179337] Code: ff 48 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc 66 66 2e =
0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f 44 00 00 <48=
> 8b 83 80 00 00 00 48 39 98 70 c3 00 00 0f 84 34 01 00 00 48 8d
[60655.198649] RSP: 0018:ff77daed34cc3b18 EFLAGS: 00010207
[60655.204121] RAX: 0000000080000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[60655.211515] RDX: 0000000000000001 RSI: ff2971b8de800690 RDI: 00000000000=
00000
[60655.218908] RBP: ff77daed34cc3c10 R08: ff2971d852dc65e0 R09: ff2971b8de8=
00000
[60655.226302] R10: 0000000000000000 R11: ff77daed34a4d000 R12: ff77daed34c=
c3e60
[60655.233696] R13: ff77daed34cc3c10 R14: ff77daed34cc3c00 R15: ff2971d8510=
96400
[60655.241086] FS:  0000000000000000(0000) GS:ff2971f7bf400000(0000) knlGS:=
0000000000000000
[60655.249438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[60655.255432] CR2: 0000000000000080 CR3: 0000000150610002 CR4: 00000000007=
71ee0
[60655.262825] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[60655.270218] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[60655.277607] PKRU: 55555554
[60655.280543] note: bcache_gc[146330] exited with irqs disabled

Reproducer for us:

dd if=3D/dev/zero of=3Dloop0 bs=3D1M count=3D1024
dd if=3D/dev/zero of=3Dloop1 bs=3D1M count=3D10240
losetup loop0 loop0
losetup loop1 loop1
make-bcache -C /dev/loop0 -B /dev/loop1 --writeback
mkfs.ext4 /dev/bcache0
mount /dev/bcache0 /mnt

Then run fio with:

[global]
bs=3D4k
ioengine=3Dlibaio
iodepth=3D4
size=3D8g
direct=3D1
runtime=3D60
directory=3D/mnt
filename=3Dssd.test.file

[seq-write]
rw=3Dwrite
stonewall

[rand-write]
rw=3Drandwrite
stonewall

[seq-read]
rw=3Dread
stonewall

[rand-read]
rw=3Drandread
stonewall


Cheers,
Stefan
