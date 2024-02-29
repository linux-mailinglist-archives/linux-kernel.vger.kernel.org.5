Return-Path: <linux-kernel+bounces-86970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38686CDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C4EB20F65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC84AECA;
	Thu, 29 Feb 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLNLUbPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40B1649CC;
	Thu, 29 Feb 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221772; cv=none; b=X5E5ham6IN10y7w/mwog+FC62R4IOzr77H1cZhW4a/l1bP0A/bqapsnu5sFBpQHAQrRAgPQ+UA7yr4MQ5R81r7XCxUiRHoU9XkcM6xqtXz56npcevBUPxjM8lik1Fk/HoqyGqBMeAZokSUpqZJib1RUIb8BMTyyM2Nqst4tFfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221772; c=relaxed/simple;
	bh=cR0HqTUaknLkPLTFIwauFtbbMFpsVGfj/+7sGvCDCjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/ho16TVaw0xaGlZ9iIcb9p/1vRzT8IY7aDFJL3/BgzJvJIMkJD5YWnDHDcp0FWtyQPHwpq/Le3wUjK10riDxZD+AmufBIPaOrKVm11+6wy7isSVNMm7fHrdm5KiRmo4lmqnNjIKDewAsSMXuc10enqEgeTMjk1PJHedUrC6DP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLNLUbPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C03C433C7;
	Thu, 29 Feb 2024 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221771;
	bh=cR0HqTUaknLkPLTFIwauFtbbMFpsVGfj/+7sGvCDCjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLNLUbPJIMJN/LwXvZt/jpAo/YdT8ztolAJtebP8zqkqmL1GBX4lN4UMH9/MYOFwV
	 FacB/7nUIoMRtLqsWVyAHcoIQyuIy/ms4M84xdLIje3AnpYsZyFx6iiubSNo498R0A
	 y0/AL5Jy0S9S5OFutfDD81arqmVQXzlm7KWDY6hR2vtgHl6YQ70iBbUr2dmo0SYUfC
	 wcDEYYuSJZu3H5+2sMf/+ozICFvw6fG93WjED6TrRjyp3fx5+MKzmKTkwCb9xuuVsy
	 iaV0TA0tefX93gK5iLwEYL0sMOXpYboAQbigwe7jsHF7oII+XHGnDZR1Tu5kYHTk5m
	 wDKFoFTS7SgLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 22/26] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Thu, 29 Feb 2024 10:48:41 -0500
Message-ID: <20240229154851.2849367-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Manuel Fombuena <fombuena@outlook.com>

[ Upstream commit 1741a8269e1c51fa08d4bfdf34667387a6eb10ec ]

Add support for the pointing stick (Accupoint) and 2 mouse buttons.

Present on some Toshiba/dynabook Portege X30 and X40 laptops.

It should close https://bugzilla.kernel.org/show_bug.cgi?id=205817

Signed-off-by: Manuel Fombuena <fombuena@outlook.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fd5b0637dad68..3e91e4d6ba6fa 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2151,6 +2151,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcddc) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
-- 
2.43.0


