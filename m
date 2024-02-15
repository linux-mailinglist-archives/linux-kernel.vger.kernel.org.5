Return-Path: <linux-kernel+bounces-67564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B0856D84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D1E28EAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870B13A250;
	Thu, 15 Feb 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HohibbP7"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131413956F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024686; cv=none; b=tnGshwLB1b4vBRb0zpNGLk3cbHbwysoy8C6rPcbBixzYDgpVGtkJumS82t2EANhR8U+fsiM5GC8Z6rk4lYwkvaIWxm47Mjl3HdSAJK9Ns0RDtSoJRaBSGglJuAZuywpbIylEN3QSmhTDCVtIOxLm2yPfBkghteNarAUsbyumG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024686; c=relaxed/simple;
	bh=o3id02ShTaAJP/qkPl05c1vDDNiTkgunU+ojuRRB+Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2ETdp750bvrAeNHm0UwkYL+hv3c+ASgSOtWmkO7/YLIW91fTB/joRKbnHyuDeGzBWv4kzopy6EUk2YWzhrS8PPuSl/eSwVF+HZv1gqsqV989g54jz8t7AD4CNSRu5dZhof7zdquSqWYXxBNzYJsZqwAxOhCEzZswqKU4FlC8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HohibbP7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so1428972e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708024682; x=1708629482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KITCyNjL2swPBA9ngw1xqwUThE0CIbT81b+KJugWYzs=;
        b=HohibbP7mBtJ0GZtU1qwGFCb0H4pFMoZtkl6cngQwpYZshPEynWs8JHESb1wvMoAgh
         cjClGG5wvTLewfzfGOQ0f2gvDcLKjRtP3DFpmdl3Ei6m4HpiyrJAaWByLgHltnJVnBh8
         pOEAmBqTgvIkNbJlLCSEPLvDOTu7AQIS2UXvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024682; x=1708629482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KITCyNjL2swPBA9ngw1xqwUThE0CIbT81b+KJugWYzs=;
        b=IPP8pobPrAa+Tf3jWNcRi4XYE+1235RaBa2jq6gBCyY+/PAPRJ0//oxqx12Ygg1L22
         Z6rGLHqgkLoch/QfHWYuccqpjePlAK97vdhX3LpAjvwcjVfgXQF+smuHlCbVNhVYLmje
         stWFFf6sSLIj2WkJ6tdO+Zv7m+3NdHZRqiH4TsZ+edz9vabQDvSDoBdysx5kd7fmHEwU
         agDQgF6qKuIZfV7fAFzdnfZeCbS4cDGJ0aAuWMjUEfpgW7ayDSLUWNwPCeKqOtLmEik8
         uPKH+6nE3Q4wu9E68jrlNLf0/uHi0UipAY+VxfEL3bipYPrUSskvIXansQqyUccW7Fel
         crHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8UULQApu09o2W5byAMvnVoamKuqyKCGd78katblo6ae/QDZXp+Rij23uoD+g0u0ONi4wdZ+fWOob0+jejOmGqR0LdDwjhiZlzufXl
X-Gm-Message-State: AOJu0YxfBjqhfL7qHvtlQKjPRmkRWApy2wPetk3i3Wz1ekarZfwPBow8
	JNQgh7qZQG+8W32C8Sc15Ft/Au9gTRQZDhyv6pU1HOVwNiY7IO0msRbQyUPMHdFwjFH9kMdVCGW
	lQgk=
X-Google-Smtp-Source: AGHT+IH9rSGNatVnu6OzsnBVquogScvOTlsqtFxdyEYTppiYgsVaskYOo1mizpDhdAjtyaFKS8+e4w==
X-Received: by 2002:ac2:446a:0:b0:511:879f:2a73 with SMTP id y10-20020ac2446a000000b00511879f2a73mr2011145lfl.7.1708024682533;
        Thu, 15 Feb 2024 11:18:02 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id qo3-20020a170907874300b00a3da5bf6aa5sm619905ejc.211.2024.02.15.11.18.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:18:01 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so1636101a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:18:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv7NWbB8jNPoWS2q5dFJMFMDvwBSE34XqxldZpe/sUG9D5tnIObIeI5x7E3XBvoz44YV+KxJ09kMkdYayuwLPYEMOo71ODxUGVHtjU
