Return-Path: <linux-kernel+bounces-54037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8884A986
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B58C1F2B353
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA50D1EB45;
	Mon,  5 Feb 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FemScorA"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D44BAB5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173058; cv=none; b=XSGTQOF+vqnHHHOCA3abfF3L+4Zk6eVnRtVeTmI4KqwIiQFXYxvHbzZVZJi86cYuPhDlnAtcftaKBZqCuCKIbd7NE0mr5hWhdtntqhnNDnHedDwvWJ26LBRnFvqowi2XwHNYS0frdT/zuaeuBoggzGZzwrH8MyLbIX3WMV+kcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173058; c=relaxed/simple;
	bh=ZQgq1MCIgYVKvCXkNtnZ9U1EnbNFNTYyqAwvNP/4WjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SClsj+7Uyh4089jcXqofuf9rEDbJ9/uZJxuYcx9G5C8xeDS9SgREPeCf3yQZ2/18XtI+F+lmBr509iOdYlXs1YQCjyTvxvnJfQYh/zdCgKGJHOt8yDIBEB6j6JGv7kS5I5vvp1oy9ntfkKGzwQ//fEo3vZ7r2s4iG8hvl32w6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FemScorA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0353e47daso1349551b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707173056; x=1707777856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlsSc3pFtKmxKFilYiWjxo3LPVslJeCkCNbb2hluo8Q=;
        b=FemScorA3FgpmqmyNWIkNg1H3g0+setZhSxFAN8BB8QkkuHitYIpjJpuo0dVLod3m/
         A5ZwdjiGrEEWPcrjWJwVNHjxQqWgHCNI0Wa4+53eJgF6l+uyemKEgwWa+UQuka5sujOQ
         1Si01k2CS5xZoF7qMh6F1Bb1OPqVQn4mTivTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173056; x=1707777856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlsSc3pFtKmxKFilYiWjxo3LPVslJeCkCNbb2hluo8Q=;
        b=IB7XR16dXZXMJ0FRxFILn7LVoV1ZQKdA0g54ygjBqrYGbJg9VnVeO9LjWnuToYw72h
         oaz+/xJph8hu9bEc1gpTo1/ar5uCi0cQ32vB9bNq962M1rr6Q12fZB00W82HLoXXKI/T
         WGYLYBaqjqN7F4lOGueQx7XHLGelAT5G1ta8ShvrDIXwDWRu5xYqZW6dAi9sf2kWh998
         NxrkYYb0b/LlKpJCtXDE3VRO6RTJ17++uN2W5P5I4nPR8hs/f82mBMaac03oNns+N7MT
         bLd/bRbWz0/W35vPk7uIBiWy/8+u5vXqMwE8vrptKWOSTSxkH/uz1jRLP5TVnojMyCUo
         L3/Q==
X-Gm-Message-State: AOJu0Yy8WzJMlElCWU29eWqdOnmNxjqJLfE6brS0b6wdOBizQ6s4C/zE
	B4+OoBkrKjlawu9ULClWopWoMDtxXX9SLooFNrEiv8Ysf/X0LYklzp7O27Qryg==
X-Google-Smtp-Source: AGHT+IE1QBh6gexcQ+2X2Gc5NMQeqE3k7X4xb8teEBAWlblyskPJ73kN16UO1tfLOwj40JT2WfGZ/g==
X-Received: by 2002:a62:cec3:0:b0:6e0:450c:4a28 with SMTP id y186-20020a62cec3000000b006e0450c4a28mr761387pfg.29.1707173056004;
        Mon, 05 Feb 2024 14:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUv8l7nHBzn2Bdlub4E1yxV75RGWc8+YfI/ZYUKbrk58oaZHuJVOKCFMyxtvcBbuHCJfRv54TwpsQ7oF6IHvjR/Ubalse+Y+AegHLipH7c0uAej5DDm1C7P0ShBhVOo1Y5oN80ZZsHeKZXzSpJ2nUqpcDFT96NANp+kB0vSKnfnntY6DT4JMsucdb9o8UpfrGWGBK0zQ3AICs1n2KSrms02YxAQoDWAMw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn11-20020a056a002fcb00b006dfb8105235sm392409pfb.112.2024.02.05.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:44:15 -0800 (PST)
Date: Mon, 5 Feb 2024 14:44:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Message-ID: <202402051443.A813E4D@keescook>
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
 <20240205202145.GB2220@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205202145.GB2220@sol.localdomain>

On Mon, Feb 05, 2024 at 12:21:45PM -0800, Eric Biggers wrote:
> On Mon, Feb 05, 2024 at 01:12:30AM -0800, Kees Cook wrote:
> > Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
> 
> Maybe these should be called wrapping_add, wrapping_sub, and wrapping_mul?
> Those names are more grammatically correct, and Rust chose those names too.

Sure, that works for me. What bout the inc_wrap() and dec_wrap() names?
I assume wrapping_inc() and wrapping_dec() ?

-- 
Kees Cook

