Return-Path: <linux-kernel+bounces-28495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E582FF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EF81F2689E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF76AC8CE;
	Wed, 17 Jan 2024 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF7jexBT"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74BB642
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461148; cv=none; b=WbQNAtYiP7HbX5i7E8n2Cy0motHButDFKCzxUVQ4o7xN6u1prBp7LMWRmb/VTC7poeyOtkYRv8qeln7J92VJOhg4/FIeeCy4NcxuZcQyUpGX8LRppaXJc4+6Yujgpm8h9aXWwBYrGJeEGcsz664jEI/I3MCgigtJvYZ6cWjKMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461148; c=relaxed/simple;
	bh=VICQkZ3AboV52RhoDU3TsfC68unKvLe48saOLuiFWlU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=H6ysNtAKZNkGiWQo6zUxmWoK9jCw6PNYsFzc8Nna4ombPzfwo9/d8lrG56tMhCPlrLJ8cX138G06//UGyneqD9k6GBSmG7CqmWjaEgkkiyhP6DSZCfxggQD10oKic6v7vZ96m0rPJh9CojOV1/l+rSdOTT5F8UxPn/99GWpWS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF7jexBT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso11768134a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461145; x=1706065945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWLq4aGpb7f9s5ZfnYqz3MCWQjdIg4mIg649H1i2jNs=;
        b=gF7jexBTUpVDiPV+yb7ONDuy8Bz0FkyEN8dpB1bD+yJ5WHucfzI/TDoC44qr9zZDGd
         6nzdHTbJoav+jYd2k4MhnOo4GnkNsySypOwkCY+dmgynoI174Z53JGxpKKkkCvdF87vU
         QQrWeqW1KaG5IcAnOqB1Mk2etFuhmXL8krrh4TE7JuAXYLiq/k0Of1lFBWwHtfpQ/p40
         AbSob4e1L/qJh7peEHYC98AThbgrU58Y9wDGNON26CVnACv1qfQr/IYvzZC/O6RVU0wQ
         r0fynkY6lwSNE5yOBEwzrqvJ663vwx01ITm7dB97gFKiQGgW2cqw78yxsj2QHzeKDrbk
         dulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461145; x=1706065945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWLq4aGpb7f9s5ZfnYqz3MCWQjdIg4mIg649H1i2jNs=;
        b=OScY9+9WjEU5/bmpldM+rZHuqtV1/ISAwlQW8PRv6/HX3F9kHoruxsYUsTw3X104pE
         bLSlkMiI5s4u2ZepvhVHVWtCzQcKma1ZXX5Jvr1wzcXCI1BDpB1lSAqAxWrfv6gcXd4y
         bvqnSDFnNx2rnJGETT2rK3lumwIRfS6zVNx7wNHrtrgBQDdtE37F0YtjueFnIT+T3CkJ
         ENz9JQ0v/8VTDHMPRPB3HJeBFT8na2SyX4RSq4Fe1NY/ztspfXZjBXwpXmu93S7scUG4
         Wbv8MdJp1zw4YpOuw6PKfnAQb9LtloZW+/BcdvTQwdIy6pAHJMxiKW/QqPLB1CDmEZgS
         Xueg==
X-Gm-Message-State: AOJu0YyAKzBWbgUdO/VELq5PWhjOGmgCyZ1LQQwy5D5IcEK+pRCg6AFf
	+YRoLnsYD/DUwuSG/rvfqpY=
X-Google-Smtp-Source: AGHT+IEmjP59OWSgsLUizwfI6NeAlYbd3r1WGISp0XSIEokfoWGm9jE1WbdrHhf6/lWKig7M+VYPKA==
X-Received: by 2002:a05:6402:74e:b0:559:b3fe:5cbf with SMTP id p14-20020a056402074e00b00559b3fe5cbfmr433485edy.7.1705461145176;
        Tue, 16 Jan 2024 19:12:25 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm2258418edw.95.2024.01.16.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:12:24 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: anarsoul@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v1 6/6] drm/lima: improve some pp debug messages
Date: Wed, 17 Jan 2024 04:12:12 +0100
Message-ID: <20240117031212.1104034-7-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117031212.1104034-1-nunes.erico@gmail.com>
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the messages more consistent by showing the pp name.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_pp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index ac097dd75072..d9e178d6645d 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -197,7 +197,7 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
 	pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_FORCE_RESET);
 	ret = lima_poll_timeout(ip, lima_pp_hard_reset_poll, 10, 100);
 	if (ret) {
-		dev_err(dev->dev, "pp hard reset timeout\n");
+		dev_err(dev->dev, "pp %s hard reset timeout\n", lima_ip_name(ip));
 		return ret;
 	}
 
@@ -423,8 +423,8 @@ static void lima_pp_task_error(struct lima_sched_pipe *pipe)
 	for (i = 0; i < pipe->num_processor; i++) {
 		struct lima_ip *ip = pipe->processor[i];
 
-		dev_err(ip->dev->dev, "pp task error %d int_state=%x status=%x\n",
-			i, pp_read(LIMA_PP_INT_STATUS), pp_read(LIMA_PP_STATUS));
+		dev_err(ip->dev->dev, "pp %s task error int_state=%x status=%x\n",
+			lima_ip_name(ip), pp_read(LIMA_PP_INT_STATUS), pp_read(LIMA_PP_STATUS));
 
 		lima_pp_hard_reset(ip);
 	}
-- 
2.43.0


