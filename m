Return-Path: <linux-kernel+bounces-113945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2856888EED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587751F26C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3F2197DC;
	Sun, 24 Mar 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGggEiae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7D1EFE42;
	Sun, 24 Mar 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321050; cv=none; b=KuLZzJI8ST5uEgQviNxW1VltuuNEVn1GTBfU0ZgXHDLwkU54XWSB4TQ7mRtdZWZ9m6lUCmLpHq8GTmKpv++wp+74GJYNI3GaMbkbIFm2ZfpYOeu5ZQwz4sxjZnO/tzQKzIA8oZDJJHokk9yCSnjqNPwqPCb9g4aTZzA34rL7Txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321050; c=relaxed/simple;
	bh=B3ZXGUAXx6lcWfqf2PJBVUj7BbEtjMdTv8BrH5L1FWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzvVswoRv9cNpmrTThptXPOZ/mWIoMUvi7c7uahZN6sB0JJ7rF3XUkIqS1FowlsjKBEErKWnRYrOhwSHe3yQ7HyjQe+gpmHA75GeF8O66q35eK6NJLCTF4Ec+NgU5q/6y2dVRpnftuWkdZsFJJV5abcu/Y4yPOSt1p2E2k2h4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGggEiae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D43C43394;
	Sun, 24 Mar 2024 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321049;
	bh=B3ZXGUAXx6lcWfqf2PJBVUj7BbEtjMdTv8BrH5L1FWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGggEiaeJpAKXqTHDdR3oqOZ9OR/HpBSgouKwxarp3AJG2eJ+7UsQEYXgEnZtjxsQ
	 i7uzvShBhnyGETWIhAskn192UU5jHYfVj3gNNR+INqxp13FgDLfGuh5K7dyfjLwLq0
	 2tm1T8h71q4E/bRmjsGPu+rrD3dusvSqqVKhV+auAKOPd+r6QzJS2o+p3k/Qo6+O91
	 Z73nHGr5TVyebMSQCGdMnhJADe3RGSNBuP19feQ70ETPL2xax/fy0rJax7bAGql7lE
	 EPiJpIV5SgRlCI53p0mZ8oYg5MbLCQA/vnM2zmD5CpsS+6Tlfq0agbxVwSDCPOIE6U
	 Yds3StJ4NGe8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathias Krause <minipli@grsecurity.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 612/713] bcachefs: install fd later to avoid race with close
Date: Sun, 24 Mar 2024 18:45:38 -0400
Message-ID: <20240324224720.1345309-613-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mathias Krause <minipli@grsecurity.net>

commit dd839f31d7cd5e04f4111a219024268c6f6973f0 upstream.

Calling fd_install() makes a file reachable for userland, including the
possibility to close the file descriptor, which leads to calling its
'release' hook. If that happens before the code had a chance to bump the
reference of the newly created task struct, the release callback will
call put_task_struct() too early, leading to the premature destruction
of the kernel thread.

Avoid that race by calling fd_install() later, after all the setup is
done.

Fixes: 1c6fdbd8f246 ("bcachefs: Initial commit")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/bcachefs/chardev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 4bb88aefed121..64000c8da5ee6 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -392,10 +392,9 @@ static long bch2_ioctl_data(struct bch_fs *c,
 		goto err;
 	}
 
-	fd_install(fd, file);
-
 	get_task_struct(ctx->thread);
 	wake_up_process(ctx->thread);
+	fd_install(fd, file);
 
 	return fd;
 err:
-- 
2.43.0


