Return-Path: <linux-kernel+bounces-87765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C486D8AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30821F22F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A921837170;
	Fri,  1 Mar 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RYoHruyp"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD736118
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256026; cv=none; b=hf+RRND9G9LQeLQqC/kuhyeQsVIwnGTNCG202+m/qHUKKx+BP4ZyMyG0ivIUL7rBn+pjAndWZ8UsRLirSOZaW2xBilDUVCLcxa50V+izhSTNoASSpUnf8txtFYqiBOTw1XWv+fabvXYFOnsQ5BDsF4frT0/xh4kgzoC0yICvfog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256026; c=relaxed/simple;
	bh=0Qce3EgeLPkKjkHYKQFnccarXSgWI3VcDD+V67lSULE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EsjJYYuyhaWPCtFKeqDid28R/+zUn50r+pAJXas9oU0Ocke1mJuELiz4KfxIdNNzGD/Bbok30/xoFN9F07Eo+gkK35Z6JP7cB7cFoFeaxcFjBMOLg7msa8FsTQuHMK8uPM60JKGQVAU+NTXJUnNEFIqAkJoutwiQA7OYA6tzH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RYoHruyp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8eX63
	ggw/SlvICRxbqzBzag4pSVNVLQSaMXoM3yRais=; b=RYoHruypxU2y8XMLNwpfe
	x82VogKFQ52DfiQ8DY2anUkdfP78KsUwqx73O6sGczzQ/Fv6zuv7XIb/I7zRBMWr
	3RuR6RY72Rui/vcvrkeVGlzukpUiym0GYEK3F/12VWsbUbMelVwosdMOT+mSrhx+
	p/I57hKRFvYLYNlvy88co0=
Received: from localhost.localdomain (unknown [111.48.58.12])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wCHb57yLOFlXN+REw--.49146S2;
	Fri, 01 Mar 2024 09:18:43 +0800 (CST)
From: songxiebing <soxiebing@163.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	songxiebing@kylinos.cn,
	soxiebing@163.com,
	tiwai@suse.com
Subject: [PATCH v2] ALSA: hda: optimize the probe codec process
Date: Fri,  1 Mar 2024 09:18:41 +0800
Message-Id: <20240301011841.7247-1-soxiebing@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <878r35huf0.wl-tiwai@suse.de>
References: <878r35huf0.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHb57yLOFlXN+REw--.49146S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry7tFW5Kw43KFW5Cr1DGFg_yoW8KF18p3
	W7Cr1fGayxtF4akFs7Gw43Ka4xWa4vqan8Jw1Yyw13Zwn7Kr1fXr9YyrW8AFW8ur4I9r1Y
	vw4UK3WkX3s8CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piwIDrUUUUU=
X-CM-SenderInfo: 5vr0xvpelqwqqrwthudrp/1tbiJxaUw2XAkqqxxgAAsM

From: songxiebing <songxiebing@kylinos.cn>

In azx_probe_codecs function, when bus->codec_mask is becomes to 0(no codecs),
execute azx_init_chip, bus->codec_mask will be initialized to a value again,
this causes snd_hda_codec_new function to run, the process is as follows:
-->snd_hda_codec_new
-->snd_hda_codec_device_init
-->snd_hdac_device_init---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_SUBSYSTEM_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_REV_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_NODE_COUNT) 2s
when no codecs, read communication is error, each command will be polled for
2 second, a total of 10s, it is easy to some problem.
like this:
  2 [   14.833404][ 6] [  T164] hda 0006:00: Codec #0 probe error; disabling it...
  3 [   14.844178][ 6] [  T164] hda 0006:00: codec_mask = 0x1
  4 [   14.880532][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0000
  5 [   15.891988][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0000
  6 [   16.978090][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0001
  7 [   18.140895][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0002
  8 [   19.135516][ 6] [  T164] hda 0006:00: too slow response, last cmd=0x0f0004
 10 [   19.900086][ 6] [  T164] hda 0006:00: no codecs initialized
 11 [   45.573398][ 2] [    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [kworker/2:0:25]

Here, when bus->codec_mask is 0, use a direct break to avoid execute snd_hda_codec_new function.

Signed-off-by: songxiebing <songxiebing@kylinos.cn>
---
Changes in v2: fix some non-ASCII comma letters.
---
 sound/pci/hda/hda_controller.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index e5c53ad..e1ece0a 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1474,6 +1474,9 @@ int azx_probe_codecs(struct azx *chip, unsigned int max_slots)
 				dev_warn(chip->card->dev,
 					 "Codec #%d probe error; disabling it...\n", c);
 				bus->codec_mask &= ~(1 << c);
+				/* no codecs */
+				if (bus->codec_mask == 0)
+					break;
 				/* More badly, accessing to a non-existing
 				 * codec often screws up the controller chip,
 				 * and disturbs the further communications.
-- 
2.7.4


