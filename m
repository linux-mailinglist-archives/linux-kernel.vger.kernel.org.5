Return-Path: <linux-kernel+bounces-128423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2340895AA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662291F220FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C415AAA3;
	Tue,  2 Apr 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opp1MDVF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562D156F33
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078630; cv=none; b=AizBAaRXnhtogPhArKsjXmy1VFVexZxIC4GUBF7XzPyfP+lFeRiikmEoPcgc0NyvxWRDY6h/tG+b2zu+p+cmNzxGQDiXagZB0oEVmY6J7cDpqb92jHBUyd6mBX98wNfR/1sqYu2QM/HtKyhpte5MgYWr2ruaM2z+ufPz8cA5dHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078630; c=relaxed/simple;
	bh=yHT7Ct3BfWZ3BreZFP2ToPJTIt1umLYayrfEthvTHxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx6jqWSveleDELx7lGHMUcTLMZZR5S9DEk5qW2Zc+Lylyqn7KVAR+/+WgHKn915EGQUEh22YNqYNxP3Qkxz9gdoxKWb7bkRU8JDsDKaaMzLmaJAAEVjROxmeGyCaAayId24+L/Rg0uSSMHQOMNJfLRlyZDhuW4yLGTlpDvTflno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opp1MDVF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso7825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712078627; x=1712683427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnglfsZWKsoCgYV9GRi7FFVEehEIz6FLkc6jkCsCjpw=;
        b=opp1MDVFgoZMn16IPTzdtWYCul1geon/Ul5aY9TmYrnrjQ9tXzjfck22+nRZFEzRdv
         JSDqC6s6JFVlLNm2dgjG9H4uQ21fugxz8HDDCz8snG/8HPUVzCibnAR24QRNPiURuKo9
         wZhkwq9wkyLaiU/01Qbbhu+orjnzBEMcWk0/GHQHqY4tMfKT7RqoRdVG3RR7BFMCmHzC
         kk0BSb8kcrcQ9W6j25ZxwXBVHey9iadxtHYRDm3trdGvqAY4yH8Cqom4B+X3ikh2h33W
         wIzuVuqtsnWZJomtQAxlbBwE8eGYTV/9glRs1SSf8ufym5wG9FA7e1fdgLUiFqDCGKOM
         dnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712078627; x=1712683427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnglfsZWKsoCgYV9GRi7FFVEehEIz6FLkc6jkCsCjpw=;
        b=q7oLU9lCGq4FAJEcgg7cgeRmRtpjXO1qLT4EoujtQOp+OS00ePahR8pYPhPvBOao/K
         cuozoS9G/HgmOveYTwLQHVafemAIqK4ATQrrNpMyli/0l5wS6JfC29dUk8yWdIbbWelf
         tiPBrysX6+6ob8WnXb1aWST6cCD5OcjJ13Kszvx9Z0eIljiFjfFEJJDczISx7nmDhIkH
         DJ+Y5XsPpsyuUBRwuPDEEHdWm7uX12+iHRw1x+5VLtj2DjC42xXRYRvDlwLnQ/qaFtCn
         7GM6/0wlNIUVZgF3QLbtQlJQNDW2PG9eh1PV6+anUID/T9pcrSu4uvxutN8H3Lxd238S
         OcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgEIK5z4SjtaNSBDmHxteP0dlplmwOFwXq7Xld/gPcv0/KpPdUXhLiHbehhMlzX7ospXrpvBrdxFMjQESISDIhFMt2a5rcjPKIpsfR
X-Gm-Message-State: AOJu0YwyZCax8cCMhraIooAt7/CaqS+Vg46pdVMqke68PGIaA/0p2Llx
	Tb1G9xDnggLP+EldBWd3BZ2cMJo6eDwKS3gtQE11+q1uKuD306JPiARS9ByhJKwAg4MyToKKqOk
	YcOOIiTN5YYQhXbtQpbXv0NZt/qlT0o7jwYM=
X-Google-Smtp-Source: AGHT+IFEO8YYRumYpxSt0I9iCuiX1OqDTN2V5IYDbPGyUZRna+pJqhvxjeDT0d/7Ziv08OzgATA2UD77n5UM3y6oMhk=
X-Received: by 2002:a05:600c:1c20:b0:413:f41a:ed1b with SMTP id
 j32-20020a05600c1c2000b00413f41aed1bmr807067wms.3.1712078627548; Tue, 02 Apr
 2024 10:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com> <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
In-Reply-To: <87frw3dd7d.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Tue, 2 Apr 2024 10:23:34 -0700
Message-ID: <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 7:57=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
> On Mon, Apr 01 2024 at 13:17, John Stultz wrote:
> > This change does seem to cherry-pick cleanly back to at least
> > stable/linux-5.10.y cleanly, so it looks simple to pull this change
> > back. But I wanted to make sure there wasn't anything subtle I was
> > missing before sending patches.
>
> This test in particular exercises new functionality/behaviour, which
> really has no business to be backported into stable just to make the
> relevant test usable on older kernels.

That's fair. I didn't have all the context around what motivated the
change and the follow-on test, which is why I'm asking here.

> Why would testing with latest tests against an older kernel be valid per
> se?

So yeah, it definitely can get fuzzy trying to split hairs between
when a change in behavior is a "new feature" or a "fix".

Greg could probably articulate it better, but my understanding is the
main point for running newer tests on older kernels is that newer
tests will have more coverage of what is expected of the kernel. For
features that older kernels don't support, ideally the tests will
check for that functionality like userland applications would, and
skip that portion of the test if it's unsupported. This way, we're
able to find issues (important enough to warrant tests having been
created) that have not yet been patched in the -stable trees.

In this case, there is a behavioral change combined with a compliance
test, which makes it look a bit more like a fix, rather than a feature
(additionally the lack of a way for userland to probe for this new
"feature" makes it seem fix-like).  But the intended result of this is
just spurring this discussion to see if it makes sense to backport or
not.  Disabling/ignoring the test (maybe after Thomas' fix to avoid it
from hanging :) is a fine solution too, but not one I'd want folks to
do until they've synced with maintainers and had full context.

thanks
-john

