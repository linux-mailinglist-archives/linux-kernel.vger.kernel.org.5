Return-Path: <linux-kernel+bounces-52664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFAF849B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5BDB214B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D82421C;
	Mon,  5 Feb 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bB0+0/ky"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D42377F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137705; cv=none; b=OIpSGJNIoH+0EHJSce50am4VV7nSzr9jwoYTQM3dRwkDM+FZoijYickfXnZP782ZM6A8eCvggr7LGon/UvJ1tT/353AokyJzFPrRj8L/FvuCIQIwneEXXOjSz5A+bleMh8EcM/zGUSn9smp/a9CWONVVMuS476n3gZXQaAS+Uv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137705; c=relaxed/simple;
	bh=NtkIUt/NPExzmQ+Wgm/bq1k0NjISHJOHOb1px1CosPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2FZSuqG8AqveBzr/G2NonAJDROiPPbbdSWCiItAVBrG6JwU7rNsuX2OihPQp6QKWilGnQA2YVl8O/JZik51J1qpsDy/i6XGWB9RJZsZK2ORWV/D9+btxT0UI+m8oK9CEop2RDEuP27wWeKyuwNIGcFN6gADvPbGXJ4+5PRAic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bB0+0/ky; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d8aadc624dso32224425ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707137703; x=1707742503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9eqj6VUl3ElBcX9JFZIdAfEkD+ItQaBMHqyrnfhAesA=;
        b=bB0+0/ky4JHuXyGYYSy5vXUmfaB7bItK39IhrUORN9M5UPfLNJSZe8fWe6yPOe+9tN
         unDKDfDSKmUMBERlzsHNrDrrWvOQ5X5kIoF4LswI9BEKWio5YyZbGlsHjnJyXpsc20g1
         ouDfzYSGFbxV1GvH4Fu9s3ewzMXQNHxrHXHgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137703; x=1707742503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eqj6VUl3ElBcX9JFZIdAfEkD+ItQaBMHqyrnfhAesA=;
        b=Gd76XDUGjqzAe/hNAHonF/RopqqAxhErHz8hWZnN5fz7WRw3eeLVx+3nGIMha/2XqG
         1UA3iEUmEjSbdJizfQ1/gJ4PMGSNVqz5ln3ja07akg+r9ZxlqxyzxGSK+UrGHmmrqC4Z
         S8oXwpNi1IqirGop/eWs4TaJqMnus52f/T6Nfg+PfRwZuAmxhgCFyUc474WNkuVwtCww
         nd+dPyVkDfI2u8rLkQ1fvyWOqDnqfNUlZkuqXXiUDnUknahYw6uBqT7sUlhzOIbOexLn
         jxbAhTgyYuydhQaNaLR6L0VZ4rIi3Qpe7VZRnI8i5AlmkprrzTunyk02nFN1lPzGYU+V
         J7gw==
X-Gm-Message-State: AOJu0YwvTQGwgMW6UqIqHkyOeWDwwt+9u713eM5aVqwoS2pvD5b3lw6A
	KHps48KUZI1cUq1v6w5HfW9m5+O9rPqIBEIVlJo8D8cciOEoFeQAue4AltlKhgteSghv1mqHCfQ
	k7A==
X-Google-Smtp-Source: AGHT+IHyEglIjeQqir7zX7bqgdlVQTPfRLYGhj2TDOlxCrJpuSazsofGogVJ+1ntp+fMcQJK4wHRDA==
X-Received: by 2002:a17:903:5c8:b0:1d9:119e:af45 with SMTP id kf8-20020a17090305c800b001d9119eaf45mr7936692plb.41.1707137702940;
        Mon, 05 Feb 2024 04:55:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVvdRXb6IOojIEym9pwkxXlecm3xXPYtnEqiRGrRaTf3kIs2Z5KJraNbE/dJM891G3HSSeoAyl6cHepw9FKKFNe6zWRkBmJaPg4EPsrA297HHgCLk422SqAzhzcLyci1XD1IVJCDaf7u90yPFwGNklRZ9Xzkhxdf5euNB5RlG3QMNih/A==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o11-20020a170903008b00b001d94c01ae96sm6284354pld.66.2024.02.05.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:55:02 -0800 (PST)
Date: Mon, 5 Feb 2024 04:55:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add UBSAN section
Message-ID: <202402050454.AD5C144E@keescook>
References: <20240130234634.work.003-kees@kernel.org>
 <202402020154.0266109CBF@keescook>
 <95711933-415e-4a49-a55b-8477a990a0e7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95711933-415e-4a49-a55b-8477a990a0e7@gmail.com>

On Mon, Feb 05, 2024 at 01:54:08PM +0100, Andrey Ryabinin wrote:
> 
> 
> On 2/2/24 10:55, Kees Cook wrote:
> > On Tue, Jan 30, 2024 at 03:46:38PM -0800, Kees Cook wrote:
> >> The kernel hardening efforts have continued to depend more and more
> >> heavily on UBSAN, so make an actual MAINTAINERS entry for it.
> >>
> >> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> >
> > I don't see Andrey on lkml in almost a year, so I'll drop the entry for
> > now. Andrey, if you want to be added, just say the word! :)
> 
> I occasionally read that stuff, so I'd appreciate if you'd kept me in ;)

You got it! :) I appreciate having more eyes on it. I'll add you back.

-- 
Kees Cook

