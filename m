Return-Path: <linux-kernel+bounces-122844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFE88FE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C1529525E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639E7E793;
	Thu, 28 Mar 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvDvHfnc"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1D7BAE5;
	Thu, 28 Mar 2024 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626300; cv=none; b=eUpiDzRfMUQ2QUaiho4KSLM9Lz/4fpu/jRtILtT5htPgtOhBmYv99Z0B6yAi3PiESlC1CXAB19WnNCOdvyYt3v4LVrRkObByDPwXxE60bPlZl9TEmFI5PL+HbfsW4ZbIqywP7dpAVEhbFvTSLQUN5JOi2rXRqazYerBPq/a1s1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626300; c=relaxed/simple;
	bh=OYM8k1EiWPWpNf5LRNyDFFCvXpyMLeqLULX1HXll2yM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GD4OBDWhT7/WGRfBaeBuV0bpeZ2s8N0pkZQTpi8An5A6xk9+U5GriR9U8yc6JMfFTsv5EgVl/Z+sjUiKl77s8TXl7NZP55dLlQ6NyA3CC+zRgotKNEICLUonIRDjE4GHQcpLAQFPrwvzMuuyWWEaRIXIaWpSulH6wukSm9TPmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvDvHfnc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513e134f73aso898489e87.2;
        Thu, 28 Mar 2024 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711626297; x=1712231097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9MZemIHH/wBwBEQSnrQYLhJvhCNeO4YGhKFn3AbGPg=;
        b=CvDvHfncRAuH6IVn/DzViCnCdrn1DwVWFosoHQgEn+CLxGaW3tOMkAohZPysyPNE17
         xnknKCruI6HOqWGdURoKY1A9KI18J/4893ifYJJABlJ2UeykkskUa9YBYjyXA5tM8YEF
         R6UF0wBp0fsyTXzLvf50tpdGDjaj3Pozj27tHyGUggMGCrjUI7B7XksNxT0V40LmL2Lw
         w1/y+3NUzVaYGks+SdY3iSTphAucmz7MQjpX0VEoxfK2jNIBewnZVSFQ2lk1T6O6Z0bw
         j+oGaMkxyj7N8hIVndso9ssnhb49aEZw6v+g1qX1GKxxGeA/NeYpwGzIai3EkpcYSKQ6
         hyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711626297; x=1712231097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9MZemIHH/wBwBEQSnrQYLhJvhCNeO4YGhKFn3AbGPg=;
        b=OGydKMyehlAswNbpDdXLsghOUDPqsGeZAuKr0NES6t0UfrrtgJPnzMjDZQPo2nSw9i
         6nri0LimLRljxs/CasXpiWO8OUwDnLd0e0dcp/xsA0EYe3cgCi2eRwB4ISCjdg8RXHcy
         HSaf913++6Bh62YMohEJJ1xc9Gcg2KbElYxqL4KYy5EllFZ0eOpNLtZCS0RJns3UypFD
         +2HKWzczipEGSfBjmRAX3MKCtVsPRQnCfA9HT+NPAwUDIQweG/YgOJkTOF1JCke26R8E
         JyK4vJ+rJVqT5UbAD2dvqHE3WlgXnAJyvgu5WVBrowuIaBrlR1FceIbF+fTLh7/vQP2x
         LMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgzWOwe9oOR51h9FWjd7BF2O56x+zQaY9t8uIsqWKRC+3kRIOMcMq/hVcvtbx298eUl4qLWN3WiZmXfwygQq42eXSlv5qq7IA++R1iBc5qZWaHdWgysc/7POE4BxI+FAGwkGVfPm1eLxc=
X-Gm-Message-State: AOJu0YxmzyjSWdqfsJ9jrF1/LbJdKTW+JfJuidGuwUgPpFOpKPWlsU1v
	N5E1gF1EafDtICjJwWlrdRJzUui1QgpOSrLpx+bcL1tKTy5oj6gu
X-Google-Smtp-Source: AGHT+IGEl6kIo0nRaR4sdMsNwoiqAEZ+tfdSkPUMmYpwE3JGZWyrDnwFHzDvEeA7KMSIxgFR1yAEjQ==
X-Received: by 2002:ac2:504c:0:b0:515:9ee7:ce45 with SMTP id a12-20020ac2504c000000b005159ee7ce45mr1914760lfm.49.1711626296973;
        Thu, 28 Mar 2024 04:44:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bp29-20020a5d5a9d000000b00341d28586afsm1581112wrb.2.2024.03.28.04.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:44:56 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: media: ipu3: remove redundant assignment to pointer css_pipe
Date: Thu, 28 Mar 2024 11:44:55 +0000
Message-Id: <20240328114455.762195-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Pointer css_pipe is being assigned a value that is never read afterwards.
The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/staging/media/ipu3/ipu3-css.c:2058:3: warning: Value stored
to 'css_pipe' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/media/ipu3/ipu3-css.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-css.c b/drivers/staging/media/ipu3/ipu3-css.c
index 9c10f1474c35..1b0a59b78949 100644
--- a/drivers/staging/media/ipu3/ipu3-css.c
+++ b/drivers/staging/media/ipu3/ipu3-css.c
@@ -2055,7 +2055,6 @@ struct imgu_css_buffer *imgu_css_buf_dequeue(struct imgu_css *css)
 			return ERR_PTR(-EIO);
 		}
 
-		css_pipe = &css->pipes[pipe];
 		dev_dbg(css->dev, "event: pipeline done 0x%8x for pipe %d\n",
 			event, pipe);
 		break;
-- 
2.39.2


