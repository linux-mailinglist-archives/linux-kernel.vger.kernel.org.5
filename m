Return-Path: <linux-kernel+bounces-56751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5284CE9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4664028BC9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94A80612;
	Wed,  7 Feb 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCObCT43"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671827E596
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322098; cv=none; b=bbRjPd5oNRJ4dRqjGMUsv/7ZjB2yhD2v4L0XEYmNthDwdlB9rnqVa/UJ646v/MLBop+YDqABo38FtZmCxQLrUN9pXabp8v3EudJlQ3dnR5oAuuNZN37u4Xt382S7fg9NKG6DM9LoUwLc3YKxtjP9/UgvZYyAv88livWdr54dVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322098; c=relaxed/simple;
	bh=Kd78ByyFT6a8YEwO3HZkgmw1fSvzekjxNAWgwK42edo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrctTJUHquG5t5EOD9jBhp1/Ldz2gcsqrNJhAHiI+Vq5D6ENGsx5s9WTixLXTOIl7C76xNwnM0xu+OyimY5JtagHC1Za7q+mPlB2EzD7F3MRVCte2x3zRku3CGfsziMqM+Zh+nTXFL/o1iw8fEmADDRJCayxnMhL+2vhr+MqzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oCObCT43; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so457803a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707322096; x=1707926896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPcc1Z5tbUu/YfL1Zy2MeFweBmwTVf9DFXiNZ7Rr3v0=;
        b=oCObCT43ZFjoI6IPa0YJJXy4VxMPOEoRZeWyvb6+NgzlPBsuajpllOkErMuitTwLEt
         vh2ApUiEfXSNyT5fLTuH1hDKOHY78sLutfVcxy8vWvqpDo8tyz3sUPIlefHzCR2IgHqz
         h9iXhRN0cZhM7pCYfzYIoTfAUi0eG9NVbrjrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322096; x=1707926896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPcc1Z5tbUu/YfL1Zy2MeFweBmwTVf9DFXiNZ7Rr3v0=;
        b=LtNDaa34kdSTOrRsaNiIcVkwXwDCyrBtYy8Ag8ORXDLT2jr2lp+hBpGHZ9vj50whAV
         mXUwsGNl4RU174X5AclByy3pidx29gDWSYR5xJ1fRkYx8wRSJP/y3Tvy9+MvpVYaREdz
         6HKEeISMQLN886U4pJf05bKQL2FGMdVlFcatvyEI8psu4e4S7434dWS6J89Rm3KHawFe
         7sU+va43cSpH23shYBIF/9quTYYSRp46G8m5Qiov/bLYUhuk4BFGrkaJoI5xDEZAMQG1
         Ll16yRxmYODkDX24kqy+fWELAk6AaUTpU6pqDAEeAHEACEDJMGxumuvL7CB/FTD6yDv0
         i0Eg==
X-Gm-Message-State: AOJu0YxBpXAMYzZpogIKYAe66wPEoyjjhYeBNsD1Ijd0GLPNgpdCpfXv
	FiF/e9EcCIHyiMhgjBlUQcz4cMbG/lMq6puXmJ0CE9RWCJDDAJtIgfZ3CkggGw==
X-Google-Smtp-Source: AGHT+IEL4dVoIUgrEfKuNyswXdeBCq+iJN21BgyINOhjGzVNggS7+fdaixLjZ7J98lvr0IBueRr7lg==
X-Received: by 2002:a05:6a20:4285:b0:19c:a3e2:58b8 with SMTP id o5-20020a056a20428500b0019ca3e258b8mr5608303pzj.12.1707322096615;
        Wed, 07 Feb 2024 08:08:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUS66k0uHq0b+5MwZzpaLXL0AsgXhY3IvIWBM9QHQ74huP9OpEpSRz771KZ1rqnVr8feMnwNO4Dxne8ARclmqWyEmUWtHsPkrqO6oy3zalSuK1uUr+zVkpIzIGv0WA96sX/0d30CXwOB3fo8/n/HBBzWIOrU9GhSa3XV/M6TCmXF+n3wpXTG8OKnVknN/0xKQEY8dIt8CfDPb+Ihqwtwz5+SRz1dmALXZBYMZbDX0ftsdnv5CMfdxIvg+LN7ogd+Z0wPQ9C+zu7BCVqOewH0RHjLL5+81muPt+q9dp/pXi2Elk3jM1Gh0dmL6Gx7hHMfCV5CopGod/9zQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y68-20020a62ce47000000b006e0545768dasm1800999pfg.151.2024.02.07.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:08:16 -0800 (PST)
Date: Wed, 7 Feb 2024 08:08:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] overflow: Introduce wrapping_inc() and
 wrapping_dec()
Message-ID: <202402070806.445F7F7F03@keescook>
References: <20240207152317.do.560-kees@kernel.org>
 <20240207152422.3855315-3-keescook@chromium.org>
 <CAHp75Vf3emnw-=it-Smb_NG+xYjWhB+U0+i1hcNPWA=BByN6nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf3emnw-=it-Smb_NG+xYjWhB+U0+i1hcNPWA=BByN6nw@mail.gmail.com>

On Wed, Feb 07, 2024 at 05:31:54PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 7, 2024 at 5:24 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > This allows replacements of the idioms "var += offset" and "var -= offset"
> > with the wrapping_inc() and wrapping_dec() helpers respectively. They
> > will avoid wrap-around sanitizer instrumentation.
> >
> > Add to the selftests to validate behavior and lack of side-effects.
> 
> I would expect inc/dec to add/subtract 1. So, to me the terminology is
> confusing. The list of the C/C++ operators on Wikipedia describes
> above as
> 
> += Assignment by sum
> -= Assignment by difference
> 
> 
> Hence the proposal is to have
> 
> wrapping_sum()
> wrapping_diff()

I think maybe the missing phrase is "assign", which is what makes
argument 1 "special" -- it's being changed. Perhaps:

wrapping_add_assign()
wrapping_sub_assign()

?

-- 
Kees Cook

