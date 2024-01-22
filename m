Return-Path: <linux-kernel+bounces-33407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3F836951
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC231C23A75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03E7E77A;
	Mon, 22 Jan 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVaEDS5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FA7E767;
	Mon, 22 Jan 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936205; cv=none; b=H7ZV/NzHnlyoL+b/OxhiGX8w3zY7iZaNGYT4fAW0QX0uJwk6eHpjd2fcH0KAckaN04Mm2Ojo0EXgfHFq83KuZH+bsxtwnJ/QtkDFYFRsTLnBdfhbp6tfbfKqcsCvBw6+EIt71DXX++M7mcSbS+A7fOfF1UHGHG2/6bDMpxhfdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936205; c=relaxed/simple;
	bh=A0S/cY9h5f1v7f0qham4Hn8BDj9W4OtxXp3D12b51HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es+2K19vowz+A+ac7LfQoJfNhGEXCDn0QsEtd/+m+pdtO+NoybVSAd3QzUTmkhI8CpJN3OfRf/pGGp9u0GBOaXSUU/R9kCNv7zRQkZhmTo7n4Y6GGd1N6qkeCJ/bVSmwsYIUKgB92Kjp6W7fVeAgnzky07SBRu5keLnY6Y/NJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVaEDS5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49AFC43390;
	Mon, 22 Jan 2024 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936205;
	bh=A0S/cY9h5f1v7f0qham4Hn8BDj9W4OtxXp3D12b51HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVaEDS5IQSatFElimcEoqLw70B7s+lRXKnflgl+xkBqo9C+ZOLK6vC+x+arUCv4VV
	 N1o2CnEybHl+jdMtm7L0RdAA1rVdKScT+RRTWxNzVaFwi7deENlEYEZv4kHW9yK1CX
	 hGT5VV7mlTE8Ri7VHbTnYlP47WZ2AsFER9B3ujlIVcFhO03GlZ1RiKcZncglW3xlPq
	 owqdMuNpGQXsnylj6L621nP5CAzJ4z+MsqxX1aiS9JyIufTaH3f55CMRkmfGU6wcoU
	 hGsdc+ivIIaGFEVn9x+9UXkcfLwCzuK305K5fYNANavP0Zh4SCkA/jJPMtno7Khf7i
	 xNRMpxR+oW4DQ==
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
Subject: [PATCH AUTOSEL 6.1 07/53] ASoC: SOF: icp3-dtrace: Fix wrong kfree() usage
Date: Mon, 22 Jan 2024 10:08:08 -0500
Message-ID: <20240122150949.994249-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 8cf421577378..c626cefa0ec5 100644
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
@@ -215,13 +216,13 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
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


