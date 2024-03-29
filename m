Return-Path: <linux-kernel+bounces-124885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AEE891D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B151C1F22496
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E514AD16;
	Fri, 29 Mar 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfEkDg5d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8D13B2AB;
	Fri, 29 Mar 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716366; cv=none; b=mJIzOODxpabyExfWBbAeYuZTnc5q+B9ZQdgIS1GCnuZ8T12Sf8hGjCW4N2OxsAZ8jILvgbzZTcj7wMqxVqrjTA9sWMsOlLGvr/eMBIa7J5PiIozU0MT0B/evxV/I8BV0HqB+8/Mme0mGsK+JayfoIug421GVt255870i+gyRpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716366; c=relaxed/simple;
	bh=Wvy/buyETZPHPs421ciUfN+W1lK7MVfN/gcP4Xfgf9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KoCbZbkpCtpmMTbFFj1sF9IUm9FhEvfbRle663OeGRKANu57W/h7AR0BMogEPpr/0deOjt7zM6j+bg2Krbbq1M8NqhwxsRbfQDJ34OCgS9Y0+qq/nyfgB4oIIjfPVvu3+8lJGi6nrkGIjEz6kldfoAXRuWvPsIFJ/nhk2GlnrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfEkDg5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F39EC433F1;
	Fri, 29 Mar 2024 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716366;
	bh=Wvy/buyETZPHPs421ciUfN+W1lK7MVfN/gcP4Xfgf9A=;
	h=From:To:Cc:Subject:Date:From;
	b=dfEkDg5d5m+2yAPlwDymCNrkmVV60ca4pjZvL8HQYA08/AN/ElvR2g0Ij185yK0Kt
	 YqLfSk5u+UTUrs/LPDSMHg3JRyWImchGC0pfAwOWl5CtaDfgv7uzady0qUvTuLl4ek
	 suRrw7irpJT8GUyLSnMdmOLkx1w9kPP8lZaX1teXrQLnyXfp3tgCifyjDGZGGqE7UH
	 g/+C1enPORVNKKrFKz2AMYGTSb0GqhhdFXHQXMqUMveopkAzAagjO/E4bj3bKl955b
	 ckBGZVxSzXNJVOg6vr+WBLH0sGSJWOI4sNOZMoMAIMUu07VIhI6ddp0Pj8X17+HMV7
	 qG8Hug5aLX0vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 01/52] drm/vc4: don't check if plane->state->fb == state->fb
Date: Fri, 29 Mar 2024 08:44:55 -0400
Message-ID: <20240329124605.3091273-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 5ee0d47dcf33efd8950b347dcf4d20bab12a3fa9 ]

Currently, when using non-blocking commits, we can see the following
kernel warning:

