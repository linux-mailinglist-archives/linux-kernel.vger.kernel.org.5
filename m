Return-Path: <linux-kernel+bounces-133256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B494D89A144
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B8283BC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB216FF3C;
	Fri,  5 Apr 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2wu2uFK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A416FF30
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331088; cv=none; b=A50tWBLTBLu538Bn+Xw/4c0jsSvRyCwEiclVc/YxpFwiYhLDym+3VPI+CQ40/gSy4IalKb3InVF8tYELfMAqts5wAvmMbyX/UMLdASmfuW2hcMAl+wsTG849jNRJ4SwgpjQSiGYzFMZmO/4bVdxo2Hx/BzB2DTn9i98vnDezNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331088; c=relaxed/simple;
	bh=cXC6o2KXoVoS1fxorVEDM5VMh0EzbI3z75qBmbAsSQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN9bg7V8PYI0wTZGoQTsb5foRsW04QaMPjGE1UVEDOk2yxAVeYTJce3uwPnusbUh6ToNVPenqVYSvnZhh6G9HKcwnpw75HtGFLGv0XZ1bcG+y1KcAhAdi/nVi9SEzCPldZialWcGm5PXe75ielc7D2Dkvq6gU53o2mLk9Le5Zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2wu2uFK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so32931601fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331084; x=1712935884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLmSQbomn7jjoFYvGpaYKKjdNIRUVaXuPm21MTZkhWI=;
        b=U2wu2uFK+r9nak6VfOD2tQ45SFekynxIZffe6Gh49zdOSPAXxeA09xwEFLFVi4YQT/
         TX60cyd+qLr96QZXS/1wkSf/Jc55DHq6W/6ZZ4Ez6TaqVfpeyUGTr3zPneD4Gw9GHFMA
         bk7aJXjkti2ami41yYCfcZ1j/5NpB1nfK1c8FHJYiuFDDrDH+0xY690aDFxgpnxszwVc
         ITyXkeSaUkYakc8jo2O1g/m4kBhrIVP8PNDzSrtjORQX8sbygo6xr69P0oYzO8bCdjCq
         M0LbTUjadcejn0yY/j94AByRPcTVVeEsskVMjaHhVPErFe1vn7lpVLvKji53c4cZ5G5Q
         cFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331084; x=1712935884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLmSQbomn7jjoFYvGpaYKKjdNIRUVaXuPm21MTZkhWI=;
        b=c5WpP0IRzTvBCG/3Wo+95T135htblp6eIn2p53TZBi1c/jTK/lvLRHThEpqycsouq9
         aE39wFVld9XtG27EQb0nndUtLOlMn39avpQZZG8tZGJg02gNVXxFNUySSGOvWNHnub3/
         tWS52R6MldZ+Icc7w7upkya3AS0SQ/wEQUGElID9ywA6Fy59MEHwTnCZG30N0f7eo9hz
         gwdRp8NgstGAsmuwlntrlGcitVI+7E1ijCR75wk1+B9pfOOravmY76mpikM5Vt4EZArL
         WJTRlsX/MaxVCRqjPMTveRFjICwIKao2Rp76OUvr0k19Hw2GrX1jGfuKcfdDfbtszVPB
         lhng==
X-Forwarded-Encrypted: i=1; AJvYcCXY0UtnAi7Se7yGORNWdlUzKPyr2bAqbUyhMdr6g3a+5BSPKcT4OPTy/GTi0W0xSZMZPz3y4zsilNp1gf3KMqFy7LFyrhivOGWyym1d
X-Gm-Message-State: AOJu0Yx5Qix5Y0OPkVSWPsS+j2R39aFVzcRm+nzDOdXy4n5y61isc1qz
	EjZ7Q/J3ohQx2WPeMbrrc42HHifMbYd991D0HON1hDax2pmfOiahCmK6j1dWnPk=
