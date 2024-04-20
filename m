Return-Path: <linux-kernel+bounces-152068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B688AB850
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20931282400
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA75382;
	Sat, 20 Apr 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EaL9YBDT"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BF7FE
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713576200; cv=none; b=HYZPhI+71cxqZQTEai9tceBDyq1Snw1+RZrRd7H5zfpEkAmnmfqOfq51Sdk2tnnbFnE9z3EooKSRNmGThH++eJq0L2s7vnLJKzABXYGzrERolX8UyqLiGzIRnzt14Fv3eX3uBcGTW+poAvCC0CLWBRDBXMM1XLSp2W5re5cJEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713576200; c=relaxed/simple;
	bh=J0MfJFQe8As9lwuUV4B9Kw4FNsDQePKIb9SHbW9KuQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDA+INxyqy7ovU3P3kghOlxMX4uFetb85hAFRiUPInSkqEegyocJUqMGutkEPo/vePgnlhwo28zIS5E+nxLYTZ+zzPeWgdaCjzDgcJ5luDQxBqevLPhNbsi7JnGKXYmSiSctkNFkY1vkcgeO/sxyfEm0Iy6bixJl3vOuuQ1NSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EaL9YBDT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb93ec8804so1498809a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713576198; x=1714180998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkYkipVaIPOoc32m8NtP1VEOzkVOrOXqd3GXQCTqvPI=;
        b=EaL9YBDTa2Go555gL23jstEDsQlUjsFNwIV3UTjJD8t5hHP6lBzwzInZxZLr4/q5oU
         gwS+Od7XHYTIrsRZrCKD7HzUyjgYgPofo6ZRPPaf+bVy/lLeMaEepLhlaz3WuSb77sTo
         5HaN7M1moweoXo2Uz7w+T/SPcHnRC/Y2GCVfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713576198; x=1714180998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkYkipVaIPOoc32m8NtP1VEOzkVOrOXqd3GXQCTqvPI=;
        b=FF0Uhn7BVAAKQo5LPB+CD5aBrFN3ygqelmEDlsqqH9Wrgys5DABaCh2MOzYVbeLVhq
         zDHuq5pUzDO/2dt21YEdNinugPF6iKUePnBfyMPuwx21kaSN2l3b78Gv43ev+APQeu5G
         gAFe6onmiF7hd7Ki4tSuaY7Jd/o+WBlu9095xUDXCy/GXUqRuwAqhrrodnPp6XGhzDLF
         epLXAMJh/G+trzo1D/ls5mLkgWuJY+gqIoqxj47d2VX3DHYte1E3pZx+4r90NDXz6E8L
         SVK7NxAGTHet0P/eZYsJ+3S4Nf/oYerPhMcWERx8N9v5GXUGXBWI/2/qWyB6vBe/eQi0
         RVew==
X-Forwarded-Encrypted: i=1; AJvYcCV9NAAmPd3TYlw3G4erFcYWlKKqnzjIz1QQLElj3DZRFLJkwEWYl8qnc5ZYCfa20BzsD/LtOrmygWSMjlhITsEKt7pJHm+Y9NuuMPyM
X-Gm-Message-State: AOJu0YyZbWH+a4SasYW6nIVTyqPDUxsT1iuGVifgivUtmGP0J1aevLAB
	9ShQeX+MRDgtKj/b+3KsfdfKeLJpv692gymIGm532USHq6bgBrJJEHntLlR8HMTQ5xStzW/lqlM
	qDama3YO9ggtoPJBV1eR6uB42HP4Zmsr2UvJLrJ5KClaoPViHgg==
X-Google-Smtp-Source: AGHT+IHBc4Rb3dg8R081whzPxTVTeU9l1xcO4/ULPqot8pzPW2t3I7MBZbBmk6o1jIf7EVB1Xx8ui0lQ4Bl/rq650XU=
X-Received: by 2002:a05:6871:203:b0:22e:d541:7eb5 with SMTP id
 t3-20020a056871020300b0022ed5417eb5mr4612272oad.38.1713576197982; Fri, 19 Apr
 2024 18:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
 <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com>
 <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com> <CAKbZUD1ZLfAPznGg-j2xmC7O2a-b8jRRQjSgRLRUrP8DQ6Lntg@mail.gmail.com>
In-Reply-To: <CAKbZUD1ZLfAPznGg-j2xmC7O2a-b8jRRQjSgRLRUrP8DQ6Lntg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 19 Apr 2024 18:23:06 -0700
Message-ID: <CABi2SkVJejGvOiSUapTJiEOcRz-c20EqE_txzUDxwWgKG0cb7A@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 10:59=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail=
com> wrote:
>
> On Fri, Apr 19, 2024 at 2:22=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wro=
te:
> > The overhead is likely to grow linearly with the number of VMA, since
> > it takes time to retrieve VMA's metadata.
> >
> > Let's use one data sample to look at impact:
> >
> > Test: munmap 1000 memory range, each memory range has 1 VMA
> >
> > syscall__       vmas    t       t_mseal delta_ns        per_vma %
> > munmap__        1       909     944     35      35      104%
> >
> > For those 1000 munmap calls, sealing adds 35000 ns in total, or 35 ns p=
er call.
>
> Have you tried to spray around some likely() and unlikely()s? Does
> that make a difference? I'm thinking that sealing VMAs will be very
> rare, and mprotect/munmapping them is probably a programming error
> anyway, so the extra branches in the mprotect/munmap/madvice (etc)
> should be a nice target for some branch annotation.
>
Most cost will be in locating the node in the maple tree that stores
the VMAs, branch annotation is not possible there.

We could put unlikely() in the can_modify_mm check,  I suspect it
won't make a measurable difference in the real-world. On the other
hand, this also causes no harm, and existing mm code uses
unlikely/likely in a lot of places, so why not.

I will send a follow-up patch in the next few days.

Thanks
-Jeff
> --
> Pedro

