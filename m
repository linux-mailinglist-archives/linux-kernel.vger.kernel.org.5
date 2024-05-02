Return-Path: <linux-kernel+bounces-166604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CE8B9CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D8028B758
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9CE153BDB;
	Thu,  2 May 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nKLmFHdF"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC315383E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661653; cv=none; b=NuXjMPyYoEy/TYP3KwfUbXS0GS6EoOX6J2/XAuZPrN9oNfkvxPr8ySdjq3YE9trFvxReXOD/pDFuPtaMX1wofD9dHdmkWxAcjOPHwnzo1g8RbyKpXoJi+9IeTunnHNG0lni/WCWmahSiAKctxNcg4y0Opox27cQis8eGlCN3Vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661653; c=relaxed/simple;
	bh=dLyycVBVkCwJPrx8KzaTxTts64S+6ktjBjYM8nUQXFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YScORpOMh4bK5waeYSgWCwTAFVEyZujDLcIaxE6dDGUWrTMUxUBgeCuUYOzMsc+RFFrvAYrVyxtx2hJredJ/tygvsgAj07uErcAEyr16oznlRbxGRbhdsthDBxmRTAOZv1Ni4pQx0atKEWbFpqYFfMdebczyUrvcpzzerGSd9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nKLmFHdF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f447976de7so89468b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714661652; x=1715266452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toaDt0gOM/D9JW9cXIx8ra8kanOeaIOI7YXzr0B4QfY=;
        b=nKLmFHdFCt/pv/ZAHD41QaOMbOVSLeoGAC47j1376BZ+ghwPkSDzXOzmKsYyED/YHp
         qKy1Cyn/5IQ8e0StiLunmy16/I9gwyIzcLpG6Nvk+8wvO/zxjTvvzBrc7XTFo8eFMgrR
         q1wsa+FkHItLcf57zQpNacC/kBqLlpV0kkO2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661652; x=1715266452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toaDt0gOM/D9JW9cXIx8ra8kanOeaIOI7YXzr0B4QfY=;
        b=SLJQUKgdy4/wwNot+aqwgD0wpSLl79/SwJVOxcTBwjZOAXSBfiau7ZRE7BYYoHHJrc
         hTD4UIrXMZCJWmfR/pm8/iZdQ90rA/hQiNqy+u08BTyCKOu8nyk6NJLGdhTJxddpa+20
         Fd0BQitn53t9ief1QPdTtQ7UClHcPtxN4Hkc6sMMEOfP+dX3tdMIUa56teyMUU+OLPNe
         nb9M39BInN1qArLGZDJwa1Jwny+pAPhY3jcE5AtSqADAl+G+QWQI91pXyq1yi2oZFkWR
         VXR3i4XaAKZLvQ8NXsxvUy9vB7WsraZsd8sfGOy/nw0FUtpDUMcMKPXs59SiDajqXs5m
         n80g==
X-Forwarded-Encrypted: i=1; AJvYcCUK5xdU3dBMSMc+O2sGnJilJ3RRsbqtiD1UIu63qLkG9/fkIiVPVng9zGelM1wiKM4ASv1zjsOtqR9uleFwOJD6GBQNSdaFNcQU4B3u
X-Gm-Message-State: AOJu0Yznwo6Nd/4fyscK53TT6grvGbCJZeBbTsYrEPKU0fUAjMQVUyBH
	5bbI32K/I+WO6sy3HZ7r2vOe/0EMNt0VlF2WGSpbvzGXZxDTVsU4IaKUBwIl4CWIxxgtz9nNa0Q
	=
X-Google-Smtp-Source: AGHT+IHTLCUnM12DuL3VBb7A6wxk1Lbr3S12D3rWq5l5tjqb9FkNWWaPYTh3WMolJVPPLDC4uTFZwA==
X-Received: by 2002:a05:6a20:3218:b0:1a9:d6e2:66e9 with SMTP id hl24-20020a056a20321800b001a9d6e266e9mr2076610pzc.28.1714661651780;
        Thu, 02 May 2024 07:54:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j4-20020a62b604000000b006edcbbff2b0sm1311726pff.199.2024.05.02.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:54:11 -0700 (PDT)
Date: Thu, 2 May 2024 07:54:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: Add additional __realloc_size() annotations for
 "dup" helpers
Message-ID: <202405020745.725A922@keescook>
References: <20240501233201.work.732-kees@kernel.org>
 <CAHp75VetkKYhnOaoM880D+VTR96NscQfBGddgAwKz681Uk5ZJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VetkKYhnOaoM880D+VTR96NscQfBGddgAwKz681Uk5ZJg@mail.gmail.com>

On Thu, May 02, 2024 at 12:45:33PM +0300, Andy Shevchenko wrote:
> On Thu, May 2, 2024 at 2:32 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Several other "dup"-style interfaces could use the __realloc_size()
> > attribute. (As a reminder to myself and others: "realloc" is used here
> > instead of "alloc" because the "alloc_size" attribute implies that the
> > memory contents are uninitialized. Since we're copying contents into the
> > resulting allocation, it must use "realloc_size" to avoid confusing the
> > compiler's optimization passes.)
> >
> > Add KUnit test coverage where possible. (KUnit still does not have the
> > ability to manipulate userspace memory.)
> 
> Makes sense to me,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
> > +               checker(len, kmemdup_array(test_phrases[idx], len, 1,   \
> > +                                          gfp), kfree(p));             \
> 
> Despite being longer, I would put gfp on the previous line for the
> sake of logical split (and additionally to be consistent with the
> below).
> 
> > +               checker(len, kmemdup(test_phrases[idx], len, gfp),      \
> > +                       kfree(p));                                      \

Oh good! This bothered me to no end too. I will adjust it. :) Thanks!

-Kees

-- 
Kees Cook

