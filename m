Return-Path: <linux-kernel+bounces-118171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC088B568
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E973C2C7A40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50B84D1A;
	Mon, 25 Mar 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERiG5aI9"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816883A0E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409853; cv=none; b=o7ioJouI94mBDNadTk4gvL1r24+1qWUxFeVnL51+XEj4GXBovE3TFcKftiBpxAnBUg2LhsbY9pmmXGrcCjZiNoJCFzS7xf+/mQFKA6P71VAfFbBfvFTlN3Sn9JGQ55xMZblj+p+bPcRbrn0eDRmNiFbCSdYSKs1GQ/Ou6cEAipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409853; c=relaxed/simple;
	bh=6dujFpkqDKPBuiO2UpfalqIfg9Gg4/76KHGhMZb6TLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C9nDOncjSS99wQzBgc17cmULiIm/cRtBBIZ2Re7SCUVS7o230OHaz3C7CqmmLTjeNMw9XB1Uz5jExLatZHsMald07AaKxFF1lXEkpgmpeVqlsx7P7wzvnmAMzmxwPIIxwPIwzhsoBlhr5CukbGz7i64l3muOMtuW5izFELmP5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ERiG5aI9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6b22af648so3883650b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711409850; x=1712014650; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t++oNQEO7IJZ94laUh866kNX+AuB2HTUTSh3SaujONM=;
        b=ERiG5aI9zJCMQ7dU2SpQGjEOPkh8ggT5du8gao09wjHeSz7hRKOhYhQ93xCN0PcIGJ
         Np7LURSwwyrnzZyhOm7+gZI0NWDC5+yj0/S/B55b+Qyf9pscEYSrUG8uwZjhUqZCQ/3S
         VzdPX0EHzzsmPlYLb5qcDo6ePo7IOr9t3fgw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409850; x=1712014650;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t++oNQEO7IJZ94laUh866kNX+AuB2HTUTSh3SaujONM=;
        b=j6qKnnc+CcsfARpDkqZ+JJkIrizTOQfUi0/4c4SGfthn4aLwwA8JVvBSBz6+hbjGGR
         z88+Gx0ylq1VWFQuAf/RZaC7wApWG4djkuZ4dVM5VT8x6NCvJSnHARXJHW133y2oiMaB
         5/9sBRqm42Yr9xqLeowncs0jziIbP3Qro+BW1TghiY8h/EQ7EJGUNtcK7ln3fhrP89Z/
         E04A+KVJ9GMCJ40q96gaDD79favV8XnMkx7Y8pfxiXW9viXpx3Vccodmqqz4v/X9RrSz
         3NpcQtMDWx7xRz+FbQoGmTFDl49mchHBGPN9MjJQC9+N61YdvhUx1kAOdMfufxz8PWsW
         7mmA==
X-Gm-Message-State: AOJu0Yz6se/mcJbN+QFxqlKJ2jwtGCWs0kgtXFw4pb2cRA9KCbGPCAKr
	tG7PlyiX77+9zH0DpZnqww9lhz11boeIY8uKQUF8+0MZvlpiwdNINJzFX8M07A==
X-Google-Smtp-Source: AGHT+IHcBEPkzWr0QfcSeXpZkg/3A5L6PkziF30F3effJxL0tfk7Lkx8vo47sJxq0qfXhXF98wJfPQ==
X-Received: by 2002:a17:902:bb84:b0:1e0:cd89:7539 with SMTP id m4-20020a170902bb8400b001e0cd897539mr2648395pls.13.1711409850342;
        Mon, 25 Mar 2024 16:37:30 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b001e0e2fde71fsm526533plh.9.2024.03.25.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:37:30 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Subject: [PATCH 0/3] usb: typec: Implement UCSI driver for ChromeOS
Date: Mon, 25 Mar 2024 23:37:27 +0000
Message-Id: <20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALcKAmYC/x3MMQqAMAxA0atIZgO1WhGvIg4aow1IlQZFkN7d4
 viG/19QjsIKffFC5FtUjpBRlQWQn8LGKEs2WGMbU1uH5zXvQniRCnqsmZibyrST6yA3Z+RVnv8
 3jCl99gMghV8AAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

We are developing a UCSI ChromeOS EC transport driver. The ChromeOS EC
implements a UCSI PPM. This driver is being developed in
drivers/platform/chrome since

1) Most other drivers which depend on ChromeOS EC reside there.

2) Our architecture might undergo a few revisions rapidly, so
   platform/chrome seems like a good place while we finalize our
   design.

This patch series creates a public include/usb/ucsi.h that can be used
by transport drivers outside drivers/usb/typec/ucsi. Then, we use this
interface and ChromeOS EC host commands to send UCSI commands in
drivers/platform/chrome/cros_ec_ucsi.c.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
Pavan Holla (3):
      usb: typec: ucsi: Provide interface for UCSI transport
      usb: typec: ucsi: Import interface for UCSI transport
      platform/chrome: cros_ec_ucsi: Implement UCSI PDC driver

 MAINTAINERS                                    |   1 +
 drivers/platform/chrome/Kconfig                |  14 ++
 drivers/platform/chrome/Makefile               |   1 +
 drivers/platform/chrome/cros_ec_ucsi.c         | 247 +++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h                  |  54 +-----
 include/linux/platform_data/cros_ec_commands.h |  19 ++
 include/linux/usb/ucsi.h                       |  66 +++++++
 7 files changed, 349 insertions(+), 53 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-public-ucsi-h-3ecee4106a58

Best regards,
-- 
Pavan Holla <pholla@chromium.org>


