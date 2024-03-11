Return-Path: <linux-kernel+bounces-99506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99592878963
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFF02820AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB856B86;
	Mon, 11 Mar 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H7Pd2iTg"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892BD56B78
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188610; cv=none; b=eLrfEmI6yuqOQ0SjGfke5BjG7chFYwDSL2GQXon+h1soRWfx7PM3xuO+JApiv1zeRM0MCXo6puW/iy6W+S1DPYb4QdkG70xgj/DKoRGZvftgr3jQLGoVSIjJY8Gb4+WjpASTXoUV6zi7OKBrpu6jd2nkqciX7hfh3H3ZZYznt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188610; c=relaxed/simple;
	bh=y144NH3QNOlKfjZ21peFLdhyR2kd90MOW/9E6QvpmtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgiEA18PeB1Ju9YHGdGqRNOygpe3hFAIRRMZV9xkS9BtSMVBNYj/TerFkNh5EQdVTlgYYWVlT7VNABQ+5ZI8GML7LfbgZM/QdRIl26mOMhuCVdA6ngTsvl/IjEA4pnUORKuyUqtaMtZ4L5gxL9cmJsJ8mYsNJmfuTHsAb67OZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H7Pd2iTg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513b39eea3dso595724e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710188606; x=1710793406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYYV2YPuUOV751HqN2amVtf9CDdy1Ok2PE8ujxANnDs=;
        b=H7Pd2iTgEe05+++9D23R7vYKlO0cgI7YC7WUk92bjoHg6Bb/7KEjee5cF3w1/X9puK
         VrndBg8gytvtPlJ8ESvfH93Sz29GA227yQNNqMQni4lIX0QLw15gOm7i0Yq9z/6KwlNr
         KIA7zpYGteDiX1lGbQRSZfmFclQtCjy559u8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710188606; x=1710793406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYYV2YPuUOV751HqN2amVtf9CDdy1Ok2PE8ujxANnDs=;
        b=et6KLrD1kGl3Yb7dCWdagoRBM4ivPXEGcAJoJG4CFOr7G0ER2fKQEoIjEpPmTLlOEc
         aT3LG+T6c60Q3pLwOGhXZycy3HvEiiEgBr/0h6ceg05w/GfsMTRgSZLA7r8MnibTEvHB
         C9i84Yg/VIz9FXwULMM+qYVfM+XTKDg49dBEdWyHrr+Q6dvsG2bc3HHHSoGU6UEg+l+7
         dx0EU6x06oTlCcl+RGBcWUk0tQ2UMgwUfDxKeNo1QXQfl+FDj6+SXgjJ3Gar6XJcsNIO
         ZGKuRTPvKuwvJSZUILjnrb2AEh4RQ0Ng12+JHUVey9xKeGlwmGT3wWGvbJYuIFcBysG0
         0pVA==
X-Forwarded-Encrypted: i=1; AJvYcCVe0ohNCZtsFSGLrgfsvg4G4R/J5N8wu7Jvk9dSkAMYU6g3h/Tt/MvlO+gxMpQy1QvdLHWW4vWKX9NdxIqsPpGEDWG+xN1F88Z3W1mN
X-Gm-Message-State: AOJu0YxQhtRC6KOz1DWW5W2DC5ojL58gZZNjD9YiX0vz5H+ueS/7y3BA
	sV1Sdffr5fozgVcLo/SKFMuMYTJnoNJ+ZxP/EfneqwPfTc0dHVgmCIQ+jesa5RU9JbXvec9Kuf9
	DSHI=
X-Google-Smtp-Source: AGHT+IHUcfnN1MT0S5FtXSIGqJTycafuJxlBKog1VfIYLadf0a2z5kuaClniEDwVanmXwVyTPEZBaA==
X-Received: by 2002:ac2:46d7:0:b0:512:cc50:c3e0 with SMTP id p23-20020ac246d7000000b00512cc50c3e0mr1004679lfo.52.1710188606567;
        Mon, 11 Mar 2024 13:23:26 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709064c4400b00a44dca5f9c1sm3150926ejw.100.2024.03.11.13.23.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 13:23:25 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so674471066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWewu/amWHGxCPXrZYSgwHNoImcoMNGk3eOoDK2s6suiGihPJtuOpYvFnLhe+k18g9qb2O/Su3FPniO2KL+QYDIbM7r1S8FlFAJAl3u
X-Received: by 2002:a17:906:3ac9:b0:a46:2874:ecd5 with SMTP id
 z9-20020a1709063ac900b00a462874ecd5mr985599ejd.55.1710188605245; Mon, 11 Mar
 2024 13:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org> <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org> <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com> <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
 <87wmq9mkx2.fsf@oracle.com> <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
 <87cys0il7x.fsf@oracle.com>
In-Reply-To: <87cys0il7x.fsf@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 13:23:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>
Message-ID: <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org, 
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org, 
	mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, bristot@kernel.org, mathieu.desnoyers@efficios.com, 
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de, 
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com, 
	krypton@ulrich-teichert.org, rostedt@goodmis.org, David.Laight@aculab.com, 
	richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com, 
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 13:10, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Ah, I see your point. Basically, keep the lazy semantics but -- in
> addition -- also provide the ability to dynamically toggle
> cond_resched(), might_reshed() as a feature to help move this along
> further.

Please, let's not make up any random hypotheticals.

Honestly, if we ever hit the hypothetical scenario that Paul outlined, let's

 (a) deal with it THEN, when we actually know what the situation is

 (b) learn and document what it is that actually causes the odd behavior

IOW, instead of assuming that some "cond_resched()" case would even be
the right thing to do, maybe there are other issues going on?  Let's
not paper over them by keeping some hack around - and *if* some
cond_resched() model is actually the right model in some individual
place, let's make it the rule that *when* we hit that case, we
document it.

And we should absolutely not have some hypothetical case keep us from
just doing the right thing and getting rid of the existing
cond_resched().

Because any potential future case is *not* going to be the same
cond_resched() that the current case is anyway. It is going to have
some very different cause.

                  Linus

