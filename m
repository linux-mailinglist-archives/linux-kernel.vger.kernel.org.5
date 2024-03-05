Return-Path: <linux-kernel+bounces-92007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6D38719A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63B21F22579
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFF52F8E;
	Tue,  5 Mar 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VkMK7cNs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925354F1F8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631128; cv=none; b=MJe17VT7B9aC2pcGzktgAc23KuvAXl0cwb3KQu8PsofcJpZzaIYxEnGpBRCP2lhHSCCkGgvMOlkLgSzdfmcBn5AhAWPoqPF1RppWtMeisJZBGDNSd6KFIrNqG/lo6QE6Dg/unUnANkH+22fWZLi3z/cFiZUF+mj4AF6zaLlQKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631128; c=relaxed/simple;
	bh=zBeKo3AW0umWo2+oVzF0kvmctDMJc7DeYmGkbvuWUkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHKuWs4fYFXerY2nfy/Ghg4pYS/yRXlUWaVzjU/vOeJBA57AZ7RScyoAPQdhtTIVFk79EQTMHEQjYL8cxougO1+VgL9ApH3pUXprgiO14ZZfpw66bPHMDbTeqacKERx7rP1H/UnJTHWs13T0JFoWJblVDdNoKJSX1p0yOvF1qEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VkMK7cNs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dccb2edc6dso45202585ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709631126; x=1710235926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwQHCS1RApRdLMtnfYY4Lo44hm6+L8NjNwQTBjGnVfA=;
        b=VkMK7cNsjtRVVRv4Q12/cCxH25ITbWCYfVKc6utxrZ/r1uLkAm16zKTDORrL7o+2ub
         hTaQUJE44SzNGiawHLrxeoyBxSEp0t/UgUC/t19bcKErtrXCvJP0huLcfZu9A5MXG73+
         WpXzTWZuk+smsErVMM7zj4208fgsh4YFv30+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631126; x=1710235926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwQHCS1RApRdLMtnfYY4Lo44hm6+L8NjNwQTBjGnVfA=;
        b=DdxAx+VvHjxHsNlrgqCUGm0k6CbQX/ZiglYt81g7foxfrK5zYQUk+YJmR7YTxtsFEb
         IRxMMwvsYiCVxIrrf4r2BSQzTm6mQxP/hIxiPN3hS0K7kmnCsue26zy75Ywh5PgKBaMN
         Gvjecnq5bDdA/xQwtdFI2Qk+WAyZ4tT2h/lzzljYtIeVcUsaMsNI0sgxoKnhfokE09JQ
         omngEWJLzGPv5yLz23TySMrzDM92hQjuQLdYSkW9c0onKtPL1Tmbv6ERberBXy/OosQL
         7fwS/JjC1spWBQ6ojcmIrCIV6AR+HD2r+mliL0bgVUz6uRnYmNMAj44cIXlTj/P8pcTA
         vbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0mk5YkTT4ozjkX8mWtHCfAjfXmuf0k7axDE0GKWG3KDyjak8iWAml2NKVF5AL7tx29N5VOrQYg94BZWsNrdc2xRBwggJF2B3ZYPwo
X-Gm-Message-State: AOJu0YzWwdGaqweTWcDTCQxzukVtVjPw+qKigcrY+/7ilwAq6oxbUvPl
	gIcraSNOt8b/Ki89TpqpZgyj69Q8gRqobig/faU7fzkIQd9FQrI2gKm/akYa9w==
X-Google-Smtp-Source: AGHT+IEkIjd9sE8/PNSfNzhkY5QnMDDggNLePYzvx388RJGPnJJiHoeKZ/QNY7uY/4Q61sqgAgAuEg==
X-Received: by 2002:a17:902:a50e:b0:1dc:66da:d21a with SMTP id s14-20020a170902a50e00b001dc66dad21amr1054443plq.28.1709631125912;
        Tue, 05 Mar 2024 01:32:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001db5c8202a4sm10192588plb.59.2024.03.05.01.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:32:05 -0800 (PST)
Date: Tue, 5 Mar 2024 01:32:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: Jann Horn <jannh@google.com>, gustavoars@kernel.org,
	akpm@linux-foundation.org, jpoimboe@kernel.org,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	nixiaoming@huawei.com, kepler.chenxin@huawei.com,
	wangbing6@huawei.com, wangfangpeng1@huawei.com,
	douzhaolei@huawei.com
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
Message-ID: <202403050129.5B72ACAA0D@keescook>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>

On Tue, Mar 05, 2024 at 11:31:06AM +0800, Jiangfeng Xiao wrote:
> 
> 
> On 2024/3/5 1:40, Kees Cook wrote:
> > On Mon, Mar 04, 2024 at 04:15:07PM +0100, Jann Horn wrote:
> >> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
> >>> When the last instruction of a noreturn function is a call
> >>> to another function, the return address falls outside
> >>> of the function boundary. This seems to cause kernel
> >>> to interrupt the backtrace.
> > 
> > FWIW, all email from huawei.com continues to get eaten by anti-spam
> > checking. I've reported this a few times -- it'd be really nice if the
> > domain configuration could get fixed.
> > 
> >> [...]
> >>> Delete __noreturn from usercopy_abort,
> >>
> >> This sounds like the actual bug is in the backtracing logic? I don't
> >> think removing __noreturn annotations from an individual function is a
> >> good fix, since the same thing can happen with other __noreturn
> >> functions depending on what choices the compiler makes.
> > 
> > Yeah, NAK. usercopy_abort() doesn't return. It ends with BUG().
> > 
> When the user directly or indirectly calls usercopy_abort,
> the final call stack is incorrect, and the
> code where the problem occurs cannot be located.
> In this case, the user will be frustrated.

Can you please give an example of this?

> For the usercopy_abort function, whether '__noreturn' is added
> does not affect the internal behavior of the usercopy_abort function.
> Therefore, it is recommended that '__noreturn' be deleted
> so that backtrace can work properly.

This isn't acceptable. Removing __noreturn this will break
objtool's processing of execution flow for livepatching, IBT, and
KCFI instrumentation. These all depend on an accurate control flow
descriptions, and usercopy_abort is correctly marked __noreturn.

-- 
Kees Cook

