Return-Path: <linux-kernel+bounces-50702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ADF847D12
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188651F24EC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A2412D752;
	Fri,  2 Feb 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="X1NLIDMD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79A12D742
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915502; cv=none; b=gQD3+zLXDFl9LFdcLIKVqy9QHoBMLGOjryChEgkFnxajihhNFQqnw0f+K8o8QHPL6eh+NN+pmT8PFIFQF4FF8qMMhEeOc5IseJWV79TK/pCko2KiXyVaQP2mohxbOasAR5ufeQpmd5gKA4DubF2rkrd9an623wAr8yQM+pl9cLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915502; c=relaxed/simple;
	bh=OIxhZkq/6YYRV2Mvx5ySYGdSKYM6uMHmLmm5AAc45uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCdbqtp8r9ZyAI3+fQJWOg4fpS2mp2pKXTIcu3+/mmiIBUA5TVn1OrZxHZLKbeLQDWxNGk4Sx7aUfZrCAdpLyEqJVIfjKSrBrtcVskKrhz6VI9EmDSYzL9TUVvrjbomUFtXPYBW7cNpCxEDYGMh0qtZCDLU1tgBH6xel9fYRmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=X1NLIDMD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d746ce7d13so21856235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706915500; x=1707520300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHdbZrsZTokHWKJxVwD4JX+ciHNdzB1lIA6SnmSwlew=;
        b=X1NLIDMDcs/gdiKR6KI4mrmVtV44Au7i/mstPWS2sDA92GWm85sW/F7+P7EIflR2Jb
         RZDJA/x//kPbVZWf7XWwgh/ubJEmVeCgqMluweAAEARdCb5PQheDiDw61ffvuXnJYiHs
         vuAPx+snqHzBEH0Gw10AzhnMFjYP6QLVITTD79fg4xi0CmY2apD2CYT1MkTm4UP8lz9d
         kXRGCpmBtYLubToLCbiUgTXFXObtnTwlANSnmacjldPzIm/CY/xg/PSHDN+rmyJN+cni
         D/odBAv6WGYaLY5vDwPv0LOkfckiZNIcZDY1H4qUT8Z0iVh7PpqNqYi4bHNQQY5hdtpZ
         j7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706915500; x=1707520300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHdbZrsZTokHWKJxVwD4JX+ciHNdzB1lIA6SnmSwlew=;
        b=L8BzAtBY51sThnPFJi0BOHrFJfsX280s8uUAoKfBiz9zv8bRVC+yA0yg504tTnNcX2
         umzgo7MGUFjly0hbmKP8xQn5QW3gSu5tfn9MQK4yjitAF8hdFBj9qt9cNXEGGVxw6oe5
         LZMBFiejM1xiBnYLZjjliMzkftKXmBvky+36eHkzbjT5q7ILJ6ngIVs0s1FQRz2rhaVt
         stJhlLpCvxsERqIil2iic4NNYFKm8j3J58RCqOHzysfZ88I9vOrZ5ziRBDRZYVoIZqtn
         ygObk/QE9H492+QsTGLd0UJ6YbjZ1Wo2irawHnd6guVRmjzmtTK0prBiygBetYeb+usa
         KTwg==
X-Gm-Message-State: AOJu0YxMEmHo/jKfutSmuLFi2FmLPm6ycaBG86TNoKQQG3Ug2MqurUsv
	N5yzkpVv3lGF2j4o5zjVdf2qF9IW1zSveLc5MJKaF2xTDljcTdFY6gSsr1MCRTg=
X-Google-Smtp-Source: AGHT+IFX/dKWJI8yIfAkoJs/rbb0rLuwba0Hcyv18OQjxuVcefT2YVIE+bGcOXuXhBT1os44X8Mj0w==
X-Received: by 2002:a17:902:f54d:b0:1d9:5763:d8a6 with SMTP id h13-20020a170902f54d00b001d95763d8a6mr7579957plf.45.1706915500419;
        Fri, 02 Feb 2024 15:11:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVIHyNlDOkD99rLrYRzWLRSHV5hpxyrtDiy3TGuaRaA4IJl6nfV3qkQY3G+zDr7nYVRuTzMLvnnQYQEfyHJ6M6DT/8EXFGJ/DI33Th9ol6wEmsfA8wqnd9+d2c1O512DzEO+DkHNCyDLVkpVfEiiYC7U3WLy6YuXi40bJ9QvZe0r2rhQSVCGE+uAmoQN6B7ObAmaBO0sFHyX008gH2VSXxt4vjgoPor72q4fIr3VJK2MMYN33N728QsbGOI6UnU7LuJ067inID33IDNC/wIBL4nEXBPwQ==
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001d987771270sm324998plw.125.2024.02.02.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:11:40 -0800 (PST)
Date: Fri, 2 Feb 2024 15:11:37 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: lib: Introduce has_fast_misaligned_access
 function
Message-ID: <Zb12qZ8cpv/O3s+4@ghost>
References: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
 <20240201-disable_misaligned_probe_config-v2-1-77c368bed7b2@rivosinc.com>
 <20240202224939.GA2055@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202224939.GA2055@sol.localdomain>

On Fri, Feb 02, 2024 at 02:49:39PM -0800, Eric Biggers wrote:
> On Thu, Feb 01, 2024 at 03:30:45PM -0800, Charlie Jenkins wrote:
> > -	if (((unsigned long)buff & OFFSET_MASK) == 0)
> > +	if (has_fast_misaligned_accesses() || (((unsigned long)buff & OFFSET_MASK) == 0b101))
> >  		return do_csum_no_alignment(buff, len);
> 
> Why did the 0 change into 0b101?
> 
> - Eric

Whoops, thank you.

- Charlie


