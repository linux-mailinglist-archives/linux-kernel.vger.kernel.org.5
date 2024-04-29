Return-Path: <linux-kernel+bounces-162969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C588B62DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172F1B2187D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1313D891;
	Mon, 29 Apr 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hFBGjjrm"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2D13D600
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420191; cv=none; b=qBGdn+IoMpIsMlcCzFou8NjnXykj1CIh0BVnpqnYhw4vp0QTDsej+0XYN1FknZQi3Qod7suTNL6oaT3ziM6x2FjP0v4hACI9qdryJCSzcp7yiE2uhH6RFgEKUs4h4SMgfE1zyEtnP3Qezrm2aw/rTLXRPATdrPTiwThKyKIVwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420191; c=relaxed/simple;
	bh=fLy9wuUj7qj/KLGKoiK5/omRxQbXTc/lSN/3AugUd4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETch7SN8Y8vfo3g4zy4lpVMbxJYOg4FsOy6sdPtc0OGYYyLG+wDaNE1lbQJxNKkuUbOgJhREcUUIY1iNM7CT2LXJw/rHIu8s+eFt0yG2SMyEfplPCF72ydQutjcyB5JLplIkNNdV4vT+Q10ydNjKcKw9XgbButLnSrWUao59oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hFBGjjrm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f3f6aa1437so1646490b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714420189; x=1715024989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdmEYuDR/RJEQB35GPv4tDo/+p4YFOvYsLxCcDQQsi4=;
        b=hFBGjjrmupEELOGBImuHMuFkbG6kgsEK4o9GXNq7ILpZ4p6QC3OhT9FOjIhH3+muUE
         RlX5i60LxP0MZuHjW28H2rDZ+d70mD6jbBtAxMwbyI6EFOVz0FiXpeD8MG9cJ5nEwVtj
         qavG754xc3mvGTYUJe2eVq6lSM1H7QAio1xPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420189; x=1715024989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdmEYuDR/RJEQB35GPv4tDo/+p4YFOvYsLxCcDQQsi4=;
        b=EbmIYrL+YnqAk1cEdf6rhEpAatPucfLVNYj6XHpdushJSDbRRKImPKUOPbII9ov6on
         AA2KrD1IN5HEOfKUskde+ug7CrXVIEWHsEw+2SsQxbF+1s1vGYNU17pJugrPwplgbgvC
         LFADT6wfH4B68gF11Eh8Wj/8NRqfvamVJllsfn9H5jZPPI5NPod1yWxdTNuGXSRurq2P
         qEN8lX37cpCGqiZVOXhn0xcY9AFpKGI26jaEdhLSj/43IZeCF/IosCEjPZsMgO0qqBVZ
         TAv53bMirv9z5fI616WKJvqoa1o4Vwjdrm+Y3tDPIWvs2bzIet6vcu8Z5umDYduAWWY2
         REYA==
X-Forwarded-Encrypted: i=1; AJvYcCUatfMV8tgM/CSE6yCX8q/1rZktKfBtTFVO050MXT75sKPHg7Hxvc6KJH4KFE3/7zHTIUIPf1s5AZMR2J98KwKsobdnkbzgzpCETVTm
X-Gm-Message-State: AOJu0Yz/JV2JhhpJWHxoUj6AytYTOU7taFC764GDVIKfLAlgfmbbYyp+
	tfI3bz65+Pfn5WXVz00XH/1pEsmr+Yr5DBRzzwTIUSoa0fZ9gqmV5wjTb2qD5Q==
X-Google-Smtp-Source: AGHT+IHMkhSs/5SnSlE9LvmWTc+i3WLtTxQUmkaAPchto2E1fkXuXDdc1dfuIKTAOn3H+oooC1kLow==
X-Received: by 2002:a05:6a20:9f8b:b0:1a7:7358:f108 with SMTP id mm11-20020a056a209f8b00b001a77358f108mr14742494pzb.24.1714420189565;
        Mon, 29 Apr 2024 12:49:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b001e8532292a6sm21156271plb.195.2024.04.29.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:49:49 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:49:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v6] checkpatch: add check for snprintf to scnprintf
Message-ID: <202404291249.078D924@keescook>
References: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>

On Mon, Apr 29, 2024 at 06:39:28PM +0000, Justin Stitt wrote:
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

