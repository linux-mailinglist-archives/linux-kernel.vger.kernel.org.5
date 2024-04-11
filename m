Return-Path: <linux-kernel+bounces-140342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934D8A130F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30421F22919
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7214884C;
	Thu, 11 Apr 2024 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0uZcOgS"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DA13DBB6;
	Thu, 11 Apr 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835208; cv=none; b=pZbCOv+NkSMWuxpmIFgef1cq6nyoOz1pbmJjAsJU+NphVNsN9fKX7wL4t8vEc8FuWvtMFCOVUBNgBVQgDB83L0sB5joQlowZlsRr1AzcNeu1kxv4DvKJywK8BaUesRNjOOpYGiADfMYY1YigcAN6Cb/+1VO1QkWTTeC2UFX5c7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835208; c=relaxed/simple;
	bh=muR1/ADu9TAIXZBQ/wfDhbYx2+qoiKVCb+YgJridmKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM/6Kik13pmr9SnTVj26pTDoGN5jcbuFfZexbqPEeogAn96WXg+MHfUcPkcHrHhss/V1/Fni1Co9ijLLnDvmrQhB27N5Con6GHhx1+Q6ODysm035LFst7inMGDz32kYZOQpdrIcAMHIb3iVCT4qaa1K08CRKBREjDUY+XD+zbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0uZcOgS; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6963c0c507eso7710426d6.1;
        Thu, 11 Apr 2024 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712835205; x=1713440005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5D3mVtPdaXrN/I59ysp1em7AlqLnMHVoxgVRiqzFUMs=;
        b=h0uZcOgSOWD6cUCJczmU7DP2Uj5TNayyLRQ6IOS7NZG1HDYu4Fw1YL07ITLUDVL+Ts
         XYX4NBAPFojBn0wOatf1PJIUyzON28vSrEeofg5s1+otRcap3811d7qvsHgV7sJR5DS/
         zOQnO14+mzlOAQ5O2epMPys+XAAOfNLjLj8RSzCT4L5rzkA4uEfoJ8JPFjRChTVdxNW3
         9J3pXykqKkQP8bo5avhRJu2Cm7MgJJeXhBriB6wn8ScyggjVeRb43qXgGRYs3GW2ssQe
         pXy7BGER4+GZNyLVJwCRe8jaGsDuZeeVDGS4THWYgk7w46aglG8J1JwgOammuMuerKmN
         fYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712835205; x=1713440005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5D3mVtPdaXrN/I59ysp1em7AlqLnMHVoxgVRiqzFUMs=;
        b=DS71xrPdYzBTVEsSMOtCflyAxMuo4MhKC7Wmh7kGew0vPvK0IAeYxVb43WimPV8TCs
         phFJVC0cLNPk5zyOZhZM3pFYb+C1qV8OYee5UrxM/WTp8Sq9ozLCZHPjDfhsT13rjkxB
         gTvGyRIntS8X77Yn86R5X697wQmg/FJM4bEdHIf8uq04UZnWN8TJw0p8eb+2/jO7/hnk
         +zh6XO+JxWTjVxSOyJh7Woyl0Jr3QdDRZ9ZvgvwJPvMbmOjQE6riZbgR8aNNkQ0i4RRi
         SpZkiWWi9yVhogbLLIr/3BnmKC2VO9iCsuyiIijDPmxNJ/vkq8MdOmdvNcxBZkrDTfdR
         FkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+geXopySZvdpcGeuBTHfalBw016LM4xKSWzLdSciPkH77jg7lgaq/9J5XdjjfF8s6DfFdcIAW84UrxxGLLbfHvcDeownxz70e/NKH
X-Gm-Message-State: AOJu0YzMAp9DhNmb5keHY8lfZpHQjeTstXECX+jPo4bvMVojlYNA3yoA
	RdhCqV2qLTpu3GX9W/lIFg6sYBDMSJHv3HczSxDd35qFnrFJ0GPW50IiFe3SL5yD3D6AhZoogS4
	CuKtBnprWofg5h8qaMdM9MAsBUG5CAa8W
