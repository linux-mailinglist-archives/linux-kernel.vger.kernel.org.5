Return-Path: <linux-kernel+bounces-87284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6D86D22D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2098D1F21EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BFF134401;
	Thu, 29 Feb 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GWtPP+Gs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8CA79DC5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231167; cv=none; b=R/w4TlIhNrxliU2RWawq3KNY4J6vQKVEuFOEDPeOy4puGEkyPmMHizPASeuw2YExG8tGOK8TfxJqvS7RctJHWW2SpJTrRbHO5uvP3iDl+5j/B56e38Jr2nrk78RxAwZEhNbVSzW1HkSr2SxBsaRQtJARz2dR2wGy9ImRPRE2bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231167; c=relaxed/simple;
	bh=GMRN6SUrrHoEIDYQZaXbYank+mE4jIYwZGljGX8JzRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar8cn8ltE14Wy0sLJNdQs2rr3NutRCXNJt7t0MsIIgDGemmMDT8J/IJ5nH5dhyXE4OmvI7Q7jbb53Dkho5b152hZrlchRJ21/WM+wwvykVX+oq2T1ulIXnJ/TNeOT7FbD5egE9Dgl6YVB8twfGjyPMwZubfyMHfa4CyaOQnxgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GWtPP+Gs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d95d67ff45so10811715ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231165; x=1709835965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=onsMWwzpvtENple3SFlR2LMD09MQgc6sYAmAsDrNdvU=;
        b=GWtPP+Gsy8M3uLFQ3Bn8eCkaLfwMSCXbCoiwv7X9D6CXKax2kNaR0Yit3mNLBqIftB
         UBUbEj3tonKTijg/2l0GXZlW1Y1C5l4OuQ6c7+OlA8nofTANoAHX5RPdp3PVZcuzyOP8
         oK8vndSURR2ikGP6Tv+IZmb/ahraIVLlxtEwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231165; x=1709835965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onsMWwzpvtENple3SFlR2LMD09MQgc6sYAmAsDrNdvU=;
        b=R9w/KhHWoMj5yMAS0lZuqttERkU6UWC8wU95BjRut3S/Sd0bDZ3EhvzfAdR1m7fQa4
         oXJRoqxoZBkR6l9I6RyneALI4ThQoTaI6iKvRoiBAzcti0xvb6KI6LldXyf/MPuk11B1
         2ArozLYD45fr3ipIwpOh501lN06SkFgThO7qHdMzL+D/7aqnZjMnV+nnXUa9lW+umNyF
         Op/vxFIJNLQKxe7WPxS6FvdgGV1u/z5yDXc/wGilZg+VBzDAIaTS02Nq81CfvseZhhGA
         TfnH33xMmgu/VK2UOBmIeGaH7AlJYc22fO1KZ0RQkKqBweHljq0B6/52SDRD94O6xWrU
         LvqA==
X-Forwarded-Encrypted: i=1; AJvYcCVPIjT9oubOlIUpstRmoydvLnl8JIq5Ce2XQYfKlzh4yq4+9NNHP6KutL+IXFG20EqfbE1RRHrkfAa+Fs2026fxAqXwhJMSFIKxaGEL
X-Gm-Message-State: AOJu0YygTsiekexWk0Q8okrVMXdic5uBY2vJODoulRMwhUv3KNR6Tg7m
	TPenDijNgUld/jhN2RwDbCFubZH9vwhG0iFbwMjsAP9WKXGJO7W2ZOvyCsahJQ==
X-Google-Smtp-Source: AGHT+IFaOyXib1ZvD8HKP8qWNtoqD6PNUUwUwDcIGpR6CELmVt23qtsOEdbZ9mepYl+BYt4oLI9EwA==
X-Received: by 2002:a17:902:a3c7:b0:1db:c6ff:664a with SMTP id q7-20020a170902a3c700b001dbc6ff664amr2752373plb.53.1709231165470;
        Thu, 29 Feb 2024 10:26:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b001da1fae8a73sm1821003plg.12.2024.02.29.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:26:05 -0800 (PST)
Date: Thu, 29 Feb 2024 10:26:04 -0800
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
Subject: Re: [PATCH v1 7/8] kunit: Print last test location on fault
Message-ID: <202402291025.0BAEBC1@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-8-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:08PM +0100, Mickaël Salaün wrote:
> This helps identify the location of test faults.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Much more detailed error!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

