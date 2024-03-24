Return-Path: <linux-kernel+bounces-115804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A76889803
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1CB1C3124B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF7B3736FC;
	Mon, 25 Mar 2024 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJwlEguC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79B53381;
	Sun, 24 Mar 2024 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321991; cv=none; b=qKCRjLchNdHqb++CbLy7bdetluMgLZwI91L/OfwFf4935yYT65gCnKA+7CsMn0RNVlFYVVNzvN83akl90VzDPQGvKFb5GWgBxXP/42CWbCwRgVs8Lxk/zyojci3pETnhUa2q0HJxUBq4Sc4DkXmxKrICTzfzNqc9cEX9jmzCQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321991; c=relaxed/simple;
	bh=zQqdpurwLB2EgsGZIeSezaN1OoSb/wsrwDE1e5WoJXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJYlsby7yZirpLopzY36eyyw7IfdCWIUnu4csl9JMM3LuHCc46H0xYSVIA3ixXGhsdOEXHKHnY0RiVjqzS0M5kjDGYbyGavVHvsduk8zYq5sj+ZWvEDgzS1tG8cklkoyiUZs0rmFiRUSRAORbLJL0PDnoSOBBlkrMCTnxWyBn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJwlEguC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D4C433F1;
	Sun, 24 Mar 2024 23:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321990;
	bh=zQqdpurwLB2EgsGZIeSezaN1OoSb/wsrwDE1e5WoJXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJwlEguCPiWbo0NdVG6idd2rlJyQxrZCT5XuZSdK7yq4v4nyFkJpMuPJ/lbK7x0mQ
	 BtMGDEpkjWVgmKCXMbpq1I86lgUu2JdeyHvGL5sceb6mxzeJbYXz/6Daa/AgbcqxxF
	 x03ZiYNMWuwPn0l+dr4UwD/pHqsHgyidQXVr9/SMZ7AKsA38MSlmqo9icDs8HtdlnA
	 Zof2269ZhY0zATQjsLVViIUSFq4SflfZYLHR9ArVRky/fFMh8aOm1DwkMKISrMLFKC
	 /dpeQ2uOujkc2lEE+zffXCGL94J1JnxUt7CMCVOivS1bt7MDFsEE+LW5LulrNVxtv5
	 YE1DDLxz85Nfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miroslav Franc <mfranc@suse.cz>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/451] s390/dasd: fix double module refcount decrement
Date: Sun, 24 Mar 2024 19:05:38 -0400
Message-ID: <20240324231207.1351418-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Miroslav Franc <mfranc@suse.cz>

[ Upstream commit c3116e62ddeff79cae342147753ce596f01fcf06 ]

Once the discipline is associated with the device, deleting the device
takes care of decrementing the module's refcount.  Doing it manually on
this error path causes refcount to artificially decrease on each error
while it should just stay the same.

Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
Signed-off-by: Miroslav Franc <mfranc@suse.cz>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20240209124522.3697827-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 029bb9e15ad90..341d65acd715d 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3512,12 +3512,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
+	device->base_discipline = base_discipline;
 	if (!try_module_get(discipline->owner)) {
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
-	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
 	/* check_device will allocate block device if necessary */
@@ -3525,8 +3524,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	if (rc) {
 		dev_warn(dev, "Setting the DASD online with discipline %s failed with rc=%i\n",
 			 discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
-- 
2.43.0