X-Google-Smtp-Source: AGHT+IH/endtO91FjJo3Xy5F+rXlR4XFKO79ufeph4ASYe6xuXY4eTUgl5yX2ukNZV+BNBOpHVygFbbcXkb4UZ3GWBg=
X-Received: by 2002:a05:6214:908:b0:699:28cd:b48d with SMTP id
 dj8-20020a056214090800b0069928cdb48dmr3911321qvb.8.1712835205378; Thu, 11 Apr
 2024 04:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK2bqV+kpG5cm5py24TusikZYO=_vWg7CVEN3oTywVhnq1mhjQ@mail.gmail.com>
 <2024041125-surgery-pending-cd06@gregkh>
In-Reply-To: <2024041125-surgery-pending-cd06@gregkh>
From: Chris Rankin <rankincj@gmail.com>
Date: Thu, 11 Apr 2024 12:33:13 +0100
Message-ID: <CAK2bqVJcsjZE8k87_xNU-mQ3xXm58eCFMdouSVEMkkT57wCQFg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Stable <stable@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

My original oops is here:

[ 7737.972588] usb 2-4: USB disconnect, device number 3
[ 7743.332135] BUG: kernel NULL pointer dereference, address: 0000000000000370
[ 7743.337805] #PF: supervisor write access in kernel mode
[ 7743.341730] #PF: error_code(0x0002) - not-present page
[ 7743.345569] PGD 0 P4D 0
[ 7743.346830] Oops: 0002 [#1] PREEMPT SMP PTI
[ 7743.349711] CPU: 4 PID: 27870 Comm: kworker/4:0 Tainted: G
I        6.8.4 #1
[ 7743.356237] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 7743.363830] Workqueue: events sg_remove_sfp_usercontext [sg]
[ 7743.368196] RIP: 0010:mutex_lock+0x1e/0x2e
[ 7743.370997] Code: 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
00 51 48 89 3c 24 2e 2e 2e 31 c0 31 c0 48 8b 3c 24 65 48 8b 14 25 40
c2 02 00 <f0> 48 0f b1 17 74 03 5a eb b9 58 c3 cc cc cc cc 90 90 90 90
90 90
[ 7743.388443] RSP: 0018:ffffc90004667e00 EFLAGS: 00010246
[ 7743.392368] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000810000d2
[ 7743.398201] RDX: ffff88805bf30e40 RSI: ffffffffa1bbd20d RDI: 0000000000000370
[ 7743.404034] RBP: 0000000000000370 R08: ffff8881144e2d70 R09: 00000000810000d2
[ 7743.409867] R10: 000000000000023e R11: 000000000000023e R12: ffff8881424039c0
[ 7743.415698] R13: dead000000000100 R14: ffff88826223a000 R15: ffff88826223a030
[ 7743.421522] FS:  0000000000000000(0000) GS:ffff888343d00000(0000)
knlGS:0000000000000000
[ 7743.428308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7743.432745] CR2: 0000000000000370 CR3: 000000000221a000 CR4: 00000000000006f0
[ 7743.438570] Call Trace:
[ 7743.439715]  <TASK>
[ 7743.440513]  ? __die_body+0x1a/0x5c
[ 7743.442707]  ? page_fault_oops+0x32a/0x377
[ 7743.445504]  ? fixup_exception+0x22/0x250
[ 7743.448217]  ? exc_page_fault+0x105/0x117
[ 7743.450928]  ? asm_exc_page_fault+0x22/0x30
[ 7743.453850]  ? __pfx_sg_device_destroy+0x10/0x10 [sg]
[ 7743.457602]  ? mutex_lock+0x1e/0x2e
[ 7743.459839]  blk_trace_remove+0x15/0x35
[ 7743.462378]  sg_device_destroy+0x1d/0x60 [sg]
[ 7743.465438]  sg_remove_sfp_usercontext+0xd2/0xe9 [sg]
[ 7743.469190]  process_scheduled_works+0x198/0x296
[ 7743.472510]  worker_thread+0x1c6/0x220
[ 7743.474962]  ? __pfx_worker_thread+0x10/0x10
[ 7743.477934]  kthread+0xf7/0xff
[ 7743.479694]  ? __pfx_kthread+0x10/0x10
[ 7743.482146]  ret_from_fork+0x24/0x36
[ 7743.484425]  ? __pfx_kthread+0x10/0x10
[ 7743.486877]  ret_from_fork_asm+0x1b/0x30
[ 7743.489506]  </TASK>
[ 7743.490397] Modules linked in: udf usb_storage sg algif_hash af_alg
snd_seq_dummy rpcrdma rdma_cm iw_cm ib_cm ib_core nf_nat_ftp
nf_conntrack_ftp cfg80211 af_packet nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter ip_tables x_tables bnep it87
hwmon_vid binfmt_misc snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_intel uvcvideo intel_powerclamp btusb
btintel snd_usb_audio snd_intel_dspcfg coretemp btbcm uvc
snd_hda_codec videobuf2_vmalloc kvm_intel snd_virtuoso bluetooth
videobuf2_memops snd_oxygen_lib videobuf2_v4l2 snd_hda_core
snd_usbmidi_lib videodev snd_mpu401_uart kvm videobuf2_common
[ 7743.490474]  snd_hwdep snd_rawmidi mc snd_seq ecdh_generic
input_leds led_class joydev snd_seq_device snd_pcm rfkill ecc r8169
pktcdvd irqbypass gpio_ich realtek iTCO_wdt intel_cstate snd_hrtimer
mdio_devres snd_timer libphy intel_uncore i2c_i801 snd pcspkr psmouse
i2c_smbus acpi_cpufreq mxm_wmi soundcore lpc_ich i7core_edac
tiny_power_button button nfsd auth_rpcgss nfs_acl lockd grace dm_mod
sunrpc fuse configfs loop dax zram zsmalloc ext4 crc32c_generic crc16
mbcache jbd2 amdgpu video amdxcp i2c_algo_bit mfd_core drm_ttm_helper
ttm drm_exec gpu_sched sr_mod drm_suballoc_helper drm_buddy
drm_display_helper cdrom sd_mod hid_microsoft usbhid drm_kms_helper
ahci libahci pata_jmicron drm libata uhci_hcd xhci_pci ehci_pci
ehci_hcd scsi_mod xhci_hcd usbcore drm_panel_orientation_quirks cec
firewire_ohci crc32c_intel sha512_ssse3 rc_core sha256_ssse3 serio_raw
firewire_core sha1_ssse3 usb_common bsg crc_itu_t scsi_common wmi msr
[ 7743.659267] CR2: 0000000000000370
[ 7743.661287] ---[ end trace 0000000000000000 ]---
[ 7743.664605] RIP: 0010:mutex_lock+0x1e/0x2e
[ 7743.667406] Code: 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00
00 51 48 89 3c 24 2e 2e 2e 31 c0 31 c0 48 8b 3c 24 65 48 8b 14 25 40
c2 02 00 <f0> 48 0f b1 17 74 03 5a eb b9 58 c3 cc cc cc cc 90 90 90 90
90 90
[ 7743.684850] RSP: 0018:ffffc90004667e00 EFLAGS: 00010246
[ 7743.688767] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000810000d2
[ 7743.694592] RDX: ffff88805bf30e40 RSI: ffffffffa1bbd20d RDI: 0000000000000370
[ 7743.700415] RBP: 0000000000000370 R08: ffff8881144e2d70 R09: 00000000810000d2
[ 7743.706239] R10: 000000000000023e R11: 000000000000023e R12: ffff8881424039c0
[ 7743.712064] R13: dead000000000100 R14: ffff88826223a000 R15: ffff88826223a030
[ 7743.717897] FS:  0000000000000000(0000) GS:ffff888343d00000(0000)
knlGS:0000000000000000
[ 7743.724684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7743.729129] CR2: 0000000000000370 CR3: 000000000221a000 CR4: 00000000000006f0
[ 7743.734961] note: kworker/4:0[27870] exited with irqs disabled

I have no idea what the current status of the fix(?) is.

Cheers,
Chris

On Thu, 11 Apr 2024 at 12:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 11, 2024 at 11:38:36AM +0100, Chris Rankin wrote:
> > The SCSI sg driver oopsed on my 6.8.4 kernel, and I noticed that a
> > patch (presumably) to fix this was pulled from 6.8.5. However, I also
> > noticed this email:
>
> Was that a warning or a real crash?
>
> > >> Reverted this patch and I couldn't see the reposted warning.
> > >> scsi: sg: Avoid sg device teardown race
> > >> [ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]
> > >
> > > Fix is here:
> > >
> > > https://git.kernel.org/mkp/scsi/c/d4e655c49f47
> >
> > Is this unsuitable for 6.8.6 please?
>
> Is it in Linus's tree yet?
>
> thanks,
>
> greg k-h

