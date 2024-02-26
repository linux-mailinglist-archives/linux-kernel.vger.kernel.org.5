Return-Path: <linux-kernel+bounces-82256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9A868142
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C028DBEB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70C131748;
	Mon, 26 Feb 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPcaERSz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC068130E3A;
	Mon, 26 Feb 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976484; cv=none; b=Isabqgj+TZumEYfgkvDh77tTDbzGfJpokWgVDIpAGrDu00OBl/FrdhZ8M9DbDzcZxKWEmuKfjoe0nwwY1KhSJ74NDg5DzIpu9/6v9BXz//9NKvTmxjh6fiwMLADVQ9FTo/Nv4YBsfGoewfIXGaCE68JdjmVhc/gotH23p5REXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976484; c=relaxed/simple;
	bh=edbpBEkpeIqUywNKnwkwMaghHIEfzwyGMaSGvyVM6s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fztaiHXI7MHqBsQiJ9PhS0UfVl9/F3wjdfBO5IN6M5bNHtlVErtfuJbu0l/VuIU+nDNqcYyRhQNGtI4pcLRPw8+xeQioX0zXgpaxaqHjqg45s6j8QDzvNWELnZCH88vHL2NUTvnrqVq939Rm/ez9k+zpfYizygHgbhCSAYjflBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPcaERSz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so50601491fa.2;
        Mon, 26 Feb 2024 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976481; x=1709581281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HILq8vE3I7ZzvY3bc/3MfQGbUQ+nQ5ixo1Vu9vm+DGY=;
        b=GPcaERSzROj+Z+PfdHDM1ayZErQK+593tNdGCwCz6g1bq2yctGJbhK8ECdXYgSGuih
         egSWoVQZXimDf1eqv4f0DMvJPpSpr0CukVpuusgiIRyTX28RYsxfU4tjat2gFrWXCjHw
         wdyNCdk8Z/aUQnzebY06U6VYloAJpEQTKGJC2q7KfmgMfHxDMtQOMfJAEO+/uJtAoMhb
         iOECU7TFcGKd2yGMaMhH0+vivoe9gUWdVtjb4PWZWuyZOzg3PnXYgtAZzF0mDO+jG/Gp
         LODrLG7UhJiBQNShDGeNdd8XjurZZUgHUGbxrYE2lxT+5yaFmPlshGce99OLXE+wJI/A
         BOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976481; x=1709581281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HILq8vE3I7ZzvY3bc/3MfQGbUQ+nQ5ixo1Vu9vm+DGY=;
        b=DimZMH6UJcX9chxkhEEUd/w3OpumoV4+CO9R+meYozj4y92+mpFzmlVJXJ40mSorik
         3Q1MmBUarymoLSIsUvdyyg1Ta4m0lRCpfMJbHIg4fN/5+GYbj1h171Hiqn3CVXAPuA36
         JV3oMO5QZyT9y08osNQol393Z1iFNJYBNtxP46Ewnizpe6pnK2YUjK7hB25xATOIIkDV
         8yRxXpzM/6bh58xqXIM7vyPP9mF4VPUiKNlstjSWW1sjW0EbDVMhHFxbNcXHWi7UwcLv
         xr3lDsO3B6QrTUiMzBfmJeBWVAdZbCz2upo2FpyuTf61G7ZJpltX09HwHzDw7rVoawnE
         n7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWB3+D/O0SIIkw+r24FWUBhJRx51l8cZeRXdq2QKqx6ektL0EFh4vHsCInF0fz4Mbj104HpawjNCwp58xwbxLwrdyloSwiG3psGfmXFpeKhIm+a/5YjclEFZOZ1YR6dWL17EzpmjuUianA=
X-Gm-Message-State: AOJu0YxSwOXM7BLUJ9F1i6XnKq2Kk8ZuzeQxcmXFkqSsyQHz/egFY6m+
	IkAil/yL6T50e5VsYdqyLrHcyPTf2eamMQzcWTE1KaIgnvHeOYKd
X-Google-Smtp-Source: AGHT+IEH5e5TmrvT9IU/hZ7j8nh3Mj80ahW9wRIMAFVXQY4jKbx5hnGDnJwk59SmYyykzpJbqy/Jzw==
X-Received: by 2002:a05:6512:239d:b0:512:f17f:2b30 with SMTP id c29-20020a056512239d00b00512f17f2b30mr6093664lfv.59.1708976480831;
        Mon, 26 Feb 2024 11:41:20 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm332328lfc.143.2024.02.26.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:41:20 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 4/6] staging: media: atomisp: Remove unnecessary parentheses from conditional statement
Date: Mon, 26 Feb 2024 20:40:21 +0100
Message-Id: <20240226194023.69070-5-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226194023.69070-1-bergh.jonathan@gmail.com>
References: <20240226194023.69070-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following changes:
 * Removes additional, unnecessary parentheses from a conditional "if"
   statement

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_sp.c b/drivers/staging/media/atomisp/pci/sh_css_sp.c
index aad0a40d08cb..281cbbb89a14 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_sp.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_sp.c
@@ -420,7 +420,7 @@ sh_css_copy_buffer_attr_to_spbuffer(struct ia_css_buffer_sp *dest_buf,
 		   lines below. In order to satisfy KW an additional if
 		   has been added. This one will always yield true.
 		 */
-		if ((queue_id < SH_CSS_MAX_NUM_QUEUES))
+		if (queue_id < SH_CSS_MAX_NUM_QUEUES)
 			dest_buf->buf_src.queue_id = queue_id;
 	} else {
 		assert(xmem_addr != mmgr_EXCEPTION);
-- 
2.40.1


