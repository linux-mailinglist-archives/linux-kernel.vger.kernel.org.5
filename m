Return-Path: <linux-kernel+bounces-99445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D39878874
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A5F1C20C11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4354BE4;
	Mon, 11 Mar 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INx9KZpz"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1F54BCA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183655; cv=none; b=B/lR6ERPxmBd8aWdu2f5FCOkJhWnM7cKtRhORd0ETah/R2wen8zbkzfjyvjjyUkiMOEqJZDYCtIVQ1lBkJnS9yE+esW99kWWfH7B5RJ88vK8Btin5pq5pt1uP6YovRWDQ11JWelps3PSdZPYL3+IOddyhJaI1JzNsdY5af4n9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183655; c=relaxed/simple;
	bh=KiRKGk/arM86qTUGeUESFhRIwoJzx+sYcCuNEYhGL7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovTG8awb7zxxIKKBwXAp5wLGuLFHc2YPQd2NC+j18+vkHbM8M/02nWTUtDjWmIlcXqHqBTg2ckEReU+7l+BxPT0qvrFu9Jd8w0abI3/RvBd7rFHeUDnMV/30up2B2cF8yJ2TQULjF3Rxgrco8yc984nHZMylfCL1XWvXmNtQBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INx9KZpz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e9df3416bso474935f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710183638; x=1710788438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92UaEgw1QR+X2SR9bZcDvQ4N0TtiusowEqo+9QUTs/s=;
        b=INx9KZpzCbptIscpwPFoCe+gvFlXcXt0Jfm1cNUw/uF/3J/NxCGK/Fu+fOGPtN9lHc
         0+7tvwDhTTKJiTA1e7GXa14eDCP8eR35i/RFbdiozoqfWtC1T4B2KIFxMtznG7VyNYyH
         RCDaeTRi/IAUA9yfzDNq441kjQH5na643euAxf4q6H10+kaBwOD8qTbhqxJEgduWGTWt
         xCHHAiUVgXXeKCvljIBntxFEVKaUqND+sXS8xtB9ydZN6B6JmFOPMIZW2xaka1v2vskE
         gyviNBq5neI7cKaFDrTnbqrpW2951n9DfaEs8xgxuvd6GV/xQFBgHhNIABY57KTcYygb
         kAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183638; x=1710788438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92UaEgw1QR+X2SR9bZcDvQ4N0TtiusowEqo+9QUTs/s=;
        b=JNZGgX782XhfkadlEg4rnHee7pIGbXUTj8IThthxg3n5A5++hbYtNtPK083/kN/5tb
         P3Lr/GdnodzazzBeiR9xkgtaLXGBOFFhQq6g5yzrVrVRqEb3L16N264EpYI62I2VeorD
         l6K15ysupGBKw8/eZFfofYkOG3V5aw1Xgoys42tnUnKTuZtAMC7cAGvhVcbg8lZElU96
         QpPveEDMQ76Ajy+4Yf4vfomVXgHPiQKzIC+eT3O+tnLPhDi+xUY0NwxfNs8ycqX9+7jB
         S/Te0c1WFpKvOfm1ZSu0NB4tQfAruXNuzSRtrEPZyIIIUXbu4oWfK0xcPJ61olb1acEf
         XZMw==
X-Forwarded-Encrypted: i=1; AJvYcCU5VA5xiRZQb8735lS1KAbmq7IW+dJ99K9Bfx6J2RItA/ZopklHjyDJN5z7UC0ZMFNBvMjxrev7nyL0lzhVkcIX0tzctugjHBOzDzCS
X-Gm-Message-State: AOJu0YwmMfva0GiucoIEof/+7SY4xPjLgFtD0GJjhLqktRpR3DTp2zXh
	Zg0CT/S1fmEwyn55J4AEsoMy9wKMY5BpS/TBm8gX8URbwEDh4iB0hjWS2/RWN7klmEeJwkLW1vC
	owGuXzUYVSWswQu4kGAMBvqEbqclhQRcUmxd5
X-Google-Smtp-Source: AGHT+IFqA/7ZEdzACvv2yaoobZtZ/wD0lAiJnn38GnMJ/ie4F+pNJ4+7Jlih62ZraeCYFNkDvJBm2hN+zJgfEq0lXh4=
X-Received: by 2002:adf:fcd2:0:b0:33d:d82e:85c7 with SMTP id
 f18-20020adffcd2000000b0033dd82e85c7mr5519195wrs.47.1710183638305; Mon, 11
 Mar 2024 12:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com> <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com> <Ze8fYF5I4mlUGHd9@x1n>
