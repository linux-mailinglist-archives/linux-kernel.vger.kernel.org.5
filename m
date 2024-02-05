Return-Path: <linux-kernel+bounces-52574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAC8499D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C411A1C21F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A02C1CD3A;
	Mon,  5 Feb 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJy4dfNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFB2260A;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134974; cv=none; b=F3ZoDOZgxxZZ+HQy82aym9WMtevEHI1Lfh0KL2kze5P0fXWQmea8dqtABSWOFjeT3Ohnyr5l61NxZmICWNg6uWnvGL/pn9PfGKpzhyBkmZeZjmGDT5U3JTy3yjfX1zzkAp5RwJusOkAqFqooK45L2xwMEhNyzvf3x1xvhFBZ65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134974; c=relaxed/simple;
	bh=7e2upngWNO5ntFqCHIcVwMlIz0QAUH3LlE8pQnC8t+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CfZBS57ZM3EwtKsND8mNvnYdi/mM0BgJ9Y2nBZBC80Ri6jVFhYC0FN5KBHjy9VDUAMsW3F0L19X7M0+0pucOWhW0zCb01x8iVhgXqSp9/YhAcvrZNGLzOfTqwUvXwzSRdNFho7VjBsELWdhxQfYGQHMsp+JgMq6a2CnsGIhqW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJy4dfNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E39CC433F1;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134974;
	bh=7e2upngWNO5ntFqCHIcVwMlIz0QAUH3LlE8pQnC8t+Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QJy4dfNXRqwlBLdK8TFL0Pj+Gq+ssJoVQvERYlyll6RJwTjl/kt8eY700LXbhIZ2o
	 drjc2PMprsc61PKhieXH3KATA3fQ5Oi3aSk6MBsEiuEZZdu85eAI67kzGkaIhgMeZf
	 tqYkqPvSu5rdZGcehAZAH7IcRQXrCgfsblsivOai52q5lgq+XslIX1Y7qFJuTnbYf/
	 LzhBkI4Jdd5bvMr/AzmZCXvTeqBVK1Mxyk4kPcC/HSU+6q+4vn1kVhvW2g0TGRlv03
	 DmwJbDC/+H9cQIZpUjXb5X97Ltou8eEjW1pemLlxgA5vPxtikgVxpO2W4yUxU9hYfP
	 GVHC9TKbt+waA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B69EC48295;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/2] fix DT overlays when device links are released
Date: Mon, 05 Feb 2024 13:09:31 +0100
Message-Id: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPvPwGUC/42NQQ7CIBBFr9KwdgxQbKwr72G6mNKhJVYwYIhN0
 7tLWbkybiZ5k//fX1mkYCmyS7WyQMlG610GeaiYntCNBHbIzCSXigtZg7FvGHJQE8zW3SP4RGH
 GJcJJSUm8rpG3Pcv9Z6AcLu5bl3my8eXDUqaS2L//WJMAAS0p06BG7Bt9RYezH4/aP/aVosjnt
 4KDac0gFFf6TPJb0W3b9gGZsc3KBgEAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707134972; l=1080;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7e2upngWNO5ntFqCHIcVwMlIz0QAUH3LlE8pQnC8t+Y=;
 b=lKkAAhch2GHEkpX4cOsUW9bnwLAlEHPSBUI1HTZX8tmKTSyyfC5P5dPUij8SGU4FcRHO0V2Ik
 quwrkFmJISoDQ2XWu594h3fXNmUIeLEH3X5hotYu7KZTjvmIb3WASnL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

Link to RFC:
 * https://lore.kernel.org/lkml/20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com/

v1:
 * https://lore.kernel.org/r/20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com

Changes in v2:
 * Don't error out in case alloc_workqueue() fails. Devlinks can still
   work and we'll then release them synchronously.
 
I'm pasting again the link of the first time I exposed the issue where
one can see the resulps (big splat) of failing DT assumption:

https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-nuno.sa@analog.com/

---
Nuno Sa (2):
      driver: core: add dedicated workqueue for devlink removal
      of: dynamic: flush devlinks workqueue before destroying the changeset

 drivers/base/core.c    | 32 ++++++++++++++++++++++++++++----
 drivers/of/dynamic.c   |  8 ++++++++
 include/linux/fwnode.h |  1 +
 3 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-fix-device-links-overlays-5422e033a09b
--

Thanks!
- Nuno Sá


