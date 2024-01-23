Return-Path: <linux-kernel+bounces-34652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4318385BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970CAB211B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C86ED0;
	Tue, 23 Jan 2024 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLRAbMT5"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E2811
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978413; cv=none; b=UuCNjRgotJ8+Z/1rC0nR0EDIJ9ACFmaEc3ldVlZ6IuCzikJDqowpFQjqDDkRF1V9Add6lz3WqcAyPWaWHMHsNMCm3+gV+YcYS/PDXjX9cS0LgG1j2FmySMkg2GvnJgvuW7v5hYkuYNNlS9pjqNXB1Pk8Cln78Ikuce2jpBP8Wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978413; c=relaxed/simple;
	bh=cC55pTITuXahQpx5YCMQPJ0anjw73aDUUrh4ymutob4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+nmor2gBQThKk9bTyGcgNbiTd0ZUxK0HGcXcGA3AybXXDutsof5IHU8vpb6Jnmvee+3LeoTBHlDB/gQcuprkl/rrwVvgBAE+7nBbhFdhRdO2bwcGG2MqGNUHO+xcuSeeUb+Av6uwl8J9UfuYeMpqOiBdCf27ONpND9/PZs65UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLRAbMT5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e0eed0427cso995927a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705978411; x=1706583211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOBCaJ52Y1g1wzfxl07PVL77XlQF0EwMm9afVAokmvY=;
        b=ZLRAbMT5C0b/oyf12DbDmWL8GIWiRrfHIy9CGljNLL4r3aMR/LPRALk47yABSsHYhl
         3yfeMP9sCJLnO/gBJ9bjeCCWXPB75hM31//j2ojGFQtAFbknwOiGp8P1mCEVSdH+qtRp
         x6w59P8IO0WeNOx6tZ2NbanMPVVy7m92IvtrWv/UoFDG0UnBozdoC4o5smoY5WVzjLjC
         +K1JAz30qzDN8QRJPfURTz5o2LUYRN3OumEHfPmcHb+LFdw0w0bN8CIojAIxW05STwPn
         liM9EUn8WRrY8XNyXAzddhIKQPxhklSiRIaxf3aR96SCT5QtE7dD+ikgL0TabjaMCxNC
         nFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705978411; x=1706583211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOBCaJ52Y1g1wzfxl07PVL77XlQF0EwMm9afVAokmvY=;
        b=OOPWzjWdbXYDeybOQykCQwY5b2XAhYQm5GAPzzFubJM6Dozv+4OQPQY1lG8z13+FT8
         4s/FrxO2KjHnfvv172IQrEZtWLdz/2AD8cDIrJmhdNBNmZP6BDRAWbZ7iTAd1rfqNdgN
         rYm4bCHmbbdO/m1LvMt2g3KqmiXtSfhPVYlqOHYdsE+UHTjL0k/rSBWjd7s8gvE/BLAO
         E0/0T7c2fFpJ3KHFf/HWI0bI7KmZiqAPEXBwto2CDc1nr8edE+FADYcAUqiv0NpzI3Zh
         OB81PNCXsMDodtRn+Jb52l6/KfFUbi32Xqg6BIKaRxc/A3t6FkXOon/lsndCFW85ZTom
         r0hQ==
X-Gm-Message-State: AOJu0YzuLuTv+IS0HXbhsnAlmNLy4g4A09TSOsmO9NZroIg+zLdekr5G
	ZZ2gtRWjiS8W5KsqkkThD0nemOCCwLfo9GevZJZkokq6YU5ht4q+ISQ6U2Wi2XWvm7oHfhbqljK
	/3OSN42BZ6eWgTl/4YOHzGJEe/THIVAXwa26z
