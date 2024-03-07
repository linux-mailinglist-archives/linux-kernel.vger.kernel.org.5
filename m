Return-Path: <linux-kernel+bounces-96113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E012F87574B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5A71C21286
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC796137C42;
	Thu,  7 Mar 2024 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gw2zGA57"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D713699B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839964; cv=none; b=oExceViYTMalxa//fLmxgynYSVtwlOrXGZxegHNmJKMbq/XvbHU8XWs9q3qpoESKxlQK7Md83nSaQ96/vlfK+XOw/2DAccd1ZMD79z62LH79T0HigbNiVcoM4xp5f5u+eRD56j8yZIu/dGbX93/L+PUBB5MRLm7PWZiDeIp+d7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839964; c=relaxed/simple;
	bh=5OZyAdHUAPw3oC7IW6omY8gpyxLtveQWTOhptQtmJ1s=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U/15VWDVON5AWsHiUXNwqzim7LTy6Q4K5vHR+Eo0A4cdpI3b4UpOpiNKlGtmPgPmNeYjROYFXv9fmkYpTgah/Y9bDrMt79IWCvssjQ6hTKwdWdgbNwVd2YDaKoZjng+ACvO4hfVyE68v/tSmLIarK40phOI+UYanZoHg1ZzBpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gw2zGA57; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso1063387b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709839962; x=1710444762; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7tFAO5LyLvnL3+HqT9Xq5HyhhJG+8Hgt83qwkFfBN8=;
        b=gw2zGA57c6SnchTFQMga1rz3QlyMVdFY5Xo/Y25UzDX3T0Te7nRHQQpR6ia4AOc0CE
         /IRi8dJ0h5QWKPuJakL9KWqV+NZ94HvwdG5XWEM4FOqfnlEWtlqFGeq0CpDNM7Gb2Xd/
         8IHRDhsVRTcKUCfdyCwdu/+ZIFllhW7ppx6Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839962; x=1710444762;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7tFAO5LyLvnL3+HqT9Xq5HyhhJG+8Hgt83qwkFfBN8=;
        b=itTAPtjmISBlixX2RTRQ/fmQhx5m1AnIwf+92XoUMLIbI0Ir0aYkhz7t232HyQ+E0F
         opTNCiXa8Bd7WadiG8IexSuz9iEjN9TofrcUjwfrQ8PhbEgQgStWqPq0dLC+csLjmt8O
         9q9cFf2HSBZBa6LBv6z3fYDZ1gzLhJZB6xmz+mZ/9yM4myUm038UmLAWvj/Vd0oaoI/A
         0TBClsuf8RblLl/omHvVIZOVGlHEtW5JkUzSMkXnUJOaqJYf9aCrvzXlxT/4QH8My7Qn
         p5bMJoEq53hgNSN7AdAKS5A1cO2OlDrW9796AaafboaByHFrPyUn8b9G7rTByfZE97Dt
         69+g==
X-Forwarded-Encrypted: i=1; AJvYcCXiTJmnamiEYrhmPqZiFc/elpqT7dR9r8iaxKXwSXjHh56d9xa2c5YgdoPVpW4+nztd3BLTKDy02mrAzTFMMgRH5wcC3wwoVahcqxu5
X-Gm-Message-State: AOJu0Yz6hX3fzRISnFCviLqyy4+DjNicvcqWxH+Te9fYi5K1yNAhLooj
	jvg05KPvSy9wGCsS2UWRvFPwEaCh72VcElfOYtDpD6aB69XFsmxRiHY92ceCWg==
X-Google-Smtp-Source: AGHT+IEXA1GnqxDeU9jnlIUs1LLr1HCKc49pvwZhgKzU/0L/Llfntwa/OA4IWFglH8mIi9V2Pf//fw==
X-Received: by 2002:a05:6a00:3cca:b0:6e5:9342:f0fb with SMTP id ln10-20020a056a003cca00b006e59342f0fbmr21379242pfb.14.1709839961147;
        Thu, 07 Mar 2024 11:32:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x20-20020a056a000bd400b006e65d66bb3csm1526541pfu.21.2024.03.07.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:32:40 -0800 (PST)
From: coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date: Thu, 7 Mar 2024 11:32:40 -0800
To: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, intel-xe@lists.freedesktop.org,
	Oded Gabbay <ogabbay@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: xe_gt_tlb_invalidation_ggtt(): Error handling issues
Message-ID: <202403071132.198D11C@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20240307 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Mar 5 16:48:55 2024 -0800
    27ee413bbc0b ("drm/xe: Do not grab forcewakes when issuing GGTT TLB invalidation via GuC")

Coverity reported the following:

*** CID 1584246:  Error handling issues  (CHECKED_RETURN)
drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c:250 in xe_gt_tlb_invalidation_ggtt()
244     		seqno = xe_gt_tlb_invalidation_guc(gt);
245     		if (seqno <= 0)
246     			return seqno;
247
248     		xe_gt_tlb_invalidation_wait(gt, seqno);
249     	} else if (xe_device_uc_enabled(xe)) {
vvv     CID 1584246:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "xe_force_wake_get" without checking return value (as is done elsewhere 15 out of 16 times).
250     		xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
251     		if (xe->info.platform == XE_PVC || GRAPHICS_VER(xe) >= 20) {
252     			xe_mmio_write32(gt, PVC_GUC_TLB_INV_DESC1,
253     					PVC_GUC_TLB_INV_DESC1_INVALIDATE);
254     			xe_mmio_write32(gt, PVC_GUC_TLB_INV_DESC0,
255     					PVC_GUC_TLB_INV_DESC0_VALID);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1584246 ("Error handling issues")
Fixes: 27ee413bbc0b ("drm/xe: Do not grab forcewakes when issuing GGTT TLB invalidation via GuC")

Thanks for your attention!

-- 
Coverity-bot

