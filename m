Return-Path: <linux-kernel+bounces-73574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920285C464
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC6A1C20C82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B3133983;
	Tue, 20 Feb 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lR3tcSEM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D37602B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456329; cv=none; b=gGLwBwZKwtVSzFN7PLDwpCuk10BM48aV+TMMrfJ9pcm/a1e/f/OzPkcLLNtPjjT+DBDV2tUuUiXexaujiOahrLHk4bSRMYHZgbmWNcxU52s+yaxJHOWo7vA4WT7zxTBDF9N5RbVM8VC9EozkcyZR7JeuwKUs7W7YnWTUseKBQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456329; c=relaxed/simple;
	bh=UV5OpmpTeat3ITv1BlNGoqwicB3qNORaSpRz3WR/B0Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qhh7FYEEzJ18mHK0ihxXhvYopjULDN1hgFszFECzoukIIBRa1KrEqDJIo5zw56Kl6DGF1W7liidD+cBysfqWRCxvaD8lM7vcWRu8uLXjSYAzGtvQ3j9DBDpvDJ91JfihAbEeqBVDzyru87tDoMxAndJ5cJHWOot6g0OJu3fjA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lR3tcSEM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60770007e52so62620597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708456327; x=1709061127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bU90kCEdhdXywfoVlc2lzAzGm8wFNOTBAuo+9ULMyJM=;
        b=lR3tcSEM91+atxZwb2pJMWNRJ1q2Lh3XLxNPB+gEXJNZ8Uf9QgW52wmFiQCpYmGRRM
         ZdOkNcgMxNbn3Z5e9qpuQF4p1oR4Y8crpqBzf+pV5oZFbk3fSefICN+R2YdB0fuYbWOK
         ZiTNhXP5pNJFfrBMMD6uvPdK/TIEqhplETjk42fF5u4INIE/UPfpf2nBXXUAi23v1as0
         +zoPJNTnGxojplmoH29ULDdT/MlmVuUs0BEVbt++owflZzkuxV8bVbyb8cGYRW7fqZrG
         dLpATMY30Xqr7RTl9sLaobjeDdyVSr839KKCl+HVE+ETZA/SuiePB+h9pOrXEyesMDed
         y0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456327; x=1709061127;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU90kCEdhdXywfoVlc2lzAzGm8wFNOTBAuo+9ULMyJM=;
        b=MBnhfQiAx4n41BmhKafavwhoW3OgGTFUhQL0VGj2KDctIBKYroyqJN9zyrUEWsmauM
         hSCrKe9VZ/2F0LUuq4P1sjAROqx+0PrLpUsoTbhhxxgo7nsEXMMmMTilLDwm7cL5PvtU
         JkfbIAS6sIgRSzhriGS6Vbw2mYFIrnsLrXU7pu229nGilK7uh6fadxWk9U6D6AVKqT5M
         atDWbhjir7LK+T6lRkkPypkka/BKrBEWj1B1m6FhQwXY6M/HmoNFliMXTZ87Lwe5pwOZ
         Xx09dWvOBXZWjXK0qp/pYT7aSoVBHUFMcgh7vm2eq2EnOwjrHs4EgcWtb8gilot6TEmW
         C94A==
X-Forwarded-Encrypted: i=1; AJvYcCU0UCOh69Ho52VpQ6UcUUSzJ0z/nsYnW3e6FXsoMO2yag2IVaHcAOgW9ph0t2PhwEO5I7b/O1BDRhVrY5AxlQ6pdBEc7vTsnJRMUz9a
X-Gm-Message-State: AOJu0YyoJS32/btWWs4/KIGvqN964AqTBSg3pa46crrdtU0tmgttaws4
	n4CI3WJ/dQIsOPqGmEFqwZtWfbgwx01yWahhLsHfxVUIayUCfkxfMPavmgByfLhSQvuh7qKfs5G
	KhLoauw==
X-Google-Smtp-Source: AGHT+IFgWEyzh6gqAlMtSgK/wXXqU4pIoql4Z5IpkPLY2RoDnc1t6RBLCmFcVpYqnlcf+nvulgO8DKFOkeQR
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:e64d:5a86:7ce2:3f59])
 (user=dhavale job=sendgmr) by 2002:a81:fe07:0:b0:608:22c7:1269 with SMTP id
 j7-20020a81fe07000000b0060822c71269mr1506123ywn.0.1708456326859; Tue, 20 Feb
 2024 11:12:06 -0800 (PST)
Date: Tue, 20 Feb 2024 11:11:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220191114.3272126-1-dhavale@google.com>
Subject: [PATCH v1] erofs: fix refcount on the metabuf used for inode lookup
From: Sandeep Dhavale <dhavale@google.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: quic_wenjieli@quicinc.com, Sandeep Dhavale <dhavale@google.com>, stable@vger.kernel.org, 
	kernel-team@android.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
we do not assign the target metabuf. This causes the caller
erofs_namei()'s erofs_put_metabuf() at the end to be not effective
leaving the refcount on the page.
As the page from metabuf (buf->page) is never put, such page cannot be
migrated or reclaimed. Fix it now by putting the metabuf from
previous loop and assigning the current metabuf to target before
returning so caller erofs_namei() can do the final put as it was
intended.

Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/namei.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index d4f631d39f0f..bfe1c926436b 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -132,7 +132,10 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 
 			if (!diff) {
 				*_ndirents = 0;
-				goto out;
+				if (!IS_ERR(candidate))
+					erofs_put_metabuf(target);
+				*target = buf;
+				return de;
 			} else if (diff > 0) {
 				head = mid + 1;
 				startprfx = matched;
-- 
2.44.0.rc0.258.g7320e95886-goog


