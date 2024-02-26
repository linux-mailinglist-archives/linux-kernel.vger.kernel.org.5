Return-Path: <linux-kernel+bounces-82255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF42868140
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087CC28D083
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F59130E52;
	Mon, 26 Feb 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdQvpaI+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDD130AC0;
	Mon, 26 Feb 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976482; cv=none; b=UDEcAVqsMEOHrLjE1ak9hxMs5OdOza0X0UQmzYmz+uvyUtnU2SN7RcdhKOjWhvmX9MSQeZv7ONKnbG4YzgACS5P00EXh4Qp9KdCOKx1b8J5pWXQCe0GfBoIpuM5/kCP35opw5BqbRRU+nzy/8TzwGZ/kW5GkGQYh9BmynLViqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976482; c=relaxed/simple;
	bh=n9VMTsl5EbE3QRKYwB1+/X4b93ZHl/WUQpm56MegPTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UV+eL1HldhNGYcX9WIFxRf+HilyKvjXPA/OcOGf6pvzBDERBy/BuooimxaSYhUpQXWALZ2JaPMyWwXjcHz1ZkodsjeIOdIiX/0sboi4JXy26xKgSwNCeGAEh2w4FbpeFVLVTae6owfGe6VZZjFHZyrZTvlCUrjVMM/nLZnWjizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdQvpaI+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513031cff23so221640e87.1;
        Mon, 26 Feb 2024 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976479; x=1709581279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdk1R1nAFAYYkP7IQxHcP9QAcpxTnZuCyz69UQAIi0E=;
        b=kdQvpaI+6arFH4xlH2OS+GDmLG/gwMj0nECe7mSQxWkAzHytEIYgHY1JpL9xfhyffp
         yJGUiQ/M2paG1zXZzFArQF7fwbghX1sk8P4XBnejYTOMRFwS7vFYgzaDOyYtw1qmGUSL
         qLs0wBNgPaJ0y26XcjergEFNvlRF4860kz7JOz5LDxeRXgPgSXiEm7UQKxzPn2eTaZuc
         ueyIk7Hj7n5UzhV9b7eFM8XHs8m/OyJ9pafJEA8LV7NOksbPe4AA1qKxDkwmlm1HYfY2
         lxMxyHwNabI7m9RkmUUb/zNwcldjPRZBi0p+2G8xS0OUeyli/W4zNlpB11cwgG2Ql0AS
         1X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976479; x=1709581279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdk1R1nAFAYYkP7IQxHcP9QAcpxTnZuCyz69UQAIi0E=;
        b=YHdypiRl54a1UUvADRRPeuc+mOiC6MKrVRVT9d+nz8KMpblrlCGB3XIX3epWhKEh4Q
         D3E6VCZzwAplqpkC9/wn/kXeewsEVoXVnFANxeoFR0/CFdfoTQ1eIWN9K2zP9L2ufVyn
         0c43wfZPhM9+lo8PC/zENz3CClh/zqjLMwYw7KDGsUEGZpaBq6Fxj8z6vBeAydUC01Su
         YiDADIQjbDcaKmYavJs/iws2ionGehEFA3HCxhDY5w6DWbzG/ljNSjWJe4wWhx40FrwB
         c6wj5J2Db8MFRyKqdBdSU06k2yofqveIdhnBUVxxJnVUZFfT4HWNEenT6xBleit7EyWZ
         zP0A==
X-Forwarded-Encrypted: i=1; AJvYcCWn11atSdKu1Rjjkx9B2bUPGquGwvTkNP1znlJXv7MD5NE974ofR3CCSi0zylwUEzAsi5fIaHtOhSPH/qPBz41sa7J08BLnyWFCNAIJrKWygXlNX90WTEnqGutwON80EfFw9MI0zlDhnPk=
X-Gm-Message-State: AOJu0YwHdBjiqzPMdVjjwv9fEuXN3F0KqhPXVvnjzS3wWCzn3PbY25Vb
	eogRryrd2F3dbn79aCehqNUoHqS/aFuL45Dva5dQINFFIPxkMcTQvBiG3a6s
X-Google-Smtp-Source: AGHT+IEjxVEULfaW3polveRyYZie6nJXmKyinWTn10GkjhgmI4AUfgGe60ONdXLbgeRx79+D9yGF3Q==
X-Received: by 2002:a05:6512:1317:b0:512:f4f6:9343 with SMTP id x23-20020a056512131700b00512f4f69343mr2786993lfu.26.1708976479116;
        Mon, 26 Feb 2024 11:41:19 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm332328lfc.143.2024.02.26.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:41:18 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 3/6] staging: media: atomisp: Ensure trailing statements are on a newline and remove spurious whitespaces
Date: Mon, 26 Feb 2024 20:40:20 +0100
Message-Id: <20240226194023.69070-4-bergh.jonathan@gmail.com>
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

This patch fixes the following minor code style issues:
 * Ensure trailing statements are located on a newline
 * Removes an instance of a spurious whitespace following a conditional
   statement

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_sp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_sp.c b/drivers/staging/media/atomisp/pci/sh_css_sp.c
index 9c15b8a1a93e..aad0a40d08cb 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_sp.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_sp.c
@@ -732,7 +732,8 @@ sh_css_sp_write_frame_pointers(const struct sh_css_binary_args *args)
 
 	/* we don't pass this error back to the upper layer, so we add a assert here
 	   because we actually hit the error here but it still works by accident... */
-	if (err) assert(false);
+	if (err)
+		assert(false);
 	return err;
 }
 
@@ -747,7 +748,8 @@ sh_css_sp_init_group(bool two_ppc,
 
 	sh_css_sp_group.config.no_isp_sync = (uint8_t)no_isp_sync;
 	/* decide whether the frame is processed online or offline */
-	if (if_config_index == SH_CSS_IF_CONFIG_NOT_NEEDED) return;
+	if (if_config_index == SH_CSS_IF_CONFIG_NOT_NEEDED)
+		return;
 
 	if (!IS_ISP2401) {
 		assert(if_config_index < SH_CSS_MAX_IF_CONFIGS);
@@ -1266,7 +1268,7 @@ sh_css_sp_init_pipeline(struct ia_css_pipeline *me,
 
 	pipe = find_pipe_by_num(pipe_num);
 	assert(pipe);
-	if (!pipe) 
+	if (!pipe)
 		return;
 	sh_css_sp_group.pipe[thread_id].scaler_pp_lut = sh_css_pipe_get_pp_gdc_lut(pipe);
 
-- 
2.40.1


