Return-Path: <linux-kernel+bounces-157856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569478B175B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563141C20FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017416F261;
	Wed, 24 Apr 2024 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lL3ORxFr"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64113A3E6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002338; cv=none; b=YsWmJvNtNYWvsIMN6Ogi9jvHrDcEHJSjefP5RV4WM9PMpvWzl45BEhcyCb3QSojwxC2U/++5iEygCpchxuRQtmMqhlk/918uKfpVHaoeZoMhtIXs25rH2GNski4769n8q+ws9JIiugUHzw1z/VbO2sW9c7frhiP+WX/vWZFoWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002338; c=relaxed/simple;
	bh=YZzLecDMNjlJHaICMLtyO//sLAP5HbJP2X8zw+1KyoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewHVeMyz5tG5zKT7mBaniOfPawztxHyKtA0uKXU7WOE0PkcBBNAq0cwyj1PL2n0zRPLq/ZMH6cPn9vmyRpuQ5yJNe5bzmyxvlJqZB8yzTgxKs0P6BOdcyHMSUGkJY+llb0g88qkfdfW26crYbLfUzhEuB2zhKruXfTECXWo4woI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lL3ORxFr; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-233e41de0caso276916fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002335; x=1714607135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZm37LU6QkjSBIlXkQ/R6Hvghsrw/r8BQ4yIk+1vAWI=;
        b=lL3ORxFr4BrN8ihblqZoEik9GoMscjpQ0ciyJyoM72TQzKCEFoIIxzxCJN1qDoCWhx
         sANiuXfqRbse9f7CGW3SZUgLaCId+pjH/OZvivgBQcwYA7bdjho4l2NpkjkDU8CK0enP
         SKeom3wN4v0YAOBFNjzN9W6aZ8BQRlARl5CAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002335; x=1714607135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZm37LU6QkjSBIlXkQ/R6Hvghsrw/r8BQ4yIk+1vAWI=;
        b=JXldTDRP4JqifosE2dJEHabV/s7QuNuc26/i25S0Ik346W86p9S7nj6bpsnBqq90GN
         ttrmP5hCGcLWXX6cf+U+BVb1oLdGPlhqZjsNNNhU0E3s2lf7BAxnzsLl5VvVSrDgGjCo
         e0cVR5zoFvOMFJipFpndJR4JdH+XYfmKbwLDBgaKNPqofkYLlUDP2GI8HBqO7AAIXfCz
         dmcubkPXm32FVb78dQ1yXJ9qXuZnuao8uF/pjRAvpuVArxMLm0yhSse3pPjt1vSYAhXH
         y11sCnqMr4NPeVoZ06bjk+khqTG7LYobgD21WOjWy7pMPLKLKX+ITRWdO+rbnFiUJUse
         rseg==
X-Forwarded-Encrypted: i=1; AJvYcCU5nm1KtWFvizxf7Tp5p/7jHhuBUVdJLZWQ0eWmxqA1emxCdzrBZjcGOB7cLvgWCWjuOQtGL/IY0NKr5xwZxB5Mz1deeFRRCOHSt9pX
X-Gm-Message-State: AOJu0Yw0h2nxEumxftCoOIxIQ8zwr/DHnu+lbP2AI1PMN2BLJLiKVACu
	D8zGysci+uQdIrYHriIGtBkrbaltRS09Y+RXRUHTZgb1JW0K01i3yhAd1mAnVA==
X-Google-Smtp-Source: AGHT+IFPfY71ZcsgQw+7I4MrUbzzyVVj1qiOQmGnTYvww5B2ZZF31JJixLHmF72t6XjiGDmeAUI9XA==
X-Received: by 2002:a05:6870:c14a:b0:235:489d:ceeb with SMTP id g10-20020a056870c14a00b00235489dceebmr4367954oad.23.1714002335183;
        Wed, 24 Apr 2024 16:45:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78142000000b006ed007b3596sm12029990pfn.69.2024.04.24.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:45:34 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Fei Li <fei1.li@intel.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: replace deprecated strncpy with strscpy
Date: Wed, 24 Apr 2024 16:45:31 -0700
Message-Id: <171400232813.3283422.11054250337629213107.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>
References: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 23:27:09 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that client->name should be NUL-terminated based on its usage
> with a %s C-string format specifier.
> |	client->thread = kthread_run(ioreq_task, client, "VM%u-%s",
> |					client->vm->vmid, client->name);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virt: acrn: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/e8a87d0cd048

Take care,

-- 
Kees Cook


