Return-Path: <linux-kernel+bounces-97503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B2876B23
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43FFFB21754
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8261F5A4E3;
	Fri,  8 Mar 2024 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuEJ1PD2"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10D8833
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925550; cv=none; b=ViZOYZBKT8MMknIt7NOdyi9D63RN9fmtjjBMENNtZualfmugmFWLWv0HIyu3m5eX18ZLGk7JweK5blUJnABPF9KWaK/PWbaylQZv1y/dhN7Uiyn+dKsGfRVNkS1A2g30PFgiS+BA3QPDOEswl1ypGX+1t9+1aZCpUUoqZ5j7e8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925550; c=relaxed/simple;
	bh=AI/VQSRaeCsmw+yYPLV6oidtLSNkXOOIzRWcNKusNqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhKRB5Po7NmJt9dtTDlKmHmrL0jRDoYMJDXFoKDkbGGeE0sJ8O9AcsNP2AwGeFXAN8R4Fs3qk1xtfAQ7O6jpqWMKcIJlRV2Wgb0rXEbN8SiuXd+abWGe4hSTKhA8XuXdJ0FccqyMo54SDqlGViGszc7NSJ+N/9mzuC6qFrWqN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuEJ1PD2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e686d60eeso985459f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709925547; x=1710530347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVPdnhePflx6M0Y1VqPM0q+L6FmThcZFrCpB9y8TiBA=;
        b=MuEJ1PD2n49TouZ57wuNHEu1X6wcJMT8Np3lWYPNE3gIy/Ti3Ui7rigk5MnaEw6D2J
         17iwIdg0Fw8emlmZSYStUQ9uKM2+y8PCgjlNiH7qtxap2vREb+dVesEDFXr0CCOp244w
         t2C3Sf2Zl+DVZZSTyTi7yB37AHDUtNoTsyQW2IZ3Y6oBuJxPJL28zye4t8xMZT3EnFi8
         e1wZvo0hbuh/RPD8wfzH25mukujJncymj3DS/Rpwj2o4eUD/TrneGG6pHs3vquogQpnH
         r0Jzk2/joh+zfdWSkhcmknBkRw/yXTxpuD+WfwK7fpqIHEnGakv7ZX1DKB4eGVo7GuIM
         TH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709925547; x=1710530347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVPdnhePflx6M0Y1VqPM0q+L6FmThcZFrCpB9y8TiBA=;
        b=oEi0Q947BGIa23Ct1FwHd5J3qfakS7lTvdQb8cnx9M1JDQ2GP8nChzCrYQW8q9YT7O
         SD7hRC9uYyhkuyEAKwtb+gkT0S0m11beRygb/+uFcjQHn3KXNEnBTXj3g4YjsLqFD+iT
         29GQMuzjkVlhlQkzzn0sFKf8apzpXp8t0IwfbxWhUo4ZhHYk+ujtX+mRJwdqsUCXRVSk
         2iCLE01eEH1GDJkTCv4OWy+xXCS8dt+03FGWtc6XeLobFdumKHTBQWKyT7ubqCGIeTmo
         8H33dQrEM9wLx/vDC3KKrYa5lO2z2wNw21jNNND+KuNGcLJgNZmjKQCrTf11RM9i4bUf
         aW7A==
X-Forwarded-Encrypted: i=1; AJvYcCWzekZH91dHbyDaCFRyYc6/z3cC57JS7Or/MBWIPoBEML3BwqghVZiOHyzXnKIih/i1Fe2md2OrjtO4SiTfu6Sqrvgqrbs44UPMxZID
X-Gm-Message-State: AOJu0YzKWpOOUfCbmDtxcZG45nTMkn+Mk2bYM8i0edZIWxECJUkS7PNR
	8SVUGBTromqV687uvTwIT6+KSocufLHqzvrfo9lhIb53vF9KhYTziXLNdC+DHEffpJFz3JKiy9a
	6L1LZGLQYK1yMx0R/8jq9jJijPeSydChi4GJ6
X-Google-Smtp-Source: AGHT+IFdGFOuBjADdIEbMGndT4cXpVw7kecKfUL2+HPEl9NNfe2ePqIdDjMJZlqSnkKRRD4FdpkvD+coDIp1GVneajE=
X-Received: by 2002:adf:fd89:0:b0:33d:aaba:aa66 with SMTP id
 d9-20020adffd89000000b0033daabaaa66mr58532wrr.65.1709925547287; Fri, 08 Mar
 2024 11:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcWOh9u3uqZjNFMa@chrisdown.name> <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
