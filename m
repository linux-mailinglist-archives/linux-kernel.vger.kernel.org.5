Return-Path: <linux-kernel+bounces-155465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD68AEAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B5A1C21ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B5413D294;
	Tue, 23 Apr 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzPzj3lS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19B13C68D;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885643; cv=none; b=ko3ZUN0u3RoaCYL2k3/CrAmCKh4Ebtz0lY8cTT+XMcMBLHy/FO7220pL8jP+hoz2oU3cvmPMBidWNYOQn1xI2smt1aCZ+DtMuSNRK0fsmSbBDZVG1MkLWDgREPfXDi43UBltKwwPr+HlPCKFt8mdrXRo8oeGoTCiK/PucKsuBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885643; c=relaxed/simple;
	bh=qPg5S47mYtFSNZmI6098SuLsJSTkHXYOky1OUsD8mu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXgsd92WFUBkPAYAtlS3xiydrNNnvI2XFveaYEUmkpmh/4wTknqdCkguZP9RcxkBuyF0DKzGLxI8KRlThZdZfAxnrD3qL5c1kcSMs/IRZXRupoMDRUILojwurRTdi8hx7sRB5XnBmmj5TDAxydj8ldUhVIjhsfCjbqd4smg5Rds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzPzj3lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CB91C116B1;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885643;
	bh=qPg5S47mYtFSNZmI6098SuLsJSTkHXYOky1OUsD8mu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RzPzj3lSqzplbAdXP9l7FK7qgQfIrBADUWCc2SgFZwJz1SLR2Pr4tAFje2Z7jxAQp
	 UA2ZSvWpE8kPu8j7eIUpKDLIUotIW6P6KHDqZRKKSeUaT95gT60hmc0SUiFFUu4ADr
	 vZxN5nKC25mVKh+UMrQP7nHGSvqAVDLNkMUB9RpeqlhAHOA1awyXcazv1kBwcNb7/Y
	 HYEsHhhdY2qSrwC4U7svkmCYlsf1Cjq2Q2OLX5GYwz0u61ZwMKP7ASGh8nt8k1ArCp
	 RBU7Qtch+BLSvZkiY3+23WQaS7zeUFz3yutnZ33UXN7Xi+F/930qXuBtPVmjwdVO4W
	 jjJNM8dsmWxiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6FFC04FFE;
	Tue, 23 Apr 2024 15:20:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Apr 2024 17:20:32 +0200
Subject: [PATCH v2 3/4] iio: backend: make use of dev_err_cast_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-dev-add_dev_errp_probe-v2-3-12f43c5d8b0d@analog.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
In-Reply-To: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
To: Petr Mladek <pmladek@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jyoti Bhayana <jbhayana@google.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713885641; l=960;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=O5sBK3dByRpiEz66h+ITvQMqPVPMlwbEa+A9Df4FqVo=;
 b=nei54/x6Mkn2Mx6Ct0Ltt/13H9JOLlF+w9Cmz3PJ7G5HAH92QrzgZNUmxoV52ZTd+mEIhRNDC
 IDXKUJpboqtCwYu3EzhkpajOLYz7lcxIbO1y+uix05hyT/x0KzVn13h
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f08ed6d70ae5..2cc6459246ce 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -475,11 +475,9 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
 	}
 
 	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
-	if (IS_ERR(fwnode)) {
-		dev_err_probe(dev, PTR_ERR(fwnode),
-			      "Cannot get Firmware reference\n");
-		return ERR_CAST(fwnode);
-	}
+	if (IS_ERR(fwnode))
+		return dev_err_cast_probe(dev, fwnode,
+					  "Cannot get Firmware reference\n");
 
 	guard(mutex)(&iio_back_lock);
 	list_for_each_entry(back, &iio_back_list, entry) {

-- 
2.44.0