X-Received: by 2002:aa7:c31a:0:b0:55f:d95c:923 with SMTP id
 l26-20020aa7c31a000000b0055fd95c0923mr2173374edq.25.1708024681342; Thu, 15
 Feb 2024 11:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
 <ZcZyWrawr1NUCiQZ@google.com> <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
 <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com>
 <CAHk-=wgBt9SsYjyHWn1ZH5V0Q7P6thqv_urVCTYqyWNUWSJ6_g@mail.gmail.com>
 <CAFULd4ZUa56KDLXSoYjoQkX0BcJwaipy3ZrEW+0tbi_Lz3FYAw@mail.gmail.com>
 <CAHk-=wiRQKkgUSRsLHNkgi3M4M-mwPq+9-RST=neGibMR=ubUw@mail.gmail.com>
 <CAHk-=wh2LQtWKNpV-+0+saW0+6zvQdK6vd+5k1yOEp_H_HWxzQ@mail.gmail.com>
 <Zc3NvWhOK//UwyJe@tucnak> <CAHk-=wiar+J2t6C5k6T8hZXGu0HDj3ZjH9bNGFBkkQOHj4Xkog@mail.gmail.com>
In-Reply-To: <CAHk-=wiar+J2t6C5k6T8hZXGu0HDj3ZjH9bNGFBkkQOHj4Xkog@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2024 11:17:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLFrbAVq6bxjGk+cAuafRgW8-6fxjsWzdxngM-fy_cew@mail.gmail.com>
Message-ID: <CAHk-=wjLFrbAVq6bxjGk+cAuafRgW8-6fxjsWzdxngM-fy_cew@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Jakub Jelinek <jakub@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sean Christopherson <seanjc@google.com>, "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 10:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 15 Feb 2024 at 00:39, Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > Can it be guarded with
> > #if GCC_VERSION < 140100
>
> Ack. I'll update the workaround to do that, and add the new and
> improved bugzilla pointer.

. and I also followed your suggestion to just consider any gcc-14
snapshots as fixed. That seemed safe, considering that in practice the
actual bug that Sean reported seems to not actually trigger with any
gcc version 12.1+ as per your bisect (and my minimal testing).

HOWEVER, when I was working through this, I noted that the *other*
part of the workaround (the "missing volatile") doesn't seem to have
been backported as aggressively.

IOW, I find that "Mark asm goto with outputs as volatile" in the
gcc-12 and gcc-13 branches, but not in gcc-11.

So I did end up making the default "asm_goto_output()" macro always
use "asm volatile goto()", so that we don't have to worry about the
other gcc issue.

End result: the extra empty asm barrier is now dependent on gcc
version in my tree, but the manual addition of 'volatile' is
unconditional.

Because it looks to me like gcc-11.5 will have your fix for the pseudo
ordering, but not Andrew Pinski's fix for missing a volatile.

Anyway, since the version dependencies were complex enough, I ended up
going with putting that logic in our Kconfig files, rather than making
the gcc-specific header file an ugly mess of #if's.

Our Kconfig files are pretty much designed for having complicated
configuration dependencies, so it ends up being quite natural there:

  config GCC_ASM_GOTO_OUTPUT_WORKAROUND
        bool
        depends on CC_IS_GCC && CC_HAS_ASM_GOTO_OUTPUT
        # Fixed in GCC 14.1, 13.3, 12.4 and 11.5
        # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
        default y if GCC_VERSION < 110500
        default y if GCC_VERSION >= 120000 && GCC_VERSION < 120400
        default y if GCC_VERSION >= 130000 && GCC_VERSION < 130300

and having those kinds of horrid expressions as preprocessor code
included in every single compilation unit seemed just nasty.

              Linus

