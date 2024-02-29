Return-Path: <linux-kernel+bounces-87281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D886D223
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407591C2360F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1E134419;
	Thu, 29 Feb 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENGQZjPM"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756967A154
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231099; cv=none; b=bowMQRJIemQ+rV4N6IKyMo5qjTtQ3WFV6AKOSnX+qEGIcFBkl89AvE+Uhsarhk+wECjki9sKF/ueykNDeGdvIpM+NoBLa3JNqg6wz5MT6a6SEVcliHwMyw99Fje2zy6mof7PxafYXzqL2772cz9nrWTQtNcjLBscEDpst6xFNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231099; c=relaxed/simple;
	bh=Ce5pyQnb9GRcPSheUoJZhjpUrjGnCB77xYc5gcYNlxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKaH9GSww5CUvFyCWJXo2D8oOtgvMvdL6jfzioIfYD6VaN5uoHqmI52lGbtENG5LM+n8eU50g2+7JTRBDylA//dbTrFJGEK3ULw6g/yYCD5eTDdFob0KxPcACwEeNbeHU2W3kFEiRfhpwYz4AXcyd9tkoyHjdvuQLjratBCHD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ENGQZjPM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e56787e691so1550868b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231098; x=1709835898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqInfZ8mOq8nYZAY0kAdxi4SUGFvyqMPNmMOUUeoyfg=;
        b=ENGQZjPMfEh2sAf36guydCaOXrhzFaPN4I3K5F3QN2g7nWsuX9IC1WQj2/cLxkTHdi
         Qo5DZpoRSvdZZ7OuoVu0wrLcKPFz6BMXzeCZhehz9AbQaFwUOvTLl5YX7GMzj4yrJXJZ
         N8m53e6FL/rmWDTyAqgK+cvAkxUMAA5y2bUUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231098; x=1709835898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqInfZ8mOq8nYZAY0kAdxi4SUGFvyqMPNmMOUUeoyfg=;
        b=q1zocUk1XoCoar6YDb26GID/4D8v8hlG9xks1vaB5qStCJkHrMA7yScB3Z2h6EtE6k
         mPW3B2ggP8KqEbuEfYjV/lEnoGJnyDlVK0ArlBzcVrUC/daZ/cQ7AJv5carg9C4MkuRQ
         7J+4AEEMiT8ohRJpRklKkbimauKAcPt4FxSva/tnSQrF+O5gyR7MYeXA1zNir/+FIQQx
         Pmu2ilPP2ReMSFlRI4butNTxVq1fcaofZLLr6yBIuKGPsTrvpgApIvWtVADmEcXuWhtS
         gXQt1zOQij13BnA16tAgltMyu/KkTNqW0yLNS2s6X5jvpOkMUUeAgIO8Aa9mOtI6p6aw
         BPnA==
X-Forwarded-Encrypted: i=1; AJvYcCXcL9MPLhQ/4JIWFmen8eduS7zxbzd1ifgStq+1vW/M7kZ7yA51WtL6Z5aIxIl91ipYhXkwmrd4QA1/pdyaHsxts3kax1DEXilemMMr
X-Gm-Message-State: AOJu0YztF7r75kHSb/NioSKsKIx48KTgyTT1lb4SaXWURswZ/S0T7jZg
	BaGlRkRvkRJU3aEqqJcO+AI9tWbiYMTo/lfWHkRj9jGWy/fXlPr8e1Gyk8h2DA==
X-Google-Smtp-Source: AGHT+IExuEVVJmKP2BNOyB+LtexDDJxYmvvXcikwCbgKNASK/A5xRah0QTnX1g4AE8/nsBFkMxCoNQ==
X-Received: by 2002:a17:90b:343:b0:29a:c992:198e with SMTP id fh3-20020a17090b034300b0029ac992198emr3923483pjb.15.1709231097697;
        Thu, 29 Feb 2024 10:24:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pl4-20020a17090b268400b0029af4116662sm3911274pjb.21.2024.02.29.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:24:57 -0800 (PST)
Date: Thu, 29 Feb 2024 10:24:56 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 6/8] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
Message-ID: <202402291024.CE0082115@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-7-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:07PM +0100, Mickaël Salaün wrote:
> Fix KUNIT_SUCCESS() calls to pass a test argument.
> 
> This is a no-op for now because this macro does nothing, but it will be
> required for the next commit.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

