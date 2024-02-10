Return-Path: <linux-kernel+bounces-60422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8288504AB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F27284110
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CC453E3C;
	Sat, 10 Feb 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="CLYuoMyR"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C836B02;
	Sat, 10 Feb 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574801; cv=none; b=qQDPje2GcMSi3HBQREyJBKgqRXWBMnGiZ6J7Ly2jMO7CqlLIca+wG4GoLZ+jfwYEhlKbPCnclqskIAzVeNPNnqAk7p/JYspR3KkOXtFkeeUSwXMdgCKkAmf++JTCO8SIsO+zxaLtKZTQ4qvGq4aV1V852jOvd5TnBUxxQNP1NBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574801; c=relaxed/simple;
	bh=QHEpmhKgjFPc76682sn4sIoMEGMcJgRjxAWR8n1DTeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvbYNebix/t0hDc80Ig/siiGOsfTbI5G8b4KT49twMFPCoQNnyS3INKWRaHC/ybPUGbCfmpK3rfzCId1GeMy7XoawjFzj75lHwUHMSMYuuHVS1TAKl2d4c+95ERDOIq+XWfWyxx3horuwwbbAXcW4sfxMvFjet6xRcFUDC80gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=CLYuoMyR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707574768; x=1708179568; i=erick.archer@gmx.com;
	bh=QHEpmhKgjFPc76682sn4sIoMEGMcJgRjxAWR8n1DTeo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=CLYuoMyR/RfpN1p89s4CKg+E1TB8++6l2iGF2gXvnfMLbE9b6PMz9cd5qyfXvSoM
	 LPQHJpXWyckAizctYuZhkFyakdBMG/I7a9DmSRe0tF/0b7WNguKne88f7j/KCte3F
	 K4MRd7LRL4DvnLGDvkTCU7TGBV1Q+yNcdO+R6BUancgCipkanPVP2A19nB/NiIflm
	 bUXRyvr+amviLy1ui9nOtpmE/RS6NFzEkO7B5md3jJtsyhIHpgNcDbkixk+pmSOup
	 gEzlkhqSoHn17evvCwaEg2zGlwXzpf8C4HelCdGUnEB6oZGlTB7H+fCyp4ONfFxw9
	 sxlZMwMM86q9H6GQMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MtfJX-1qiDsO3GNL-00vA8E; Sat, 10 Feb 2024 15:19:27 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] drm/xe: Prefer struct_size over open coded arithmetic
Date: Sat, 10 Feb 2024 15:19:12 +0100
Message-Id: <20240210141913.6611-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eah5uIlmx1Oy3vyLT4zwqfiQ5COrJpSQE4f6/oguSrE2kY86hdo
 QIjW/Bs/9Xo0Qm3o7B3tEM/5G1hyC3HQsuMpWJx4b/bdceZiEsEWP/KmpQj1NKIEdPx0G5q
 2eeEy4B3+Csbkv9p9lnZCZE+bd2cADA4HhKSh3suTuHxjpueSp6JUsHY9VUhIBjRrnXfh3t
 5GbhzX0HiER7+MDJiic/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IhzvHcuJC+E=;GHJKGjSsCANS54bqCQNxN/44ifo
 9bqCvzBCyyIV5AAQy8U8INvWJk97jyY8ZGzj7mZTzjWOuOt7smSagbXITxKv4geCA3XJVu4vE
 0hYsfu3sWvy3fCNwJ6s6QkBNQb1BTMGw9mwy3poECc1wxqSWYuf3A2VVqwpBlj8slxgsPgQgq
 syX6sEZDY3swhYf/zAN3socKGOStAUxhxAug7nOsrWmzKpJw/DqVVTEYPq3zH0WRlmTtRHLGA
 40Rx8L9wLQSnLQyZHuiMAsCXu4LCM5C+S7xIKwZiYPp/sedY8TnWkTGhhUuamhFaP7mQWSAFx
 gWIZblydoT47nujdxItHU4Pchxv21B3hn7DV9t2jo/MFke0/tfxG/YgnjFzHxlTcWJgMK/eRj
 r39nXPlktMP/WGhU9CFgt4RQIjX7+M9oh25lh8MsQG6yLNm/lD/FNsUY7eZ10c1tQYRK9Av6e
 DTUK7/fyJ1mvHCwAGegKsvH4UjIIAw0cNeuXA5CKV1V24aCR94301qCEqn5Of6CSu+ZlCqx1e
 Hc8YLjCL6tR8k/xpWHgnbxdWAw+PQXqfj1BMY9G5Cec/Y8eNrTC31fwJne/V5i2C4u3+PpI/I
 y50J6IUjptVJVwlPulFqoOITs9Qy31YppK2J1pfXkAoC4rRNXMd0nmBFZmF8wP90h9gWAuh3F
 JIM9kAh9YMRL2r//CFBoB5tqqf7+66erb4WC+idlctJvqdFrqlKSYFdgq30bl5RIpAGiOeKUA
 Ns8GvXUrIin1O4SSgzRz2gaESJgvPZYFO+dlQOC78cvP5N7jlsHPru14iWXSwJsGTxUbh/AYI
 1Th85XbchPMIC00qz2yCW+fCe/5ZJux9ejnMRssskIR/0=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

As the "q" variable is a pointer to "struct xe_exec_queue" and this
structure ends in a flexible array:

struct xe_exec_queue {
	[...]
	struct xe_lrc lrc[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the argument "size + size * count" in the
kzalloc() function.

This way, the code is more readable and more safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/gpu/drm/xe/xe_exec_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_ex=
ec_queue.c
index bcfc4127c7c5..f4e53cbccd04 100644
=2D-- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -44,7 +44,7 @@ static struct xe_exec_queue *__xe_exec_queue_create(stru=
ct xe_device *xe,
 	/* only kernel queues can be permanent */
 	XE_WARN_ON((flags & EXEC_QUEUE_FLAG_PERMANENT) && !(flags & EXEC_QUEUE_F=
LAG_KERNEL));

-	q =3D kzalloc(sizeof(*q) + sizeof(struct xe_lrc) * width, GFP_KERNEL);
+	q =3D kzalloc(struct_size(q, lrc, width), GFP_KERNEL);
 	if (!q)
 		return ERR_PTR(-ENOMEM);

=2D-
2.25.1


