Return-Path: <linux-kernel+bounces-122112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB86C88F1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D706C1C2A2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69882153BC4;
	Wed, 27 Mar 2024 22:46:23 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF5C1534E8;
	Wed, 27 Mar 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579583; cv=none; b=Shxv7C7zFy1vcNIaf6csLrtDvGHOAZjYyJi+4tp8Emys6vmLhEtlv04czO+AXSrsPA8smc1tzLy37Wo5YRvJIplhoV3/hsQtz49/+o/vFDckP15bx8CoZ63GSdTxJ8jXgmNdEFPNjSmSkmwKcx53e81x9ZQQMH1iTvw5CqEFHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579583; c=relaxed/simple;
	bh=1e5raAEhprHiUiXaZsfBHSBgylnBCBNmi0u+bA8rljM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCNBSnaIMTChkQOmnLvWZlgLqttzY+uqOYWXkAcO1tL2QtJFD6w/X/3unyFXpHl/dVTvvK1cF8LaiiXoksSTKsSCm8QDR13pX+Gn0dyTiZS0yBhJsWfi8+JYV5KmIINByFzrR9ddLpvSP44UUm8V1k2KuwYDodiA5cQXTl6Xf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 5F6691403E6; Wed, 27 Mar 2024 23:46:17 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org
Subject: [PATCH 0/3] usb: typec: ucsi: Ack connector change early
Date: Wed, 27 Mar 2024 23:45:51 +0100
Message-Id: <20240327224554.1772525-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As briefly discussed here
  https://lore.kernel.org/lkml/Zf1XUrG1UbVJWzoz@kuha.fi.intel.com/
acknowledge connector change events along with the first command
in ucsi_handle_connector_change(). The connector lock should be
sufficient to protect the rest of the function and the partner
tasks.

This allows us to remove the Dell quirk in ucsi_acpi.c.
Additionally, this reduces the number of commands that are sent
with an un-acknowleged connector change event.

Christian A. Ehrhardt (3):
  usb: typec: ucsi: Stop abuse of bit definitions from ucsi.h
  usb: typec: ucsi: Never send a lone connector change ack
  usb: typec: ucsi_acpi: Remove Dell quirk

 drivers/usb/typec/ucsi/ucsi.c         | 48 ++++++++++-------------
 drivers/usb/typec/ucsi/ucsi.h         |  2 -
 drivers/usb/typec/ucsi/ucsi_acpi.c    | 56 ++-------------------------
 drivers/usb/typec/ucsi/ucsi_stm32g0.c |  1 +
 4 files changed, 25 insertions(+), 82 deletions(-)

-- 
2.40.1


