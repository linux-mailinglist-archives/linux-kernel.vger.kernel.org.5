Return-Path: <linux-kernel+bounces-72735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062785B826
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBFEAB28A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F509612EA;
	Tue, 20 Feb 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iINWP9PW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956267A0D;
	Tue, 20 Feb 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422389; cv=none; b=R+w3ZX0y3houMZxFjJ5dkF/uGoRUIZSRLf2SDx+xyhBYBhBxB2v5VeD8AXjuCSRkkEdQjNfyBZq8EmEyjBkzlrFzRYV7vhs2+A2d4HwJrusy/BncpTXVYdIHrIcp0G05qLmCaLIYsTdshhxsolShzCESxduCKjH52azeSZ4wRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422389; c=relaxed/simple;
	bh=As0fs15zX6e/lVzirTWd9KBu940ZNj9/uvV35M86qz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjoiS9tZrjgkS0GzmuXYH2ZL9MerxqxvAhYQVnoVw3ASRW65PGdYXWSuiNjpIfPB9nURh0jpRTJzWvfgzktpOvbEpZjzfkaR8wmpKmxheJEl3WLfFYIRwTu1P7ZJHsClfqmj3jDYmeglQ5yvPtzfnwG6ukeRL8PjoBvRxAaZIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iINWP9PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014AEC433F1;
	Tue, 20 Feb 2024 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422389;
	bh=As0fs15zX6e/lVzirTWd9KBu940ZNj9/uvV35M86qz0=;
	h=From:To:Cc:Subject:Date:From;
	b=iINWP9PWAyR9xHeTa/2TFnmNehIsm4u/jt68pRmpFE80YN9QXk+hd5MPYByCht+wP
	 /wxyKpkGLZUeXbdGPhImBZWbrJakB7KujDkH08H8Z/ahBa3VzYERNxx8KD8vcB/EUC
	 /EMLQqq0OKkiYC0vOGTse71SuSrqTVhtnHhk9Sj/t46rtk+SGyeVMxdYr/5vpB3NGH
	 8PIfdBz85mdGEafsHQi3oxlAriRnCF7Ny/5mjM4vjn9asuhmwaWWO2A2ixU9zfRQFS
	 8nPhMnOoORlqm+jMiQdeMY44SpUAxREUuIkJsB7cH7zsQt6EKquix3s5u3KIzvFNj+
	 F5q/lLnHxCZZw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1rcMhm-000000031Qp-2QwH;
	Tue, 20 Feb 2024 10:46:26 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH 0/2] Add some uevent variables on DVB to support persistent names on udev
Date: Tue, 20 Feb 2024 10:46:00 +0100
Message-ID: <cover.1708422122.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed by https://github.com/systemd/systemd/issues/31406,
currently, udev doesn't have pesistent names for the subsystem.

Add adapter's name and device's parent device, as those may help
adding unique persistent names.

While here, also change em28xx-dvb to use a real name instead of
the parent dev name. With that,  uevent for DVB devnodes will
resemble this:

/sys/class/dvb/dvb0.demux0/uevent:MAJOR=212
/sys/class/dvb/dvb0.demux0/uevent:MINOR=1
/sys/class/dvb/dvb0.demux0/uevent:DEVNAME=dvb/adapter0/demux0
/sys/class/dvb/dvb0.demux0/uevent:DVB_ADAPTER_NAME=PCTV nanoStick T2 290e
/sys/class/dvb/dvb0.demux0/uevent:DVB_ADAPTER_PDEV=2-1:1.0
/sys/class/dvb/dvb0.demux0/uevent:DVB_ADAPTER_NUM=0
/sys/class/dvb/dvb0.demux0/uevent:DVB_DEVICE_TYPE=demux
/sys/class/dvb/dvb0.demux0/uevent:DVB_DEVICE_NUM=0

Tested with a PCTV nanoStick T2 290e device.

Mauro Carvalho Chehab (2):
  media: dvbdev: export adapter's name and bus ID to DVB uevent
    variables
  em28xx-dvb: fix DVB adapter device name

 drivers/media/dvb-core/dvbdev.c       | 2 ++
 drivers/media/usb/em28xx/em28xx-dvb.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0



