Return-Path: <linux-kernel+bounces-139260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDB8A00A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D21F24E27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C0E18130E;
	Wed, 10 Apr 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qm5dqFwr"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F5181326;
	Wed, 10 Apr 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777541; cv=none; b=k+L7DJgH7353LB+2ctyYBmZRVnHT3X2DM+HM+TmL+R/Upr0HmW2YnbIVuqO8U1EB8pGv5oeRpD4jivPqJesd6Uz/O3SUQpU92c0KO/v52lTjHTW8hYlKEhmZTMYStrrCWDPp5fSDWltq527DzI2ObowGUVjjUo8I7tinVrYgogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777541; c=relaxed/simple;
	bh=IzeZ91SeHcwYDVn7roxFUtb7k/ofYflkvi3yePDZrjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PPM78CvcoFXMTbiCctEPQeCTiLaRdS4Yrga//nIHVZ3x9OP8YdDjT0UZqzKpfuUnTlwVqzJuJ06um54VJ+bil/gAMxWfFMDYpjEVROarPiI3qDYL1NVqfDTInOk4+OvtlZ5Sp+hrAgMlkwfswATQVifgsDuPxNlGK/qI60nHnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qm5dqFwr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0BBX8iMUSXRdpsV82ttXRAZ6Ck4RcdoUOX+ysmUXY0k=; b=qm5dqFwrDGxZqyleS41qEmPLWb
	u+TR1oOxVeUL7b4lTQX0NUUeHmFyJC+23gUADtEkbKhpignxkLlgeGeOZ50Z1zR2irZjxYsiUK9ta
	lC70GjpvfnhYkJtyYmJUU0/QpdP98hrFCHqGoIgLCN+c60YrNxLj+Wk6tIX8imLVu6hfG/1BNhrNV
	rqaXIjHR5wK5obWtZY4uBm3c99wKbX93O7tBQUoGtwPxrPk9nu1vHaKiBlSJrDBp6HwFpB+wkHcbZ
	8/xstvycuTbUP66rqXPlyD6ijR4l+0NloAG/sLJpAtXFRLBfd4qTS+peEDJVESsSxT3SFFxE+oH09
	0+IfDw1w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <kibi@debian.org>)
	id 1rudg2-001DxX-1F; Wed, 10 Apr 2024 19:32:10 +0000
Date: Wed, 10 Apr 2024 21:32:07 +0200
From: Cyril Brulebois <kibi@debian.org>
To: regressions@lists.linux.dev, stable@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [REGRESSION] Loss of some SMART information in v6.1.81
Message-ID: <20240410193207.qnb75osxuk4ovvm6@mraw.org>
Organization: Debian
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="olzcwrbws5uz2dte"
Content-Disposition: inline
X-Debian-User: kibi


--olzcwrbws5uz2dte
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Munin uses the following command to get sensor-type information out of
SMART-aware disks (e.g. temperature):

    /usr/sbin/smartctl -A --nocheck=3Dstandby -d ata /dev/sda

This broke following an upgrade from v6.1.76 (as found in Debian 12) to
v6.1.82 (as currently found in the proposed-updates repository for the
next point release of Debian 12), with smartctl's now reporting:

    smartctl 7.3 2022-02-28 r5338 [x86_64-linux-6.1.0-19-amd64] (local buil=
d)
    Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools=
=2Eorg
   =20
    Device is in SLEEP mode, exit(2)

This happens on baremetal with 2 pairs of disks:
 - 2=C3=97ST4000VN008-2DR1 (sda, sdb)
 - 2=C3=97ST8000VN004-2M21 (sdc, sdd)

and that's an obvious lie with one pair doing system stuff and the other
one doing media stuff.

This also happens within a Debian 12 QEMU VM running on a Debian 12
libvirt host, when using a SATA disk, which is what I've used to test
various builds from the stable/linux-6.1.y branch and associated tags.

Building stable releases, I pinpointed it as a regression between
v6.1.80 and v6.1.81, then pinpointed it to commit cf33e6ca12d8.

