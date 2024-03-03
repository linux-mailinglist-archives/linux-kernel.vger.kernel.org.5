Return-Path: <linux-kernel+bounces-89695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4502D86F446
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7625C1C2093C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC1BA46;
	Sun,  3 Mar 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHX/kwrC"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CBB654
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460358; cv=none; b=UWA0jys5BsiA1wuB/gl8kUZeiALnOah2Z5Vhn0JINWTvMpQwQWOo8cR7RJJTkZkZTSl3MkTvs04Vx51i81OgBbWwyYkoniLlMDWaX1DaNT5Hm9eAjC40qtFx9IOu4WtZ/LCV88LwERVlNR3BhhrI2B6YsM9EWlS5x4c4Z4wGX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460358; c=relaxed/simple;
	bh=OmYET0QB0zeLXSGxbulUqK1HnTbhzf6jYRRsCBroE6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gzmk/p5S0hIp09RVSErYu/IJs1EaNNMtiHL2gzeKLUyAVZ1YaKiIutYoz0MUA1gT0omIdM9wlumAWOdrtO5BhTHsf1nPSnwJ+0iOxzKzP8GvJevzBzMgxNVsSJKQIVfmoTy7qTfPO7eArlz1bD2sQ3ahON/YRsjhyM4bfh4KP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHX/kwrC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d29111272eso53287271fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 02:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709460354; x=1710065154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH1ky7tDsOuUrQSh4kqJYPWEuylUXg0nuBp9vVXdmio=;
        b=BHX/kwrCi5Cqp2M3DYvJQwND3s6/O5RoWas6dOkH1zk7Mbn7/7YATpzoj909ghZceo
         zYmjfo9OrJnHkQpsUJdWx91VXJj0rBnT9rr4eih4GYaMDVE1AGvqZbffa03dFtKH9oCG
         uwKedqNDrVho8upARiyW3fVDjtYcn+YN3DRPGtc+94vXc1L6pMKrh0q/6tKoSy6g2K4z
         gtyS/CB8fjW4tBity3awyXuT5tSKOS33LbM61glVkbMSraPTZEkTJx3AHw+d+f3aTyzs
         N0LHFMtXMLrQ28FQb45t79oIEC3bL97tWWrDxDrQ5ls34gDDpbT8jT/RyVy2t7Xv8an3
         c0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709460354; x=1710065154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH1ky7tDsOuUrQSh4kqJYPWEuylUXg0nuBp9vVXdmio=;
        b=CyRkqCB8QcOvB35D8enp43lABX3Tfg0y10UFrrbd7slYCv6y47Lte3xFXfWlAlFx8M
         SC5ad/MVA0wRAZDUD1gTiY9d9VOR37U6xsF34GlRVmvmEDF+UtZf6Sd9iiszsV0knvfY
         EK6lzoq8GnDix8TNbSpD0uwSycc9bZsE5vNTvzxPyMepe1JEw4mVjR+T6aifZKUiRBIW
         ATyav4HTgGNbL7pQjqP0NiQTqfSTJgskUuRX/SrgjdRh1xrmy8y1pR563wiy8NdCxsyl
         3XphvenFX+s8c5V1mE0AjmRlM+FdVutJzTSEIHeypDUMS1uUUwop/wx7mudIcTBaGTAP
         5w1A==
X-Gm-Message-State: AOJu0YzbNoMwEbqKje/aOnrMsW+by/Etv9rbdBAp/K0WvlxvETsYvYE7
	O9B40EBouQak5HBsA4Uq8TezaSBiOH/xZ3USCzT+aHgTq8sVcV24
X-Google-Smtp-Source: AGHT+IEZVXinPCiO3KXm0qAAZIfUiLOJMk/yd4ylYi+UQWXvWeEPxY44iceYS8KUIeMWbG2wep2wOw==
X-Received: by 2002:a2e:8e93:0:b0:2d3:7e8e:de23 with SMTP id z19-20020a2e8e93000000b002d37e8ede23mr554596ljk.23.1709460354168;
        Sun, 03 Mar 2024 02:05:54 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id n5-20020a2e9045000000b002d24306ada3sm1264523ljg.120.2024.03.03.02.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:05:53 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/2] staging: vme_user: Add a newline after variable declarations
Date: Sun,  3 Mar 2024 11:05:47 +0100
Message-Id: <20240303100547.153636-2-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303100547.153636-1-bergh.jonathan@gmail.com>
References: <20240303100547.153636-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following change:
 * Adds a newline after the variable declarations as per checkpatch's
   warning

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index 2a92497c5570..a1b8288b101a 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -34,6 +34,7 @@ struct tsi148_driver {
 	void __iomem *base;	/* Base Address of device registers */
 	wait_queue_head_t dma_queue[2];
 	wait_queue_head_t iack_queue;
+
 	void (*lm_callback[4])(void *);	/* Called in interrupt handler */
 	void *lm_data[4];
 	void *crcsr_kernel;
-- 
2.40.1