[  110.908514] ------------[ cut here ]------------
[  110.908529] refcount_t: underflow; use-after-free.
[  110.908620] WARNING: CPU: 0 PID: 1866 at lib/refcount.c:87 refcount_dec_not_one+0xb8/0xc0
[  110.908664] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device cmac algif_hash aes_arm64 aes_generic algif_skcipher af_alg bnep hid_logitech_hidpp vc4 brcmfmac hci_uart btbcm brcmutil bluetooth snd_soc_hdmi_codec cfg80211 cec drm_display_helper drm_dma_helper drm_kms_helper snd_soc_core snd_compress snd_pcm_dmaengine fb_sys_fops sysimgblt syscopyarea sysfillrect raspberrypi_hwmon ecdh_generic ecc rfkill libaes i2c_bcm2835 binfmt_misc joydev snd_bcm2835(C) bcm2835_codec(C) bcm2835_isp(C) v4l2_mem2mem videobuf2_dma_contig snd_pcm bcm2835_v4l2(C) raspberrypi_gpiomem bcm2835_mmal_vchiq(C) videobuf2_v4l2 snd_timer videobuf2_vmalloc videobuf2_memops videobuf2_common snd videodev vc_sm_cma(C) mc hid_logitech_dj uio_pdrv_genirq uio i2c_dev drm fuse dm_mod drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
[  110.909086] CPU: 0 PID: 1866 Comm: kodi.bin Tainted: G         C         6.1.66-v8+ #32
[  110.909104] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
[  110.909114] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  110.909132] pc : refcount_dec_not_one+0xb8/0xc0
[  110.909152] lr : refcount_dec_not_one+0xb4/0xc0
[  110.909170] sp : ffffffc00913b9c0
[  110.909177] x29: ffffffc00913b9c0 x28: 000000556969bbb0 x27: 000000556990df60
[  110.909205] x26: 0000000000000002 x25: 0000000000000004 x24: ffffff8004448480
[  110.909230] x23: ffffff800570b500 x22: ffffff802e03a7bc x21: ffffffecfca68c78
[  110.909257] x20: ffffff8002b42000 x19: ffffff802e03a600 x18: 0000000000000000
[  110.909283] x17: 0000000000000011 x16: ffffffffffffffff x15: 0000000000000004
[  110.909308] x14: 0000000000000fff x13: ffffffed577e47e0 x12: 0000000000000003
[  110.909333] x11: 0000000000000000 x10: 0000000000000027 x9 : c912d0d083728c00
[  110.909359] x8 : c912d0d083728c00 x7 : 65646e75203a745f x6 : 746e756f63666572
[  110.909384] x5 : ffffffed579f62ee x4 : ffffffed579eb01e x3 : 0000000000000000
[  110.909409] x2 : 0000000000000000 x1 : ffffffc00913b750 x0 : 0000000000000001
[  110.909434] Call trace:
[  110.909441]  refcount_dec_not_one+0xb8/0xc0
[  110.909461]  vc4_bo_dec_usecnt+0x4c/0x1b0 [vc4]
[  110.909903]  vc4_cleanup_fb+0x44/0x50 [vc4]
[  110.910315]  drm_atomic_helper_cleanup_planes+0x88/0xa4 [drm_kms_helper]
[  110.910669]  vc4_atomic_commit_tail+0x390/0x9dc [vc4]
[  110.911079]  commit_tail+0xb0/0x164 [drm_kms_helper]
[  110.911397]  drm_atomic_helper_commit+0x1d0/0x1f0 [drm_kms_helper]
[  110.911716]  drm_atomic_commit+0xb0/0xdc [drm]
[  110.912569]  drm_mode_atomic_ioctl+0x348/0x4b8 [drm]
[  110.913330]  drm_ioctl_kernel+0xec/0x15c [drm]
[  110.914091]  drm_ioctl+0x24c/0x3b0 [drm]
[  110.914850]  __arm64_sys_ioctl+0x9c/0xd4
[  110.914873]  invoke_syscall+0x4c/0x114
[  110.914897]  el0_svc_common+0xd0/0x118
[  110.914917]  do_el0_svc+0x38/0xd0
[  110.914936]  el0_svc+0x30/0x8c
[  110.914958]  el0t_64_sync_handler+0x84/0xf0
[  110.914979]  el0t_64_sync+0x18c/0x190
[  110.914996] ---[ end trace 0000000000000000 ]---

This happens because, although `prepare_fb` and `cleanup_fb` are
perfectly balanced, we cannot guarantee consistency in the check
plane->state->fb == state->fb. This means that sometimes we can increase
the refcount in `prepare_fb` and don't decrease it in `cleanup_fb`. The
opposite can also be true.

In fact, the struct drm_plane .state shouldn't be accessed directly
but instead, the `drm_atomic_get_new_plane_state()` helper function should
be used. So, we could stick to this check, but using
`drm_atomic_get_new_plane_state()`. But actually, this check is not really
needed. We can increase and decrease the refcount symmetrically without
problems.

This is going to make the code more simple and consistent.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240105175908.242000-1-mcanal@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index eb08020154f30..7e6648b277b25 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1415,9 +1415,6 @@ static int vc4_prepare_fb(struct drm_plane *plane,
 
 	drm_gem_plane_helper_prepare_fb(plane, state);
 
-	if (plane->state->fb == state->fb)
-		return 0;
-
 	return vc4_bo_inc_usecnt(bo);
 }
 
@@ -1426,7 +1423,7 @@ static void vc4_cleanup_fb(struct drm_plane *plane,
 {
 	struct vc4_bo *bo;
 
-	if (plane->state->fb == state->fb || !state->fb)
+	if (!state->fb)
 		return;
 
 	bo = to_vc4_bo(&drm_fb_dma_get_gem_obj(state->fb, 0)->base);
-- 
2.43.0


