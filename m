Return-Path: <linux-kernel+bounces-50474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559A84798D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C526A1F25EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3415E5B5;
	Fri,  2 Feb 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERFw2f+7"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87815E5A6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901667; cv=none; b=U01ntkE+QDUS61I9OyPQaIqbuqEc0E69rP0xCtg0LRoGItTDOugPovAhfMqOYM7kdHczhNDYegvc+jW4Z6kmrR0ExTdqKhs6pErVGdH0sedIpqWr1rcIGACDAlZ92kEbhr79sdUxDqTFLA0iASV19Sp0Xk8S8HGoYJIeiKuX9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901667; c=relaxed/simple;
	bh=SX/1kOEJ3Ax/hWf0xgUvpBYNBAwAbB0XQf4SpCcsEO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws2hj3Cb8Db+LGBSEHRTCjfiTlqEuJenbU9ZNJixRRNIVew+NyJbpEA698QtHGPPYdouaRKuXNZMt0bz/Y9S4zoCn2VEvUyKPfq4MAmMiLg7Mpi8zoVzsPTu3Om76+YoVAz9XOcGH9T8AAxx2008isjnr37PADC1DrG3jrYR2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ERFw2f+7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d040a62a76so26473421fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706901663; x=1707506463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzRl/p/zBM55V3qi6ZzeQftf/q51vbL6S+/zvQ3KD1E=;
        b=ERFw2f+7iPRhhZJmxJgvdF4FkggcG8ZCPJew47O5IaW4Z3UoejdaJJLVm7t4IHr9Zp
         i27NjxcSydlFGcrc/DHpQwtWiDGr8THWTG5pIGqMn8KOYo3hAuKlz02YbiJak+f/49Th
         KryKnsQ50kg5sl85FLeuo+tp9Eh8E545I3aqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706901663; x=1707506463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzRl/p/zBM55V3qi6ZzeQftf/q51vbL6S+/zvQ3KD1E=;
        b=AuA8lcL8P6olVGA2meU0d7B7NJ9t7Ar6cKcfxuecDxrdPyTMgU22/PWQyUsa19dojV
         KX1QZWgDaBvlvlWB7NwsSZ4h2j+ttI3iIHCSJdCX4+tbipYV5B7EGku9wkQFoa5d3moO
         BVE9Gvq1jM8Xx0zAXr7Ypnu7fhsnQPLyDF0F9gMPV8pIO0W/eNWnYfVIu4GNZNSRwugu
         uRwxCzZYzMK/3qUjtxvvQDCMZ0FO2qHkUT/Tbtf29t/BYpISCte1JVGl/ElF5E7gJCP1
         RxLXZFlMZajM/XpqVH96hSMDgVMCJC5khKtCezQRTJ/5z5l2hlVOHYrUAK4zzO7BG+eA
         bFMA==
X-Gm-Message-State: AOJu0YykpQeEgtfNm0lOg3EvbMkEb3UGkfAoUSbjV0haBusNsPN4ppiW
	ma3mOwUv/Wdau3DFw89LK2kJGmONcpDk4aHnD6AhlxS97naLU5fICVqzBkCqQ6EXC76ewsWQZiG
	IR1cH
X-Google-Smtp-Source: AGHT+IEQ5mhB6dbpe0NShtpSWGfiOalkn/spXOWnfpwh58Q6baioYnxNBDBJrtNqDBo2gArQrw3E0A==
X-Received: by 2002:a05:651c:220f:b0:2d0:97e9:99c with SMTP id y15-20020a05651c220f00b002d097e9099cmr295168ljq.19.1706901662883;
        Fri, 02 Feb 2024 11:21:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7TqzGjzhe9taiOrrlCPzEfEJIxH0HS7xRVpTIGnypWgUwwpiMnYP6FJeeZTzjeyRtioE9Lj5dweSwSPc47iwzNfnHHA0iQCjRUsjM
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id fe9-20020a056402390900b0055d312732dbsm1057600edb.5.2024.02.02.11.21.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 11:21:02 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso6995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:21:02 -0800 (PST)
X-Received: by 2002:a05:600c:6016:b0:40f:cb0d:4dd1 with SMTP id
 az22-20020a05600c601600b0040fcb0d4dd1mr54895wmb.6.1706901204019; Fri, 02 Feb
 2024 11:13:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV> <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV> <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV> <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
 <20240202164947.GC2087318@ZenIV> <20240202165524.GD2087318@ZenIV> <Zb0vem7KC28gmT5U@e133380.arm.com>
In-Reply-To: <Zb0vem7KC28gmT5U@e133380.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 11:13:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XDg2Q2Gkv0pnngfUMJUOctXhe7f_33DW4TpLxTdG7KBw@mail.gmail.com>
Message-ID: <CAD=FV=XDg2Q2Gkv0pnngfUMJUOctXhe7f_33DW4TpLxTdG7KBw@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Dave Martin <Dave.Martin@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 10:08=E2=80=AFAM Dave Martin <Dave.Martin@arm.com> w=
rote:
>
> So, if the only reason for trying to migrate to vmalloc() is to cope
> with an insanely sized regset on arm64, I think somehow or other we can
> avoid that.

Right. The only reason for the patch to switch to vmalloc() was in
reaction to seeing the order 7 memory allocation. If we can decrease
that to something sensible then I'm happy enough keeping the
allocation as kmalloc().


> Options:
>
>  a) bring back ->get_size() so that we can allocate the correct size
> before generating the regset data;
>
>  b) make aarch64_regsets[] __ro_after_init and set
> aarch64_regsets[REGSET_SVE].n based on the boot-time probed maximum size
> (which will be sane); or
>
>  c) allow membufs to grow if needed (sounds fragile though, and may be
> hard to justify just for one arch?).
>
>
> Thoughts?
>
> If people don't want to bring back get_size(), then (b) doesn't look
> too bad.

Either a) or b) sounds fine to me, but I'm just a visitor to this code
so maybe I'll let the adults in the room chime in with their opinions.
;-) Also: if you think it's fruitful for me to try to write a patch to
do either of those then I can, but I also wouldn't object at all to
someone else writing a patch to fix this and I can just provide a
Tested-by and/or Reviewed-by. Let me know.

-Doug

