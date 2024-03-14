Return-Path: <linux-kernel+bounces-102702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE087B634
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F9028649B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965E522E;
	Thu, 14 Mar 2024 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JCKtg8Iq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC94A08
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710380976; cv=none; b=knY2t30CI8hZwHCQXhUm15l30sRXkyzaTmDMBC/ZUG5XYcD3A1Zw4wzag3ANkGpJ629Qn2AeeM07RcgWU6rA2gcX8n3nwW7KmGc5Lyou3WSJSDwyxRsrTch9+wKuWk6Wit0OxGuDkYYdY/ePEw4/npAl1p0FJyPZLe1t5xs+eYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710380976; c=relaxed/simple;
	bh=c4NzE5f5DDPUJAGH2Mr5TzbraablBRmWpp2QGcZvQ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l97+wqywKo0tzVybPPGu60hxd2wd8o1FqSEynqCAy3drZzxpI1fc7lhPXg7OL8HSSxbelkdgfBWjNQxJSA86bOXg1CrDD2OX3UT4Ki22hAPdiBUsD0YZrgVXXeuslURT7IZ0MpnVgJea4xW5cF/EDrnLW0v3I4v/VQltxoCNdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JCKtg8Iq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56838e00367so609073a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710380973; x=1710985773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t319UmoMBPRcB8lPsWRleDMOWnBo8zQ3du7ZSGpezIE=;
        b=JCKtg8Iqo5Djo6opQKN+u4SJcSHhm4QzzpPiG5l+JNtOsuzFtxaEfy4LMCp/QHCQsi
         pLk3oSsOR9Z83Ty+c4TVsyFkiira3bPTTAeJe7mBCeP4QtQlBATO+C/PQvdW9ZSOzFD1
         JkTOCflwOTitOP2u1Xfo0x0QqHvZWOz1YPGqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710380973; x=1710985773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t319UmoMBPRcB8lPsWRleDMOWnBo8zQ3du7ZSGpezIE=;
        b=dsMAiPfFcYsvBgtJrQSMh5tXMhETMuTmloDzB3MrSzaxJoFithR8PuHt3ga5nhsSdo
         0Ibq3CkM6/2JxXnHDXeeGWq4IzZXJZ9XkUjhUFNYrYOl12zJ3OGlO1KHRg+k2R+ZIHTk
         HLlykgCKAee9zpyRnm9zmM1oHT9jBxPzR3ZMGlGHoIRDN8H+Px5XCL2kxPwWZHMo3y5I
         3GMM0bjQVDK/OOT1gT+OVrnKnW9VMwkU5grjnWWAAAgZROLMHb9aBvGXiuH6OtULzbKV
         j+uqLCWmSjBT83aJu9BI6TNrTsyZYb2t04Akc1/bLwyMwxfAW3WeoR0HRcoDiNLBiON8
         NowQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUeENemwlj0nlACSK9XsrbBOlbFFBQCHiTs46ru86sbrwuuSJ8yYl2c/gAXbg5aCqAhHdBo4QmtkRwVSvZwHWrXKqZL1/qQDlmJFnd
X-Gm-Message-State: AOJu0YxIZ37URvKO7hmRdvL7DcrGlsX+FlPLxEBWllRcK7JLli1fc10T
	RnjbDhrbcLIWYdanMheh9BPM1UiVgOcBeJkXbmcZ5fISBQNDHmf2P5oafVByIaszpT+e1fyOH4A
	cHW+kLQ==
X-Google-Smtp-Source: AGHT+IHgWCVnuOXcPaframsUuSuysEc0HFJG7O1W7WYMVuMBJiaXMe+XlgN4kdvC+48v/4BtnUqzgg==
X-Received: by 2002:a05:6402:3981:b0:567:2cf:1ecc with SMTP id fk1-20020a056402398100b0056702cf1eccmr196585edb.30.1710380972773;
        Wed, 13 Mar 2024 18:49:32 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id v21-20020aa7cd55000000b005689f9158ddsm127863edw.23.2024.03.13.18.49.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 18:49:31 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a467322d52eso2814166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:49:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlVfVoeuXmzJDkja/nAnH0EqT7vTMYRadJ9da1bOrCeyzKEvSydiJXzmo3EFPeD2+U5g7GEtyAa/tSp1qTtW/w/4F0qQnUx/Vfwa8k
X-Received: by 2002:a17:906:a449:b0:a45:ac3b:4aca with SMTP id
 cb9-20020a170906a44900b00a45ac3b4acamr157510ejb.44.1710380971337; Wed, 13 Mar
 2024 18:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twR+WnE3GGqyeh1cuGVmpADPTwDPK10625RP--rLrqkxA@mail.gmail.com>
In-Reply-To: <CAPM=9twR+WnE3GGqyeh1cuGVmpADPTwDPK10625RP--rLrqkxA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 18:49:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTWLKkg0Hht4ofDTVsebD2Zq-m4UP-DsiZjM+w4b7qug@mail.gmail.com>
Message-ID: <CAHk-=wiTWLKkg0Hht4ofDTVsebD2Zq-m4UP-DsiZjM+w4b7qug@mail.gmail.com>
Subject: Re: [git pull] drm for 6.9-rc1
To: Dave Airlie <airlied@gmail.com>, Animesh Manna <animesh.manna@intel.com>, 
	Jani Nikula <jani.nikula@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 21:07, Dave Airlie <airlied@gmail.com> wrote:
>
> I've done a trial merge into your tree from a few hours ago, there
> are definitely some slighty messy conflicts, I've pushed a sample
> branch here:

I appreciate your sample merges since I like verifying my end result,
but I think your merge is wrong.

I got two differences when I did the merge. The one in
intel_dp_detect() I think is just syntactic - I ended up placing the

        if (!intel_dp_is_edp(intel_dp))
                intel_psr_init_dpcd(intel_dp);

differently than you did (I did it *after* the tunnel_detect()).

I don't _think,_ that placement matters, but somebody more familiar
with the code should check it out. Added Animesh and Jani to the
participants.

But I think your merge gets the TP_printk() for the xe_bo_move trace
event is actively wrong. You don't have the destination for the move
in the printk.

Or maybe I got it wrong. Our merges end up _close_, but not identical.

               Linus

