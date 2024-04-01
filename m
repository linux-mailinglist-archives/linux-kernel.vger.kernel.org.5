Return-Path: <linux-kernel+bounces-127076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9DF894676
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B323A1F2256C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC654BEA;
	Mon,  1 Apr 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8mov7ER"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424584683
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006436; cv=none; b=ZpOsuuDI5IB5MJoRKNWeqgy+6x55wukvvtkD5D6vD+x0nsY4HKlvvLMmNM+ozwLd59Z9TUYBMhn/f2RA+yNwuaXKbnctxAhNX+twZHpyTc3dxsd7gQchhP1ZOeKWZhEyX0/9HFjbMZKhOgXaZLfDt4BJqVxtz4gnp8nHVcmAfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006436; c=relaxed/simple;
	bh=vT/AW0jz/eIGA6MYYfDf8sPYADaQJOmtIELLk5M15lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljoUDUYkuqiWbHW3PIadrrnvX+XJv03uuO2XndJyc9q10Po1b5bzew9ZdsDQh9D1kB1dlmXG/veRKD92P/vA/4L5IbKGh8ACkamAMsBqn17oeRF8xVd72Cgx2L+8tw/Ii0umh5z5TkTr2dT9OkxevfVnjJOLCllCHDBTPHSy5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8mov7ER; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4e34d138f9so404063466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712006432; x=1712611232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rtOIDYuOCQzCWWiPyJve7IUdlBxqpyYfYMB6nDSQUYE=;
        b=P8mov7ERL4Cdj5bVzQOsXBA9mViM97jBZtxkTufE+p3depEPe/BCGPLrDgNZAeKxdm
         8Kuds9j1lu8LDNEcN/j13zQG5ojYH3EIK545hwR3FgnSaCB0Zb0DCeFFXmcKA5L6O5TT
         vu8hqpD48M5WVvhXFiwH2MNuCqeOdAQ115LQeAeMwdpTjN3O6CzlkKqx/R5+KVY4majY
         KKYYxSsRt2g3H9XJTGQpICgaMIwrSVsFdtbgzj8oEZKOxoufnhS3plPN6D3vEM4+6pxX
         0VBKbruxpylyNAusDit1TAPQykjgpfIa3oDqsIGYkGReqAl9U4aEIURNcL2Xh6YQiYQ4
         K5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006432; x=1712611232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtOIDYuOCQzCWWiPyJve7IUdlBxqpyYfYMB6nDSQUYE=;
        b=LlK4yT61qVaLZ4E8fTtWJdEv2BwL29mrmTEC5Fq/jIli6/NxhBeRiG1skFfwC+9y7K
         8b3tcYSzU/6f+ER7HbX6Xa+g6aL+t/9QMDW383Wo2D9TjqDAOpoXyy8T4BWlAY32Lthu
         DOLmeFIV3wXTlD+g5Ru6kmnzc9JBwKVhhRbDoVwCacN8vflfLtGgOfHmiNwWYC4k6har
         fVZCe0X1qCvwmXSvnlqWtfShp/ob+8IgFl3nwz04sY8Md/1hVrMPlEjbE3fMjae8Yadb
         9qKSd8xd2RApIyAylBgdOxZE9JXzxfVMW61BqiqsnKyZ0qELa+S3NazFb/cN++SnxtIz
         z8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVihmU2xkW4567MkeBo/YuUZ+rOftapOboJUcTwIYyxbLMEVRgSHRQcHDbN3dN95slJxSPbrwBhjDVwyti11PVSowIGy3TS598P5rhz
X-Gm-Message-State: AOJu0Yw7BBWXdsa9axV0yH4G7Dh5H4r3QvV4PCn4DJBb5mY2RVMCbVom
	vQYQSIg2xOv+8YD8oFOFN9uWV+2HhNJKrnSr/kJtZzPgDxBBC6Z/
X-Google-Smtp-Source: AGHT+IF/1TkflsuVeUnLYItXsThhHP1RqlVmXnxmKiYJwjqy0QVVdJ/iTih7AO+b1juMz/6FKNa80w==
X-Received: by 2002:a17:906:4553:b0:a4e:6f5b:17c2 with SMTP id s19-20020a170906455300b00a4e6f5b17c2mr1937387ejq.32.1712006432519;
        Mon, 01 Apr 2024 14:20:32 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709061d0c00b00a4da28f42f1sm5737881ejh.177.2024.04.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:20:31 -0700 (PDT)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	christian.koenig@amd.com,
	megi@xff.cz,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 0/2] drm/lima: fix devfreq refcount imbalance for job timeouts
Date: Mon,  1 Apr 2024 23:20:00 +0200
Message-ID: <20240401212002.1191549-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup to https://patchwork.freedesktop.org/series/128856/

Patch 1 rev1 from that series
https://patchwork.freedesktop.org/patch/574745/?series=128856&rev=1
was dropped because it needed a better solution for a race condition
between the irq and the timeout handler.
The proposed solution in that discussion is to solve the race condition
by masking the irqs during the timeout handler execution, which is what
is done here.
This bug is very hard to reproduce with regular applications, but I
found it to be reliable to reproduce with a program that triggers many
jobs right in the boundary between timeouting, so that jobs still manage
to complete while the timeout handler runs.

With this series, I was unable to further reproduce the bug.

At first I had only the pp and gp irqs masked and the problem never
reproduced again on Mali-400, but I still managed to reproduce it on
Mali-450 after hours of test time. After masking the pp bcast irq as
well I was not able to reproduce it anymore even on Mali-450, so I think
that was the missing bit for it.

Erico Nunes (2):
  drm/lima: add mask irq callback to gp and pp
  drm/lima: mask irqs in timeout path before hard reset

 drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
 drivers/gpu/drm/lima/lima_bcast.h |  3 +++
 drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
 drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/lima/lima_sched.c |  9 +++++++++
 drivers/gpu/drm/lima/lima_sched.h |  1 +
 6 files changed, 51 insertions(+)

-- 
2.44.0


