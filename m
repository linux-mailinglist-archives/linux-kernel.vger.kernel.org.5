Return-Path: <linux-kernel+bounces-114817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDF889174
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132EC29582F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB92BF2E1;
	Mon, 25 Mar 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhsyWPT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE92130A6D;
	Sun, 24 Mar 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323432; cv=none; b=E7G/pNd2ACeyXKOlZa10c0UtJZouXGrvQ39VBgEwgFSkfmuQmcnAwk3g6Hq5e5eW8EyQMPAibHimJsw3L2M8XlqBx27QLiwHsh7VARKrVG9ry+LDh9NPgD1h7bIDPxYTbYwyQSr1bRtb8xz0R+DSwgwpN2WIyPGoRdbr+33aq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323432; c=relaxed/simple;
	bh=NPjfnzED8BoT35x6bgMnmQsuwCdMFgSn/d3NxJwHA54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaVOZL91XJw03VyZacnCDggBlWvQgYxcY1FCraQAOuWZ05x0oI9LbeN/vhJVLrVfHd7XuLfXx2YigjdPyE4gEBrgja0Ao02mZyrON4LFDNJnJbBd+GqoGHK7J/WCcfOHXOUoa0erMki4oXX+iTmezYTNO3BE50fQn1coBTjefF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhsyWPT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FECC433B1;
	Sun, 24 Mar 2024 23:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323430;
	bh=NPjfnzED8BoT35x6bgMnmQsuwCdMFgSn/d3NxJwHA54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhsyWPT6aX4LRgFlxkiic8TmDohiAtSaWFTmpIzof5G3oACBC8IOeuaSlRCpEKn2Z
	 xaFja10ieWtJq7ncdyG9t2iwDHTkjo5m8+TU1o4Btq3AtIsStzNFpu013kzkAw1lWk
	 pRDJTdVc8gscld8hPJjBxlQtBVBd7ejlx6XcbmxM73xvcc80rVZlDqF9zJyELRHl3+
	 2K8LxEMwRa+j6IPsH19Ms/7mJI1Kzm5QsSN5HvxaJ3cZGpoyHd+vASXCP8QcgVxyKh
	 j0gJlBatt9vT1LyqnPM10/cSuIO3gs92hcGsn/uWLUtSpUxEASVXQ/VBJsmEz+sVYK
	 objCgghR09fFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 133/317] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:31:53 -0400
Message-ID: <20240324233458.1352854-134-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 281d464a34f540de166cee74b723e97ac2515ec3 ]

The devmap code allocates a number hash buckets equal to the next power
of two of the max_entries value provided when creating the map. When
rounding up to the next power of two, the 32-bit variable storing the
number of buckets can overflow, and the code checks for overflow by
checking if the truncated 32-bit value is equal to 0. However, on 32-bit
arches the rounding up itself can overflow mid-way through, because it
ends up doing a left-shift of 32 bits on an unsigned long value. If the
size of an unsigned long is four bytes, this is undefined behaviour, so
there is no guarantee that we'll end up with a nice and tidy 0-value at
the end.

Syzbot managed to turn this into a crash on arm32 by creating a
DEVMAP_HASH with max_entries > 0x80000000 and then trying to update it.
Fix this by moving the overflow check to before the rounding up
operation.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Message-ID: <20240307120340.99577-2-toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index f02d04540c0c0..b591073c5f83d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		/* hash table size must be power of 2; roundup_pow_of_two() can
+		 * overflow into UB on 32-bit arches, so check that first
+		 */
+		if (dtab->map.max_entries > 1UL << 31)
 			return -EINVAL;
-	}
 
-	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-- 
2.43.0