In-Reply-To: <Ze8fYF5I4mlUGHd9@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 11 Mar 2024 11:59:59 -0700
Message-ID: <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com>
Subject: Re: BUG selftests/mm]
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:12=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 11, 2024 at 03:48:14PM +0100, David Hildenbrand wrote:
> > On 11.03.24 15:35, Peter Xu wrote:
> > > On Mon, Mar 11, 2024 at 10:31:41AM +0100, David Hildenbrand wrote:
> > > > On 09.03.24 20:12, Mirsad Todorovac wrote:
> > > > > Hi,
> > > > >
> > > > > Routine run of the test in net-next gave also this mm unit error.
> > > > >
> > > > > root@defiant:tools/testing/selftests/mm# ./uffd-unit-tests
> > > > > Testing UFFDIO_API (with syscall)... done
> > > > > Testing UFFDIO_API (with /dev/userfaultfd)... done
> > > > > Testing register-ioctls on anon... done
> > > > > Testing register-ioctls on shmem... done
> > > > > Testing register-ioctls on shmem-private... done
> > > > > Testing register-ioctls on hugetlb... skipped [reason: memory all=
ocation failed]
> > > > > Testing register-ioctls on hugetlb-private... skipped [reason: me=
mory allocation failed]
> > > > > Testing zeropage on anon... done
> > > > > Testing zeropage on shmem... done
> > > > > Testing zeropage on shmem-private... done
> > > > > Testing zeropage on hugetlb... skipped [reason: memory allocation=
 failed]
> > > > > Testing zeropage on hugetlb-private... skipped [reason: memory al=
location failed]
> > > > > Testing move on anon... done
> > > > > Testing move-pmd on anon... done
> > > > > Testing move-pmd-split on anon... done
> > > > > Testing wp-fork on anon... done
> > > > > Testing wp-fork on shmem... done
> > > > > Testing wp-fork on shmem-private... done
> > > > > Testing wp-fork on hugetlb... skipped [reason: memory allocation =
failed]
> > > > > Testing wp-fork on hugetlb-private... skipped [reason: memory all=
ocation failed]
> > > > > Testing wp-fork-with-event on anon... done
> > > > > Testing wp-fork-with-event on shmem... done
> > > > > Testing wp-fork-with-event on shmem-private... done
> > > > > Testing wp-fork-with-event on hugetlb... skipped [reason: memory =
allocation failed]
> > > > > Testing wp-fork-with-event on hugetlb-private... skipped [reason:=
 memory allocation failed]
> > > > > Testing wp-fork-pin on anon... done
> > > > > Testing wp-fork-pin on shmem... done
> > > > > Testing wp-fork-pin on shmem-private... done
> > > > > Testing wp-fork-pin on hugetlb... skipped [reason: memory allocat=
ion failed]
> > > > > Testing wp-fork-pin on hugetlb-private... skipped [reason: memory=
 allocation failed]
> > > > > Testing wp-fork-pin-with-event on anon... done
> > > > > Testing wp-fork-pin-with-event on shmem... done
> > > > > Testing wp-fork-pin-with-event on shmem-private... done
> > > > > Testing wp-fork-pin-with-event on hugetlb... skipped [reason: mem=
ory allocation failed]
> > > > > Testing wp-fork-pin-with-event on hugetlb-private... skipped [rea=
son: memory allocation failed]
> > > > > Testing wp-unpopulated on anon... done
> > > > > Testing minor on shmem... done
> > > > > Testing minor on hugetlb... skipped [reason: memory allocation fa=
iled]
> > > > > Testing minor-wp on shmem... done
> > > > > Testing minor-wp on hugetlb... skipped [reason: memory allocation=
 failed]