#regzbot introduced: v6.1.80..v6.1.81
#regzbot introduced: cf33e6ca12d8

This is also affecting v6.1.84 and v6.1.85 (released during my git
bisect session).

Reported in Debian via: https://bugs.debian.org/1068675 (which included
a trace with the distribution-provided v6.1.82 package).

Most recent trace, with v6.1.85 (mainline, using the distribution's
config but without any patches):

    [   30.547027] ------------[ cut here ]------------
    [   30.547034] WARNING: CPU: 0 PID: 697 at drivers/scsi/scsi_lib.c:214 =
scsi_execute_cmd+0x42/0x2c0 [scsi_mod]
    [   30.547082] Modules linked in: tls tun intel_rapl_msr intel_rapl_com=
mon kvm_intel kvm irqbypass ghash_clmulni_intel sha512_ssse3 sha512_generic=
 sha256_ssse3 sha1_ssse3 snd_hda_codec_generic ledtrig_audio snd_hda_intel =
snd_intel_dspcfg snd_intel_sdw_acpi aesni_intel snd_hda_codec crypto_simd c=
ryptd rapl snd_hda_core snd_hwdep bochs drm_vram_helper pcspkr drm_ttm_help=
er snd_pcm iTCO_wdt snd_timer intel_pmc_bxt ttm iTCO_vendor_support snd wat=
chdog soundcore virtio_console virtio_balloon drm_kms_helper button joydev =
evdev serio_raw sg binfmt_misc fuse loop drm efi_pstore dm_mod configfs qem=
u_fw_cfg virtio_rng ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mb=
cache jbd2 hid_generic usbhid hid sd_mod t10_pi crc64_rocksoft crc64 crc_t1=
0dif crct10dif_generic ahci libahci virtio_scsi virtio_blk virtio_net net_f=
ailover failover xhci_pci crct10dif_pclmul crct10dif_common crc32_pclmul li=
bata crc32c_intel xhci_hcd psmouse i2c_i801 i2c_smbus scsi_mod scsi_common =
lpc_ich virtio_pci
    [   30.547194]  virtio_pci_legacy_dev virtio_pci_modern_dev usbcore usb=
_common virtio virtio_ring
    [   30.547205] CPU: 0 PID: 697 Comm: smartctl Not tainted 6.1.85 #1
    [   30.547210] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-debian-1.16.2-1 04/01/2014
    [   30.547217] RIP: 0010:scsi_execute_cmd+0x42/0x2c0 [scsi_mod]
    [   30.547247] Code: 55 48 89 fd 53 48 83 ec 10 4c 8b 64 24 50 48 89 0c=
 24 4d 85 e4 0f 84 02 02 00 00 49 83 3c 24 00 74 24 41 83 7c 24 08 60 74 1c=
 <0f> 0b bd ea ff ff ff 48 83 c4 10 89 e8 5b 5d 41 5c 41 5d 41 5e 41
    [   30.547251] RSP: 0018:ffffa70f80defbd0 EFLAGS: 00010287
    [   30.547256] RAX: ffffa70f80defc30 RBX: ffff9ab18b085000 RCX: 0000000=
000000000
    [   30.547259] RDX: 0000000000000022 RSI: 0000000000000022 RDI: ffff9ab=
18b085000
    [   30.547262] RBP: ffff9ab18b085000 R08: 0000000000000000 R09: 0000000=
0000009c4
    [   30.547265] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa70=
f80defc30
    [   30.547268] R13: 0000000000000000 R14: 00000000000009c4 R15: ffffa70=
f80defc60
    [   30.547271] FS:  00007f8ee64ad840(0000) GS:ffff9ab1bec00000(0000) kn=
lGS:0000000000000000
    [   30.547275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   30.547278] CR2: 00007fff08df0bc0 CR3: 000000000439a003 CR4: 0000000=
