Return-Path: <linux-kernel+bounces-150002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF98A98F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894031F233CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F9115FA83;
	Thu, 18 Apr 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oflefiUI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51715FA69;
	Thu, 18 Apr 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440909; cv=none; b=sEFvcUTBQqVTmE+3Ow8w9ui7o8qi7VBdfj4uTSkj4X6yZWULzR+YHmJgyYbqpu9MML3eELyJWzxfOfmFXVLivICTu7B1wnO0KLKwx/qW8QLiUR8xx7WkVDgt1SNoxI4IvxoyFOS2FKAGSFM8eZ5qnoy/Xp+JpxxjgLdCGEar4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440909; c=relaxed/simple;
	bh=8VJ5hKHmYOp/46ZdNZxyjLIo6lOw9/Vq2aq/KzWpkQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvIaQHEjUb8Kq19ypwXKgpq5q8wbJlCjXEPjavYtLCZR+4yqmUg+z++GOauVhE02MkzS6tj7kM2L3SQSMznro/vBJ4dIR6R4Mv+xUujQ1AzobH3qizkIarVQumguNG85iXE8L0an0sMOZEQIoc0PWNJrp7NmSkgJM46Myyf4bMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oflefiUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57633C32783;
	Thu, 18 Apr 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oflefiUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713440905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ae0zTG4DxkCJg7AeltX/Gau4i8llJFr54olJaeSeesc=;
	b=oflefiUI3WblrKofe4FNMGhCZRAa94XIlS9eMnTEJ1KIV44v1DKXlFSxehRkjD8HvDpQR/
	rfeEXMVaZHjU9RDYaK/KS+A6QttMVmspa6V969dtETg29xwvD20NhL6dQ04y310Y+NwzQo
	BGp6H9xGCPZNnAJ5YCDQI7+7Vz2Qi/w=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c16785af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 11:48:25 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Revert "vmgenid: emit uevent when VMGENID updates"
Date: Thu, 18 Apr 2024 13:48:08 +0200
Message-ID: <20240418114814.24601-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ad6bcdad2b6724e113f191a12f859a9e8456b26d. I had
nak'd it, and Greg said on the thread that it links that he wasn't going
to take it either, especially since it's not his code or his tree, but
then, seemingly accidentally, it got pushed up some months later, in
what looks like a mistake, with no further discussion in the linked
thread. So revert it, since it's clearly not intended.

Fixes: ad6bcdad2b67 ("vmgenid: emit uevent when VMGENID updates")
Cc: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20230531095119.11202-2-bchalios@amazon.es
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/virt/vmgenid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..a1c467a0e9f7 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -68,7 +68,6 @@ static int vmgenid_add(struct acpi_device *device)
 static void vmgenid_notify(struct acpi_device *device, u32 event)
 {
 	struct vmgenid_state *state = acpi_driver_data(device);
-	char *envp[] = { "NEW_VMGENID=1", NULL };
 	u8 old_id[VMGENID_SIZE];
 
 	memcpy(old_id, state->this_id, sizeof(old_id));
@@ -76,7 +75,6 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
 		return;
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
-	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
 }
 
 static const struct acpi_device_id vmgenid_ids[] = {
-- 
2.44.0