In-Reply-To: <ZeEhvV15IWllPKvM@chrisdown.name>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Fri, 8 Mar 2024 11:18:28 -0800
Message-ID: <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
Subject: Re: MGLRU premature memcg OOM on slow writes
To: Chris Down <chris@chrisdown.name>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:30=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Axel Rasmussen writes:
> >A couple of dumb questions. In your test, do you have any of the followi=
ng
> >configured / enabled?
> >
> >/proc/sys/vm/laptop_mode
> >memory.low
> >memory.min
>
> None of these are enabled. The issue is trivially reproducible by writing=
 to
> any slow device with memory.max enabled, but from the code it looks like =
MGLRU
> is also susceptible to this on global reclaim (although it's less likely =
due to
> page diversity).
>
> >Besides that, it looks like the place non-MGLRU reclaim wakes up the
> >flushers is in shrink_inactive_list() (which calls wakeup_flusher_thread=
s()).
> >Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I =
agree it
> >looks like it simply will not do this.
> >
> >Yosry pointed out [1], where MGLRU used to call this but stopped doing t=
hat. It
> >makes sense to me at least that doing writeback every time we age is too
> >aggressive, but doing it in evict_folios() makes some sense to me, basic=
ally to
> >copy the behavior the non-MGLRU path (shrink_inactive_list()) has.
>
> Thanks! We may also need reclaim_throttle(), depending on how you impleme=
nt it.
> Current non-MGLRU behaviour on slow storage is also highly suspect in ter=
ms of
> (lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, bu=
t one
> thing at a time :-)


Hmm, so I have a patch which I think will help with this situation,
but I'm having some trouble reproducing the problem on 6.8-rc7 (so
then I can verify the patch fixes it).

If I understand the issue right, all we should need to do is get a
slow filesystem, and then generate a bunch of dirty file pages on it,
while running in a tightly constrained memcg. To that end, I tried the
following script. But, in reality I seem to get little or no
accumulation of dirty file pages.

I thought maybe fio does something different than rsync which you said
you originally tried, so I also tried rsync (copying /usr/bin into
this loop mount) and didn't run into an OOM situation either.

Maybe some dirty ratio settings need tweaking or something to get the
behavior you see? Or maybe my test has a dumb mistake in it. :)



#!/usr/bin/env bash

echo 0 > /proc/sys/vm/laptop_mode || exit 1
echo y > /sys/kernel/mm/lru_gen/enabled || exit 1

echo "Allocate disk image"
IMAGE_SIZE_MIB=3D1024
IMAGE_PATH=3D/tmp/slow.img
dd if=3D/dev/zero of=3D$IMAGE_PATH bs=3D1024k count=3D$IMAGE_SIZE_MIB || ex=
it 1

echo "Setup loop device"
LOOP_DEV=3D$(losetup --show --find $IMAGE_PATH) || exit 1
LOOP_BLOCKS=3D$(blockdev --getsize $LOOP_DEV) || exit 1

echo "Create dm-slow"
DM_NAME=3Ddm-slow
DM_DEV=3D/dev/mapper/$DM_NAME
echo "0 $LOOP_BLOCKS delay $LOOP_DEV 0 100" | dmsetup create $DM_NAME || ex=
it 1

echo "Create fs"
mkfs.ext4 "$DM_DEV" || exit 1

echo "Mount fs"
MOUNT_PATH=3D"/tmp/$DM_NAME"
mkdir -p "$MOUNT_PATH" || exit 1
mount -t ext4 "$DM_DEV" "$MOUNT_PATH" || exit 1

echo "Generate dirty file pages"
systemd-run --wait --pipe --collect -p MemoryMax=3D32M \
        fio -name=3Dwrites -directory=3D$MOUNT_PATH -readwrite=3Drandwrite =
\
        -numjobs=3D10 -nrfiles=3D90 -filesize=3D1048576 \
        -fallocate=3Dposix \
        -blocksize=3D4k -ioengine=3Dmmap \
        -direct=3D0 -buffered=3D1 -fsync=3D0 -fdatasync=3D0 -sync=3D0 \
        -runtime=3D300 -time_based

