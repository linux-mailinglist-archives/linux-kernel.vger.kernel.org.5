Return-Path: <linux-kernel+bounces-141505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9423B8A1F21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67211C243ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1136014AA7;
	Thu, 11 Apr 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPkKTdvY"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F213ADC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862509; cv=none; b=A5I9OqfHD8m/E491/JDQ7gbXOzavZezAmAC3JwLXgyP4XDpBR3bDb0Jra8FlZ3pAWZ8QILQ74ccuDWECfYnMlP0bZpRQ/gUnnt3uiQ+xy1cZ3TtAsvLy/ZTX8cKVYw1YzLe3s2mxUuLwyhlUV5K8U3Vqq5EVQwkj7Id9xqnISlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862509; c=relaxed/simple;
	bh=98Mnvon7EQHgSDoOI3AzsOkvdvUWgbW9iC605W95gZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6RbxNvDe0X9iWx0419iqQ8VGbl2el/UKTXfEYmmYvmU2eQtbyyoaVWpml6ldVsuNyHep5xsVi0g7D5xzRa3arcdyy2XbUiWqJhLmfpFdJsC+MPtR8dn/OOO+dpAdqw4dfytF1ciBOz/963MRcRwnHKW8VJdEl1Ww02PeRtdDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPkKTdvY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so1246091fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712862506; x=1713467306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/uG8LatAMX5NvKEwUo6328DD3s9kCkeEOzfZbrZ19g=;
        b=QPkKTdvYWHW9+v/nEeygbh7H4+cZDkOlK59OOvJJMNpLfRroSpfu8R1r89b5PsSYCn
         MjQZGL81HPUJbz1er/OMyRtTKUWM/63lF1J/aGbqgqmyc6APndW7Grl8DR2KslxdV1VQ
         WZhLzdwD4s7jkQjocU3IG7FSlzRbW29veIozoJ+/aACjDAaRwnSWzUtncjAdBRYUv2Qm
         Ak8hzJ05HXp1hfmAKjPP0peIzDTlEvhKHdDSsI1TYQHNyigldeOL20FzY5TknYIQGeZc
         i07baPiOlNWJIoxx65fofNWYpZxDGApk3G8dDdFeCVEUvHyPsatxGWi2fJbY5/V2E8Bj
         iyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862506; x=1713467306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/uG8LatAMX5NvKEwUo6328DD3s9kCkeEOzfZbrZ19g=;
        b=isrLxUOpT2PrmFNuPMgHZQxXMXSdecI81Y9f/z4MpbQac8kEbmv41q8gkx3cH3al4V
         64iYJcFqgLp4HzX22g569h2fWN6q5KVJA4PROKKYBxVh0GXbOIz7EPyNZszrHKOdi4Qp
         5v2kCgsY5G/UwLNdMrszeMlHoHsVwoVwCRglq84TrTolLDPw7R7g0Vq8Cv0r09NHzEt2
         1B00OgU4sQ3WeZ7EnTJqzR+YtsAOXrMAMf+P0SDJfFvynxsPvOcSm57SSfqqy8++A8nD
         Lcw4x+P2aRTKWj+8o1aSiPHBbm/ezCeqMD6P2qKG352YvFz/XP4QX+5kBu6gZpiRWggE
         mShA==
X-Gm-Message-State: AOJu0Yw4XuFDOARW315MzVI29FZIRVmn/Higo3FjMT5HIlgKm0SGV7eD
	osekYeGnyVBeD3SZov6KgHkfE/I/uYU84nRqpxcpoa/c9hqz5PsKmnzqvvP+tXMZ09DOwMj+wKX
	7mTjsn1JGOZvsA91xoVbbvhJjpSg=
X-Google-Smtp-Source: AGHT+IHLveaNy4JMgX7/1WlkjFDYOw/+V1yM9R+UeUFr2XTcda9NNjtDp4BY9iJbwN1DtTULt0CwRF4syDf+KxHuHXo=
X-Received: by 2002:a05:651c:11d4:b0:2d8:eaff:8a38 with SMTP id
 z20-20020a05651c11d400b002d8eaff8a38mr281274ljo.46.1712862505758; Thu, 11 Apr
 2024 12:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325140943.815051-1-ubizjak@gmail.com> <20240325140943.815051-2-ubizjak@gmail.com>
 <Zhfkinpp92Ja6Orl@gmail.com> <CAFULd4ZhJonzsP1GexJOy1PTx4PCTZoU1ukQrpmaNusumU2FTA@mail.gmail.com>
In-Reply-To: <CAFULd4ZhJonzsP1GexJOy1PTx4PCTZoU1ukQrpmaNusumU2FTA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 11 Apr 2024 21:08:14 +0200
Message-ID: <CAFULd4bLBuPUK-Efdw65h3=fk2819zFnNkvUBh_OdNBbNFJBQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 3:35=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Thu, Apr 11, 2024 at 3:24=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wr=
ote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > -     locked =3D cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
> > > -     if (likely(locked =3D=3D _Q_LOCKED_VAL))
> > > +     if (try_cmpxchg_release(&lock->locked, &locked, 0);
> > >               return;                                   ^------------=
 ???
> >
> > This doesn't appear to be a particularly well-tested patch. ;-)
>
> Ouch, embarrassing... oh it is a generic function, conditionally compiled=
 with
>
> #ifndef __pv_queued_spin_lock
> #endif
>
> and x86 defines its own function ...

Looking at the assembly of the fixed function, it looks that improved
generic function is better than x86_64 special asm:

This is the new generic function:

0000000000000750 <__pv_queued_spin_unlock>:
 750:    f3 0f 1e fa              endbr64
 754:    b8 01 00 00 00           mov    $0x1,%eax
 759:    31 d2                    xor    %edx,%edx
 75b:    f0 0f b0 17              lock cmpxchg %dl,(%rdi)
 75f:    75 05                    jne    766 <__pv_queued_spin_unlock+0x16>
 761:    e9 00 00 00 00           jmp    766 <__pv_queued_spin_unlock+0x16>
            762: R_X86_64_PLT32    __x86_return_thunk-0x4
 766:    0f b6 f0                 movzbl %al,%esi
 769:    e9 02 ff ff ff           jmp    670 <__pv_queued_spin_unlock_slowp=
ath>

and  the x86_64 asm version:

0000000000000050 <__raw_callee_save___pv_queued_spin_unlock>:
  50:    f3 0f 1e fa              endbr64
  54:    52                       push   %rdx
  55:    b8 01 00 00 00           mov    $0x1,%eax
  5a:    31 d2                    xor    %edx,%edx
  5c:    f0 0f b0 17              lock cmpxchg %dl,(%rdi)
  60:    3c 01                    cmp    $0x1,%al
  62:    75 06                    jne    6a <.slowpath>
  64:    5a                       pop    %rdx
  65:    e9 00 00 00 00           jmp    6a <.slowpath>

I didn't investigate slowpath, but the generic fast-path part is
certainly better than x86_64 special asm.

Uros.

