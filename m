Return-Path: <linux-kernel+bounces-54255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F61E84ACDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AEE28675B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477DC745CE;
	Tue,  6 Feb 2024 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOoi/NnZ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D27319F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190176; cv=none; b=HVBeQwGlVFfrdJFXR69ynkwjCtSM9g7rOhut5WpQTj4j2LcaB2AU/GyJsu32Y0HNnDV/poD8svouxrvqI8DMh3f6/X1IOCsV6wJ8V/5nFh/a/6KNAh6591EiBw6cCRBygK7XIf6lrMrrMngeOqY7t4dWk2+txwhAxTjXJ2biYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190176; c=relaxed/simple;
	bh=K47t6Qn8VX9LZd2vOHxHLV0Ys/CaGLr5+PC1CzGP2TU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tCEHbEVQthxdgQR9x9qQTOEBv7gfai2XCiW/V6n2jjcG87WXDdtAKCcHXfhCe6xac3wDyMepnmaGN8Ej/qoQzfs+3IxshNvF4gV0MrWr34iY5OZ4O9sTd7yHHQiV4oLWB5p87LPPKkCq4pFI8ahKo8BcpIonBniPCoSxAZWL5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOoi/NnZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so8480598276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190174; x=1707794974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tfd5OhfoKoOciQEBeRQDfj0WyGPDWpvLlZKvDtbwOk=;
        b=TOoi/NnZH+pUj3KWcAJqUOwBc0c7UoEkwSEdwf66eoWBdZcAhhPN8swGlvwOqxFDkp
         mzzYCAoip5P/yGQwTlxmz9KRuhSX2trcjL6e4e4f9gPhg44AKcksyuKB6YDPrkQ1k5v7
         hOtGz9Q0VcgWLJRJj+7SMghr9zd1nI3r0BCfx/DCHMVaYsCbx2TnwZTDtK6kGv/UpUSJ
         0chnSZ2EaLKri/8e7zGssw0b7/mLd7kqrAF4j2WtYUEaYr1sp8oLs79qbzDtlrlvdfML
         wXsoENVlptkI5EG6ELh4enZ5KSfX6Z4m/f/89PSHdVcbKk0Ar2OTfA+eIIOteJf5/swi
         DEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190174; x=1707794974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tfd5OhfoKoOciQEBeRQDfj0WyGPDWpvLlZKvDtbwOk=;
        b=i8en16wF9VTQ/JSVlPku0NABdySPwtZxXZ8iXADpV5G/6H8QxpLD+YMlDPui6MKD4v
         eX47nsymDo++kvdHcgUEpSgJy6swt4Qw1vxFrOjMRGotw3YFzsy+BKBSqrIQJCG95dQl
         JuwtjM0tJskbdYEo2fU2IXxwaSgyObbizsu8frXhslDoJiB8++L3Jij3iYqk3yURoQe2
         verRdSAuAewB2Cwv56tqTOssZd49mIOpNkjsN9AZhXUUUaDvreDJRWk3bQA6c/erMtPn
         zS2Tm8vdTa0kzxg9Trl85rDxI/t5cHTjfMESkxzt4T/E7SJfL6HtI5aiyPylSMSXNEiG
         dggg==
X-Gm-Message-State: AOJu0Yz6rUcDOz4DxHgL9CEqQ19/d2JWC4FN/htr7lC0kUdOICrvkRJy
	K5p0YMmVf+o469y+pgXichWTwkUzH608NBh6NvuQk4Hvf+tSw1YXg+lsnbHKMHS9zgH5XN+a0AU
	86w==
X-Google-Smtp-Source: AGHT+IFGKs7rwk/xOH6e9m0tOkG5KkbLAalcPqOVjHui+Z6DsE6kZ01uHKZEANcR0800iNMQT8Is5W6Gv14=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:160d:b0:dc2:1f34:fac4 with SMTP id
 bw13-20020a056902160d00b00dc21f34fac4mr139109ybb.2.1707190174210; Mon, 05 Feb
 2024 19:29:34 -0800 (PST)
Date: Mon, 5 Feb 2024 19:29:32 -0800
In-Reply-To: <ZRpiXsm7X6BFAU/y@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <ZRZeaP7W5SuereMX@infradead.org>
 <ZRb2CljPvHlUErwM@google.com> <ZRpiXsm7X6BFAU/y@infradead.org>
Message-ID: <ZcGnnIJNPG-nGAND@google.com>
Subject: Re: [PATCH v9 0/6] KVM: allow mapping non-refcounted pages
From: Sean Christopherson <seanjc@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Stevens <stevensd@chromium.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Oct 01, 2023, Christoph Hellwig wrote:
> On Fri, Sep 29, 2023 at 09:06:34AM -0700, Sean Christopherson wrote:
> > With the cleanups done, playing nice with non-refcounted paged instead of outright
> > rejecting them is a wash in terms of lines of code, complexity, and ongoing
> > maintenance cost.
> 
> I tend to strongly disagree with that, though.  We can't just let these
> non-refcounted pages spread everywhere and instead need to fix their
> usage.

Sorry for the horrifically slow reply.

Is there a middle ground somewhere between allowing this willy nilly, and tainting
the kernel?  I too would love to get the TTM stuff fixed up, but every time I look
at that code I am less and less confident that it will happen anytime soon.  It's
not even clear to me what all code needs to be touched.

In other words, is there a way we can unblock David and friends, while still
providing a forcing function of some kind to motivate/heckle the TTM (or whatever
is making the allocations) to change?

