Return-Path: <linux-kernel+bounces-48099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AFD845733
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EFB1C24D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDF15DBB4;
	Thu,  1 Feb 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCw/ca8D"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172A4D9E9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789905; cv=none; b=i4GJVRVoETpqPDgXqlNaAnTZRgiVaqpNHaAVQdzWJ2NoSC2GNFRwDx5jOvoK9DoEvrck71aH7sZPqSF8DTsJcfbpRFDs1iehfIUHGYYLkiOBdZS6nHHDiiczte8Q/INOvagkMX6CbX/nzNy/8DZwQ1a35Jr09TZPEcOn0NtQ/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789905; c=relaxed/simple;
	bh=pmWxUNJ1KD2n0FwuTqq2fLlfQZHYRoMgFaaqE7HmJ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fEYX+Fx6vvMJi5T+DTiNDqfjBsycS9Znw4gLGBw+ZzUCd6fqvsEot5gsrKOn7y8M+sYOj2/LgOGhqProHoU9amLilEjI+p9AygtFrlqCgXRuHHd+C7Jovy2g2F8NnLeCOEcmQn+tMAsL4rehjCY1h70QKlu+Bka5UPg+E8193Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCw/ca8D; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so116071266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706789902; x=1707394702; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2orRofZirbGTvQ+iko65Kwmr8ByVwpBalWEASle2m+g=;
        b=QCw/ca8DPcGrbovxb6hvCb1JMEeIzqyVuftjvJYM667wQ4cF8bCiT2tMbKL6qkoSAT
         jcOa7ZAEfGahAV5IAlC88zr3Xqnr6gwI2VHBj243FttlUb60GNwsAO+cUDJUo2qpHtYz
         TDbmOTcysnrW2+Hh9x7Gw+BE1kUSiuoFws5Y21dckBjdtbO+GDzgW89v8cNr64RStqWM
         wS+G65/sxMfstbj6FnDXbxSpDRZc7ib6QgYrVNHZag4fZ5ZBo90/AaJ0/5Br6DVieSE3
         moSFGIrdh0cwrQ/LZpIkwjTq9/00yAQ53KFV3h2T5lDdYj0ND6i8LOVVdjfuYY2fOYVQ
         1MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789902; x=1707394702;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2orRofZirbGTvQ+iko65Kwmr8ByVwpBalWEASle2m+g=;
        b=TDW0jsWnp2gR191TwQqsGrN0XdwFTFuuJYwjkWJYjQjbyjOFRb4erOvzQKyT845DpW
         R3VmRXJizeqxHy4cUoVZo9Ia3McpYD3EZSKnT6dKOPoK5fU5xJhT/fPoBYfFVNL6wnF8
         W+W1uq9vwjKE4YdVy+C44X3NP9hMlkFgonGT+X5J52XxLqodhb50E68B8fOZsT4uBwH7
         Si21Svig+teIEJegWTl+3iUZXk/zk7rCZUUBXprmVGqizcIc7KaVZ4tVYf0/1jDZP7Kk
         19FTfxsmSg5d95MMIf/3q3u9xkkkgJWmLW99VpOD/EhmuPWHEb7ZCOCCPTJndA2jrRU4
         SShw==
X-Gm-Message-State: AOJu0YzP9mj9QRiW68A+Wzp95Q2BAUBY/+ZJ3+IJuP6HaSyveYsT4/yC
	08IVNz782OMh+XJY/A38KkX1lFuKi0fTFeACOvH6KPE+1ox+JdDgpYnJv5dNShM=
X-Google-Smtp-Source: AGHT+IEI0C9CnkKb2LW+p5Sm+IWjNynh3uPDi+tNE3FOxGscu5UPewiZ0qE61L40eFIimq0qURI+uw==
X-Received: by 2002:a17:906:688d:b0:a36:72f5:af5 with SMTP id n13-20020a170906688d00b00a3672f50af5mr3691533ejr.11.1706789902360;
        Thu, 01 Feb 2024 04:18:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXEMWMXmLPaVrc8bpUVhzoxSuuUr3Oj4BdXzjtgA7agaXhQP4eDTz3MW+pL+zUFM84Fxby4GOkiEtieTwdvxdKPiYQqOrXYWd5SAXddSwoN0MVVzatdTgjO4q5xKHhxQ0usT1lFZlNdjliW6kIoYuC1UHVBdF8zFntt88miAaq5PrZ7VQ0vnTlHierISQ5RvZPEMvyJTF2B2CmoQDPrRaNl2pHCpXS66IsILZbcbuCRJKQnwsXW0yiMuRdD6vE/IQB6xKuZbTEnSCFVEcswYmIMy0sFt3nEHtvCjSiSI5WOW3nxolRfv6I3E4s5XxfCHqKmFaGfWXNHqrhdbNdXUTTeDeo90Ieae4/yPb2S010iavMfkCBzbsRekClOoUNKUq+Or+lJm8+psdbLi4FGDT2oCEVc7eySRbHx0qhV0SusAn/Q7cWp5nRYUKWAfuPl+z51rsXaWmq7cv4smDA3Het5+dGrf9INovOc
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id vi7-20020a170907d40700b00a369fbc95c0sm944194ejc.79.2024.02.01.04.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:18:22 -0800 (PST)
Date: Thu, 1 Feb 2024 15:18:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sarah Walker <sarah.walker@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Donald Robson <donald.robson@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/imagination: Fix an IS_ERR vs NULL bug in
 pvr_context_create()
Message-ID: <cde5a0bf-0d17-4fad-9c85-c7587c73a131@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The pvr_vm_context_lookup() function returns NULL on error (not error
pointers).  Update the check accordingly.

Fixes: d2d79d29bb98 ("drm/imagination: Implement context creation/destruction ioctls")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/imagination/pvr_context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
index eded5e955cc0..e38d3578fc09 100644
--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -315,8 +315,8 @@ int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_create_co
 		goto err_free_ctx;
 
 	ctx->vm_ctx = pvr_vm_context_lookup(pvr_file, args->vm_context_handle);
-	if (IS_ERR(ctx->vm_ctx)) {
-		err = PTR_ERR(ctx->vm_ctx);
+	if (!ctx->vm_ctx) {
+		err = -EINVAL;
 		goto err_free_ctx;
 	}
 
-- 
2.43.0


