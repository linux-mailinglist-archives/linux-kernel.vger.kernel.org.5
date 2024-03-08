Return-Path: <linux-kernel+bounces-97406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78954876A17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A5B1F21AD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C63FB9E;
	Fri,  8 Mar 2024 17:42:16 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8A3217;
	Fri,  8 Mar 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919735; cv=none; b=FHjrORPBmvhLBhmu+plvOHu3BYHHkxzh132+7Y7TsCqTGMn682RBE6aaVy8CKNP1S2ObHB4a4c93Zg5WaKCoV412lqlR/HNIBFoIB8oVTREPm/FtKo9teSyn8BYAm2rwaJhD50jMwe8mUqFHSqkT3JsgII5BSnj/a5zJSCYztpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919735; c=relaxed/simple;
	bh=J64dE3WP+PZYmP2KxggN7FPTEDJqMClbq9ewdZ6bQpc=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=nrI90dncrIXA4SMbPbtpiuw2plR5Ad99VVFCAwmEQVxIODNgqVYWdn/mvuLPbK0L5odVxPMGB/xA8ziZUsHPC8vCVnVviC7lAEbzvKBm4kspKsFOpSgaUpnshJSxPn4Pwn0+7k8GmN6k55xibDUD0yLqmK7wWIEdgOforYAxFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000767FD.0000000065EB4DED.0020A5AB; Fri, 08 Mar 2024 18:42:05 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/5] ALSA: hda/tas2781: restore power state after system_resume
Date: Fri,  8 Mar 2024 18:41:39 +0100
Message-ID: <cover.1709918447.git.soyer@irl.hu>
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

This series makes some simplifications, speeding up the start of the 
playback and restoring the power state of the amplifiers after 
system_resume.

Gergo Koteles (5):
  ALSA: hda/tas2781: use dev_dbg in system_resume
  ALSA: hda/tas2781: add lock to system_suspend
  ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
  ALSA: hda/tas2781: do not call pm_runtime_force_* in
    system_resume/suspend
  ALSA: hda/tas2781: restore power state after system_resume

 sound/pci/hda/tas2781_hda_i2c.c | 35 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)


base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
-- 
2.44.0


