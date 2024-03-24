Return-Path: <linux-kernel+bounces-113853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E088886F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710561C25BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576820631E;
	Sun, 24 Mar 2024 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQuUhfXK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A31E8E58;
	Sun, 24 Mar 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320893; cv=none; b=eCkUO6nyFP3wrg6nkJeNngaROwGrnZO99oajUBi0vXTBjVZlMFWJGm74MNnG+NxfgT7ZuUkYgZ/FCN8br1lHWu00P3QRcGHGzL3ciDMRPj31tCeDVMpbYdDixMb1xnEG5CyrcGSgkgGVv0WIlHOfoNPJTH3bagtQ6RRv7Q1i2+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320893; c=relaxed/simple;
	bh=V4NVh05WyemHL5wZcJ0nlItQbZj2IaY9CQKDxk9qkGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAKIUpj3gi1xGc81HSqIoKfkXN7x6K7dgX1jbe2HuEd+O/ZmBhSwb0yKIiYKccVxJuVOOd3ANwEYs9JC3UdWFLc6rxs8FAAhAfJOXGeNJjhwsFUYVzOroudX7MFt3G/T9TiMPPhC4q4Ly0FlpTZ04cQq80Snl6guHxwShl+pzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQuUhfXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0555AC43399;
	Sun, 24 Mar 2024 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320892;
	bh=V4NVh05WyemHL5wZcJ0nlItQbZj2IaY9CQKDxk9qkGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQuUhfXKlk9cX9FuU/puVWBAuw6WLSNeD9u5M4SKPO8C8TgHafQ2/w3khGTX81Eny
	 JFMTclhj39GAnnOybZ+5HZwwEX3vgPefDMjlUBtPfS+AA5mR3PWXqI67sih2FZz5ha
	 mjEmM5EaTKShHx2xBDrbw+APr6AW5baayN2dubjZajzpE4oVZ9qOYrARQEvNmgMx4/
	 TioKlVS4qHHnHsj+b81lnPmqhUMtAajwZVRNdRW5UuLnK8eExUIOI552XBB+BFDC8O
	 o4JHoxLbilJwjj2rL+fdxzCf/HlQ12JvBa9dsyyMIZ6UkL3MAhQX5CcgyWuX58uIhk
	 12NQ/dC0bOlNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	James Clark <james.clark@arm.com>,
	Kaige Ye <ye@kaige.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 456/713] perf expr: Fix "has_event" function for metric style events
Date: Sun, 24 Mar 2024 18:43:02 -0400
Message-ID: <20240324224720.1345309-457-sashal@kernel.org>
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

From: Ian Rogers <irogers@google.com>

[ Upstream commit 6dd76680b925228312756c13b9b983661b552a64 ]

Events in metrics cannot use '/' as a separator, it would be
recognized as a divide, so they use '@'. The '@' is recognized in the
metricgroups code and changed to '/', do the same in the has_event
function so that the parsing is only tried without the @s.

Fixes: 4a4a9bf9075f ("perf expr: Add has_event function")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Kaige Ye <ye@kaige.org>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240209204947.3873294-3-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/expr.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7be23b3ac0821..b8875aac8f870 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -500,7 +500,25 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 	tmp = evlist__new();
 	if (!tmp)
 		return NAN;
-	ret = parse_event(tmp, id) ? 0 : 1;
+
+	if (strchr(id, '@')) {
+		char *tmp_id, *p;
+
+		tmp_id = strdup(id);
+		if (!tmp_id) {
+			ret = NAN;
+			goto out;
+		}
+		p = strchr(tmp_id, '@');
+		*p = '/';
+		p = strrchr(tmp_id, '@');
+		*p = '/';
+		ret = parse_event(tmp, tmp_id) ? 0 : 1;
+		free(tmp_id);
+	} else {
+		ret = parse_event(tmp, id) ? 0 : 1;
+	}
+out:
 	evlist__delete(tmp);
 	return ret;
 }
-- 
2.43.0


