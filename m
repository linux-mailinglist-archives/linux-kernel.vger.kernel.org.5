Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDF7E8F86
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjKLKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:48:03 -0500
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 02:47:58 PST
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC44273F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:47:58 -0800 (PST)
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:date:subject:subject:from:from; s=dkim; t=
 1699785734; x=1700649735; bh=2THmWKAL2YRfUmlJ5yUPdv9Huk+yZ0Nz3Jj
 dwcjUxGI=; b=tCtnB4lwbDv49x63kSY9JCrT919fa0mGFvdt0ZtYKvvTMkENazU
 yDPArNMRr0K5VhHT3CsuzzZm2jriJfPORiJ73crg4lU0+gEK3YOCHjK12b2ALvJn
 iI0BrLAH4Kzl/dFfuttFyx+9om+/1u57udBZaZD2UJnOvashxM77G5kI=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     rostedt@goodmis.org
Cc:     akaher@vmware.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org,
        Milian Wolff <milian.wolff@kdab.com>
Subject: NULL pointer dereference regression when running `chmod -R
 root:tracing /sys/kernel/debug/tracing`
Date:   Sun, 12 Nov 2023 11:41:58 +0100
Message-ID: <20231112104158.6638-1-milian.wolff@kdab.com>
In-Reply-To: <20231105160139.660634360@goodmis.org>
References: <20231105160139.660634360@goodmis.org>
MIME-Version: 1.0
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

Hey all,

this patch seems to have introduced a kernel bug causing
a NULL pointer dereference when one runs:

    sudo chown -R root:tracing /sys/kernel/debug/tracing/

See the archlinux bug report I created initially for some more information:
https://bugs.archlinux.org/task/80230

With 6.6.1 and 9aaee3eebc91dd9ccebf6b6bc8a5f59d04ef718b reverted,
the above `chmod` command works. With a normal 6.6.1 build, or re-applying
the patch again, the command fails and `dmesg` shows:

```
[ 60.723813] BUG: kernel NULL pointer dereference, address: 0000000000000058
[ 60.723817] #PF: supervisor read access in kernel mode
[ 60.723819] #PF: error_code(0x0000) - not-present page
[ 60.723820] PGD 0 P4D 0
[ 60.723821] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 60.723823] CPU: 5 PID: 2830 Comm: chown Tainted: P OE 6.6.1-arch1-1 #1 be=
166a630cd909acf8820643140e9106c6ea80e6
[ 60.723825] Hardware name: LENOVO 20Y30018GE/20Y30018GE, BIOS N40ET42W (1.=
24 ) 07/26/2023
[ 60.723826] RIP: 0010:eventfs_set_attr+0x28/0xd0
[ 60.723830] Code: 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 55 41 54 49 89 d4 55=
 48 89 fd 48 c7 c7 a0 b7 b2 b2 53 48 89 f3 e8 8c 16 8c 00 4c 8b 6b 78 <41> =
f6 45 58 01 0f 85 87 00 00 00 48 89 de 4c 89 e2 48 89 ef e8 4f
[ 60.723830] RSP: 0018:ffffc90007fdbd38 EFLAGS: 00010246
[ 60.723832] RAX: 0000000000000000 RBX: ffff88810047e180 RCX: 8000000000000=
000
[ 60.723832] RDX: ffff888174b6ce00 RSI: ffff88810047e180 RDI: ffffffffb2b2b=
7a0
[ 60.723833] RBP: ffffffffb2b20620 R08: 0000000000000000 R09: ffffffffb2a4a=
488
[ 60.723834] R10: 00000000654f505f R11: 0000000018432441 R12: ffffc90007fdb=
e00
[ 60.723835] R13: 0000000000000000 R14: ffff88810047e180 R15: ffff8881004c0=
2a8
[ 60.723835] FS: 00007f4ac6f4c740(0000) GS:ffff88901f540000(0000) knlGS:000=
0000000000000
[ 60.723836] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 60.723837] CR2: 0000000000000058 CR3: 000000021ad48001 CR4: 0000000000f70=
ee0
[ 60.723838] PKRU: 55555554
[ 60.723839] Call Trace:
[ 60.723840] <TASK>
[ 60.723842] ? __die+0x23/0x70
[ 60.723845] ? page_fault_oops+0x171/0x4e0
[ 60.723847] ? generic_permission+0x39/0x220
[ 60.723850] ? exc_page_fault+0x7f/0x180
[ 60.723853] ? asm_exc_page_fault+0x26/0x30
[ 60.723857] ? eventfs_set_attr+0x28/0xd0
[ 60.723858] ? eventfs_set_attr+0x24/0xd0
[ 60.723859] notify_change+0x1f2/0x4b0
[ 60.723862] ? chown_common+0x222/0x230
[ 60.723863] chown_common+0x222/0x230
[ 60.723865] do_fchownat+0xa3/0x100
[ 60.723866] __x64_sys_fchownat+0x1f/0x30
[ 60.723867] do_syscall_64+0x5d/0x90
[ 60.723869] ? syscall_exit_to_user_mode+0x2b/0x40
[ 60.723871] ? do_syscall_64+0x6c/0x90
[ 60.723872] ? do_syscall_64+0x6c/0x90
[ 60.723874] ? do_syscall_64+0x6c/0x90
[ 60.723875] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 60.723877] RIP: 0033:0x7f4ac704e2ce
[ 60.723904] Code: 48 8b 0d 65 8a 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e=
 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 04 01 00 00 0f 05 <48> =
3d 01 f0 ff ff 73 01 c3 48 8b 0d 32 8a 0d 00 f7 d8 64 89 01 48
[ 60.723905] RSP: 002b:00007ffed0b735b8 EFLAGS: 00000246 ORIG_RAX: 00000000=
00000104
[ 60.723906] RAX: ffffffffffffffda RBX: 00005625366cfd80 RCX: 00007f4ac704e=
2ce
[ 60.723907] RDX: 0000000000000000 RSI: 00005625366cfe10 RDI: 0000000000000=
004
[ 60.723908] RBP: 0000000000000001 R08: 0000000000000100 R09: 0000000000000=
007
[ 60.723908] R10: 00000000000003e9 R11: 0000000000000246 R12: 00005625366cb=
9c0
[ 60.723909] R13: 00005625366cfd10 R14: 00005625366cfe10 R15: 0000000000000=
000
[ 60.723910] </TASK>
[ 60.723910] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_d=
evice rfcomm ccm cmac algif_hash algif_skcipher af_alg bnep nvidia_drm(POE)=
 nvidia_modeset(POE) snd_ctl_led snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_=
common snd_soc_hdac_hdmi snd_sof_probes nvidia_uvm(POE) snd_hda_codec_realt=
ek snd_hda_codec_generic snd_soc_dmic intel_tcc_cooling snd_sof_pci_intel_t=
gl x86_pkg_temp_thermal intel_powerclamp snd_sof_intel_hda_common soundwire=
_intel coretemp snd_sof_intel_hda_mlink nvidia(POE) soundwire_cadence snd_s=
of_intel_hda kvm_intel snd_sof_pci snd_sof_xtensa_dsp snd_sof kvm snd_sof_u=
tils snd_soc_hdac_hda vfat snd_hda_ext_core fat snd_soc_acpi_intel_match ir=
qbypass snd_soc_acpi iwlmvm crct10dif_pclmul joydev soundwire_generic_alloc=
ation mousedev soundwire_bus crc32_pclmul snd_hda_codec_hdmi snd_soc_core p=
olyval_clmulni polyval_generic snd_compress gf128mul mac80211 ac97_bus ghas=
h_clmulni_intel snd_pcm_dmaengine sha512_ssse3 btusb aesni_intel btrtl uvcv=
ideo snd_hda_intel crypto_simd btintel videobuf2_vmalloc
[ 60.723940] snd_intel_dspcfg cryptd libarc4 btbcm uvc snd_intel_sdw_acpi b=
tmtk videobuf2_memops iTCO_wdt hid_multitouch snd_hda_codec intel_pmc_bxt v=
ideobuf2_v4l2 mei_hdcp mei_wdt mei_pxp rapl ee1004 iTCO_vendor_support inte=
l_rapl_msr snd_hda_core bluetooth processor_thermal_device_pci_legacy video=
dev processor_thermal_device iwlwifi processor_thermal_rfim spi_nor videobu=
f2_common snd_hwdep intel_cstate think_lmi processor_thermal_mbox intel_unc=
ore psmouse pcspkr cfg80211 mc ecdh_generic mtd firmware_attributes_class w=
mi_bmof mei_me ucsi_acpi processor_thermal_rapl snd_pcm i2c_i801 intel_lpss=
_pci typec_ucsi intel_rapl_common i2c_smbus intel_lpss thunderbolt i2c_hid_=
acpi mei snd_timer typec intel_soc_dts_iosf idma64 i2c_hid int3403_thermal =
roles int340x_thermal_zone int3400_thermal acpi_tad acpi_pad acpi_thermal_r=
el mac_hid i2c_dev crypto_user fuse acpi_call(OE) dm_mod loop ip_tables x_t=
ables ext4 crc32c_generic crc16 mbcache jbd2 i915 thinkpad_acpi rtsx_pci_sd=
mmc ledtrig_audio i2c_algo_bit mmc_core serio_raw
[ 60.723972] platform_profile drm_buddy ttm snd atkbd nvme intel_gtt libps2=
 vivaldi_fmap soundcore drm_display_helper nvme_core xhci_pci crc32c_intel =
spi_intel_pci rfkill rtsx_pci spi_intel xhci_pci_renesas cec nvme_common vi=
deo i8042 serio wmi
[ 60.723982] CR2: 0000000000000058
[ 60.723983] ---[ end trace 0000000000000000 ]---
[ 60.723984] RIP: 0010:eventfs_set_attr+0x28/0xd0
[ 60.723985] Code: 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 55 41 54 49 89 d4 55=
 48 89 fd 48 c7 c7 a0 b7 b2 b2 53 48 89 f3 e8 8c 16 8c 00 4c 8b 6b 78 <41> =
f6 45 58 01 0f 85 87 00 00 00 48 89 de 4c 89 e2 48 89 ef e8 4f
[ 60.723986] RSP: 0018:ffffc90007fdbd38 EFLAGS: 00010246
[ 60.723987] RAX: 0000000000000000 RBX: ffff88810047e180 RCX: 8000000000000=
000
[ 60.723987] RDX: ffff888174b6ce00 RSI: ffff88810047e180 RDI: ffffffffb2b2b=
7a0
[ 60.723988] RBP: ffffffffb2b20620 R08: 0000000000000000 R09: ffffffffb2a4a=
488
[ 60.723989] R10: 00000000654f505f R11: 0000000018432441 R12: ffffc90007fdb=
e00
[ 60.723989] R13: 0000000000000000 R14: ffff88810047e180 R15: ffff8881004c0=
2a8
[ 60.723990] FS: 00007f4ac6f4c740(0000) GS:ffff88901f540000(0000) knlGS:000=
0000000000000
[ 60.723991] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 60.723991] CR2: 0000000000000058 CR3: 000000021ad48001 CR4: 0000000000f70=
ee0
[ 60.723992] PKRU: 55555554
[ 60.723992] note: chown[2830] exited with irqs disabled
```

Thanks, if you need more information just let me know.

Cheers