000170ef0
    [   30.547291] Call Trace:
    [   30.547296]  <TASK>
    [   30.547301]  ? __warn+0x7d/0xc0
    [   30.547308]  ? scsi_execute_cmd+0x42/0x2c0 [scsi_mod]
    [   30.547338]  ? report_bug+0xe2/0x150
    [   30.547348]  ? handle_bug+0x41/0x70
    [   30.547354]  ? exc_invalid_op+0x13/0x60
    [   30.547358]  ? asm_exc_invalid_op+0x16/0x20
    [   30.547368]  ? scsi_execute_cmd+0x42/0x2c0 [scsi_mod]
    [   30.547397]  ata_cmd_ioctl+0x144/0x2f0 [libata]
    [   30.547448]  scsi_ioctl+0x3f5/0x930 [scsi_mod]
    [   30.547477]  ? scsi_block_when_processing_errors+0x22/0x100 [scsi_mo=
d]
    [   30.547503]  ? __mod_lruvec_page_state+0x93/0x140
    [   30.547508]  ? scsi_ioctl_block_when_processing_errors+0x45/0x50 [sc=
si_mod]
    [   30.547535]  blkdev_ioctl+0x133/0x270
    [   30.547553]  __x64_sys_ioctl+0x90/0xd0
    [   30.547564]  do_syscall_64+0x55/0xb0
    [   30.547574]  ? handle_mm_fault+0xdb/0x2d0
    [   30.547582]  ? do_user_addr_fault+0x1b0/0x580
    [   30.547589]  ? exit_to_user_mode_prepare+0x40/0x1e0
    [   30.547596]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
    [   30.547608] RIP: 0033:0x7f8ee611cc5b
    [   30.547617] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05=
 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
    [   30.547621] RSP: 002b:00007fff08df0960 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
    [   30.547626] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f8=
ee611cc5b
    [   30.547629] RDX: 00007fff08df0bc0 RSI: 000000000000031f RDI: 0000000=
000000003
    [   30.547632] RBP: 00007fff08df1040 R08: 0000000000000000 R09: 0000000=
000000000
    [   30.547634] R10: e7e85eefeeee1b19 R11: 0000000000000246 R12: 0000563=
48ba28600
    [   30.547637] R13: 00007fff08df0bc0 R14: 00007fff08df12e0 R15: 0000000=
000000000
    [   30.547642]  </TASK>
    [   30.547644] ---[ end trace 0000000000000000 ]---


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--olzcwrbws5uz2dte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmYW6TcACgkQ/5FK8MKz
VSAF/BAAgBhVmR/cWgdQrMfSqXfl/68i+1kDNjIPNTy3HD5jsEApqiW3AsFV+sIP
4pRws5bM0nz5RDQOf+0Pa/33hF03nDUd+qrz/wRNGFVUXGl0w0Gbmv/kc45oQZXZ
i0J02RcWC83G/MKAERzgEv0/iEyUNRZXFcVQ2+KdOZyKysDczsw9bg3O1WLgK48R
B8W0EM4GVv7aVXYjzTWBlPr8TjIAJDUioreRA2OLTTj1nMhCEos/SlqU+5U6nUfo
O6WoEBuBG7kS5+doKsIfoqQ6W78ly21Sgf8gksVEhFBUzz/Iscj3CIMySDhZXxFw
EQEuBPa67BN8pt06b0+kKSzmyA4EkpiJAsXrKhz3XCMVF+fMYNnS/6pVQ2jNiH/b
OV3lbu8uuWg2YKJOaV8oQoKBgr5862smmJCFOVJLlulynuU1kkl/S3Lp7rf0rlTC
hCdWd6nFwCQSXaEJQOnW3vcRD4XuF6Z30HZaaS8rhA5UBJaebThn3fHjlwVoLlNP
9BTLuiqNG5VbVvtXcUxW5kUd+7DKbntBksTNTDMx6re0RHmngpOBj2Lk8n3xNqXn
1KzmxtO7ZoN+QWXLfGxfT43w+B5UoHOWD64q8wClKCWhfZbaU4R/Be8zvTn00mKX
eDlRS3hZTjIFu32iVnyhBGxKQplnXr/3FGnlXr57Bsybj3Wz9Y8=
=OtOw
-----END PGP SIGNATURE-----

--olzcwrbws5uz2dte--

