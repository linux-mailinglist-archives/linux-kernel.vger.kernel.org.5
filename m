Return-Path: <linux-kernel+bounces-93049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A77872A20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BB21F25EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079012D1F8;
	Tue,  5 Mar 2024 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dCTmHMU5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DC18E29
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677322; cv=none; b=jfEPdrIm65UD2lmu0h31FnGLcwtAQX/gJCzPxVnDptBlWEPXGwGi7yaguKBSs16nitXXBQjD+fMBExvifiiG2d4BDCSzaPN+crtR8trVtG8TMgrW/e4xpVjXk8OPbhv6h2xzsggDfiJb1PYo4k1V7+LdQ9kEqmt9Xi+W80wPnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677322; c=relaxed/simple;
	bh=zVGaZRLOhq1YhulEff7D7jtiyyKQZe29YJFuxh459zs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kYq51TAzce7J2o6uzyzF0Fy9nTZn4DgYLn1yU/g6kH7LgE1B6iOaf/T3+nRfGbhZ47rr+qXVRoaV2yPC5XzQSyyOeYkUtGi3kz7nEtUsDOAR3VJZXQnllUmbLuDECh3eoGOaYVa1Ipika9mWkrcMfA/zoOdu+hs3JUqqLVTjNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dCTmHMU5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709677318;
	bh=zVGaZRLOhq1YhulEff7D7jtiyyKQZe29YJFuxh459zs=;
	h=From:Subject:Date:To:Cc:From;
	b=dCTmHMU56iTZFVNiIH5l1KibsMHT+N19cWb9j0r+Ce3WVtaNAeh41Fzst5d30vm/L
	 vxoiYizJ+530O1lUvL3jBcbNxIglXJCRx8Q0nDLc+hlc3Md3p21KXtfk2sLb84D+se
	 teFewFMrlMWen8w1cM5yi2hiEfBneP03Jk1/so2bJBzcWou5E/U3nbGAZIf7EZrjW8
	 ELv0nXxlPVuREivLbopNP1g+FK+9qIROn98HuUwlQ5rCB8xrB28Jnw5XnlpwRUJVKt
	 SpVHPMCYQnvk0V9IJOwLSjIO0LKQjpABT3S+SYH4VvtXP4nkd12hHbGrmlgkklHmNx
	 KrqKWXaBr035g==
Received: from [192.168.1.241] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB53B3781FCE;
	Tue,  5 Mar 2024 22:21:57 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/3] device: core: Adjust device probe log messages to ease
 error detection
Date: Tue, 05 Mar 2024 17:21:35 -0500
Message-Id: <20240305-device-probe-error-v1-0-a06d8722bf19@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO+a52UC/x2M0QpAQBBFf0XzbGotEr8iD+xczIvVbEnJv9s8n
 jrnPJRgikRD8ZDh0qTxyFCVBYV9PjawSmbyzjeudi1LlgL4tLiAYRaNEfoe3SLipaYcnoZV738
 6Tu/7AZTIrw9kAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

This series adjusts log message's log levels and helper functions to
make it easier to detect issues with the probe of devices.

This is the rationale:

- The dev_* printk variants should be used to log information related to
  the probe of a device so that the messages get the device's metadata
  attached and can easily be correlated to it.
- Issues in the probe of a device should be logged at the error level.
  If it is likely that an issue has ocurred, but not guaranteed, log at
  the warning level.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (3):
      driver: core: Log probe failure as error and with device metadata
      driver: core: Use dev_* instead of pr_* so device metadata is added
      device: core: Log warning for devices pending deferred probe on timeout

 drivers/base/dd.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)
---
base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
change-id: 20240305-device-probe-error-ec99e7bdd2d3

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


