Return-Path: <linux-kernel+bounces-84625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DB86A924
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133031F24ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C5250FD;
	Wed, 28 Feb 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PqujgYET"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2CD24B41
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106141; cv=none; b=MOLG1UGLTevFiMTe9keRDWA5mUl6eLFYJWzaXOQug44CdyxvJYywOgkcU6Gi3WfG2AaWRrI9gf9A17sra48hpbLWd5K7VXd0NDFqGn4cYCI0Z4muFC7ClguNsoaVZAY96GJ12dDdnNQie8Ub3ToAUL3RU3Osb6hMs5/Rh2eAivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106141; c=relaxed/simple;
	bh=u84TQ2oYytZsBuH/zcjVZljLTWPVxv1MJltl+gVYCDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jGQ84iyMznqDJH+59ZQJth1Fo/Hd4J4gayLTh/VfRaDUQkVWA1xJQUteamJqaCq7SRH80rjKU7e0aXyePpYG5AIUEjdVVO+ZxRmcJoZ8sd8g4+jq4UECMuLreHpuENLk3HNijeELmrH5QDRO4hWshtVB2MQWsparJOpJ75dYWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PqujgYET; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ZJ1CeXr5L+70RmndFbrJnevySNkuujkOo+h0+Lv9h0U=;
	b=PqujgYETxj5f7eV9lUrTkoUzayo9LMbSPGWyHOPRvIQDbxPQP1lCJA5gQGeIjU
	mOrersbX7qIPd8kNbxGZqZSDU/ToKHAHBMu7JpoBQxo7DOOjQjVwUS6OiOfXdzVV
	6qq1pkk5xVjb1OQgQlXgMK8qxTXJ45WlpwEL3srKXnuWs=
Received: from localhost.localdomain (unknown [111.48.58.12])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDH7ou1495l4CPFFQ--.17527S2;
	Wed, 28 Feb 2024 15:41:41 +0800 (CST)
From: songxiebing <soxiebing@163.com>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>
Subject: [PATCH v1] ALSA: hda: optimize the probe codec process
Date: Wed, 28 Feb 2024 15:41:38 +0800
Message-Id: <20240228074138.23679-1-soxiebing@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH7ou1495l4CPFFQ--.17527S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Jr4UAFW7Ar1UJrWxtFb_yoW8Kr1Up3
	W3Cr1fG3yxtF4akFs7Gw43Ka4xWa4kXan8Jw4Yyw13Xwn3Kr1fXr9YyrW8AFW8Cr429r1Y
	vw4UK3WkX3s8CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0iifUUUUU=
X-CM-SenderInfo: 5vr0xvpelqwqqrwthudrp/xtbB0BqSw2WXwG99aQAAsS

From: songxiebing <songxiebing@kylinos.cn>

In azx_probe_codecs function，when bus->codec_mask is becomes to 0(no codecs),
execute azx_init_chip, bus->codec_mask will be initialized to a value again，
this causes snd_hda_codec_new function to run, the process is as follows:
-->snd_hda_codec_new
-->snd_hda_codec_device_init
-->snd_hdac_device_init---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_VENDOR_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_SUBSYSTEM_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_REV_ID) 2s
		       ---snd_hdac_read_parm(...AC_PAR_NODE_COUNT) 2s
when no codecs, read communication is error, each command will be polled for
2 second，a total of 10s, it is easy to some problem.
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


