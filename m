Return-Path: <linux-kernel+bounces-6502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661B8199B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85B4288A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C71F614;
	Wed, 20 Dec 2023 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXLTQ5DO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70051F600;
	Wed, 20 Dec 2023 07:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D3EC433C8;
	Wed, 20 Dec 2023 07:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703057934;
	bh=npKwGFoNMhkCrPaQzFSksmdJeACxgz31jGlwwfNba5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wXLTQ5DOuw8vuINew63Di+cUKndnXKNnLeeR+9xaqyme9Q0xp1a4dwPHRDWVDLwtu
	 h08YXfOOB4Pa6wVOTQHjuO5djsydVAMmjeHAlGwx79hReb/4bqdxZUj0YKFF3ful7n
	 dG4BVX6qcUQ70oUU8bIFHuWS5o5uyCN/OBrb5ybM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 2/3] HID: make ishtp_cl_bus_type const
Date: Wed, 20 Dec 2023 08:38:47 +0100
Message-ID: <2023122048-tribute-quote-1b4d@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023122045-pellet-eggbeater-8d2f@gregkh>
References: <2023122045-pellet-eggbeater-8d2f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 28
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=npKwGFoNMhkCrPaQzFSksmdJeACxgz31jGlwwfNba5s=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlNszjSz5+K8hO9yCq294n0X6ksiWDO8hfMW/O/LP+r0 7Dif41/RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyE6wvDPLuHu6c7bGea5t2x Lthxa8S/Be4/TzPMFS9S66pOsP4Vs0fNX+9cpPfR91nyAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the ishtp_cl_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 7fc738a22375..aa6cb033bb06 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -378,7 +378,7 @@ static const struct dev_pm_ops ishtp_cl_bus_dev_pm_ops = {
 	.restore = ishtp_cl_device_resume,
 };
 
-static struct bus_type ishtp_cl_bus_type = {
+static const struct bus_type ishtp_cl_bus_type = {
 	.name		= "ishtp",
 	.dev_groups	= ishtp_cl_dev_groups,
 	.probe		= ishtp_cl_device_probe,
-- 
2.43.0


