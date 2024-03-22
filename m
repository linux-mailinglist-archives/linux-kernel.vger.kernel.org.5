Return-Path: <linux-kernel+bounces-112008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45388740D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D83328254E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306A7FBA0;
	Fri, 22 Mar 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EXILuZAD"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406A7F7DD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137378; cv=none; b=IYC0aaJAAcC3zOA+EIOSHXaFnlsIn5SE6hsfpaS1Rl6LLD47Nd2MGY4iuiedLSqJT7/dP/0UdAsutH71eCqGcr8ridkpTgM1n0zC9s8XUzAyXY2TleG9P3rUJdl6XC4QpisD5UiYRgdeCMoEfftWJ3O8TBdBd3b/Wu+5jzXXgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137378; c=relaxed/simple;
	bh=kEPXH+l/Pa5KYbYBvhkjCAhhsDglYWMHVXWYgQs1Dss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRZDhgh4z9ZvdQ4TuwcRnEXj1w1m1RdIvcFWAtrNziAAqnK15eHfQZuQH2TKZDtkjexMxzEZ2y/QLlTL2gSN251Gbu85fdz0r3C+cf3eGbLPlAI+cuzEG+AhxYGw1WHmGFyrNPu+y/7Ks6A/YTtfKC7Rao4WRKuP6E8KXzP6V1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EXILuZAD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466a27d30aso330488066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711137375; x=1711742175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ceUxvYrzPOvc3uSwb/RCsigp5k0CjOlOqglIw+EfE8A=;
        b=EXILuZADeZ4q+QOfsh6mIRJsJd4ac0zgIBggXEjzxPalBvMYeEWBagtuObkQrgPJS3
         TcdnuR0z8ReCv/JY2cN5Q8mLuHu8IeXzxO/Pevy/Q36PAUGocn4lPbRWTvDTDBV/1Qwa
         yazyB45zfzMPSyo0vudGKw5lU0330DdoarBNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711137375; x=1711742175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceUxvYrzPOvc3uSwb/RCsigp5k0CjOlOqglIw+EfE8A=;
        b=URtkyQQSlZn2hn/mN1tdx3UH98DtheJCjNDnrMDLKMwmepnf9xdF6O9l8jWID0cA6g
         l+Vpw7yT0N3kqELbtPDG/Z49HbRW6xFpdoscaTo7HrZ1LHictcE0U3sgVe6lQZoLwfP5
         gW6gCFdLKf/xOMpSKKYQ/EqxVLmWPskcB0tG+rMEE00ryEYNF5/j7e1fB4+fiAgG/M9u
         sbgXWnDkpK6K1olWqDyGWSaCDeX9Oz4kmlu75C/zCNJwn0b9Haxz2ot3/f+WjV/dniV9
         fKoqGcXpRvIEJJmly0rin+Uz2qg7QK1yIrndX0xLVsA3KB6x1B3DGx/UCw5Y2IKh8RIz
         hEqA==
X-Forwarded-Encrypted: i=1; AJvYcCWc2tnehp/T6IAByLtqg6s/n+CC/YK0ksJRUeaHADIkEwwYbCIAphnYt2LzEoWcYHDalBKGFcxeVIw+pAiYv8kFjH2a3E3ie850y4Pz
X-Gm-Message-State: AOJu0YyaEDlIdyFc+FqN2qR2ZW9zdggvLh006W+/HernEY5XaQWnXalu
	y0VPFA3CjNijZo9lAIVOhiD5KbjlUcxeTTsXehgFGxkHtY9fSOZDtDTFqAuT/Kld9Ph0dVYtVXl
	VFmI=
X-Google-Smtp-Source: AGHT+IGtR39jg59/JgMrrG+aCc16szzz74EICxOUVHLdfVlfWDoihQdafPunx3doUUbTn3xDhsPESQ==
X-Received: by 2002:a17:906:b808:b0:a45:f965:9963 with SMTP id dv8-20020a170906b80800b00a45f9659963mr501999ejb.59.1711137374762;
        Fri, 22 Mar 2024 12:56:14 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id t26-20020a170906a11a00b00a473792da26sm164715ejy.19.2024.03.22.12.56.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 12:56:13 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a473865ee3aso79709766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:56:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyGPrmSUvrOiCzsKKq1IQBk04BOhIAdQr9BayTclCZeCbJ+wZniuAk/nboiDDbfuYNe/GhPxoPEeXhcF1zW6JkGw9fCD5HNEQU5jfQ
X-Received: by 2002:a17:907:7892:b0:a46:c8d5:84c8 with SMTP id
 ku18-20020a170907789200b00a46c8d584c8mr486369ejc.38.1711137373495; Fri, 22
 Mar 2024 12:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
In-Reply-To: <3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 12:55:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9pvT5YEo_kGo2QGjbC-eRaaQNOZuJYCsM1zaxj+rnug@mail.gmail.com>
Message-ID: <CAHk-=wg9pvT5YEo_kGo2QGjbC-eRaaQNOZuJYCsM1zaxj+rnug@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI postmerge updates for the 6.8+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 12:12, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Eleven patches that are based on the rw_hint branch of the vfs tree
> which contained the base block and fs changes needed to support this.
> 8 patches are in the debug driver and 3 in the core.

Please people - the number of patches involved is entirely immaterial.

I want my merge messages to say what those patches *do*?

This whole "how many patches" thing is a disease. It's not even
remotely interesting. I see the size of the patch in the diffstat, and
that actually has some meaning in the sense of "how much does this
pull actually change", whether it's in one patch or a hundred.

I have absolutely *zero* idea what the above pull request actually
asks me to pull.

So I won't.

                Linus

