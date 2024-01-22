Return-Path: <linux-kernel+bounces-33224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E56836705
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3DBB2AD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427C248CF3;
	Mon, 22 Jan 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEpKIFIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAD48CE0;
	Mon, 22 Jan 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935393; cv=none; b=FliUv8pflgXK04m/wJytC5uO5tgOpKKReBo+hxyEGV0jvH6l1s7EdeOMPxPfe4xfDuDmWAV5PC6nvzuLwWI9VTx9gP3aCH2kAP9nPAp7ck2yUId4rq5GefevJEp9E9HDx2ag11OKjj167VCIlaJtb2kYRXM/qjQ7j7+cI7/M9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935393; c=relaxed/simple;
	bh=LXGuMI1JaZaVMaaVgo4W/1k5pUsxNryaR6dPrfqytik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTY636nbYNmUWZaVR0/NE/aMX4lc4/q8aSOspccB/Y7YmhfWcFjDOdnKdkoK9EVRtTO9pW9fXTMUOcUCWLAC/YLMs2qfDjb0nw+KA+zIqRRroeaOE2QwYB005GpqNYmY6x91hc5lOB6UfeiL54Be2EQNVL/UBpcBlmXpZ0YrP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEpKIFIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403D5C4166C;
	Mon, 22 Jan 2024 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935393;
	bh=LXGuMI1JaZaVMaaVgo4W/1k5pUsxNryaR6dPrfqytik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEpKIFIuGn/uqtLor9Su7wrEfb9Ue/x5YPuy6L6w0DF2TYWz7uisZ/qbryUhgAQCe
	 KyADAR24DgdVn0zkMLuD7EX7hJklgemjQ6h8ChdFMprGlpXcHVJLEPTACT1IorLESL
	 RRyHI7hBE/UAPIQZDXxQ2lw4C6wwQHKuzHlDf3TtTgBzbkfLjc1i0c/g0762vxlr7H
	 TmRQNy9cJaQnj6JLBfURAJgDJancZU1KyGkUyKRtPi6J8aGWfIPNG02n5VEPa9DW1g
	 xq4LAtnSp0SgylNmCoKjG1pck6v8tZQ3PJX1KOHHG/MHrtDEf2VwZ8pVK/AMrGq58I
	 EkBjHm8B/Gt5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamil Duljas <kamil.duljas@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 10/88] ASoC: SOF: icp3-dtrace: Fix wrong kfree() usage
Date: Mon, 22 Jan 2024 09:50:43 -0500
Message-ID: <20240122145608.990137-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Kamil Duljas <kamil.duljas@gmail.com>

[ Upstream commit 8c91ca76f44804868d12aed20ebdbc2f89aa7d60 ]

trace_filter_parse() allocs memory for *out and when
-ENOMEM is returned, caller function, dfsentry_trace_filter_write()
trying to freed this memory.

After this patch, the memory is freed in trace_filter_parse()
before -EINVAL returned. In caller function removed kfree(elms)
from error label

Signed-off-by: Kamil Duljas <kamil.duljas@gmail.com>
Link: https://lore.kernel.org/r/20231116220102.2097-2-kamil.duljas@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-dtrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index 0dca139322f3..93b189c2d2ee 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -137,6 +137,7 @@ static int trace_filter_parse(struct snd_sof_dev *sdev, char *string,
 			dev_err(sdev->dev,
 				"Parsing filter entry '%s' failed with %d\n",
 				entry, entry_len);
+			kfree(*out);
 			return -EINVAL;
 		}
 	}
@@ -208,13 +209,13 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 		ret = ipc3_trace_update_filter(sdev, num_elems, elems);
 		if (ret < 0) {
 			dev_err(sdev->dev, "Filter update failed: %d\n", ret);
+			kfree(elems);
 			goto error;
 		}
 	}
 	ret = count;
 error:
 	kfree(string);
-	kfree(elems);
 	return ret;
 }
 
-- 
2.43.0


