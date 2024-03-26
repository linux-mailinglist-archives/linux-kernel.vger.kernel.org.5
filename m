Return-Path: <linux-kernel+bounces-119439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9E288C8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1473051DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829E13C9D3;
	Tue, 26 Mar 2024 16:19:03 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EF13C815;
	Tue, 26 Mar 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469942; cv=none; b=JExfJiNYGxgOk1ExSpJKNv0/uvYJKkWsm4NpebNQW9b7m6PXP3FhcXujmhXEWaPn6287U/wuFkVv8VbCqOXH58tzCHqaPnc1g5QyYb5Q7A38HDK5mNkCG3ImPOBxpNI8O57kg1DoXm6A2h/CwYAtsy9iofpWOu6dw1nrUawRgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469942; c=relaxed/simple;
	bh=S3l1dZyZnQC7nwH1O/0scw5bzhAI9A79lxA/h5x0VvI=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=j7Ypx9QRriCIcIhO5ccnl9YC5IOw/g5QDqW6fJp3RONCbxeXJmO+w+uQ/pqkR4D0enrQGW18XNCO+efH0cP23y+cZ5DB3TrH5k6zskZo265f4I9YlDqEA4h58wI2HFqn20J9wV3JB/Sf7lg3OCASzwRq8JvnXssxnwzUS3oqCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007732E.000000006602F56D.0023D3A1; Tue, 26 Mar 2024 17:18:53 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 0/4] ALSA: hda/tas2781: fixes for 6.9-rc1
Date: Tue, 26 Mar 2024 17:18:44 +0100
Message-ID: <cover.1711469583.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Hi,

This series removes the no longer needed digital gain kcontrol, which 
caused problems in tas2563, because the register does not exists there.

This series also adds locking and debug statements to the other 
kcontrols. They sometimes ran in parallel with tasdev_fw_ready, and 
caused weird sound problems.
https://github.com/tomsom/yoga-linux/issues/58

Regards,
Gergo

Changes in v2:
 - Do not remove dvc_tlv scale from tas2781-tlv.h as it is also used by
   sound/soc/codecs/tas2781-i2c.c
 - Add kcontrol name to debug statements
 - Add a new patch to remove a useless debug statement.

[1]: https://lore.kernel.org/all/cover.1711401621.git.soyer@irl.hu/

Gergo Koteles (4):
  ALSA: hda/tas2781: remove digital gain kcontrol
  ALSA: hda/tas2781: add locks to kcontrols
  ALSA: hda/tas2781: add debug statements to kcontrols
  ALSA: hda/tas2781: remove useless dev_dbg from playback_hook

 sound/pci/hda/tas2781_hda_i2c.c | 118 +++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 41 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


