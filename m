Return-Path: <linux-kernel+bounces-92981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE18728FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1A628DA31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE4A12B14F;
	Tue,  5 Mar 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBWqCKDG"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395812AAC2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672270; cv=none; b=ZAyoYgi5peipqeTy7ae1JsU68eSDDia8PFEewtjEPaTnC68dCsGHmvIaf1qdCeipJkqA3DmuksGm8fJO30YClcqrPYcTMSCpLrPZSGm7Pdx+CMBO4tRPV9GTNG9kNTTPOt5zKgA88H8m7RdUYs3/KafRL6bsT6/QE+G63cf6g1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672270; c=relaxed/simple;
	bh=4y2L0boXZTMV4TDb8hO8PgzieZmUzq9lbLSb3KvG8k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ued6Omzggzwc8TW2bje3GF7L2y/tGgIiBqzqJOTioVSzgsW3TKLxEUNxSr2pOyMAqee0lJX7khKOnML/U+Cprdpbf0yDbZXxqBqg/68FhaXJWp02e5sQKZnhC396DGWO+s0VcqTfVUPFIUxLIFGjtHnpOo2YNlOefH0OcbMKw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBWqCKDG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42ef8193ae6so81791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 12:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672268; x=1710277068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMppHw7KV/r56VUSnIREU2O979JxXuHNtcifN4Olhis=;
        b=VBWqCKDGDtqfSjtVb345vt3+W6a38qDDSmcNfrprRiqVm5KKVxFG1eaTAs9zIWM7nw
         XkfOxDepJJzr4XmZd2u0E14fT33iq5bTYaYJAj3YXIw3pmu04FxywWf4wDtLfOOe835A
         8kzpzXszReLLvUFCmeHlZGEqYf+80F8kAuEVgvBt84uIPsSTZBAmHO6jNpzDHrfodkz5
         c6WNZ/4ukxpBT5QAY192A537hKlu+uJfMgubl5uWcaSnP+OBxYno6lBa2Na//z/s/1se
         X7EpWXiF+JDkISNr909WYap/KO8NOmEeRwkBSjEq4MPYqu9SXDfRAV7It/+xUW8waKIf
         +byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672268; x=1710277068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMppHw7KV/r56VUSnIREU2O979JxXuHNtcifN4Olhis=;
        b=MJJT/3lzswmQtk3197xW4Lau5myd4yDQ5YH1QEvWfaOpGkjkNh8QPVQjGQ7eReAnnb
         7JseL8eUtVfOicDKpN3ggjvFCxMWOWg9oZsiF6p3eTiFYTmeCYveSo/4tIUeXR1BteiZ
         M4vUQtTIpSlAeAA83yZk6YyvUoFqDv6fIHzoplg60lwtrGhbBidQGGWeIQvYnc1lW2ro
         0/C/aMtP5eSL5OSZFWi5LsjCaVavAkezQhLCogUihbJcDQ/Y0ujS3NlX0WY+CUGGHiSs
         42Q/ek93xcoFH6LyqlUczd41jZyJ1tXpsSu9WNjHc7CO3vrmt3Ku23xjgUPgYlugThiM
         AppQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGgjrLiLEOIjCBGqD6AjGtTLx0bDCeOGjfSl0QthEcWTlDiI/9sWneupTjRwPt4sCUDZ7vKsBuLIy+HVd9zT2JTZBGCdB9MDn0rE7U
X-Gm-Message-State: AOJu0YzG2HHjlo6QYw2YS9CY8c/K9ftF6w6Vv+0QD2BaSzMSahqGbAov
	4GNPRI2tdydk60FOH7/0Ic/vZuO1pfjZpOsr2wt0hkpqyZYA4EvkYVVoOwHHVLcwW3Tt7gHny/j
	Bw2BhC2CCB7XYfmzT1XgNV+7LmEhlpsV+n5JR
X-Google-Smtp-Source: AGHT+IHUUnMvT3jqlx4mYU0Zq3/oVljYM3tgXS+x8Lb6hAUG4wgFseZ7U1lT7XFjP+BusQQ9kBXfhI9r5cdZ6lf7hXM=
X-Received: by 2002:a05:622a:28c:b0:42e:6de9:cd13 with SMTP id
 z12-20020a05622a028c00b0042e6de9cd13mr258781qtw.3.1709672267992; Tue, 05 Mar
 2024 12:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-2-mic@digikod.net>
In-Reply-To: <20240301194037.532117-2-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:57:35 -0500
Message-ID: <CA+GJov4U+bXK3Q2cmXtsdnrNNiwuDmxsU4-ghVM_8M1vjyMVWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kunit: Handle thread creation error
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:40=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> Previously, if a thread creation failed (e.g. -ENOMEM), the function was
> called (kunit_catch_run_case or kunit_catch_run_case_cleanup) without
> marking the test as failed.  Instead, fill try_result with the error
> code returned by kthread_run(), which will mark the test as failed and
> print "internal error occurred...".

Hello!

I have tested this and this fix looks good to me. Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>


>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-2-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index f7825991d576..a5cb2ef70a25 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -69,6 +69,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                                   try_catch,
>                                   "kunit_try_catch_thread");
>         if (IS_ERR(task_struct)) {
> +               try_catch->try_result =3D PTR_ERR(task_struct);
>                 try_catch->catch(try_catch->context);
>                 return;
>         }
> --
> 2.44.0
>

