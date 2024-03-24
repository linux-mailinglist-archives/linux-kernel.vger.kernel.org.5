Return-Path: <linux-kernel+bounces-114301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CDA8889EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CABB288DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79184D00;
	Sun, 24 Mar 2024 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/cDvQjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184413A889;
	Sun, 24 Mar 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321680; cv=none; b=cqVjsZjonNPC/K7mqs+MUIlmK2VS5n+H+rlx8WdAYi+HBs6w0fdzhMbQN/CGBRl24COAilXj+kp8X+RARG2D2h8EbaxS3XlC+oJBYvS0vfObCVFKG2sWSFSYvvKjQvPTSRvZ+awsgkc9kwWkKSbCUvztae+/rw0LwGM1fqdSmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321680; c=relaxed/simple;
	bh=M1QItdYAF71ObWMVTznHt14H9vDAKX8BuqolOPqVItE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lumpuD+UqypozqA6u7OqHZHgAeYyIxGsdWxis6ba+kLlcslZo/NWKz1tH9CbnRK5f8VrL74pGJZ951xrRCbHAPaHcG586sFx8qGdXeQOPhteDGgTyx9n4pGX0fIfWOAtckGT5Ll3HM68gp4a7CeQyZZZoviygjWH0DEykj1tPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/cDvQjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208ADC433C7;
	Sun, 24 Mar 2024 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321679;
	bh=M1QItdYAF71ObWMVTznHt14H9vDAKX8BuqolOPqVItE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/cDvQjvx+8jJxfLmkRwip0S3UjhZkQJ4LaWZ7AbuSAKluJ6jV+7aoYEfF/pwCrym
	 GT6Zg2Ubi4p6zsZRV+oxJIhZmLwlrNBKwZogufv0NMaCwvtHHl4ukPr+L35CmIgxyL
	 bJtKEw73BWr2TQHQirfUH5xaEsD71/bNYn3XW04UAzDAZR0JSa1cAZUqbFjKENGFqC
	 5LsXlikFP3f8h8nXzuEjtUMYqUpUEPdCIlGcjvZmotmmamhP9Bqes78ryJB3lolHpq
	 sM5dNQeQjs5/20wRncNkRZ9I2DpdVYhgP/yt0TOgf/jI7xRE+Yz2jtvE1SjiPbsguz
	 U84YmSr7rgJug==
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
Subject: [PATCH 6.6 408/638] perf expr: Fix "has_event" function for metric style events
Date: Sun, 24 Mar 2024 18:57:25 -0400
Message-ID: <20240324230116.1348576-409-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 4488f306de785..80cf2478f98fc 100644
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


