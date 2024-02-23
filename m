Return-Path: <linux-kernel+bounces-77810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D632860A76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862A9288917
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F912B61;
	Fri, 23 Feb 2024 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRdtD3FF"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBB125B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667452; cv=none; b=cT2HXcSyiszo2NYPN57KAlSE3TPGqYQUNgJ7J5Ly3D0Li52nL7uKAbAv8aMNgOVJJN2ONVI2FbM+qry6tvScGm1rVOCewLwZyO40uDkZ8+UOqGmgGlmw6QfyYvL+tVRQDVrYXEVGzLS4R5l7YBpW2XRo6sLd+e0N7GACsQb8KKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667452; c=relaxed/simple;
	bh=6CcSPVx9G4kFBCSEc197AtRmLI7s5cZLnX7peLANnHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLKQf2jGIwGdqaB8Nn42bxuDnUxPx8m08y3O3aZyJaBw/liCEnybizDWfR0/wqBGWSBcWXzsvKGQVbb7hl8fooD0TGu5XOCj6Bjxop9jBu1yR7PIi5F8JVJTP6XfxJ2/RZEVKDL2nU95AjrGiIdqqAatqjLZnHF2iOglk2lpZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VRdtD3FF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so444532a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708667450; x=1709272250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrD4aVisPoatToYkXMHA67YFZEJaZr2i7UcckDCOmFA=;
        b=VRdtD3FF+DvtMDIKxWW87q7tzOW3sNFbQ+8J3t8lCtZFiD1xrBVAOcZf0TEE853Lj9
         hJGD4WoZpUi4+lD5i1TlTeN/Nh7iX3UPiY+15A+qwdLkD0gr/jxLsHn44RQWfGu9NCU1
         ENOyLJIDdeHpovIonUvzLEfrtZXrOCKrBjjDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667450; x=1709272250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrD4aVisPoatToYkXMHA67YFZEJaZr2i7UcckDCOmFA=;
        b=CX9bVIeyqxdZYS3OyHxTu7AB8Nbk435bl4Jbt0PUqUOHAmfphN7z15tGUW4y0LPpcp
         kmnEy/114/F0Ym2zDMh2OUo3cGWpsi4mCX3Ov+DjIForRwZEA6IBraaL9sCzcKyqo925
         9RerJ1Itf6OalOOQ5jvpiw5UPUMHmRwG2otV6rBFtjA37bRUcaw8ELIUpiqYCPXEPlxu
         w0sg5KKZ2+Iw1iBra0fs799s5jHekBCA+aST3PPJCxG7xXoNxVndWpFPpFN4DCqN3ex/
         B7TXYaUoSYi5Uu7OpetFjfUV++rt+r0uX5f9Plu3aPJAyqBZZF/gYMtTARlWDpl/+JzT
         /DWA==
X-Forwarded-Encrypted: i=1; AJvYcCWTS20YpZr8bFLTfppTNujepCcZlLYoK8PMXYvIzOe6vqNo8qrptGPq/0S2xXmbuqMIYCliw23TEnPtTpsf6cZsVRvqRF0r88YZGUUQ
X-Gm-Message-State: AOJu0YzESyZxbsiq2i6du5kkKMjiWSoPCab2Pg/sIii0ZggMLAT1xFdd
	f6GSAmRrOMdJzZiC4QGEM/xij4oZJ2xn4Qrbi854NPrcmCAybBDKCcmzVzlXVA==
X-Google-Smtp-Source: AGHT+IGTu2lqOryY1wAHJStKm+nQ7ysr6ySPy4jXinCm6kYlAZJWf+06iYxKQGfMLdVDBboieFmN4Q==
X-Received: by 2002:a05:6a20:d905:b0:1a0:e248:dbb5 with SMTP id jd5-20020a056a20d90500b001a0e248dbb5mr255442pzb.50.1708667450261;
        Thu, 22 Feb 2024 21:50:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902aa4400b001d911dd145esm3329047plr.219.2024.02.22.21.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 21:50:50 -0800 (PST)
Date: Fri, 23 Feb 2024 14:50:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: hannes@cmpxchg.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com,
	yosryahmed@google.com, linux-mm@kvack.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3] mm/zsmalloc: remove unused zspage->isolated
Message-ID: <20240223055045.GU11472@google.com>
References: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
 <20240219-b4-szmalloc-migrate-v1-3-fc21039bed7b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-3-fc21039bed7b@linux.dev>

On (24/02/20 11:37), Chengming Zhou wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The zspage->isolated is not used anywhere, we don't need to maintain it,
> which needs to hold the heavy pool lock to update it, so just remove it.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