> > > > > Testing minor-collapse on shmem... done
> > > > > Testing sigbus on anon... done
> > > > > Testing sigbus on shmem... done
> > > > > Testing sigbus on shmem-private... done
> > > > > Testing sigbus on hugetlb... skipped [reason: memory allocation f=
ailed]
> > > > > Testing sigbus on hugetlb-private... skipped [reason: memory allo=
cation failed]
> > > > > Testing sigbus-wp on anon... done
> > > > > Testing sigbus-wp on shmem... done
> > > > > Testing sigbus-wp on shmem-private... done
> > > > > Testing sigbus-wp on hugetlb... skipped [reason: memory allocatio=
n failed]
> > > > > Testing sigbus-wp on hugetlb-private... skipped [reason: memory a=
llocation failed]
> > > > > Testing events on anon... done
> > > > > Testing events on shmem... done
> > > > > Testing events on shmem-private... done
> > > > > Testing events on hugetlb... skipped [reason: memory allocation f=
ailed]
> > > > > Testing events on hugetlb-private... skipped [reason: memory allo=
cation failed]
> > > > > Testing events-wp on anon... done
> > > > > Testing events-wp on shmem... done
> > > > > Testing events-wp on shmem-private... done
> > > > > Testing events-wp on hugetlb... skipped [reason: memory allocatio=
n failed]
> > > > > Testing events-wp on hugetlb-private... skipped [reason: memory a=
llocation failed]
> > > > > Testing poison on anon... done
> > > > > Testing poison on shmem... done
> > > > > Testing poison on shmem-private... done
> > > > > Testing poison on hugetlb... skipped [reason: memory allocation f=
ailed]
> > > > > Testing poison on hugetlb-private... skipped [reason: memory allo=
cation failed]
> > > > > Userfaults unit tests: pass=3D42, skip=3D24, fail=3D0 (total=3D66=
)
> > > > > root@defiant:tools/testing/selftests/mm# grep -i huge /proc/memin=
fo
> > > > >
> > > > > It resulted in alarming errors in the syslog:
> > > > >
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055103] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4631e000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055132] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46320000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055160] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46322000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055189] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46324000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055218] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46326000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055250] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46328000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055278] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4632a000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055307] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4632c000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055336] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4632e000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055366] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46330000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055395] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46332000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055423] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46334000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055452] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46336000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055480] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46338000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055509] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4633a000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055538] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4633c000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055567] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 4633e000
> > > > > Mar  9 19:48:24 defiant kernel: [77187.055597] MCE: Killing uffd-=
unit-tests:1321817 due to hardware memory corruption fault at 46340000
> > > > >
> > > > > At this point, it can be problem with my box's memory chips, or s=
omething with HUGETLB.
> > > > >
> > > > > However, since the "classic" allocations were successful, the pro=
blem might be in huge pages, or
> > > > > if I understood well, in deliberate poisoning of pages?
> > > > >
> > > >
> > > > Isn't that just the (expected) side effect of UFFDIO_POISON tests?
> > > >
> > > > IOW, there is no problem here. We are poisoning virtual memory loca=
tions
> > > > (not actual memory) and expect a SIGBUS on next access. While testi=
ng that,
> > > > we receive these messages.
> > >
> > > Correct.
> > >
> > > >
> > > > The "ugly" thing here seems to be that we can trigger repeated pr_e=
rr() from
> > > > user space. There is no rate-limiting in place. Maybe UFFDIO_POISON=
 requires
> > > > root permissions so this cannot be exploited by unprivileged user s=
pace to
> > > > flood the system log?
> > > >
> > > > CCing Axel
> > >
> > > This is pretty unfortunate.
> > >
> > > I'm not concerned too much on flooding whoever kicks off the selftest=
s, but
> > > indeed this seems to be able to be used by anyone to trigger such end=
less
> > > reports in dmesg.
> >
> > Right.
> >
> > >
> > > The issue with requiring a privilege means any hypervisor that will n=
eed to
> > > use this to emulate memory errors will also require such privilege, a=
nd it
> > > can be a problem.
> > >
> >
> > Yes, we don't want that.
> >
> > > Logically such "hwpoison errors" are not real so it is not needed to =
be
> > > reported in dmesg, but now we're leveraging it to be exactly the same=
 as a
> > > real hw error to share the code path, iiuc (e.g. on MCE injections).
> > >
> > > One option is to use a different marker reflecting that such hwpoison=
 error
> > > is internal, so we don't need to report in dmesg. That'll also requir=
e
> > > (besides another bit in pte markers) one extra VM_FAULT_* flag just f=
or
> > > such reports.  Might be slightly an overkill, but I don't see another
> > > better way; not reporting HWPOISON will complicate at least kvm use c=
ase
> > > even more.
> > >
> > > Or.. does syslog has its own protection in general for such printk fl=
oods?
> > > It'll be easier if that's not a concern to flood then, but I'm not su=
re
> > > from that regard.
> >
> > From what I know, flooding is considered problematic and we fix it up u=
sing
> > "Fixes:" commits. See 1b0a151c10a6d823f033023b9fdd9af72a89591b as one
> > "recent" example.
> >
> >
> > Usually we switch to the _ratelimited() functions, maybe
> > pr_warn_ratelimited() is good enough? But we'd lose some details on a "=
real"
> > MCE storm, though.
>
> Yeah, I didn't consider that previously because I thought leaking MCE
> addresses might be a problem.
>
> But now thinking it again, it'll be great if pr_err_ratelimited() works
> here (I think we'd still want to report them with "err" not "warnings",
> btw).
>
> I don't worry too much on MCE storm, as in that case explicit addresses m=
ay
> not be necessary if the whole system is on risk.  What I don't know howev=
er
> is whether the addresses may still matter if e.g. two continuous MCEs are
> reported in a small time window, and whether those addresses are a concer=
n
> in that case if some got lost.
>
> My MCE experience is pretty limited, so I don't have an answer to that.
> Maybe it can be verified by proposing a patch like that and see whether
> there can be any objections making it rate limtied.  I'll leave that to
> Axel to decide how to move forward.

I'd prefer not to require root or CAP_SYS_ADMIN or similar for
UFFDIO_POISON, because those control access to lots more things
besides, which we don't necessarily want the process using UFFD to be
able to do. :/

Ratelimiting seems fairly reasonable to me. I do see the concern about
dropping some addresses though. Perhaps we can mitigate that concern
by defining our own ratelimit interval/burst configuration? Another
idea would be to only ratelimit it if !CONFIG_DEBUG_VM or similar. Not
sure if that's considered valid or not. :)

>
> --
> Peter Xu
>

