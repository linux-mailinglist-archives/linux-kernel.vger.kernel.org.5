Return-Path: <linux-kernel+bounces-71966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F44485AD25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B3281B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7453815;
	Mon, 19 Feb 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lkCwbPlF"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89450524BD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374446; cv=none; b=AVKN0+CVLLrrAktQ7rjySW/rUVPnnbfMhwUmCt1RAL+o8ABNR8icbKsM/FZxBWeIaJ68wW0YmIBR9LnbiQZj7RcQj9Wm78DqxQM17oYqNvdOqA7asoV1OO1qWS5q2zgEE6X3ZEc2wFsfqmHwUq0hHphTjv+FJd1ArKUu5eLHL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374446; c=relaxed/simple;
	bh=Q76MkSwse6DwwFM74aXHBqVgCkUqP3UGGGeVotD5+cY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N7h1Mm2NtAUcu+yVpKUMxsdIXC8tAMyYnxQ+bDQ0aLQOHxY/OjC+L6LBwibOy5RLjk/D+XeGww8paS7Ah2GblDREtoqzitmJabyGCZl8yZBMkpam4W675ikEJ6wGomY3BZk8hk4y7trw7qKfzR/H8x6RQXNwU0ZGqvqWYAy5XO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lkCwbPlF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708373975;
	bh=Q76MkSwse6DwwFM74aXHBqVgCkUqP3UGGGeVotD5+cY=;
	h=From:Subject:Date:To:Cc:From;
	b=lkCwbPlFXcWo56CfgO3rGZUSzgpxGfPqn0OVl3eUjEjriTF6z+EIfWBBwBVZS4ZIt
	 GvC2I8v9WUxuBWNZo9VJ4v/cE/c4ltFa9bkScwl55QCzLHWBvgcjyC5Q0nknM8P+k5
	 YSe5D5wsw1828d1v/q+99NECFRYuqo5HwzGFZ8kw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/3] scripts: check-sysctl-docs: adapt to new API
Date: Mon, 19 Feb 2024 21:19:21 +0100
Message-Id: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMm302UC/3XMQQ7CIBCF4as0rMXAQGvrynsYFxWmQjStYSraN
 Nxd2pXRuPxf8r6ZEQaPxPbFzAJGT37oc6hNwYxr+wtyb3MzEKAkgOA0kRlv3Dg0V17XAqpS2ka
 XluXLPWDnXyt3POV2nsYhTKse5bL+gaLkkmsQBq1uq8buDk/0RGTcw217HNmiRfgUqi8BsgBWd
 6U4K2GV/hFSSm9iKVLk7wAAAA==
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708373973; l=1348;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Q76MkSwse6DwwFM74aXHBqVgCkUqP3UGGGeVotD5+cY=;
 b=y3ImIKH0AEAZP8g9AUrKA/9IzsxNZtZNUozo2WR7KW33UCWencQy8yKbuBj/bviu5aik1qU5E
 att3GHkbN47CHiLFj0Ck8+rx2Pw0W4oITKVJMASGFnw7eQWwo6hoCId
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The script expects the old sysctl_register_paths() API which was removed
some time ago. Adapt it to work with the new
sysctl_register()/sysctl_register_sz()/sysctl_register_init() APIs.

Per-namespace tables via __register_sysctl_table() are also handled.

Note that the script is already prepared for a potential constification
of the ctl_table structs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Handle per-namespace tables
- Link to v2: https://lore.kernel.org/r/20231226-sysctl-check-v2-1-2d4f50b30d34@weissschuh.net

Changes in v2:
- Remove unused global variable "paths"
- Remove docs for deleted variables "children" and "paths"
- Link to v1: https://lore.kernel.org/r/20231220-sysctl-check-v1-1-420ced4a69d7@weissschuh.net

---
Thomas Weißschuh (3):
      scripts: check-sysctl-docs: adapt to new API
      ipc: remove linebreaks from arguments of __register_sysctl_table
      scripts: check-sysctl-docs: handle per-namespace sysctls

 ipc/ipc_sysctl.c          |  3 +--
 scripts/check-sysctl-docs | 65 +++++++++++++++++++++++------------------------
 2 files changed, 33 insertions(+), 35 deletions(-)
---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20231220-sysctl-check-8802651d945d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


