Return-Path: <linux-kernel+bounces-60934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C16850B55
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD02B213B8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B5A5EE72;
	Sun, 11 Feb 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DHNepSWW"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9185D72B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707681612; cv=none; b=Mrimjjm4nCH/Z4mKR78h8FV1zsjJIH66y00wLUaeeqlue0Z/nXbYxciVLkm74d/LsWBxqGaUTJZXElAMDkXZ6/qzcRtYNd5+X85JjDQ58QIu2HxWPA/CCwPIPPVvcgwKlgIzc9sumh+b+xNXeUsF98W9hjKNGDGyWqZEm3yFzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707681612; c=relaxed/simple;
	bh=yHcIHSK6i6VhUKzbQ7HCE1nMkKO6GXpkQD3eG2PRvSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqtKb2cdFjY93e1WC3CQlavD0kmwlTxSSVWdYuA43bdy7jNpf8s14myR8904IjLWgbjKWpPfIhj9yG/s60+gMx1581wDzRlirUOjfx0UFZWtXzXUI55zMJxpqb6a+uynkPzzWZ7nm1Ep+gvqeDPJ8KwKv4kH5u0GQh9qtlCEPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DHNepSWW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0e2adfeefso21403991fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707681608; x=1708286408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J45x/tj4nmdlGBDAbOeZG0/l8SPCbpFWq5LzEROciCk=;
        b=DHNepSWWHtEwK0HfiDSBiEflo/iN3ySNLlcWi4slhaJ/v7jSlPqm/pzwfPVG/mglx/
         ujVWa8sBc/ad7Tk+oGZ55ZxkVTmo2WMIQzTw+zc03lco9goaAFA+oMzLq5ERSH1C9n9h
         aMWhyKY7NoaGz6/mtKClGIO1p5m3rYVETmoXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707681608; x=1708286408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J45x/tj4nmdlGBDAbOeZG0/l8SPCbpFWq5LzEROciCk=;
        b=JaxjBMzg6Pin7W8VBy+gYkVbsBNh9+/OyIIm30PjG/iK4lLceZfW7whPEmIWtP2xpx
         aHVz6rHXcP2Bvqd1AaNhlTyGgb0ls1390FPuumJ5vbKi3He+W1Nka1NMo6esPOATjUC5
         nKpBp9HWGcAplYZwblveE0duLGh/z6ncF1laKE9XvSSmcNnOfMDUany8dCdJMDxXSD9E
         sh6BoxHiNR6D9FogAyJO67SitVuu/2wniqiEvFxerfi+0YiRDN3ED4+EnVmSoGhFi+3U
         8DdJ4vYZVWRchoqwPYAlQdJp8HqcHNe6Mm2N2vA96d3phRaFfCHsRHaUyjnkjZoSP73g
         wZZA==
X-Forwarded-Encrypted: i=1; AJvYcCXU5OsQJ1dT8Z31/GU8J0HC8Was/3s5MzEeVHKBs7Wl9aMU4Wiy19bT5FURh/kPlj8aqzKC+fTdqjYKZrR9ihVywakipablQQu6X6MJ
X-Gm-Message-State: AOJu0YyXa82+vqIKEZ4+qb6Z71qgszOqjyOMzwvC+jJUfw0eu/OiH3m4
	klJsJINyaShBC1vTqxfclMaePjN8RXUWJ3IPzDS+7refo4PAM6xQhZP/r88z1qEuOq00LACvlwp
	v/Z0=
X-Google-Smtp-Source: AGHT+IGgZMdIBL3+mRoPsEca8J+LhS2+fLvbo4EbW7PUybGxYzDjskhlHicmeTYaS56EYqTfdT/AkA==
X-Received: by 2002:a2e:99c2:0:b0:2d0:b3c3:d8d8 with SMTP id l2-20020a2e99c2000000b002d0b3c3d8d8mr2936939ljj.43.1707681607635;
        Sun, 11 Feb 2024 12:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlcGI/KW2k90nASjNK3xvzRJN6OEP+sx3bsbVo5v7xyeeuRYaipCuljqt6uu4/qPmDzOFYcEj3XBh7KeIxo2buaFJAWv3UKqx5l7X3
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id ef13-20020a05640228cd00b005612025465asm2064018edb.74.2024.02.11.12.00.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 12:00:06 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so3334725a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:00:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrLbXL6XLwqWNSbsabs59umzxfZs95YPGzV70qOBzaysg9UFV09vVxulrmX3HfS2GAA1BJfmGQr9lPpWuii+HY4BErNXib77fQ5v5E
X-Received: by 2002:aa7:da4a:0:b0:561:3880:ab14 with SMTP id
 w10-20020aa7da4a000000b005613880ab14mr2854639eds.26.1707681606348; Sun, 11
 Feb 2024 12:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
 <ZcZyWrawr1NUCiQZ@google.com> <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
 <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com>
 <CAHk-=wgBt9SsYjyHWn1ZH5V0Q7P6thqv_urVCTYqyWNUWSJ6_g@mail.gmail.com> <CAFULd4ZUa56KDLXSoYjoQkX0BcJwaipy3ZrEW+0tbi_Lz3FYAw@mail.gmail.com>
In-Reply-To: <CAFULd4ZUa56KDLXSoYjoQkX0BcJwaipy3ZrEW+0tbi_Lz3FYAw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2024 11:59:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKq0bNqGDsh2dmYOeKub9dm8HaMHEJj-0XDvG-9m4JQQ@mail.gmail.com>
Message-ID: <CAHk-=wiKq0bNqGDsh2dmYOeKub9dm8HaMHEJj-0XDvG-9m4JQQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Jakub Jelinek <jakub@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Feb 2024 at 03:12, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> I'd suggest the original poster to file a bug report in the GCC
> bugzilla. This way, the bug can be properly analysed and eventually
> fixed. The detailed instructions are available at
> https://gcc.gnu.org/bugs/

Yes, please. Sean?

In order to *not* confuse it with the "asm goto with output doesn't
imply volatile" bugs, could you make a bug report that talks purely
about the code generation issue that happens even with a manually
added volatile (your third code sequence in your original email)?

> So, I'd suggest at least limit the workaround to known-bad compilers.

Right now, I don't think we know which ones are bad.

If it was just the "add a volatile by hand" issue, we'd have a good
pointer to exactly which issue it is.

The other bugzilla entries I saw talked about ICE errors - and one of
them is quite likely to be the cause of this, because it really looks
like the code issue is some internal confusion. The asm that Sean uses
doesn't even have an unused result, so even the volatile shouldn't
matter, and seems purely a case of "limiting optimizations partially
hides the issue".

And then us adding another empty asm obviously does just even more of
the same, to the point that now the code works.

So I don't think we actually know which compiler version is the fixed
one. We only know that gcc-11 doesn't work for Sean.

                  Linus

