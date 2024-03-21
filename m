Return-Path: <linux-kernel+bounces-109715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F7881CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F42283EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEE4DA10;
	Thu, 21 Mar 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgwLZfty"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3F3770D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004990; cv=none; b=foeDZjElLJ/l1WdpK0nr9xtEG8fBbj74K1ygJWlG++vTa17sYuO3O4jSDiWdsHgibamINIwElZ9iCeHOdpRA1UDXucama7jOdXKdblmLYXyKYFUChc+bg59N5Z+khwWorBg7ZWXJRBWtb6GnzANQU27z3hs2XrIMDJ7L7hEwB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004990; c=relaxed/simple;
	bh=q5R/sV0oThhoaTn7BNDCxLdWwVMl9Bypnpb1bNRWY5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ep7qu6WYdnr9QSOX7esFjn6cWrVb4RkLfYR+gnEHm2+lx+zBnsCPgQZkNaGpgc6k4wiu3Y56TaOR7zCVVxcvl8CuhbXJybbsSRNE3nL+X40t869KOLY5RbCeIgeLcFS4q4iI5CwJ+rME66iSmDlKf8CEpG6byuf41YVESZaBJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lgwLZfty; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e00d1e13acso3942815ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711004988; x=1711609788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRY0pVFx5hvWyvGusyC9aLcoBfDJnjCMV4j0O5N7/aM=;
        b=lgwLZftyzQK3+Xj/2ldXhMLsI1FSk/rzrcoOXrazDuvI9q+U5+nnsEe96G6gMeg0MU
         hQGGTvWOHEhVSZwQiRoPaq6MCI8UbaE5FfRoEzGWsCoeOfQQ3qJlX5RGOcHI0eVSStbs
         IKyYJDNN+LMN9KQomn/4AcaWkxW5qMKD7KupE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004988; x=1711609788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRY0pVFx5hvWyvGusyC9aLcoBfDJnjCMV4j0O5N7/aM=;
        b=eW8ccQjx5laOh/ZKcEafZ+gZRM2Nchl11Yshk/W+NPA0jD4+2bX2Qtcc1onMoLHY1r
         PjsHTDO40uj9wG+OWl/EES9WazBDk2I8/+vG0727Tl6OTA6VvvMS7Dkw8ihMBkRAvleO
         s8LDBjXwPVsrmpOy713uHa1NCYd/p5bY1UEaglstnTlpQGhoWu9SNhTICm+uBGU7MdYE
         KkrVBAUeqM54ZmHb9Z4YCaIrXpqKCsjRVMiYbs8Eg8nVikc91Wrd/WbQ7+BpBvn/mhfL
         0UjheUdANpE56aqc254DhdBPAFKTYUQEG16GrUKK0sVRUfrsynSLZo/nP8O8dEOxv49z
         r2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbtlXRSKAIMiwfsQYa2Qs5AAWbQEhA/iFYRT4zyoAn1U43xFfy45iGakneI715g7kws/tMCGZHPa4pzx7gWfDRfE8oI6dRYLqXCqbb
X-Gm-Message-State: AOJu0YwEWfl6YkKBUEaxCo+zwfZfcVh3Z+0qFyPauUF5KeBnwodt8lGg
	k0xnRKm0wIz+uDoMBn92fHvQxx/ZlQTAUINReLCsa0plZd1gar6k/RIoijY2Ow==
X-Google-Smtp-Source: AGHT+IH57yxJiEyp3oRKr8txV8M/DfsK8WHQOpuCYRXilXXDGc8rC+frhVE/5DbrWBUAwhTudJ3yqg==
X-Received: by 2002:a17:903:13c7:b0:1e0:11a4:30e0 with SMTP id kd7-20020a17090313c700b001e011a430e0mr5267687plb.19.1711004988238;
        Thu, 21 Mar 2024 00:09:48 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001dbcfb4766csm8705582plg.226.2024.03.21.00.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:09:47 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes NULL pointer access in spi-mt65xx.c
Date: Thu, 21 Mar 2024 15:08:56 +0800
Message-ID: <20240321070942.1587146-1-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains two patches for spi-mt65xx.c, both focusing on its
interrupt handler mtk_spi_interrupt().

The first patch is to fix a NULL pointer access in the interrupt
handler, which is first found on a MT8186 Chromebook device when the
system tries to establish host communication with its embedded
controller.

The second one is a decorative clean-up when I'm working on the first
patch, which simply renames a variable to better follow the rest of the
code.
I put this after the first fix because I think that will make
maintainers and users slightly easier to only backport the fix if
needed.

Looking forward to any feedback, thank you.

Regards,
Fei

Changes in v2:
- Restore a missing curly brace being dropped during rebase
- Fix a typo in commit message (trans, not xfer)

Fei Shao (2):
  spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
  spi: spi-mt65xx: Rename a variable in interrupt handler

 drivers/spi/spi-mt65xx.c | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


