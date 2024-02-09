Return-Path: <linux-kernel+bounces-59842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0586C84FC66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC101F215D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFCF8564E;
	Fri,  9 Feb 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XB/Pu4Vn"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36857339
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504993; cv=none; b=Dif0hZSpOsqF9Y+Kh0UXU6fJ3EbfsSl+hHLVwGN7V/8ke3+amW/87+uhyVWKtW8/GNB6k3A48nJ3oAfurEQs4/M2TWp9WueV7qOWAHtgJP5SHesse841UfAC8trSltaIth2CdaLP9cn3zTKXCXKX7RMQuSlnyuw74S/C6kQ7iiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504993; c=relaxed/simple;
	bh=jyq3Ou2zoIChrt4YF00OKCr8nhre49VBm+9l9qv0SqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lELzyKzyTMbP1wj6wx8rHM9dn3JBdb0qTQLxPEhVvCnUaZrYVJGRBFzhDUkFkE3JKKaD45YHylnptO3ZGnLqmQSN+3m9ekviA0h7pyT3DU2Tp9z0PEpD8NEcmA3wyS9pwJiH5PKnsS+QJu0KN9KHH9KiWdgur+1C5sZlls+MCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XB/Pu4Vn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so1855065a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707504988; x=1708109788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tAuVk7SJcg0Z9C1D9VIVQQXO8KJNkpgkmG6crijy/Y8=;
        b=XB/Pu4Vngv+/JFGRfr8J+55vfjciRym7m5SmLAoM/3U68VIRoI/r4OyWAz1IA0MesN
         xE6dedJdFW2rTj6JnZc7lAy/gcl5q5EjSqzDL/9wG+YTGifRzJob3rGGMGloiHNYaL5+
         rRPts5BG0b8L5XS461g5my7n45/wnnqaMYl6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504988; x=1708109788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAuVk7SJcg0Z9C1D9VIVQQXO8KJNkpgkmG6crijy/Y8=;
        b=WkIqjg9OjXQVhRTltSXlmGm15dKvUh06erl2tLKGIl6OVk7a0pr2AQ5+NdnINLBsyY
         NYiA5nq6n/rdhT+Yl9WFOAIgXA3Ul+26A91Z1kynViUbgMRY2yaMhx0bEAArYnuZR3gR
         OvAwtrYx+DcqrzNCrSM2guRVd0SEQTMGcQn83/jJ23eTwUJc1iugBK6lNxKyzRhYBZdp
         nJ7uObrCUwfQAKTZN1LGi7zE6RJeE+TQa/Ow1ksQZyNqtW/rUYHAykB3NLQN6Q2luMoS
         OJB9JM5MHnuWPbr6P5OARKauiTes5ifIfLsyxEXuivEnIDVa65La/5YcbqjGJ3bbpmi4
         2eKA==
X-Forwarded-Encrypted: i=1; AJvYcCWkxL6la2MEySTDmbl9h6NpsDJfTZ0wsUD0eeAv3qIW2h2c+o+z2IZYOPVaa2s6dcfkq0Hr7Gkg8h/NfIC1YNm3kp9xh5qocqHnsXIT
X-Gm-Message-State: AOJu0Yww18zBZECs/FlEBlu4LX6ldxNiQGhNye3gLV4mUX3Xhx9DnlBq
	9eoW9lpMNVjtQRkYMGNIW0XbUgfATGWyjPeYQ6wiy9/CWGI/iLZb5aFh8XNLCMfX2neOlGp3TZp
	tYEU=
X-Google-Smtp-Source: AGHT+IFR6oABj3yt8fZrmywM+tJQMkCKbd2FEPmALZ/3IiltFvQ4Ki2CSLHe1vt7TJzfnituPnZXQA==
X-Received: by 2002:a17:906:c298:b0:a36:5e34:3a34 with SMTP id r24-20020a170906c29800b00a365e343a34mr2186776ejz.69.1707504988603;
        Fri, 09 Feb 2024 10:56:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzSPuxsPeXebINNqmnowZb7ZDSEHc21I5uKkbTR4B/IWqa/3O8IWqxObtDIahSyFM/tr2YssGKFa8mKHf8bBF246kCggH1zvBTen5f
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id wp2-20020a170907060200b00a3702ab71f6sm1019761ejb.206.2024.02.09.10.56.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 10:56:28 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so1799632a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:56:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU58JshA4ZiywW/L9GjyvWUpDFB6OgD/a4JRWM4jx3hP/I8sr/FOFnoOB/BrsgNvhOo7g69ITCCFuztLF9RPK0JzEbWE0W1jUKguSJb
X-Received: by 2002:aa7:c6d8:0:b0:560:bbcf:1f45 with SMTP id
 b24-20020aa7c6d8000000b00560bbcf1f45mr2004566eds.5.1707504987581; Fri, 09 Feb
 2024 10:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com> <ZcZyWrawr1NUCiQZ@google.com>
In-Reply-To: <ZcZyWrawr1NUCiQZ@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2024 10:56:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGn5j-1whM66VWJ=tVmpMFO8Q91uuFAJUXa5hG-PWdxA@mail.gmail.com>
Message-ID: <CAHk-=whGn5j-1whM66VWJ=tVmpMFO8Q91uuFAJUXa5hG-PWdxA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Sean Christopherson <seanjc@google.com>
Cc: "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 10:43, Sean Christopherson <seanjc@google.com> wrote:
>
> > We've removed that workaround in commit 43c249ea0b1e ("compiler-gcc.h:
> > remove ancient workaround for gcc PR 58670"), I'm wondering if maybe
> > that removal was a bit optimistic.
>
> FWIW, reverting that does restore correct behavior on gcc-11.

Hmm. I suspect we'll just have to revert that commit then - although
probably in some form where it only affects the "this has outputs"
case.

Which is much less common than the non-output "asm goto" case.

It does cause gcc to generate fairly horrific code (as noted in the
commit), but it's almost certainly still better code than what the
non-asm-goto case results in.

We have very few uses of CC_HAS_ASM_GOTO_OUTPUT (and the related
CC_HAS_ASM_GOTO_TIED_OUTPUT), but unsafe_get_user() in particular
generates horrid code without it.

But it would be really good to understand *what* that secondary bug
is, and the fix for it. Just to make sure that gcc is really fixed,
and there isn't some pending bug that we just keep hiding with that
extra empty volatile asm.

Andrew?

                   Linus

