Return-Path: <linux-kernel+bounces-118033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF4688B2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506151C3EC18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E686D1C1;
	Mon, 25 Mar 2024 21:25:59 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FE5D744;
	Mon, 25 Mar 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401959; cv=none; b=Pnxt1YnsL1ePNB2EDbO3hCKlxxARQ9eQkC79tiDk+1+veTc5vuIBEbZQfTzqSSUQquLNFAYzfCaEb/pw3BaZHq68OOERzEEAABsb7vje2xkq0USqf5eJux2k8/AloxduO/atQU5ChrtSgEFdRX6o7+eWCFIFseLj6wQiiinsROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401959; c=relaxed/simple;
	bh=k9v5Ltm9l7F5/wZwQ/APUya5hmjRVWK8DhyYFYiswFc=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=XjfM34zKLeCP7BLBLBmFJ5FyXCaZc/J5VNja1BJ9VaOlWcpN+WxtzRuopP0dwuiPscJ+OLFNWY13LTOXnv7wRAoXr1DkMLp0WkeQJgMrQUQ7/gxm/jK+PgL+gVXpHjSdogcyt+v6bOv11+oB2NHXhjU12fnm8qoHlF1fP34Zu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000770A7.000000006601EBDC.0023A883; Mon, 25 Mar 2024 22:25:48 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/3] ALSA: hda/tas2781: fixes for 6.9-rc1
Date: Mon, 25 Mar 2024 22:25:32 +0100
Message-ID: <cover.1711401621.git.soyer@irl.hu>
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

Gergo Koteles (3):
  ALSA: hda/tas2781: remove digital gain kcontrol
  ALSA: hda/tas2781: add locks to kcontrols
  ALSA: hda/tas2781: add debug statements to kcontrols

 include/sound/tas2781-tlv.h     |   1 -
 sound/pci/hda/tas2781_hda_i2c.c | 103 +++++++++++++++++++++-----------
 2 files changed, 68 insertions(+), 36 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


