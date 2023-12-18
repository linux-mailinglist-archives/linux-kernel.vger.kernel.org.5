Return-Path: <linux-kernel+bounces-4121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32781781D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB59282F73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB48E4FF77;
	Mon, 18 Dec 2023 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DoHiKEa3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C924FF63
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so1180585a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702919117; x=1703523917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6nTiiGacCNrmDCbMZV/7f2ztu88BMzgp6UsJ0N8RIdA=;
        b=DoHiKEa3oreT8CPe5mcDwVcQni1sj1apJC06llLpicF6cU46L5JkGhW3v997ZZsaID
         lI0QXcqkc0QOHRGhLwZrYNNlxVWMugW4v2b8pBqy3b6WEi7/6qo7CjoctNoLrkQstD6X
         /c4E7Klz+YFJ1CcT0bKCf7TWtBPkIF+W5ZJWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919117; x=1703523917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nTiiGacCNrmDCbMZV/7f2ztu88BMzgp6UsJ0N8RIdA=;
        b=wl5NvGT+TkdZlhX3VeCdXEKGPts3AAKXg5DkgLwY6fsE7AoRe77egdhm3jzVM8Uo9J
         XE4z6CxDH8JoMxoPbr31qhDdG28AzGZrzc9tjnQzi5yk2bgytb8FE7uElhyGNzKD4DEg
         0ZiQ7C6e28LdOTxkfXfElcLxRAhwYfY2DFyCzDaAhLSJcb0IZHoMVIOdxCXT4jvn1Ijh
         E3ryfZg/vFDOptWsucgKCvArbOBvCN+Ui8BitWg9HXRyhALarvkSoEi/Oig4JkNVAZtb
         14ENKrnXLhTKFLwGvn1689O1GktZW5lBHYV5NCr63PKxk5z3TiZG8AG+G6gN0d0Jq3mf
         vZtg==
X-Gm-Message-State: AOJu0YyHPJ52a8G3zAm6jLu6/loSGAv+SdIhfQsxDiK05o6rUcG3jQuF
	B/FePUcWUjnEvamyUqas4ZXs6w==
X-Google-Smtp-Source: AGHT+IHg9ABCbWkA7VoPZPr1sTq1sDouZ3GIy6+HwcJFobGQJk3C/ii80KtyGCsLQvm7zzyFgvOW+g==
X-Received: by 2002:a05:6a20:c488:b0:190:53f9:43ff with SMTP id eo8-20020a056a20c48800b0019053f943ffmr7065209pzb.45.1702919117178;
        Mon, 18 Dec 2023 09:05:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5163:2c6f:e99d:7dd9])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7814f000000b006cdd00f91fdsm12188049pfn.185.2023.12.18.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:05:16 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ps8640: Fix size mismatch warning w/ len
Date: Mon, 18 Dec 2023 09:04:54 -0800
Message-ID: <20231218090454.1.I5c6eb80b2f746439c4b58efab788e00701d08759@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 26195af57798 ("drm/bridge: ps8640: Drop the ability of
ps8640 to fetch the EDID"), I got an error compiling:

  error: comparison of distinct pointer types
  ('typeof (len) *' (aka 'unsigned int *') and
   'typeof (msg->size) *' (aka 'unsigned long *'))
  [-Werror,-Wcompare-distinct-pointer-types]

Fix it by declaring the `len` as size_t.

Fixes: 26195af57798 ("drm/bridge: ps8640: Drop the ability of ps8640 to fetch the EDID")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Sorry for sending this hot on the heels of the other patch, but for
some reason that other patch compiled fine for me until I picked it
back to my downstream tree. I'll see if I can track down why. In any
case, as soon as I see a Reviewed-by tag I'll land this.

 drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index d264b80d909d..541e4f5afc4c 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -210,7 +210,7 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 	struct ps8640 *ps_bridge = aux_to_ps8640(aux);
 	struct regmap *map = ps_bridge->regmap[PAGE0_DP_CNTL];
 	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
-	unsigned int len = msg->size;
+	size_t len = msg->size;
 	unsigned int data;
 	unsigned int base;
 	int ret;
-- 
2.43.0.472.g3155946c3a-goog


