Return-Path: <linux-kernel+bounces-168142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642E28BB432
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958031C23A33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B621586F7;
	Fri,  3 May 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSSv8KLx"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A195339A1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764971; cv=none; b=qrGRhgkbZOhJnZQiGJ8bvqMWnLR2y/ISvhk0jgKeY1xrO2XrPNNJFnXXmCdzNx42EaqBfcVmroVYpnnDyFKBEiFVsnLnm9EeGqAQnnRh/r1LCOgjvk5WFlK7EyHCo/oRm7xs0VF2ocEgieICL5OUM3S3wcWHIzhB1lAPngDF+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764971; c=relaxed/simple;
	bh=hBfweb+GcZYEr5/bxAzp1k3NSgb+RSkSW+CIbLIqrbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvR64jdgyY0RTK3DwvaVpMlAfTkUPY9M6EImUnwnEn3KGrI/anWMDJDpVIXnNbF5cQy8k9UF0xWtX8c5zBn/KmN1V/gvB1RchFVFymKt+1fqPQUOJUPJsQh1SrlXorp66T1+e9qPfnfCLmFnGyBvYIbfZaLtxGUAXYKMEcpltsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YSSv8KLx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ecddf96313so117055ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714764970; x=1715369770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS9YtwqoetoZnr/s/Q6BCYI3bgLi2hYXmlOhnf91tPw=;
        b=YSSv8KLxJoK47DH/msAbivGhhocXB4IyR2/7CFlwZ7W4/ft8u66iShjjWVki8/Mbxl
         tj6zLjb0YlrIVPHvnQ3HtFpySbQHdzmE0AfbG3uLeQAcBaJodQEEQd7+xo8PwBYIJdjN
         nvppszCDSVo+RvJpIVbJiWV20IF6wknylCNQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764970; x=1715369770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS9YtwqoetoZnr/s/Q6BCYI3bgLi2hYXmlOhnf91tPw=;
        b=S56a4G/L268RCoDnrcC4KD8Hdb4xbBQawV/Z1jCsdHJvT/H319ZKoIFZ5FNVazH/lO
         ZU/YdfHOkDAmezB+He43XRttDJP6O4aGnV5fzAA3o6Y721DYJSHaRCi/5ONf1mAfUNKN
         u18eZiQC6UgVn85dSUgXU3/sWjfuuLEJlfYa6EzM+IlusqCrw9R7KkP1v7H12Snt5MoE
         ZJ4WV0/IgaJSQl9o4J6el6mzc0vyPYKyEWhIyNVRu6RgvmK3XtTaoVK/wMltrxz+beiZ
         xjhEU5L1JIdkD0YFG4HY4Pvwo/vSQMT8IDc4ejhunxbMYOsZfmbyCTxPu2bKSmTqmkAa
         +l+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3Y0PJG9lH4OxDGWmaVlyqw1BfbyPi5MFjff9xP5p+CkPiSJ/boY/5lafoVKR4PnklvsJ+Rsn/VgDZjemCm1Z1KlzNeWP3LwqWMUCQ
X-Gm-Message-State: AOJu0YwpbrsAHrNhKpHWLiKd81/Fqt1wWAVBqB5aOmDjiVIDj0g0Utfk
	9A1NuuhLABuKh7aaoEQf9fT7jZENdf8zpj5brui3Y0BHnM/vbMNNl/ekKEoDbA==
X-Google-Smtp-Source: AGHT+IFC/8F9Ovu7bGHhulDN2Zn/p+vJxATDZ0By1DvhsuyQKNVhwpT8z16+LTSxWkjHZvQ2PNzCfg==
X-Received: by 2002:a17:902:f70d:b0:1e2:81c1:b35e with SMTP id h13-20020a170902f70d00b001e281c1b35emr4853176plo.54.1714764969845;
        Fri, 03 May 2024 12:36:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e2c8bc6bebsm3716248plb.81.2024.05.03.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:36:09 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexander Popov <alex.popov@linux.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Date: Fri,  3 May 2024 12:35:48 -0700
Message-Id: <171476494554.2457276.4385338995352491886.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 03 May 2024 15:44:09 +0200, Thomas Weißschuh wrote:
> Sysctl handlers are not supposed to modify the ctl_table passed to them.
> Adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> This is also a prerequisite to enforce the immutability of the argument
> through the callbacks prototy.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] stackleak: don't modify ctl_table argument
      https://git.kernel.org/kees/c/0e148d3cca0d

Take care,

-- 
Kees Cook


