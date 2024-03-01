Return-Path: <linux-kernel+bounces-87959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA16086DB7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BD91F225FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B267E67;
	Fri,  1 Mar 2024 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZNA2R66r"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62C433DA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274796; cv=none; b=Nqor3heiw24wi9DOMFC3wKt2WbQJFlJBOkxAk0gaaWjjNlb7maRGsHgw4PfftjT8BQuW3xmEYdHSoYeiljS4Dip0beHbwE7TKZMOLUs7SS1pz8BNU8ETZ8+ThNXg8niZ2Czw9IVNVVH02FnoRNekyJYUqcjqr1l7QWqJD/OOQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274796; c=relaxed/simple;
	bh=1A49pWCrKxjDV0YLcbE2h1uhtFbcqlO7mDjyc4a8aDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyr71FXH51Jh6LFrOdQql6uR9vQ3Cb4SRz4M40hlICdKGEaUfG6IvJgYCCEB5jnCObLFYyK0feCdii+XpbmkpSWoe82/fz9u4GBpFPVit1U9x6BPpkFp02OrD+PLC9a2jD0J2DbygVTbJJBKHbxyv9Qcgr0ux7VXEZ8UHUPROPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZNA2R66r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcd6a3da83so12980405ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709274795; x=1709879595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQwQz/QJ5mWY5tSctsi2zwWFgf7B4XFbDdy0fTpAkBg=;
        b=ZNA2R66rg1PSPPyatqHeNgwengHmb1SNAUSvJ2T6tssnC5dVkx4cqmrkyGFaImbMIz
         YeUB3sVjtiZuvVWakl/UAzLV7ElgAAj1naxrgG+UPMMvC08FJVbMokDA4I2J/0VPxl+X
         bUsTfXjedbdJxxUbcH0XSFbjJSlsMWKJrY49E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709274795; x=1709879595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQwQz/QJ5mWY5tSctsi2zwWFgf7B4XFbDdy0fTpAkBg=;
        b=uL3RbIY4lhmqMXL2nLhzCTm6kkCGOvNtU2D+zppDCIZ365yUbZs5SRDZ+p4eplnxIV
         hx7B4BMPUriBc1lwIK6Wu0RK/YaiMgG110rmVEQTbx1rUiqhTIcRZIwYq1mHT7P/wBiU
         lRqrA8ZZCv4XInSuxcdvL6tUr6TXgVQI2kU8s/IU5DHPNP3PIJrAhfn7OO33WkXaCLbK
         qg6YMvBFLTyYo/4WG9nBLdmnN2v3RCWAkbCvq/cvYzXQGunjqRHQzwcPFZalaaQjK0P6
         Gup9aS0DCeTqblnn7hZ25483HHY1koZdkLfL5erEpU9L5SrPbewQnKtJ8r7mdM0Evc46
         Hxhg==
X-Forwarded-Encrypted: i=1; AJvYcCVSCKoa9RpAKkADhvjd1RozLMChYNrWvhVLN79CqLOnuqjPg+SUe7u0K68BaALD5EavQ/+rx3lGFBXcQF211v9Llmc7psBMDzGezyGU
X-Gm-Message-State: AOJu0YxNTPYTMStD5R+9zFWoODQyA7Op5O2vUEYgr+BSPOS1FXPllSCU
	DYhnvS1r5V+b+BzXBHTh+jLfinw/UBBXpZ7vHLd1wmIZ0qSJQhTCED25X1fytA==
X-Google-Smtp-Source: AGHT+IGtxhru9efUicC8Zpnox8H1x+W+BNgnhPRPfG5fxB3Z5iWoADp4ruD8eC+7D+TUCAYpeIHX5A==
X-Received: by 2002:a17:902:c412:b0:1dc:3c3f:c64b with SMTP id k18-20020a170902c41200b001dc3c3fc64bmr1019191plk.24.1709274794801;
        Thu, 29 Feb 2024 22:33:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b001d9ef7f4bfdsm2586276plf.164.2024.02.29.22.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 22:33:14 -0800 (PST)
Date: Thu, 29 Feb 2024 22:33:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic
 blocks
Message-ID: <202402292232.2D9E913F@keescook>
References: <202402240702.zJFNmahW-lkp@intel.com>
 <202402231632.D90831AE51@keescook>
 <20240227073527.avcm5naavbv3cj5s@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227073527.avcm5naavbv3cj5s@treble>

On Mon, Feb 26, 2024 at 11:35:27PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 23, 2024 at 04:45:22PM -0800, Kees Cook wrote:
> > Josh, Peter, can you give a clue about what's happened here? For
> > added context, the referenced commit is changing a noreturn function
> > prototype[1], which I know gets some special objtool handling, but it's
> > converting a pointer arg to a u8... I can't imagine what has gone weird
> > here. :P
> 
> I think this convinced GCC to reshuffle some basic blocks, which
> uncovered an objtool bug.  Or, objtool just wasn't smart enough, as the
> warning says ;-)
> 
> This should fix it, absent any more warnings.  Kees, feel free to take
> it in your branch if that helps.

Thanks very much! I'll carry it in my tree.

-Kees

-- 
Kees Cook

