Return-Path: <linux-kernel+bounces-87703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F386D7F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0D61C212C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBAD7D062;
	Thu, 29 Feb 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AW67M3HE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653B17545
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249950; cv=none; b=V4dlhjT8up5sc/ELPmJ/Mcc56nzxvQOnmpx75gxGkVv5zxpDwKWhPVrw59y6vzyfJn5+VhYs1mN7oQyRozhsorSdfeJV+KIXxJ15ErAutFj2HnjoCw9Wpx/FWPKw9xZlo2GJx+G+FdapEts6pg+GMLY1wBVLss5E7Zcz8dNHt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249950; c=relaxed/simple;
	bh=e/8V7q0T5PQHD8Yc+VQwsb6DOiBHkVWPVrFu2N9+wis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PszSlmsm9QYKDw4pAPuWjmxJw3NXBkrLwGmSXle25m2HGfM199mp90YnAJ3I4XnUkFFevmlq/pNgzgZ3cwAKbBsN4A3Iclep+Qwr0Ghtla9+4077P7r3B+JUkZKCZ+ZC66i2Gt+GgYGx73whxNocg6exFUiSYpB121CFKk+Dqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AW67M3HE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so708741b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709249948; x=1709854748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrpA1mv8JfPN81Pqls2RUoWHBrGbGLLk6Rp+CKKaj/s=;
        b=AW67M3HEZ8+Ko+S4R3j/DvmN4MVoDg3TDZNuAbZqUz/VFKHMsUsdNh/+1ZdSQsSkvr
         hp9HCzh5UdgCOcyGFxcJuA9Dh9znea32nlkv4PM06/9wRhCQHGNngGYa1JAmewCY7SDl
         LcZuHZk2REpIz+uTgCvUUL3ru3b3OYswWiuXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249948; x=1709854748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrpA1mv8JfPN81Pqls2RUoWHBrGbGLLk6Rp+CKKaj/s=;
        b=uwJEpSFVn8S3Xh+ZWzqO4qYAuAtq+EmUEGCv/SJYMeAhAg+6PqEIPRD+LqjJ9qn3IW
         WDQ5RuPbsOL9DgZVzsSdoAiaxSxyi45EIebda9Fj7c12JUaa9eHIXndpbZZmVtGSV8Vn
         eq6tA0Z4YBiH+GbhaxTDBtbCMTeldDXm32Rz+Q+T8SomXoBhNWeGleKJigrxXEvb5+zz
         rKbC7Zc/uC35Fr6+il0KAmwwmjX/6ysbJfHEbMdlWIJFyRIJhMN9qcPJEb+rj1Kac0F1
         u/XdX7SXzW48SrrrcdIvstDg0enewn78GULwgbLeaTR9vqYC7Wcnf5426Lczt9Y7Bbs3
         oK2A==
X-Forwarded-Encrypted: i=1; AJvYcCWqz69Asot3FF1TZ9kFoO4OcjpDWa0EdwPGOtwdWz8zjdcltcTQTIl2hU/XCacV7aV7U+GvR+ck3i/2vRQv6JLJpuSZQK5/+RvIeuBp
X-Gm-Message-State: AOJu0YzIi97W+VaIbTl/ehpFbgN9+KUjaCUK1QHwTx3cS5ZLyZO2SDwV
	118ZRGu0wlN5By5JXBXlZU50eNDdsVIwd5k8PXtpntSDuck33NpCjk9PF1WtJQ==
X-Google-Smtp-Source: AGHT+IGJVW2Kg8FOzevwO891TfCYJpBIFcznOfoM7q4NgpLUnUQXz9LiC/9jjgPSzgqu4jXznWV/FQ==
X-Received: by 2002:a05:6a00:2293:b0:6e5:599a:5252 with SMTP id f19-20020a056a00229300b006e5599a5252mr665091pfe.15.1709249947822;
        Thu, 29 Feb 2024 15:39:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e509762bc2sm1813393pfa.26.2024.02.29.15.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:39:07 -0800 (PST)
Date: Thu, 29 Feb 2024 15:39:06 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] string: Convert helpers selftest to KUnit
Message-ID: <202402291539.F0E3E63061@keescook>
References: <20240229233432.work.675-kees@kernel.org>
 <20240229233528.1538803-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229233528.1538803-2-keescook@chromium.org>

On Thu, Feb 29, 2024 at 03:35:24PM -0800, Kees Cook wrote:
> Convert test-string_helpers.c to KUnit so it can be easily run with
> everything else.

Gah, I will send a v2. I thought I was doing this on top of the
get_size() change, but I didn't...

-- 
Kees Cook