X-Google-Smtp-Source: AGHT+IE7RgZin2OZ+qw13032XMFBtJshqJC/13QOVSjiQyPWaNMLxo/xWtEHTWGKxvCq6iMC0ubYRQ==
X-Received: by 2002:a05:6402:3716:b0:56d:c757:9379 with SMTP id ek22-20020a056402371600b0056dc7579379mr3103612edb.15.1712331064035;
        Fri, 05 Apr 2024 08:31:04 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id ca19-20020aa7cd73000000b0056dfda8eef3sm906752edb.54.2024.04.05.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:31:03 -0700 (PDT)
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
Subject: [PATCH v2 1/3] drm/lima: add mask irq callback to gp and pp
Date: Fri,  5 Apr 2024 17:29:49 +0200
Message-ID: <20240405152951.1531555-2-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405152951.1531555-1-nunes.erico@gmail.com>
References: <20240405152951.1531555-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed because we want to reset those devices in device-agnostic
code such as lima_sched.
In particular, masking irqs will be useful before a hard reset to
prevent race conditions.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
 drivers/gpu/drm/lima/lima_bcast.h |  3 +++
 drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
 drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/lima/lima_sched.h |  1 +
 5 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_bcast.c b/drivers/gpu/drm/lima/lima_bcast.c
index fbc43f243c54..6d000504e1a4 100644
--- a/drivers/gpu/drm/lima/lima_bcast.c
+++ b/drivers/gpu/drm/lima/lima_bcast.c
@@ -43,6 +43,18 @@ void lima_bcast_suspend(struct lima_ip *ip)
 
 }
 
+int lima_bcast_mask_irq(struct lima_ip *ip)
+{
+	bcast_write(LIMA_BCAST_BROADCAST_MASK, 0);
+	bcast_write(LIMA_BCAST_INTERRUPT_MASK, 0);
+	return 0;
+}
+
+int lima_bcast_reset(struct lima_ip *ip)
+{
+	return lima_bcast_hw_init(ip);
+}
+
 int lima_bcast_init(struct lima_ip *ip)
 {
 	int i;
diff --git a/drivers/gpu/drm/lima/lima_bcast.h b/drivers/gpu/drm/lima/lima_bcast.h
index 465ee587bceb..cd08841e4787 100644
--- a/drivers/gpu/drm/lima/lima_bcast.h
+++ b/drivers/gpu/drm/lima/lima_bcast.h
@@ -13,4 +13,7 @@ void lima_bcast_fini(struct lima_ip *ip);
 
 void lima_bcast_enable(struct lima_device *dev, int num_pp);
 
+int lima_bcast_mask_irq(struct lima_ip *ip);
+int lima_bcast_reset(struct lima_ip *ip);
+
 #endif
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 6b354e2fb61d..e15295071533 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -233,6 +233,13 @@ static void lima_gp_task_mmu_error(struct lima_sched_pipe *pipe)
 	lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_gp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	struct lima_ip *ip = pipe->processor[0];
+
+	gp_write(LIMA_GP_INT_MASK, 0);
+}
+
 static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
 {
 	struct lima_ip *ip = pipe->processor[0];
@@ -365,6 +372,7 @@ int lima_gp_pipe_init(struct lima_device *dev)
 	pipe->task_error = lima_gp_task_error;
 	pipe->task_mmu_error = lima_gp_task_mmu_error;
 	pipe->task_recover = lima_gp_task_recover;
+	pipe->task_mask_irq = lima_gp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index d0d2db0ef1ce..a4a2ffe6527c 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -429,6 +429,9 @@ static void lima_pp_task_error(struct lima_sched_pipe *pipe)
 
 		lima_pp_hard_reset(ip);
 	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_reset(pipe->bcast_processor);
 }
 
 static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
@@ -437,6 +440,20 @@ static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
 		lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_pp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	int i;
+
+	for (i = 0; i < pipe->num_processor; i++) {
+		struct lima_ip *ip = pipe->processor[i];
+
+		pp_write(LIMA_PP_INT_MASK, 0);
+	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_mask_irq(pipe->bcast_processor);
+}
+
 static struct kmem_cache *lima_pp_task_slab;
 static int lima_pp_task_slab_refcnt;
 
@@ -468,6 +485,7 @@ int lima_pp_pipe_init(struct lima_device *dev)
 	pipe->task_fini = lima_pp_task_fini;
 	pipe->task_error = lima_pp_task_error;
 	pipe->task_mmu_error = lima_pp_task_mmu_error;
+	pipe->task_mask_irq = lima_pp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index 6bd4f3b70109..85b23ba901d5 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -80,6 +80,7 @@ struct lima_sched_pipe {
 	void (*task_error)(struct lima_sched_pipe *pipe);
 	void (*task_mmu_error)(struct lima_sched_pipe *pipe);
 	int (*task_recover)(struct lima_sched_pipe *pipe);
+	void (*task_mask_irq)(struct lima_sched_pipe *pipe);
 
 	struct work_struct recover_work;
 };
-- 
2.44.0


