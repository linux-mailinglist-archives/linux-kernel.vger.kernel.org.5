Return-Path: <linux-kernel+bounces-40595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E983683E2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AECD1C2352E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E022F17;
	Fri, 26 Jan 2024 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="P7o5HwKN"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2922EF8;
	Fri, 26 Jan 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298939; cv=none; b=aHSVSolgwO5SViNc80vlY7IR6BFXhkFNvUg/raA6KeGt2V5NRNUSfc9vGdzKZ1PxnGipQM7bWnbUXQ3x7NA3s2BBwu/Q8hbwlA3Zg3/kgVii0O6B1MqUwgQJb1QcPL/h8qU3bV4UlAonIuxsXAtUW4CI4a/LkekQiNa3+891Le4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298939; c=relaxed/simple;
	bh=+npbQHZuZBd0gTA1lLyMDwpNWnMD0l2Ea23p7bvYMBU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CNH0/V7BHSOFWiLicixWjqEBXNGWnBL0DCszttVn5Le7Dm5VRHIscgAk3sI4e51p8NqMb4D/LFv/3axIl332Ikf8pmKykjIUXZGweFuj/BLL9t7cJxY8EZlQymMIqFhUWOdMPlFS2k1rXmv5qnUY5piMKbcxjxzpJA0KfmTuTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=P7o5HwKN; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1706298452;
	bh=+npbQHZuZBd0gTA1lLyMDwpNWnMD0l2Ea23p7bvYMBU=;
	h=Date:From:To:Subject:From;
	b=P7o5HwKNFO+kfvsL1sw4+yniPUjmqIu2HTGQ6gIAjOfpXdtsgEiGdWl8Vr1R0aV7d
	 7lmOAli/Rt3X99FdYa0x12uH1hf708rq00vR8sOa9I+Mdl89EkiNwUgaQdKGrAUXuy
	 dgDTRsvoD13EXaROiEqreobxlCS2iUTDJ9gcwdLB2N32yQ9WQ1Ap95+tQ2gBokvI/A
	 KlciJ8Zmh33fSDaiH558EduyMoq1gq8sStg31sFpePefAhGdgUM4506dWgmaSe2g/w
	 5n/E5C0HgxG64rgIIFcDxbxnxSNQ4/Nc9VQ8K9UzEsTgpZ7SvWvNiufvbwFPq4E2SO
	 r7G4eQL6oBtXw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AB97C34A;
	Fri, 26 Jan 2024 20:47:32 +0100 (CET)
Date: Fri, 26 Jan 2024 20:47:32 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: memcpy: detected field-spanning write (size 101) of single field
 "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2251
 (size 1)
Message-ID: <xebnh5c5rnfequ6khyhieugefrtt5mdftr6rsw522ocpg3yvln@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mluzsztmpjhpplhn"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--mluzsztmpjhpplhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have a Google Hana (mt8173-elm-hana.dts) laptop with Wi-Fi provided by
the mmc@11260000/mwifiex@1 device ("marvell,sd8897").

