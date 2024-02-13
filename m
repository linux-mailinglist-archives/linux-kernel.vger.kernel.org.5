Return-Path: <linux-kernel+bounces-62774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6C85258F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F6289DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980221F5F6;
	Tue, 13 Feb 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BELHSyJh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FA1DFFC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785475; cv=none; b=jNI3YtU7c4dnmfINYH9+a3X18OSCGMY0ZiUsA1XaghjLvK06mm4LAIqa7NTzYh4Gu7tKskIQO1Z5lLfFKvuDZNC/ON+0QoHEmwr2HhUFDrENdUgoM4Txrs3G42YtylhOXC5E4UP2rMiB7PYUFs37KPfcedGqbOn9UubDgZWdECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785475; c=relaxed/simple;
	bh=ey7reqdyEMdyt0U+wc6isCd5i2G3QaAEjU6W+bXRcdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k/4Run20+/QE1lWCOH26a5Ld+glfbRohyIi+53TDIVgnw2AGKHfEsk7IWuakYjseFcvEM6nk4KV+L1/UETjeWxmtDaDDEw76/X39SXVxg/l6OdHm0p8wGPQmDGJU4KoPW9DwyQWAib/F5FzzUaS+UB2WvFAtD1iVhKlfzMN93Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BELHSyJh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707785454; x=1708390254; i=w_armin@gmx.de;
	bh=ey7reqdyEMdyt0U+wc6isCd5i2G3QaAEjU6W+bXRcdM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=BELHSyJhEmz3uAJ55HzjRL1FY6oYkh5fSPAP4VrjPTwQiIHWxjzBGiH7zNjhIX5M
	 o1hL7CaND0ByRF5MC4FhkV7cuRHatvZe/wJP4N5+RQ2/TrCgqo1GAbHOBi4BgzYFj
	 EM/J+Lc3rrUAXj+bCT1Q5OYyztmUvK/420LcOJvX/72Yi0DYFuh64G/2iS5w6ckJK
	 NL7V1J/EiOu9wuwe3g4J/5wFss7Glpqspx4oBFayqscxnAlTGTivKqB2Qz/IY9Ldd
	 Sngu3fskSSSRCVRd/KmthbvIgM/O7XKk1ZK6hNZwMvfZn5cLUr5yUYnZ4c0TeANaP
	 /+qE2jxK9wf0YEJ1zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MryT9-1rEsNn2fbh-00nvoP; Tue, 13 Feb 2024 01:50:54 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix memory leak in dm_sw_fini()
Date: Tue, 13 Feb 2024 01:50:50 +0100
Message-Id: <20240213005050.4442-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:txK5GIP1CJKI2+qnEyUyucXhG2X+JRy/QYC3OoT7DjNOn2mydAp
 M5bHds0vbZWQFEiZccqvIGQ3d8NxzQxJV4kmpqIyjK2KJc5MKQLebUpgnQhoPazXAiYhRqV
 nYnD1BztfPyXVTHvnuc70xzX0L0mzh0UqcoRy/77BAzaf+yU0IeFE//r5PdBiaccRI9j5Hg
 wnM+ChIcuLfQACJilY3eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9GILGb7t888=;Xkv/X0SRY9RV0DtgulGZhg+N60c
 kXd80iCFIP+MnX0QRtvOj4FK9592oNVlPshqD5jaOXnN8jbNWNQEr/xLMEuOICuMb2fECsOLM
 tJ5yE0LrTqakgngNZQvPs6/9PuFOiu6thEEkvjibkrsz1ETv2wNYT3diL1B0Qj+UkTT+OLRG5
 gwDl/6cT0y0aztnY6IRv/Ej9v3jAgCo6sdyrSSwGjRaDDXQz1VFwAotYPPH/LTLQ+YmgXMdhf
 OrrYOPkPIMZBOlQJgGzOCgJvuApzQX8vTDf95Q00lAOgffjXHTHRMzrBtyBUCfQYuuFCWA7ma
 F2xW+rOTNXqAMdvDEUvZRt36aMDY4TCV/+ti/LWQucxcGgjIPD1z/UebXOgjqBHyLiJL1+Rkf
 UyAOLsIS9PGF3Bfx42mBDd6hUDA9Xl9lS59Yqy8Tnwt4MbCAZooxrATzx5fHeqtCvSd/IKe9u
 qG/RBwq03VAQr7vCuzjY8bbBg0xUSe40/ztv4ucFgaT51BRPS6m1m7EbaWqFuljHGUG/rJBrd
 uPfSrB4I0DpPmoeGCqtlzvTBGE6/TQ31Uyd+zMelQC8BXrdJFuICXLGw8Bw+R8cr7LWO48QSu
 WVZWsSdl2Qv26NwrgnON5Fk33QvA+DOj0rGiaYwKmiXyBJ+/UqeC4BU5XmSJG+FtZzZ8xaoSo
 bEt3ytnMnqACCOjeWkyFsetBWrHPqtsBZ8X7Xte33QQk85epyVvuegcHi8s+qFH5hGkU8MHSO
 P14oiseodVgV23otrKGBzohb/hxBimX7xthiqndXcq1/pPIcX+PEilgJqo4t8eDp0AHjvSq+r
 /ZLxVojYaO7l6KnAI8ZbfUbFtDLJq2vS65vae9WW6giGA=

After destroying dmub_srv, the memory associated with it is
not freed, causing a memory leak:

unreferenced object 0xffff896302b45800 (size 1024):
  comm "(udev-worker)", pid 222, jiffies 4294894636
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 6265fd77):
    [<ffffffff993495ed>] kmalloc_trace+0x29d/0x340
    [<ffffffffc0ea4a94>] dm_dmub_sw_init+0xb4/0x450 [amdgpu]
    [<ffffffffc0ea4e55>] dm_sw_init+0x15/0x2b0 [amdgpu]
    [<ffffffffc0ba8557>] amdgpu_device_init+0x1417/0x24e0 [amdgpu]
    [<ffffffffc0bab285>] amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
    [<ffffffffc0ba09c7>] amdgpu_pci_probe+0x187/0x4e0 [amdgpu]
    [<ffffffff9968fd1e>] local_pci_probe+0x3e/0x90
    [<ffffffff996918a3>] pci_device_probe+0xc3/0x230
    [<ffffffff99805872>] really_probe+0xe2/0x480
    [<ffffffff99805c98>] __driver_probe_device+0x78/0x160
    [<ffffffff99805daf>] driver_probe_device+0x1f/0x90
    [<ffffffff9980601e>] __driver_attach+0xce/0x1c0
    [<ffffffff99803170>] bus_for_each_dev+0x70/0xc0
    [<ffffffff99804822>] bus_add_driver+0x112/0x210
    [<ffffffff99807245>] driver_register+0x55/0x100
    [<ffffffff990012d1>] do_one_initcall+0x41/0x300

Fix this by freeing dmub_srv after destroying it.

Fixes: 743b9786b14a ("drm/amd/display: Hook up the DMUB service in DM")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 59d2eee72a32..9cbfc8d39dee 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2287,6 +2287,7 @@ static int dm_sw_fini(void *handle)

 	if (adev->dm.dmub_srv) {
 		dmub_srv_destroy(adev->dm.dmub_srv);
+		kfree(adev->dm.dmub_srv);
 		adev->dm.dmub_srv =3D NULL;
 	}

=2D-
2.39.2


