Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0F7F75A2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbjKXNwX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 08:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKXNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:52:21 -0500
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 05:52:27 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07475CE;
        Fri, 24 Nov 2023 05:52:27 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 585941FDFA;
        Fri, 24 Nov 2023 13:46:41 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 809B5139E8;
        Fri, 24 Nov 2023 13:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id KYZlCz2pYGWTFwAAn2gu4w
        (envelope-from <colyli@suse.de>); Fri, 24 Nov 2023 13:46:37 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: bcache: kernel NULL pointer dereference since 6.1.39
From:   Coly Li <colyli@suse.de>
In-Reply-To: <71576a9ff7398bfa4b8c0a1a1a2523383b056168.camel@gekmihesg.de>
Date:   Fri, 24 Nov 2023 21:46:23 +0800
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Zheng Wang <zyytlz.wz@163.com>, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Stefan_F=C3=B6rster?= <cite@incertum.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Bcache Linux <linux-bcache@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <989C39B9-A05D-4E4F-A842-A4943A29FFD6@suse.de>
References: <ZV9ZSyDLNDlzutgQ@pharmakeia.incertum.net>
 <be371028-efeb-44af-90ea-5c307f27d4c6@leemhuis.info>
 <71576a9ff7398bfa4b8c0a1a1a2523383b056168.camel@gekmihesg.de>
