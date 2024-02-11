Return-Path: <linux-kernel+bounces-60978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E8850C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F173E1C20D26
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8FB171BF;
	Sun, 11 Feb 2024 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLcOWOXP"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0A14010
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707692982; cv=none; b=Tj/0Eyth5qBu92h5Ye7lyUUTzxiyXCTgCqEKe9hR939TmqqYq9Pk5Sao6zv0CZ8VdURlIl+C+RucwSv6zbpvQyzql+bp4Bzxv4gE7HUQm40+XZf0jl20x134ZDwvHDFc6oBA7GAOmXJ3udel2rLUX5M7hcr4jt6CP5Sj0eeUJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707692982; c=relaxed/simple;
	bh=PBwTc0snBpC6w//kV2waa0nNNhztL61+Bau0t5MMRpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCtCasBRQTHsH+piaLNlEvTPgLBzGcOJpKwxR16/A4lQ62cLrA8LDL6K0TGVg83loO+7hYD4Ebbq2CBelE97Vo+VmKa0VMJIyqq+HKtoxiQtzt/iwWNHHmiwQW07JpRnX66Iq5HTVptMjfgNn5YncuZfcJRNt6NosJaBnnuKmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLcOWOXP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78406c22dc7so162909485a.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707692979; x=1708297779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDZSdShs6vj/lWP/S7/E1GOAK4CmrS93rbjOgt/s+9E=;
        b=GLcOWOXP7WjnbhVFtjdnoNvgoN6YGu7dmusK9LB+JuHJ5/jwFlj6SDNfNmmjuTIYOZ
         JDd7ecEWYs568Xv1014rt75qe9ubkeGhInrJxcxlQS5oWDrue+r0sph2VkpWUNH72NnJ
         goDFd3/Jqz+3OnRrcLHjOxVGQHpwIwyupFnnMQ//MDVZDI3GFYLiuwykcnNtgulY39iG
         WpAWkszSjivUdG7Z1uPRShRj95ClsJ9ZZufXqSqn0czjp3ZTIarNd+650r/SJKqq3w0V
         Cgl+e2ZeCsZKacmPc3Wd07D6mC0WMxyVFOE+aVXRARZmGSgkz8/NjqIvxxWY0xLPP+l0
         HZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707692979; x=1708297779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDZSdShs6vj/lWP/S7/E1GOAK4CmrS93rbjOgt/s+9E=;
        b=qQx0M/tc86pi+xW9jbtBAWQttlEF1aO+XZyhXfhH8jyHPkHARqe8an/WFShjuoq+Ah
         AKzNRX8V3XO/5L2zsSe8puGfVRi9b0NsGx/KZBxIQDLMwoim7JwXBTQjdx0P/9wLv0fa
         JuZaHyva2hMPNJAbdJ+ZAx8HVQ2PDi9o0nsiq/Bys8PWfLmU8SoFtCNO/UicWCN4B70Z
         IuwZXPA28FQ1GRjiX2U24kfEYc4vFMv5cHLeGHgcEuHcfQJd7ftIICNIDYUDP+KtkX8B
         +m3Z+ylX6PrsYxCCjgKBMFImRPnSKH1o6m2oTz1jY6gUr/QLHJlJ0gNyBCQqp1oJvfiW
         2KMA==
X-Forwarded-Encrypted: i=1; AJvYcCXDZAbHI9qCsBlQC8kPZI5JegmfZvNu/T4Jhu+Z9BzEV5OXckN+DfmIoNKfe8gdSPex2EOX+zIQegvuFDodLvLzO7/emBL56YI41KCW
X-Gm-Message-State: AOJu0Yy7q8kIwDFgBQIpz7KR6NEpGhXmW3n8oN9VOZ1hxE/Py9W5+lmv
	wwEeJywsL1jE4axmo8BuBJXhjI9CU4rKVgiRmg5O9erYcWNRyi0Q
