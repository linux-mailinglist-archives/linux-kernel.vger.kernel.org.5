Return-Path: <linux-kernel+bounces-91010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF687086C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF68B21616
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129C612F3;
	Mon,  4 Mar 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGQRTfXF"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98001FA4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574004; cv=none; b=CRai7B7j1DTKDmTK8z+XRflmDNxBRZM4rvBEod/Tjh/MsRJfXKe/QC1LeBkkN8UOi4JONkIwjs/9xmMDNtuzbNBFPoUiUDvlTwDrg3d1Bh85PBa+i/tWtxPjNDKEkHA52xnxieKOKZFXDCMgw4WiZWp4/VjJ8kqr/XEiHMAL5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574004; c=relaxed/simple;
	bh=vvUOD0CFjw9j0T2nZIns184UVZGkZxXpItCCB1Xq4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlh2eA/ODtQYmuA7/RtWMrhKga6pgXlForD93xJ4hpEM13+64d82Joq31IH6lf7sRb2+kQy+kw1AoYlkWi363Ia6Q1DlkYd9GSm+Bmm3jJ03AEevOl8XiemFYGvtkUPbJs7OZIuKfNWs01+/XRI5RcWPPA4Rkt4nz5RIveAB7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KGQRTfXF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so2854882b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709574002; x=1710178802; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RyZsHAo58L7KMnZ/iYkcv6g6DGnJjygri39sflW2A24=;
        b=KGQRTfXFACD7/rggYCxUumWi8IGfDY45wgYkCRYIvS4yhX/bXIrkjH2Rwe+xMeaw2f
         xdp/Rt8Wpi5FTEYBnXO3+kcShFHxWJhseJxpDhrnYQtlXoSgdjBWW17uAiMuU0oyuVwm
         3FFoD60rcV+iglREYO6qdsxsvbHIdjTdyyOXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574002; x=1710178802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyZsHAo58L7KMnZ/iYkcv6g6DGnJjygri39sflW2A24=;
        b=RBWKb5hJ2zHiqafPolGjyaTqWlFJKFyD+toWmosNKh2AhQhXXMFMto6yfRnnqbqYNy
         QXqeoUtLag/otueeFKTYICA2DLk5ws/rfQ4XTN0oL3x3U+kGipRukThF3hChDIio8VaE
         rgN1uxsGwpBSdf+T0QiuG+tKioesil4WOorVBL/xtLfeAXmCNdOBQGtyYkbq14foSR5m
         ZqrRXqgClyeQgq8zzKgAWO3dwAfM4VSGY33wPPNapsLpNv73Pm4j+KVmvCSxtKD3+uN0
         5Eg49hl2o0qv/6EP2yoBeUIaJokkcSgPA/YLUiaXJP/ca2/p2cgiMOpBJmW2LobHHTxY
         OPXA==
X-Forwarded-Encrypted: i=1; AJvYcCWcaT6dma0xpT4Rl7ujrLzIXnj+b0RAtW+dc2zXIeFkF5dOqz3fKm5bwu3bgXbQjEBqWLfQqK2XOXVZlUwp+67BOWDN4LqCfRkP4kBk
X-Gm-Message-State: AOJu0YzoUxoig2fayAMAzw38Je992kt60s9Jr04/QlrKcbm0Vfb2CtCU
	HUr5NnsgqxPXHRIrxVuVJ3eDG3b3w80klVBngYoue+oO+0lt5TLSVBYrpl/kfQ==
X-Google-Smtp-Source: AGHT+IGQ7bchTfFmOCc/+mlkhCkqHxq4az+ZQyntLHbRLi0vYhRoD1GW4l+IVJmIASmmaG0WZgoZEw==
X-Received: by 2002:a05:6a00:4b02:b0:6e6:279e:3dc2 with SMTP id kq2-20020a056a004b0200b006e6279e3dc2mr2611552pfb.25.1709574002161;
        Mon, 04 Mar 2024 09:40:02 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u20-20020a62d454000000b006e468cd0a5asm8103347pfl.178.2024.03.04.09.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:40:01 -0800 (PST)
Date: Mon, 4 Mar 2024 09:40:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Jiangfeng Xiao <xiaojiangfeng@huawei.com>, gustavoars@kernel.org,
	akpm@linux-foundation.org, jpoimboe@kernel.org,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	nixiaoming@huawei.com, kepler.chenxin@huawei.com,
	wangbing6@huawei.com, wangfangpeng1@huawei.com,
	douzhaolei@huawei.com
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
Message-ID: <202403040938.D770633@keescook>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>

On Mon, Mar 04, 2024 at 04:15:07PM +0100, Jann Horn wrote:
> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
> > When the last instruction of a noreturn function is a call
> > to another function, the return address falls outside
> > of the function boundary. This seems to cause kernel
> > to interrupt the backtrace.

FWIW, all email from huawei.com continues to get eaten by anti-spam
checking. I've reported this a few times -- it'd be really nice if the
domain configuration could get fixed.

> [...]
> > Delete __noreturn from usercopy_abort,
> 
> This sounds like the actual bug is in the backtracing logic? I don't
> think removing __noreturn annotations from an individual function is a
> good fix, since the same thing can happen with other __noreturn
> functions depending on what choices the compiler makes.

Yeah, NAK. usercopy_abort() doesn't return. It ends with BUG().

-- 
Kees Cook

