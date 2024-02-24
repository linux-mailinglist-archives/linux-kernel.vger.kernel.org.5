Return-Path: <linux-kernel+bounces-79393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77186218D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7D928709A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5E79DF;
	Sat, 24 Feb 2024 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caEkkQyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0C63AC;
	Sat, 24 Feb 2024 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737053; cv=none; b=TA3voLpo6OyXFqHpTMs1+ucsyr9PiIap+wDO0l1vbTVCKGjBWpDaCh1y4khVc/glowL8D1iJ5yaT5z9yBNJeyPcNKkBAuOqei7EBesyc7gTOe3lS8ZzlBlZgji7QFNIf3Q9ZBpLhzSrQCH6GGudLtxxz/FLNBiXLwQcA/MEiB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737053; c=relaxed/simple;
	bh=eJon+naYLvX2TtPG4PA+bOIKoeqRl8FeptOhgYTmTjY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkWS7CqtztPQFb4lye3Qheo9Wh8B9SRVFcoBFWNRVRfRiklceMSN2MztIwEiD1VKbSQJxjgNCUrhRXghpbkszpjF3FRjMtkv6s3SxntA5bRUXhzNiDcgWKruFvE3TgS4Qv387+sip6PZtZF0KdRzuLbboKeXeqHwh8QyVDrnFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caEkkQyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157A1C433C7;
	Sat, 24 Feb 2024 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737053;
	bh=eJon+naYLvX2TtPG4PA+bOIKoeqRl8FeptOhgYTmTjY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=caEkkQyzIq0Ve+Ewj/ihNiVZjSYmf5e1Klx0MPBtyINMpbgb6aCxsqckZ+GRb8kKK
	 zHIlArrJNyH+I13vprpxjOTejJt0fy5KpBtrBDFdLrF8getzqnngOgaRagSoc7hMiY
	 rhyAo8S8GXIfP+Oe5ms1/NuSh5tAB/tywCZP/gkYPYjYQMJ4M0KD69CaAfIPpWShYJ
	 7OFgAkkMbi0XGgXjHiqbRpJrsuaq6pdNff6nrs+fE4EyuM7uR0gjEHs5twu8Btym2f
	 Ao1hKS2DnwLicW4aFYYqZeIgm1M4BlajMV1TLu7akKwpYlP+0Xm0FcGsJKVpcme+nl
	 IONWowmzq/AmA==
Date: Fri, 23 Feb 2024 17:10:52 -0800
Subject: [PATCH 03/10] time_stats: fix struct layout bloat
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873667989.1860949.8776444464588431097.stgit@frogsfrogsfrogs>
In-Reply-To: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
References: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make these more efficient by getting rid of the holes.  This reduces the
structure size from 224 bytes to 208 bytes.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/time_stats.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)


diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
index c05490101d197..1c1ba8efa7bfe 100644
--- a/include/linux/time_stats.h
+++ b/include/linux/time_stats.h
@@ -77,19 +77,19 @@ struct time_stats {
 	u64		last_event;
 	u64		last_event_start;
 
-/*
- * Is this really a struct time_stats_quantiled?  Hide this flag in the least
- * significant bit of the start time to avoid blowing up the structure size.
- */
-#define TIME_STATS_HAVE_QUANTILES	(1ULL << 0)
-
-	u64		start_time;
-
 	struct mean_and_variance	  duration_stats;
-	struct mean_and_variance_weighted duration_stats_weighted;
 	struct mean_and_variance	  freq_stats;
+	struct mean_and_variance_weighted duration_stats_weighted;
 	struct mean_and_variance_weighted freq_stats_weighted;
 	struct time_stat_buffer __percpu *buffer;
+
+/*
+ * Is this really a struct time_stats_quantiled?  Hide this flag in the least
+ * significant bit of the start time to avoid blowing up the structure size.
+ */
+#define TIME_STATS_HAVE_QUANTILES	(1ULL << 0)
+
+	u64		start_time;
 };
 
 struct time_stats_quantiles {