X-Google-Smtp-Source: AGHT+IEB/0itn55YYOtAkQi6ez+VIx6nfzo099ZocfgyOQH11IHH5G9m1PD1LiZCZIz3bQBU1RY8wA==
X-Received: by 2002:a05:620a:530e:b0:785:bfc9:d293 with SMTP id oo14-20020a05620a530e00b00785bfc9d293mr5507721qkn.38.1707692979388;
        Sun, 11 Feb 2024 15:09:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGqurWOl57x9bgNJRz6cyWvOTe4crDyX9WLpj2s+URspqY2130GspQbY0lgSSrNKecEX+267I+s4HcJQp/nSjzhOzT/zHFKirIb1lx4UmYZ23pSoSGJFXlN3W4/Aq7TA8EPSaZGQOIGI4yqwXuvvuTEuwXyPN6xkbfl/0J7ens2FgoKo3Ru4B1kECV6KrS2j5Vg+b0jkDlWX7hP4nc7je7tseF4NcVZr1CMgoiRkZYqiAx4dAeWCN03DKN9rw2m19ge3ukDif6x/DjywyC2SuFA4zNVdXlNglwWQFoRE/md3SNgUWfU2AKMR8dpSTvP9NKpRA1Wxd/7EKJK1mbfG/ekUsbTCQ3eIJwZX8e0Ojwuk8KMjRuAK8wpkgkf43Pa+m+X8LXiODAs+ivI3uM47gmgFK2YqZOwcy0SoL0gc92BUfel/EfO+LejKf3ghNcxKR15GDJbg+IwjuhjAt1q1flwqbX/Gego+wfo/KZKvFJ8d5GuruyUB/uJJMkgc7qNboz/4vxIIXgXas0aeO33hdSkMPZY4fldYiSd5YLxKjS3WjZR3t8EjESL8q1sficyJraCEl+FqmdvER4kY7KyKMzpws0EH5S1of+E/Y910xz09OQX774Qv/5G58NxIncZNPc7jw1V5Su0eCf6V0IRxgM3X+0HkzPOqsNlvQFDe2g622ojM3Qctbs1MzzvCM5W1l2atGkeVk1YuXQ
Received: from aford-System-Version.lan ([2601:447:d002:5be:c8c4:8542:9142:2184])
        by smtp.gmail.com with ESMTPSA id a25-20020a05620a103900b007855bec5da8sm1589773qkk.16.2024.02.11.15.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:09:38 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Michael Tretter <m.tretter@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] drm/bridge: samsung-dsim: Set P divider based on min/max of fin pll
Date: Sun, 11 Feb 2024 17:09:29 -0600
Message-ID: <20240211230931.188194-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The P divider should be set based on the min and max values of
the fin pll which may vary between different platforms.
These ranges are defined per platform, but hard-coded values
were used instead which resulted in a smaller range available
on the i.MX8M[MNP] than what was possible.

As noted by Frieder, there are descripencies between the reference
manuals of the Mini, Nano and Plus, so I reached out to my NXP
rep and got the following response regarding the varing notes
in the documentation.

"Yes it is definitely wrong, the one that is part of the NOTE in
MIPI_DPHY_M_PLLPMS register table against PMS_P, PMS_M and PMS_S is
not correct. I will report this to Doc team, the one customer should
be take into account is the Table 13-40 DPHY PLL Parameters and the
Note above."

With this patch, the clock rates now match the values used in NXP's
downstream kernel.

Fixes: 846307185f0f ("drm/bridge: samsung-dsim: update PLL reference clock")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
V2:  Only update the commit message to reflect why these values
     were chosen.  No code change present

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 95fedc68b0ae..8476650c477c 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -574,8 +574,8 @@ static unsigned long samsung_dsim_pll_find_pms(struct samsung_dsim *dsi,
 	u16 _m, best_m;
 	u8 _s, best_s;
 
-	p_min = DIV_ROUND_UP(fin, (12 * MHZ));
-	p_max = fin / (6 * MHZ);
+	p_min = DIV_ROUND_UP(fin, (driver_data->pll_fin_max * MHZ));
+	p_max = fin / (driver_data->pll_fin_min * MHZ);
 
 	for (_p = p_min; _p <= p_max; ++_p) {
 		for (_s = 0; _s <= 5; ++_s) {
-- 
2.43.0


