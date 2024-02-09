Return-Path: <linux-kernel+bounces-59755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E384FB4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3531C250C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7187F7CD;
	Fri,  9 Feb 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UZPGqns1"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC469E16
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501373; cv=none; b=bi1iLNZj43QGLBcia+27Qbyk2uss436B65Mhf3rp0WXjR9zu01U4im2hnMOvD6kDsiRc2UoHgKWGckzMV+ZANThpD1VXVWxyi41oUw+qpESIxW8w5hogsm1c0CgmpLBtc6f0aXh44hN8pky4UMMAlalO2QCsMh2cK7cWFTueYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501373; c=relaxed/simple;
	bh=Vf9sTnp18c97Qa74hLutsqcRaj6j2Rea5/NTIJB8XkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/3Rhy51UWpBifddyW+z6eH4x2Xr5t20010BEhABcXYt0fF11evDkttKj/XYsxLvC7EhG+hvjwqUpeZNNNBh+LlnR/V4e6gF+OssRGrYoekXXDlIy7yLR8FMkDzn5P5Gj2Plvdg85NvHhZJJTQphb7r8rAOeWdVwPlT3MSFUicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UZPGqns1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0ce2222a6so14433251fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707501369; x=1708106169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NoqTVJex4Iddq9y5fjMVxpMdqogqTy+7RDtEYo1Z2eY=;
        b=UZPGqns1ddpe6PE8qep76DghxIZ54oub7dZQCE2ld456iSv0wQTTK1WqrvH5gsnz+J
         ThgCjE92VR5XRff4s3ohXEaHmItKSRgRGGyAeeSCYqYIS14AwfBa3T91/+CcBxuXv5dy
         5S2mi5tEO5XyFp0l1j1XI0c6dwu7iWzBkraLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707501369; x=1708106169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoqTVJex4Iddq9y5fjMVxpMdqogqTy+7RDtEYo1Z2eY=;
        b=wEt2ptOb0Ykqr+T/m2XWEYMnl7jf/6VE5TPkNgfO0v5npR2AKhYAwAw0Ez/oY6IVk7
         AcqsCa7blBbIzkbhou6/PIu2nbOU+BR16D0iVEpaPZ56kwCX8OXydykQXK33/PMaljaZ
         Gp0jD7r+/wHBlKmuuYe54knQjCW9FPMwCol0kWAo72hXVOWHtzERlNJypPC81E1wVRVc
         l6dE0JWmU5EkwSazTfRVuVIGpgUOQk1cSLAzF8XG5cwLeiGbsrqpsAyBXJwOn3sAMCds
         hFVCVurREFr2+wGPhQyQejlCRBhQiMioZcTon3WeDZhXG/W3ITL8PwjunO+VI3uf7TyJ
         KjiQ==
X-Gm-Message-State: AOJu0YyNdijdB9pvzZRgRkNywePlKOhHaJFW8NJuGy0OwVSuV7A23FEk
	z+dtw4bVoISYDeF0htDorJnvkr8+cxsNuRfyC7rawDwrNz1rWDkFGarv7H8wZ55TDb5aCrnILAM
	k
X-Google-Smtp-Source: AGHT+IGdMBEwUJCdjS4Xl1O6cdui69S8UsaZwBEZN53SoiLoyGm1WaJYgV4sq540uGBgetfzuE1Qsw==
X-Received: by 2002:a05:651c:10af:b0:2d0:aafc:9138 with SMTP id k15-20020a05651c10af00b002d0aafc9138mr1523179ljn.42.1707501369325;
        Fri, 09 Feb 2024 09:56:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtP79a02kjIguSNd3fi4FCMz9/YySbeOquqUQdwop8koNICAl0RasWL/hPqhL9NMoN2xRCCwHojfgW1ZV3LyADFesP4Cc0A/n+pW0V
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o16-20020a2e90d0000000b002d0aa95176dsm331021ljg.29.2024.02.09.09.56.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 09:56:08 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0a4e8444dso13775931fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:56:08 -0800 (PST)
X-Received: by 2002:a2e:b057:0:b0:2d0:c9b5:7257 with SMTP id
 d23-20020a2eb057000000b002d0c9b57257mr2002248ljl.8.1707501367696; Fri, 09 Feb
 2024 09:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2024 09:55:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
Message-ID: <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 09:14, Andrew Pinski (QUIC)
<quic_apinski@quicinc.com> wrote:
>
> So the exact versions of GCC where this is/was fixed are:
> 12.4.0 (not released yet)
> 13.2.0
> 14.1.0 (not released yet)

Looking at the patch that the bugzilla says is the fix, it *looks*
like it's just the "mark volatile" that is missing.

But Sean says that  even if we mark "asm goto" as volatile manually,
it still fails.

So there seems to be something else going on in addition to just the volatile.

Side note: the reason we have that "asm_volatile_goto()" define in the
kernel is that we *used* to have a _different_ workaround for a gcc
bug in this area:

 /*
  * GCC 'asm goto' miscompiles certain code sequences:
  *
  *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
  *
  * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
  *
  * (asm goto is automatically volatile - the naming reflects this.)
  */
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)

and looking at that (old) bugzilla there seems to be a lot of "seems
to be fixed", but it's not entirely clear.

We've removed that workaround in commit 43c249ea0b1e ("compiler-gcc.h:
remove ancient workaround for gcc PR 58670"), I'm wondering if maybe
that removal was a bit optimistic.

                Linus