To:     Markus Weippert <markus@gekmihesg.de>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spamd-Bar: ++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of colyli@suse.de) smtp.mailfrom=colyli@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [10.79 / 50.00];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         TO_DN_SOME(0.00)[];
         MV_CASE(0.50)[];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[163.com];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[gekmihesg.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FREEMAIL_CC(0.00)[leemhuis.info,163.com,vger.kernel.org,incertum.net,linuxfoundation.org,kernel.dk,lists.linux.dev];
         RCVD_TLS_ALL(0.00)[];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 10.79
X-Rspamd-Queue-Id: 585941FDFA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023年11月24日 21:29，Markus Weippert <markus@gekmihesg.de> 写道：
> 
>> On 23.11.23 14:53, Stefan Förster wrote:
>>> 
>>> starting with kernel 6.1.39, we see the following error message
>>> with
>>> heavy I/O loads. We needed to revert
>> 
>> Thx for the report. I assume that problem still occurs with the
>> latest
>> 6.1.y kernel?
>> 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.39&id=68118c339c6e1e16ae017bef160dbe28a27ae9c8
>> 
>> FWIW, that is mainline commit 028ddcac477b69 ("bcache: Remove
>> unnecessary NULL point check in node allocations") [v6.5-rc1].
>> 
>> Did a quick check and noticed a fix for that change was recently
>> mainlined as f72f4312d43883 ("bcache: replace a mistaken IS_ERR() by
>> IS_ERR_OR_NULL() in btree_gc_coalesce()") [v6.7-rc2-post]:
>> https://lore.kernel.org/all/20231118163852.9692-1-colyli@suse.de/
>> 
>> It is expected to soon be interegrated into a 6.1.y kernel.
>> 
>> But maybe it's something else. I CCed the involved people, they might
>> know.
> 
> We applied f72f4312d43883 to the current Debian kernel (based on
> 6.1.55) but it didn't help, same stack trace.
> Looking at the description, __bch_btree_node_alloc() should never be
> able to return NULL anyway after
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.39&id=7ecea5ce3dc17339c280c75b58ac93d8c8620d9f
> But I didn't verify all callers, so this might still be correct, if
> it's not always initialized with the return value of
> __bch_btree_node_alloc().
> 
> Anyway, I think we fixed it by applying this:
> 
> diff -Naurp a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> --- a/drivers/md/bcache/btree.c 2023-09-23 11:11:13.000000000 +0200
> +++ b/drivers/md/bcache/btree.c 2023-11-24 13:13:09.840013759 +0100
> @@ -1489,7 +1489,7 @@ out_nocoalesce:
> bch_keylist_free(&keylist);
> 
> for (i = 0; i < nodes; i++)
> - if (!IS_ERR(new_nodes[i])) {
> + if (!IS_ERR_OR_NULL(new_nodes[i])) {
> btree_node_free(new_nodes[i]);
> rw_unlock(true, new_nodes[i]);
> }
> 

The above change is what commit f72f4312d43883 ("bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()” does.

Although the above patch is suggested to go into 6.5+ kernel, for this condition it should go into all stable kernels where commit 028ddcac477b69 ("bcache: Remove unnecessary NULL point check in node allocations”) were merged into.

Coly Li


> --
> 
> That seems to run stable now. I suppose the culprit is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/md/bcache/btree.c?h=v6.1.55#n1448
> 
> new_nodes[0] = NULL;
> 
> for (i = 0; i < nodes; i++) {
> if (__bch_keylist_realloc(&keylist, bkey_u64s(&r[i].b-
>> key)))
> goto out_nocoalesce;
> 
> 
> So if __bch_keylist_realloc() succeeds, then btree_node_free() will be
> called with new_nodes[0] which is NULL.
> 
> This is still the same in mainline:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/bcache/btree.c?id=31f5b956a197d4ec25c8a07cb3a2ab69d0c0b82f#n1481
> 
> 
> 
>> 
>> Ciao, Thorsten
>> 
>>> to make sure the systems don't suddenly get stuck.
>>> 
>>> 1. Kernel 6.6.2-arch1-1 on Dell Latitude:
>>> 
>>> [16816.214942] BUG: kernel NULL pointer dereference, address:
>>> 0000000000000080
>>> [16816.214948] #PF: supervisor read access in kernel mode
>>> [16816.214951] #PF: error_code(0x0000) - not-present page
>>> [16816.214953] PGD 0 P4D 0 [16816.214956] Oops: 0000 [#1] PREEMPT
>>> SMP NOPTI
>>> [16816.214960] CPU: 7 PID: 83416 Comm: bcache_gc Tainted:
>>> P          
>>> OE      6.6.2-arch1-1 #1 11215f9ba7ddfb51644674a5b2ced71612c62fe9
>>> [16816.214964] Hardware name: Dell Inc. Latitude 5431/06F77M, BIOS
>>> 1.17.0 09/21/2023
>>> [16816.214965] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
>>> [16816.214999] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
>>> 90 90
>>> 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f
>>> 44 00
>>> 00 <48> 8b 83 80 00 00 00 48 8d ab 90 00 00 00 48 39 98 60 c3 00 00
>>> 75
>>> [16816.215001] RSP: 0018:ffffc90021777af8 EFLAGS: 00010207
>>> [16816.215004] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
>>> ffff888515ce0670
>>> [16816.215006] RDX: 0000000000000000 RSI: ffff888515ce0680 RDI:
>>> 0000000000000000
>>> [16816.215007] RBP: ffffc90021777bf0 R08: ffff88819476d9e0 R09:
>>> 00000000013ffde8
>>> [16816.215009] R10: 0000000000000000 R11: ffffc9000061b000 R12:
>>> ffffc90021777e40
>>> [16816.215010] R13: ffffc90021777bf0 R14: ffffc90021777bd8 R15:
>>> ffff88819476c000
>>> [16816.215011] FS:  0000000000000000(0000)
>>> GS:ffff88886fdc0000(0000)
>>> knlGS:0000000000000000
>>> [16816.215013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [16816.215015] CR2: 0000000000000080 CR3: 0000000294a20000 CR4:
>>> 0000000000f50ee0
>>> [16816.215017] PKRU: 55555554
>>> [16816.215018] Call Trace:
>>> [16816.215021]  <TASK>
>>> [16816.215024]  ? __die+0x23/0x70
>>> [16816.215030]  ? page_fault_oops+0x171/0x4e0
>>> [16816.215035]  ? __pfx_bch_ptr_bad+0x10/0x10 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215059]  ? exc_page_fault+0x7f/0x180
>>> [16816.215065]  ? asm_exc_page_fault+0x26/0x30
>>> [16816.215070]  ? btree_node_free+0xf/0x160 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215095]  ? btree_node_free+0xa3/0x160 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215118]  btree_gc_coalesce+0x2a7/0x890 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215144]  ? bch_extent_bad+0x81/0x190 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215172]  btree_gc_recurse+0x130/0x390 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215197]  ? btree_gc_mark_node+0x72/0x240 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215221]  bch_btree_gc+0x4b6/0x620 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215246]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [16816.215250]  ? __pfx_bch_gc_thread+0x10/0x10 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215272]  bch_gc_thread+0x139/0x190 [bcache
>>> 33eebe64448bb81d5f2a10179a48eb0a5bdb25a6]
>>> [16816.215295]  ? __pfx_autoremove_wake_function+0x10/0x10
>>> [16816.215298]  kthread+0xe5/0x120
>>> [16816.215302]  ? __pfx_kthread+0x10/0x10
>>> [16816.215306]  ret_from_fork+0x31/0x50
>>> [16816.215309]  ? __pfx_kthread+0x10/0x10
>>> [16816.215312]  ret_from_fork_asm+0x1b/0x30
>>> [16816.215318]  </TASK>
>>> [16816.215319] Modules linked in: bcache tun ccm rfcomm
>>> snd_seq_dummy
>>> snd_hrtimer snd_seq nvidia(POE) typec_displayport cmac algif_hash
>>> algif_skcipher af_alg bnep hid_sensor_custom hid_sensor_hub
>>> intel_ishtp_hid snd_hda_codec_hdmi snd_sof_pci_intel_tgl
>>> snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink
>>> soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
>>> snd_sof snd_sof_utils intel_uncore_frequency
>>> intel_uncore_frequency_common snd_ctl_led snd_soc_hdac_hda
>>> r8153_ecm
>>> snd_hda_ext_core iwlmvm cdc_ether snd_soc_acpi_intel_match usbnet
>>> snd_soc_acpi soundwire_generic_allocation soundwire_bus
>>> snd_soc_core
>>> x86_pkg_temp_thermal snd_compress snd_hda_codec_realtek
>>> intel_powerclamp
>>> ac97_bus snd_hda_codec_generic dell_rbtn coretemp btusb
>>> snd_pcm_dmaengine snd_usb_audio mac80211 btrtl snd_hda_intel
>>> kvm_intel
>>> btintel snd_intel_dspcfg snd_intel_sdw_acpi snd_usbmidi_lib btbcm
>>> dell_laptop snd_ump btmtk libarc4 snd_hda_codec uvcvideo kvm
>>> snd_rawmidi
>>> bluetooth snd_hda_core videobuf2_vmalloc hid_multitouch iwlwifi
>>> [16816.215367]  dell_wmi snd_hwdep iTCO_wdt snd_seq_device uvc
>>> nls_iso8859_1 videobuf2_memops dell_smbios intel_pmc_bxt mei_hdcp
>>> mei_pxp spi_nor snd_pcm processor_thermal_device_pci r8152
>>> videobuf2_v4l2 dell_wmi_sysman irqbypass intel_rapl_msr dcdbas vfat
>>> iTCO_vendor_support fat rapl intel_cstate intel_uncore psmouse
>>> pcspkr
>>> dell_wmi_ddv firmware_attributes_class ledtrig_audio
>>> videobuf2_common
>>> ucsi_acpi dell_wmi_descriptor processor_thermal_device mousedev
>>> ecdh_generic snd_timer mii joydev mtd wmi_bmof e1000e cfg80211
>>> processor_thermal_rfim mei_me intel_lpss_pci i2c_i801 snd
>>> processor_thermal_mbox typec_ucsi intel_ish_ipc intel_lpss mei
>>> soundcore
>>> i2c_smbus processor_thermal_rapl rfkill thunderbolt typec idma64
>>> intel_ishtp roles intel_rapl_common igen6_edac i2c_hid_acpi
>>> int3403_thermal i2c_hid int340x_thermal_zone intel_hid
>>> int3400_thermal
>>> acpi_thermal_rel sparse_keymap acpi_tad acpi_pad mac_hid
>>> vboxnetflt(OE)
>>> vboxnetadp(OE) vboxdrv(OE) v4l2loopback(OE) videodev mc i2c_dev
>>> crypto_user fuse loop ip_tables x_tables ext4
>>> [16816.215420]  crc32c_generic crc16 mbcache jbd2 dm_crypt cbc
>>> encrypted_keys trusted asn1_encoder tee usbhid i915 dm_mod
>>> crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>>> i2c_algo_bit
>>> polyval_generic serio_raw rtsx_pci_sdmmc drm_buddy gf128mul atkbd
>>> ghash_clmulni_intel ttm mmc_core sha512_ssse3 libps2 vivaldi_fmap
>>> intel_gtt aesni_intel nvme crypto_simd drm_display_helper video
>>> nvme_core cryptd spi_intel_pci rtsx_pci spi_intel i8042 xhci_pci
>>> cec
>>> nvme_common xhci_pci_renesas serio wmi
>>> [16816.215451] CR2: 0000000000000080
>>> [16816.215453] ---[ end trace 0000000000000000 ]---
>>> [16816.215455] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
>>> [16816.215478] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
>>> 90 90
>>> 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f
>>> 44 00
>>> 00 <48> 8b 83 80 00 00 00 48 8d ab 90 00 00 00 48 39 98 60 c3 00 00
>>> 75
>>> [16816.215480] RSP: 0018:ffffc90021777af8 EFLAGS: 00010207
>>> [16816.215481] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
>>> ffff888515ce0670
>>> [16816.215483] RDX: 0000000000000000 RSI: ffff888515ce0680 RDI:
>>> 0000000000000000
>>> [16816.215484] RBP: ffffc90021777bf0 R08: ffff88819476d9e0 R09:
>>> 00000000013ffde8
>>> [16816.215486] R10: 0000000000000000 R11: ffffc9000061b000 R12:
>>> ffffc90021777e40
>>> [16816.215487] R13: ffffc90021777bf0 R14: ffffc90021777bd8 R15:
>>> ffff88819476c000
>>> [16816.215488] FS:  0000000000000000(0000)
>>> GS:ffff88886fdc0000(0000)
>>> knlGS:0000000000000000
>>> [16816.215490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [16816.215492] CR2: 0000000000000080 CR3: 0000000294a20000 CR4:
>>> 0000000000f50ee0
>>> [16816.215493] PKRU: 55555554
>>> [16816.215494] note: bcache_gc[83416] exited with irqs disabled
>>> 
>>> 2. Kernel 6.1.55 (Debian 6.1.0-13) on HPE Gen11:
>>> 
>>> [60654.670443] BUG: kernel NULL pointer dereference, address:
>>> 0000000000000080
>>> [60654.677474] #PF: supervisor read access in kernel mode
>>> [60654.682651] #PF: error_code(0x0000) - not-present page
>>> [60654.687825] PGD 0 [60654.689852] Oops: 0000 [#1] PREEMPT SMP
>>> NOPTI
>>> [60654.694240] CPU: 16 PID: 146330 Comm: bcache_gc Tainted:
>>> G       
>>> W          6.1.0-13-amd64 #1  Debian 6.1.55-1
>>> [60654.704399] Hardware name: HPE ProLiant DL380 Gen11/ProLiant
>>> DL380
>>> Gen11, BIOS 1.48 10/19/2023
>>> [60654.713071] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
>>> [60654.718437] Code: ff 48 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc
>>> 66 66
>>> 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f
>>> 44 00
>>> 00 <48> 8b 83 80 00 00 00 48 39 98 70 c3 00 00 0f 84 34 01 00 00 48
>>> 8d
>>> [60654.737342] RSP: 0018:ff77daed34cc3b18 EFLAGS: 00010207
>>> [60654.742604] RAX: 0000000080000000 RBX: 0000000000000000 RCX:
>>> 0000000000000000
>>> [60654.749790] RDX: 0000000000000001 RSI: ff2971b8de800690 RDI:
>>> 0000000000000000
>>> [60654.756975] RBP: ff77daed34cc3c10 R08: ff2971d852dc65e0 R09:
>>> ff2971b8de800000
>>> [60654.764536] R10: 0000000000000000 R11: ff77daed34a4d000 R12:
>>> ff77daed34cc3e60
>>> [60654.771987] R13: ff77daed34cc3c10 R14: ff77daed34cc3c00 R15:
>>> ff2971d851096400
>>> [60654.779410] FS:  0000000000000000(0000)
>>> GS:ff2971f7bf400000(0000)
>>> knlGS:0000000000000000
>>> [60654.787784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [60654.793794] CR2: 0000000000000080 CR3: 0000000150610002 CR4:
>>> 0000000000771ee0
>>> [60654.801203] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [60654.808609] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
>>> 0000000000000400
>>> [60654.816009] PKRU: 55555554
>>> [60654.818949] Call Trace:
>>> [60654.821623]  <TASK>
>>> [60654.823950]  ? __die_body.cold+0x1a/0x1f
>>> [60654.828110]  ? page_fault_oops+0xd2/0x2b0
>>> [60654.832352]  ? exc_page_fault+0x70/0x170
>>> [60654.836505]  ? asm_exc_page_fault+0x22/0x30
>>> [60654.840922]  ? btree_node_free+0xf/0x160 [bcache]
>>> [60654.845863]  ? up_write+0x32/0x60
>>> [60654.849396]  btree_gc_coalesce+0x2aa/0x890 [bcache]
>>> [60654.854512]  ? bch_extent_bad+0x70/0x170 [bcache]
>>> [60654.859452]  btree_gc_recurse+0x130/0x390 [bcache]
>>> [60654.864475]  ? btree_gc_mark_node+0x72/0x230 [bcache]
>>> [60654.869758]  bch_btree_gc+0x5da/0x600 [bcache]
>>> [60654.874428]  ? cpuusage_read+0x10/0x10
>>> [60654.878390]  ? bch_btree_gc+0x600/0x600 [bcache]
>>> [60654.883232]  bch_gc_thread+0x135/0x180 [bcache]
>>> [60654.887986]  ? cpuusage_read+0x10/0x10
>>> [60654.891944]  kthread+0xe6/0x110
>>> [60654.895290]  ? kthread_complete_and_exit+0x20/0x20
>>> [60654.900296]  ret_from_fork+0x1f/0x30
>>> [60654.904079]  </TASK>
>>> [60654.906455] Modules linked in: bonding tls cfg80211 rfkill
>>> intel_rapl_msr intel_rapl_common intel_uncore_frequency
>>> intel_uncore_frequency_common i10nm_edac nfit binfmt_misc libnvdimm
>>> x86_pkg_temp_thermal intel_powerclamp ipt_REJECT nf_reject_ipv4
>>> coretemp
>>> xt_comment nft_compat nf_tables nfnetlink nls_ascii nls_cp437
>>> kvm_intel
>>> vfat ipmi_ssif fat kvm irqbypass ghash_clmulni_intel sha512_ssse3
>>> sha512_generic aesni_intel crypto_simd cryptd mgag200
>>> drm_shmem_helper
>>> pmt_telemetry pmt_crashlog rapl intel_cstate acpi_ipmi evdev
>>> intel_sdsi
>>> pmt_class idxd hpwdt mei_me isst_if_mbox_pci isst_if_mmio
>>> drm_kms_helper
>>> intel_uncore pcspkr isst_if_common mei watchdog hpilo i2c_algo_bit
>>> ipmi_si idxd_bus acpi_tad intel_vsec sg acpi_power_meter button
>>> ipmi_devintf ipmi_msghandler loop fuse efi_pstore drm configfs
>>> efivarfs
>>> ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs
>>> blake2b_generic
>>> xor raid6_pq zstd_compress libcrc32c crc32c_generic ses enclosure
>>> bcache
>>> sd_mod scsi_transport_sas dm_mod nvme
>>> [60654.906508]  nvme_core xhci_pci t10_pi megaraid_sas ehci_pci
>>> xhci_hcd
>>> ehci_hcd crc64_rocksoft crc64 tg3 crc_t10dif scsi_mod usbcore
>>> crct10dif_generic crc32_pclmul crc32c_intel crct10dif_pclmul libphy
>>> scsi_common usb_common crct10dif_common wmi
>>> [60655.017712] CR2: 0000000000000080
>>> [60655.021262] ---[ end trace 0000000000000000 ]---
>>> [60655.173744] RIP: 0010:btree_node_free+0xf/0x160 [bcache]
>>> [60655.179337] Code: ff 48 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc
>>> 66 66
>>> 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 55 53 48 89 fb 0f 1f
>>> 44 00
>>> 00 <48> 8b 83 80 00 00 00 48 39 98 70 c3 00 00 0f 84 34 01 00 00 48
>>> 8d
>>> [60655.198649] RSP: 0018:ff77daed34cc3b18 EFLAGS: 00010207
>>> [60655.204121] RAX: 0000000080000000 RBX: 0000000000000000 RCX:
>>> 0000000000000000
>>> [60655.211515] RDX: 0000000000000001 RSI: ff2971b8de800690 RDI:
>>> 0000000000000000
>>> [60655.218908] RBP: ff77daed34cc3c10 R08: ff2971d852dc65e0 R09:
>>> ff2971b8de800000
>>> [60655.226302] R10: 0000000000000000 R11: ff77daed34a4d000 R12:
>>> ff77daed34cc3e60
>>> [60655.233696] R13: ff77daed34cc3c10 R14: ff77daed34cc3c00 R15:
>>> ff2971d851096400
>>> [60655.241086] FS:  0000000000000000(0000)
>>> GS:ff2971f7bf400000(0000)
>>> knlGS:0000000000000000
>>> [60655.249438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [60655.255432] CR2: 0000000000000080 CR3: 0000000150610002 CR4:
>>> 0000000000771ee0
>>> [60655.262825] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [60655.270218] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
>>> 0000000000000400
>>> [60655.277607] PKRU: 55555554
>>> [60655.280543] note: bcache_gc[146330] exited with irqs disabled
>>> 
>>> Reproducer for us:
>>> 
>>> dd if=/dev/zero of=loop0 bs=1M count=1024
>>> dd if=/dev/zero of=loop1 bs=1M count=10240
>>> losetup loop0 loop0
>>> losetup loop1 loop1
>>> make-bcache -C /dev/loop0 -B /dev/loop1 --writeback
>>> mkfs.ext4 /dev/bcache0
>>> mount /dev/bcache0 /mnt
>>> 
>>> Then run fio with:
>>> 
>>> [global]
>>> bs=4k
>>> ioengine=libaio
>>> iodepth=4
>>> size=8g
>>> direct=1
>>> runtime=60
>>> directory=/mnt
>>> filename=ssd.test.file
>>> 
>>> [seq-write]
>>> rw=write
>>> stonewall
>>> 
>>> [rand-write]
>>> rw=randwrite
>>> stonewall
>>> 
>>> [seq-read]
>>> rw=read
>>> stonewall
>>> 
>>> [rand-read]
>>> rw=randread
>>> stonewall
>>> 
>>> 
>>> Cheers,
>>> Stefan


