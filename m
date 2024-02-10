Return-Path: <linux-kernel+bounces-60329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0C85033F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C391F2161F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB028DC9;
	Sat, 10 Feb 2024 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcgMYLoc"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F036114
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549193; cv=none; b=ESNOfxKfnTcY40jzrJEkavpi7ZYhmnMNc+QxFX6lMkOEOJ8HRO1n69RktSTgz9LjoXkJtz91MopXdFHVBAxWaaAhngQzAqilixDgdOuZalE2aRwJguH+yGqAOolQHWcTJVcEXoz8ukCE0ICMccX8GCuX6llSa9yyETx66DtYGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549193; c=relaxed/simple;
	bh=qa6lwNwuaNmnSvIUXpbojAW7vqsJ6IReplZl0473XF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+wgEfosidINgkO8FVBLmfawE2ub4R5ziwPpiM3u6d6XahKKlJ/HwNHbD6M+JECmmQpXRniXMIxMXZOQiNyseGhgPPFwLLJ6FCidT8P4dszXLFLvNGnB+9cd0utdQh/MkObFqXQXTdLk2chmcVDbhkjgTOAsF8syurYc50y5QeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gcgMYLoc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d91397bd22so14421845ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549191; x=1708153991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZRBOHYkP72NNNveV+hEVqEGZ7ldBtbUUMBQ0P3CVIk=;
        b=gcgMYLocUStc53ai4JvFtG4qnGOEWc345nVX3KJrSHd0Vrkm3c90x1V0CC2I5qWZZ0
         uPdu93dpjo2CJVPxPpcgN43hJIpe4hgD2dC3+aGfHiQjTcl/4otXb1B8oyeYIPqokp//
         g/EMM1chtpAvfTZe5JhMFxUKuF6zBfDOhuhQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549191; x=1708153991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZRBOHYkP72NNNveV+hEVqEGZ7ldBtbUUMBQ0P3CVIk=;
        b=TQ8uqbQN7CqDI5pS5Dd0eeoE0RcoTCqmZ0pyfNIBsTJKnu+PV30OGhAZgJ0MWouUmq
         O5koEfumrYUq8SnBV06DJ/gCKsfD6CvlvrjoVaA1uBi57sxLvnVJEeNV10szrAKTOHFv
         OUYCOy1DMKAULORxmwjr7fgxz+WA2LZVFjvEjmzi6FCK7vI5h3YrRGVGZLVBAsz+qzqZ
         Di/kQkVJFj+2mCgOEdAUutpSJ+JfFX5sXN5E2cvnsDkklg/ZhLGccnysDTh8MGtD7h7e
         IJ2159c7Fcvd2jRK6LQz4uPpgz8tL/9pK8N4DMBO7NxM5OppOt5F5mHa+3wKeuYomWtA
         dWIg==
X-Gm-Message-State: AOJu0YzLj68IdXJefBixrzbjPH1m6AFynMMEX1ZvAKyc2z4rjukIgy0X
	43hRO+04WOQmE+OWcmNpeY/TQzerIT2dek8k4R5Zfu7yagGFlemqpd8QhjcLcw==
X-Google-Smtp-Source: AGHT+IHfnrueqCTQZn5yBVsCerNu9bFRsxFYoYcwRrkCE11kCBAFTjZ+205YnVm/uIms6cv0AEHi8Q==
X-Received: by 2002:a17:902:ea94:b0:1d9:c37d:7194 with SMTP id x20-20020a170902ea9400b001d9c37d7194mr1528203plb.30.1707549191674;
        Fri, 09 Feb 2024 23:13:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjbPKyAh1Ahj3YvSqb2HTaAM0tr+qznBDgMHZs9QY0DF7fhQwtJlx6RJOp07ohJnXymDKfdvMYZYG8NIbJAcQqBqOYQ5nBlATpBS0D9wIpHEnM8lMGpalxtBzujnB+zE4PnFtE6rMoz2t0mnEWHUHbVZugV27I4P4KLBRnK49llqEuzVfFGjRQJAB6w4KKqiIQV9PCSWJJYkQVhQnbxPC69lqnery7gZnE2LEPPqHJmNmeRFLYAdb9QI2BEbBX18QAjfHlvrGURthc4KZ3hA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001d9469967e8sm2500730plh.122.2024.02.09.23.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:13:11 -0800 (PST)
Date: Fri, 9 Feb 2024 23:13:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/10] scsi: aic94xx: Remove snprintf() from sysfs
 call-backs and replace with sysfs_emit()
Message-ID: <202402092307.FC979BCBA5@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-10-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-10-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:21AM +0000, Lee Jones wrote:
> Since snprintf() has the documented, but still rather strange trait of
> returning the length of the data that *would have been* written to the
> array if space were available, rather than the arguably more useful
> length of data *actually* written, it is usually considered wise to use
> something else instead in order to avoid confusion.
> 
> In the case of sysfs call-backs, new wrappers exist that do just that.

Actually, a treewide replacement for snprintf(dst, PAGE_SIZE, ... to
sysfs_emit might be workable too. Here's the .cocci file I made quickly:

@replace@
expression DST;
@@

- snprintf(DST, PAGE_SIZE,
+ sysfs_emit(DST,
  ...)

This produced almost 1000 changes:
 118 files changed, 964 insertions(+), 958 deletions(-)

Some need some manual examination, like:

arch/powerpc/platforms/ps3/system-bus.c:modalias_show() does:

        return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;

which isn't needed any more.

Regardless,

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

