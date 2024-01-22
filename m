Return-Path: <linux-kernel+bounces-33325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382A836868
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BA31F21662
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60CF60B8F;
	Mon, 22 Jan 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2CKp54U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E060BAB;
	Mon, 22 Jan 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935891; cv=none; b=OFQ1In2dL32bDcp0FtcPw0DFIFZ3PsvR/W4aWnhtPMbQn33++xXKnwlAN9PauopdsQuef+060ChsOQc6iZ/VlmbHzsm82daVupHjFCTa1XTe4bvTxnaCLcRWzd+/8mjUDR95XVVS6zGDrI4R24UVp8Db38/ss9gVBCoGSNA+y0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935891; c=relaxed/simple;
	bh=VcP6uwD51JXmYRKVMSfvM90rlnQYA4eqCW0hRNoYMy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlot60bIilH7wqtuv6/PPpFMPuyr7YTlyViffF6LqXW54pBQgPyz2BsQEimCA6AgNBdZsI/oxEhzgwuVXRSV8LgVZ+En21U9wkeearxmr/pae9bht2w6iVXQpB0j69v1kKT88mqTI093iLULDTlRgCJ/UzvNgjrKeAiD6sBtj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2CKp54U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03121C43399;
	Mon, 22 Jan 2024 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935890;
	bh=VcP6uwD51JXmYRKVMSfvM90rlnQYA4eqCW0hRNoYMy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2CKp54UHhQaVy1o5YugPj5f8TNpSH5TkuURYrR3U6iD4JgOqxaw0xHDhMTYw/Ro2
	 2DKQMx2rGYewhmQPbEsQTTukDdYBkCcY+w6MU0x+iVWw472sgnxNIRRtxeN8i7i4NR
	 g6aeObKZjAms/fPs9N4ARN+tHNV0fPpYdILdby+ieiJMGvVVr/msHqn5Rxtt5AylGr
	 NpFqFBlJtHgdkXJ69QusdOGVwUnuVX8X+IhzNFae+PbrMPHae1CgoWK9GMiY8ybvjD
	 /OuldLEoXFf52c3/1MegDu6r2y7rNh0xKrbEopyMaluAPUribgi1S9NngJ2YqEIDMj
	 R+cep92elz78A==
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
Subject: [PATCH AUTOSEL 6.6 08/73] ASoC: SOF: icp3-dtrace: Fix wrong kfree() usage
Date: Mon, 22 Jan 2024 10:01:22 -0500
Message-ID: <20240122150432.992458-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index bd07f0472efd..8b5b128db24f 100644
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