On 6.6.11 in the dmesg I see
[   41.314595] ------------[ cut here ]------------
[   41.314634] memcpy: detected field-spanning write (size 101) of single f=
ield "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:=
2251 (size 1)
[   41.314739] WARNING: CPU: 1 PID: 298 at drivers/net/wireless/marvell/mwi=
fiex/scan.c:2251 mwifiex_cmd_802_11_scan_ext+0xa8/0xb8 [mwifiex]
[   41.314802] Modules linked in: uvcvideo uvc videobuf2_vmalloc xhci_mtk_h=
cd xhci_hcd hid_multitouch joydev sbs_battery snd_soc_hdmi_codec btmrvl_sdi=
o evdev btmrvl crct10dif_ce bluetooth polyval_ce mwifiex_sdio polyval_gener=
ic sha2_ce sha256_arm64 mwifiex sha1_ce arm_smc_wdt mt8173_rt5650 ecdh_gene=
ric mt8173_afe_pcm snd_soc_rt5645 snd_soc_mtk_common snd_soc_rl6231 snd_soc=
_core snd_pcm_dmaengine snd_pcm snd_timer mtu3 snd ofpart udc_core spi_nor =
i2c_hid_of soundcore i2c_hid elan_i2c elants_i2c melfas_mip4 da9211_regulat=
or mt6577_auxadc spi_mt65xx gpio_keys ghash_generic ghash_ce gf128mul gcm a=
es_ce_ccm algif_aead crypto_null des_generic libdes ecb algif_skcipher aes_=
neon_blk aes_ce_blk aes_ce_cipher md4 cfg80211 algif_hash af_alg rfkill bin=
fmt_misc pkcs8_key_parser dm_mod loop efi_pstore dax configfs nfnetlink ip_=
tables x_tables autofs4
[   41.315059] CPU: 1 PID: 298 Comm: iwd Not tainted 6.6.11 #75=20
[   41.315072] Hardware name: Google Hana (DT)
[   41.315082] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   41.315096] pc : mwifiex_cmd_802_11_scan_ext+0xa8/0xb8 [mwifiex]
[   41.315132] lr : mwifiex_cmd_802_11_scan_ext+0xa4/0xb8 [mwifiex]
[   41.315169] sp : ffff800082e43620
[   41.315177] x29: ffff800082e43620 x28: 0000000000000000 x27: 00000000000=
00000
[   41.315196] x26: 0000000000000107 x25: 0000000000000001 x24: 00000000000=
00000
[   41.315213] x23: ffff0000cb4d3400 x22: ffff0000cb694000 x21: 00000000000=
00065
[   41.315230] x20: ffff0000cbc6e3c0 x19: ffff0000cb4d3400 x18: ffff8000815=
4d871
[   41.315248] x17: 0000000000000001 x16: ffffffffffffffff x15: 00000000000=
00004
[   41.315265] x14: ffff800081f1eee8 x13: 0000000000000003 x12: 00000000000=
00003
[   41.315283] x11: 0000000000000000 x10: 0000000000000027 x9 : bd143d0859b=
fb200
[   41.315300] x8 : bd143d0859bfb200 x7 : 205d343336343133 x6 : 332e3134202=
0205b
[   41.315318] x5 : ffff80008215d2ff x4 : ffff800082e431d7 x3 : 00000000000=
00000
[   41.315335] x2 : 0000000000000065 x1 : ffff800082e433d0 x0 : 00000000000=
00094
[   41.315353] Call trace:
[   41.315362]  mwifiex_cmd_802_11_scan_ext+0xa8/0xb8 [mwifiex]
[   41.315399]  mwifiex_sta_prepare_cmd+0x774/0x848 [mwifiex]
[   41.315435]  mwifiex_send_cmd+0x28c/0x300 [mwifiex]
[   41.315470]  mwifiex_scan_channel_list+0x294/0x348 [mwifiex]
[   41.315506]  mwifiex_scan_networks+0x1a4/0x3b8 [mwifiex]
[   41.315541]  mwifiex_cfg80211_scan+0x37c/0x850 [mwifiex]
[   41.315577]  cfg80211_scan+0x48/0x2d0 [cfg80211]
[   41.315734]  nl80211_trigger_scan+0x728/0x788 [cfg80211]
[   41.315836]  genl_family_rcv_msg_doit+0xc4/0x128
[   41.315855]  genl_rcv_msg+0x214/0x228
[   41.315868]  netlink_rcv_skb+0x128/0x148
[   41.315881]  genl_rcv+0x40/0x60
[   41.315893]  netlink_unicast+0x24c/0x400
[   41.315905]  netlink_sendmsg+0x2d8/0x3d8
[   41.315917]  __sys_sendto+0x16c/0x1f8
[   41.315931]  __arm64_sys_sendto+0x34/0x50
[   41.315944]  invoke_syscall+0x78/0x108
[   41.315959]  el0_svc_common+0x8c/0xf0
[   41.315972]  do_el0_svc+0x28/0x40
[   41.315984]  el0_svc+0x40/0xc8
[   41.315997]  el0t_64_sync_handler+0x90/0x100
[   41.316009]  el0t_64_sync+0x190/0x198
[   41.316021] ---[ end trace 0000000000000000 ]---

(With the line unchanged in ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7.)

I don't really know what the relevancy or meaning of this is,
but one has to assume a WARNING with a backtrace is never good,
so forwarding.

Best,

--mluzsztmpjhpplhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmW0DFEACgkQvP0LAY0m
WPFGHw//XnD9pn4PLO9yHjKSz8FVAkpgWOPK9NUe8dKdSvjoAF0cyzrhYcy04f6T
pTUeNGjxQss9yMKsJMMGAWaA8jo9u8CAeXocbOSdyN7BeYGwi2Ya7TJfH8xz8Y03
IsxXaiJJsKD/53Vkv5GGicT40Uv1tcI78j6dhpEpIjkWYZPLb8LZbBxmMkR2V9+j
5h2Muixny8ZJFE9Cr+xWh7xabVwYJrOYh7MroGQINEaDurXOB74cYiItM5OwGwTk
5L8VhO9MtUkz7wFgWwC1cl0SP0ZCuwVHIwzBZTzcJaFxGvMore1CoOQv939im7FR
16dD9P/SHgPT5/Lxm4UA9WX97YBAs2GXe7OARIwzMAHazpTfmfAXIQob0YInST4N
B0bvimBGFY/tBbd1FSZszwRAw7Qwxj7/7//pGmiS5At+i8l7Gza7tvAavjsb4HCQ
azpg5fnK9LFcoJQxS70vURlgRpnN505gqYbpK36GCMUuNtBzlFFmR7iXPWWi0OI/
vjhZZVDPG9Nsw9SctZlmhc5BtJN3HGVP78jbxiGnyDvFQx/QVmVICFg6DQ2UrarT
K7f2snMhA6YNhB+ttSyd5h9IrK6sL9SrwM5EBSDKNHsK1jt24AsrFy50NK8IJiN1
oAxiLFR0zTmLpjR552EkDbQx/3iTZb5O5kR5MnzQWLDtagTUapM=
=feCv
-----END PGP SIGNATURE-----

--mluzsztmpjhpplhn--

