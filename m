Return-Path: <linux-kernel+bounces-72433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FF85B32A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B029A1F228CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA336AF1;
	Tue, 20 Feb 2024 06:53:16 +0000 (UTC)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054D29A8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411995; cv=none; b=QBS3ISFq6M6Uj65YtkX1wwv4pGFQH01FyzKFPaAJLQywUetKQ0chEGSRPWv9RMGaQ7uVebEUnd+r019yUwrV8rkRKhqH3Ut8m6KSOetqaY1qybotIp169iMOoW01pnnGuBntqXqMyoY1nqpmuJm/DE+PxelFElXMFGJREW+6cRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411995; c=relaxed/simple;
	bh=yJjdYMX6BDehTddWARepn2ys3Jf+gUjLRqGIZysR440=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=UOuyX4FOdFgzBJfzPYOixpdYMUUkaTQL9ZXGJGXX6cPwBMiq/8spmreUaLBlQ5qf9dw0jF2dd/m7dha1lI2G5wZbpUJu1uqo3RX7Ag8pF3JroeYbIv1lPeRsC2+zcTShzOHfaQlLVwCh7oitFGBS5VAnPlsgfbHPXxUlladw+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/3] mm/zsmalloc: some cleanup for get/set_zspage_mapping()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAEtM1GUC/w3LwQqDMAwA0F+RnBeopRbc3yRdsIUYpcEdJv77enyHd4NLb+Lwnm7o8m3eDhuYXx
 OUSrYJts8wxBBTiDEgJ/z5TqpHwaJCdp245EBpXlbmzDAmkwtyJyt1XLtUn+cPJtXeZ2oAAAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 20 Feb 2024 06:52:59 +0000
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com>
To: nphamcs@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 hannes@cmpxchg.org, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708411986; l=1144;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=yJjdYMX6BDehTddWARepn2ys3Jf+gUjLRqGIZysR440=;
 b=3E03UvayTvmsSPw6C/NHdSEUGs1uauED/D/lL7MgvuRpiqEJ8Ps/jdHWZfuZj80aa7zgPnn9y
 LOe3amM2QuKCkfKzSc+eAksEkPDA7G8CNAJY287QAJxnv2sCWN18HXe
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

The discussion[1] with Sergey shows there are some cleanup works to do
in get/set_zspage_mapping():

- the fullness returned from get_zspage_mapping() is not stable outside
  pool->lock, this usage pattern is confusing, but should be ok in this
  free_zspage path.

- we seldom use the class_idx returned from get_zspage_mapping(), only
  free_zspage path use to get its class.

- set_zspage_mapping() always set the zspage->class, but it's never
  changed after zspage allocated.

[1] https://lore.kernel.org/all/a6c22e30-cf10-4122-91bc-ceb9fb57a5d6@bytedance.com/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (3):
      mm/zsmalloc: remove set_zspage_mapping()
      mm/zsmalloc: remove_zspage() don't need fullness parameter
      mm/zsmalloc: remove get_zspage_mapping()

 mm/zsmalloc.c | 55 +++++++++++++------------------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)
---
base-commit: 207636f0f52428f3b46540b212d6f93c6ac484cf
change-id: 20240220-b4-zsmalloc-cleanup-560a4159bb6b

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

