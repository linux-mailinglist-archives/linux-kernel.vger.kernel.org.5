Return-Path: <linux-kernel+bounces-108042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505F880527
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86341F2466E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651383A1AA;
	Tue, 19 Mar 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b7gzV3Cb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFD39FC5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874509; cv=none; b=YT+rNYbFMIzXG8uNDWOkLcOcnVdaXu6R7V9PqIdUxypBxlAVK+vl85MtqLeI5+iRKxAMQlEi60kZni2g8vHhAboXwxAXclmKGVp3J614E9IBDVl1r6UdvHAasku/JySSXnaH/RDUFB/mcYRv19djtsouDcVhTHxH1lvdeIdla28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874509; c=relaxed/simple;
	bh=cquyfRZ0VBetvG8+L3oqKgTGchO/YG/tGhNA+Cv+Co0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFny4A5O5LqCsnuaSCt95jenivyHQ95HEpwf/Ul+Yctmk8ZZeT0ThXZ5WTHzOQUIyaXHwGMb9zvhikmeAQ407y+IVhOhSPWC9Pr54tRelWcYk4ROlMPzyFUhmwMRy67fxCZyVS3TD3a1jPsHWgpON6w8C1UZwbSvx0seX9Z6bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b7gzV3Cb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56a2bb1d84eso291684a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710874506; x=1711479306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4KodDa0zT/HNzbAX2EO8nLcPy/wnsGHD7zCwXLN7BY=;
        b=b7gzV3Cbtoo13O7zkMZsbBl0KrI+htHS+KyP8w5EUiEyjwvAbXFlqGMAA65pfARnkV
         mHixlgRLdzQHXtXpWZQA9STVE6BVA2JNjaLOQgztT1CbX8gO6tCCWFGvl+Uxhg6/jd9C
         SuN1HVOuPAStpUUhLYFwOk1hy6Gczc0oqVmEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874506; x=1711479306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4KodDa0zT/HNzbAX2EO8nLcPy/wnsGHD7zCwXLN7BY=;
        b=Q/hbTYDmh89/8Zz9DOt7c35u9YYNXkzEfrf018etxBmPY5m8p+B8VWlj1xwfTfLccl
         dP3nGbs0UHtHNVL6V3l9CoKHXOE3ZJiNhItWl+FCHLULgIFjA5cohT37ipOC/JVK3Lrg
         H3nJIls7Q5dtu2rEb7yQE2Oo2wUlDP9rAdRR+I8es2BZVeM+syBAksf+Pxq8x8obpul5
         RIVbKlnXSpc07YoyMm/NMDoq1XS4eyjoQ5jh6feVtjaP/dhN/WxdZQ6Hr28F6V5OG38d
         wEB0OzBaASApIpseyUMVQqP9gEWUM/FjC4JRuZV/En/b/jw/8cJiXWnALdkr66cAag5X
         TS4g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2fUZ5C7KoZ2ezsq9UCmQZBBWJpeobtDmgR2fWow/2KA83JjGD+C/uNPalr1XQoFza8rHgYBV4VRISzH2b8tW7Y4YAoEd2sFtmdS9
X-Gm-Message-State: AOJu0YyafaPRKBddvT4TwTxF7giGE+pPcA4ixzbSwrelNEQyWmMyDGV/
	HTUPw2ap2ez+xwHbiu1PW0mXcTUUVqbJg7s+yNB6CgIdEwwPQjxN3E97Je6Srng1u4hFh76soZP
	DSNkcmA==
X-Google-Smtp-Source: AGHT+IG/pxV42cQEhsuKmNf+P+NycmYYZpQuMIjifVexMk0R5Hr46IoPf2fdrzE+vP+CD9fHPqb2Fg==
X-Received: by 2002:a50:9e61:0:b0:568:a8f5:d47d with SMTP id z88-20020a509e61000000b00568a8f5d47dmr3177750ede.17.1710874505658;
        Tue, 19 Mar 2024 11:55:05 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id ev19-20020a056402541300b005689c2c6508sm6024091edb.70.2024.03.19.11.55.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:55:05 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so31188266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:55:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpNCvS6ow1ldQtO6tKOfuVHW0eumtKmLl7s31b89CVKn8+oyx4oMNe5QYQnpGSQkG3yeLcdfV67pd+yWeKfIGAecA80SbbXNs3RsKH
X-Received: by 2002:a17:906:c7d4:b0:a46:dd1f:7dc6 with SMTP id
 dc20-20020a170906c7d400b00a46dd1f7dc6mr2839426ejb.24.1710874504637; Tue, 19
 Mar 2024 11:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319141230.23303-F-hca@linux.ibm.com>
In-Reply-To: <20240319141230.23303-F-hca@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 11:54:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGkerd+_ARB6bbSgAm02nkoOxRiy4LVsS_24ANQV-eZA@mail.gmail.com>
Message-ID: <CAHk-=wiGkerd+_ARB6bbSgAm02nkoOxRiy4LVsS_24ANQV-eZA@mail.gmail.com>
Subject: Re: [GIT PULL] more s390 updates for 6.9 merge window
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 07:12, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> - Add new bitwise types and helper functions and use them in s390 specific
>   drivers and code to make it easier to find virtual vs physical address
>   usage bugs.

Hmm. Because you still want to be able to do arithmetic on them, this
is really what "__nocast" should be used for rather than "__bitwise".

__bitwise was intended (as the name implies) for things that can only
be mixed bitwise with similar types. It was _mainly_ for big-endian vs
little-endian marking, where it's actually perfectly fine to do
bitwise operations on two big-endian values without ever translation
them to "cpu endianness", but you can't for example do normal
arithmetic on them.

So __bitwise has those very specific rules that seem odd until you
realize what the reason for them are.

In contrast, your types actually *would* be fine with arithmetic and
logical operations being done on them, and that is what "__nocast"
really was meant to be.

But we basically never had much use for __nocast in the kernel, and
largely as a result __nocast was never fleshed out to work very well
(and it gets lost *much* too easily), so __bitwise it is.

Oh well.

It looks like it's not a lot of arithmetic you want to allow anyway,
so I guess the fact that __bitwise forces you to do some silly helper
functions for that isn't too much of an issue.

              Linus

