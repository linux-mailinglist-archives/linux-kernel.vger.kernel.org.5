Return-Path: <linux-kernel+bounces-34203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5976A837582
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E884289640
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70294481C4;
	Mon, 22 Jan 2024 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LBqEgZfD"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81E47F66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959435; cv=none; b=fMiRDg7Si3wSBNf/TCayGv55HMLbHSLydiyPU64VM924ZyGSGuh5KWp8t1fEKL+bMHl9K5DhWFKife3DKDMHOOQH+Q4LT57JoG6HXshzq0pMg2oWuTydvWLuvtHgS3ldwi9r0QUGmQV3TVrS+ZNJ0GU4VkhmAY5yKSqveqfkPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959435; c=relaxed/simple;
	bh=HNTtOHdJXNAt7afBOtGBu0agxiWRvw0w3IbNe3pA13s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtvDw2FsWStkcXZSaHBGZGoC9rzcMq6Fo36Rv1g6lpU9jUL+iLBBRjhjdDUKJTTWobxViwm24fB3sQ/r8hC9X4LH059ue8Vn5Os/leyDuWjSjZm4I7X/6/7lyOzKWyCyXNcrpH17QOXbFC7UIOBsSOHmY6Uek20RIVtAqT5/5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LBqEgZfD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d70b0e521eso26438605ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959434; x=1706564234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ohIM+QBLSzmN75oEYt6DocSn1ONwoFPk6+o1PYHvXM=;
        b=LBqEgZfDtM5qGvIPatKQoM5JBD8E4vd4gVfWjbZh/PQWIZt8CeMUARdrqEekvMe9R6
         /VuKCnHfTo5CXltB7VXNPWEpvd6lWRglRRV04z4a9WtWf7SQhJbGtz+ONw8C35gHmyls
         CCbqQBAYw8v+/yaETCwt9hgLqIIsFGM40t6Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959434; x=1706564234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ohIM+QBLSzmN75oEYt6DocSn1ONwoFPk6+o1PYHvXM=;
        b=PlarGF2laVPyNNZ4RAATlw9Yu2FMd0MrbpKRLJzOu/miOimpG/vbp92MIBEd0870Vc
         aTcNCBSUveHMcMXJLpsXF04uX4Z88zcVfwJ1cyG/2UBoiNLX5F2n+hS/Pj+XHdGNiffk
         3HFEjNeY6/XWM5lOje47v/jQ4BQiOSwXkODuNLoK188sIFZA0Le+mDqWP46cXmxwTYfP
         QBnWP14fHkvhHSMXRioBOqmpMx5RnEGxSbe8vdoItqwO1u1jbg79TmCmaFQzRqwrOKvX
         O2qehyeVtvc3s8WQjDEs4pbS6nkEwvSnGH3sbTBANj16bcxesuES5S8tvms7O4a4AiYp
         M4xw==
X-Gm-Message-State: AOJu0Yx2OEVhtdid4ZQ6uQPiGk64RUmmzm8FTxUddeeI4EXoVlri4S0J
	kQXxmsTaoDQOcRhn+AO6N0CGK/5FB6JEJEWeykyJJBMAgT5q6zRCGKcwk0Lyig==
X-Google-Smtp-Source: AGHT+IHDm3PgnIf8kOCaE+ks0YcNVeiVaAo4XhhQf4tT4YoipxfjtqAWre6bTc+kgyN68SkCyPCLzw==
X-Received: by 2002:a17:902:d505:b0:1d7:407e:4182 with SMTP id b5-20020a170902d50500b001d7407e4182mr3650157plg.101.1705959433868;
        Mon, 22 Jan 2024 13:37:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001d0cfd7f6b9sm7649182plb.54.2024.01.22.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:37:13 -0800 (PST)
Date: Mon, 22 Jan 2024 13:37:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v3 1/2] kselftest/seccomp: Use kselftest output functions
 for benchmark
Message-ID: <202401221337.8A3B228688@keescook>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-1-785bff4c04fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-1-785bff4c04fd@kernel.org>

On Mon, Jan 22, 2024 at 09:08:17PM +0000, Mark Brown wrote:
> In preparation for trying to output the test results themselves in TAP
> format rework all the prints in the benchmark to use the kselftest output
> functions. The uses of system() all produce single line output so we can
> avoid having to deal with fully managing the child process and continue to
> use system() by simply printing an empty message before we invoke system().
> We also leave one printf() used to complete a line of output in place.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