X-Google-Smtp-Source: AGHT+IFXnuoWHsPt7MY3gRiy78pyvptCCA/Wzy2bbiGjmlKPmzoyWRp+/5K0w+QS+OWCk9JQTFxdNGfCk/E9iYZ3T2w=
X-Received: by 2002:a05:6870:4624:b0:213:4043:aaf2 with SMTP id
 z36-20020a056870462400b002134043aaf2mr810089oao.83.1705978410832; Mon, 22 Jan
 2024 18:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117192534.1327608-1-dylanbhatch@google.com>
 <20240119141501.GA23739@redhat.com> <20240119141529.GB23739@redhat.com>
 <CADBMgpxC+BP-wfrM-wP1nbZOcRb0LbsmMDQ3LQ8hUKYsF3QECw@mail.gmail.com>
 <20240120204552.c0708fd10fc8e2442c447049@linux-foundation.org> <20240121120754.GA2814@redhat.com>
In-Reply-To: <20240121120754.GA2814@redhat.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Mon, 22 Jan 2024 18:53:19 -0800
Message-ID: <CADBMgpz7k=LhktfcJhSDBDWN0oLeQxPqhOVws3fq0LNpnfOSYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] getrusage: use sig->stats_lock
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mike Christie <michael.christie@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Stefan Roesch <shr@devkernel.io>, 
	Joey Gouly <joey.gouly@arm.com>, Josh Triplett <josh@joshtriplett.org>, Helge Deller <deller@gmx.de>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Florent Revest <revest@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 4:09=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Dylan, do you have a better description? Can you share your repro?

That description seems accurate to me.

> although I think that something simple like
>
>         #define NT BIG_NUMBER
>
>         pthread_barrier_t barr;
>
>         void *thread(void *arg)
>         {
>                 struct rusage ru;
>
>                 pthread_barrier_wait(&barr);
>                 for (;;)
>                         getrusage(RUSAGE_SELF, &ru);
>                 return NULL;
>         }
>
>         int main(void)
>         {
>                 pthread_barrier_init(&barr, NULL, NT);
>
>                 for (int n =3D 0; n < NT-1; ++n) {
>                         pthread_t pt;
>                         pthread_create(&pt, NULL, thread, NULL);
>                 }
>                 thread(NULL);
>
>                 return 0;
>         }
>
> should work if you have a machine with a lot of memory/cpus.
>
> Oleg.
>

Here's my repro, very similar to what you've sent:

#define _GNU_SOURCE
#include <sys/resource.h>
#include <sched.h>
#include <sys/wait.h>
#include <stdio.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>

int thrd_func(void *data) {
       struct rusage usage;
       int *complete =3D (void *)data;

       while (!*complete);
       while (1) {
              getrusage(RUSAGE_SELF, &usage);
       }
}

#define STACK_SIZE (1024)

int main(int argc, char **argv) {
       if (argc !=3D 2) {
              printf("Usage: %s <thread count>\n", argv[0]);
              exit(EXIT_SUCCESS);
       }
       const int cnt =3D atoi(argv[1]);
       int pids[cnt];
       int complete =3D 0;
       printf("Starting test with %d threads...\n", cnt);
       for (int i =3D 0; i < cnt; i++) {
              char *stack =3D mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE=
,
                                               MAP_PRIVATE |
MAP_ANONYMOUS | MAP_STACK, -1, 0);
              if (stack =3D=3D MAP_FAILED) {
                     perror("mmap() failed\n");
                    return -1;
              }

              pids[i] =3D clone(thrd_func, stack + STACK_SIZE, CLONE_THREAD
                               | CLONE_SIGHAND | CLONE_FS | CLONE_VM |
CLONE_FILES, (void *) &complete);

              if (pids[i] =3D=3D -1) {
                     perror("clone() failed\n");
                     return pids[i];
              }
       }
       complete =3D 1;
       printf("waiting on threads...\n");
       sleep(100);
       complete =3D 0;
       printf("test finished.\n");
       exit(EXIT_SUCCESS);
}

I can't remember exactly why I chose to call mmap and clone directly instea=
d
of using pthreads... but I do know what mmap'ing in a smaller stack size
makes the repro more reliable since you can create more threads. It
seemed like around 250K threads was about enough to reliably produce
the lockup, but your mileage may vary.

