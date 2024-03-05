Return-Path: <linux-kernel+bounces-92798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C6872618
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D65B2A953
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3B217BC2;
	Tue,  5 Mar 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NG2exrpP"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609B179AE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661500; cv=none; b=VDWGsO9ChPTpjqYd7ySU6+7B1ZSgCT1kyD5LpiQPt1oJiDjJr1S9m10/udjamHETekfDVszdofK+JDuX6rNZu9NQu5k3PJatePScAqU6BSYE2bznhRv/LJTxey3X06SewRZeDfhMD8IX8AKpXe/dus6EZZXA5u89HUxPfYElh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661500; c=relaxed/simple;
	bh=vgsmr9tJ4N+iUmYsDzkiKcPorKbBR/Nr+bKBtk/siOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA8cilgZTC6SOl9F7IBcu7E2ASzhlzLeYc8ldgeJadirmSXYjRjLl4AJbwbFOnmao829RA2M/aEJb1mbifmPfJRdoyZ0lvCZ4/2mhPOtPMjX449QQo1vYML0XC2Ogz/QiK3OPtoTv28ZpPgvAQpzf9vcXqJpZDhvTpsnw7lVRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NG2exrpP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131316693cso7829272e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709661496; x=1710266296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D5YQCxQHduP3JvbhcqBfSHr7Q7jty3FaHYmIqmS0PXg=;
        b=NG2exrpPwVpkVgmIyWL/WlNXQ5Rt+Zkx3fjqEl2xGwEDuBYJnyTYrLdMzYetxqN9XZ
         VwshTKgZDZyIx1/4QHZflR44u9lc2DwGHxt+6Yy47NyQ0KyIo7KBUAUxskuen7BTiH/g
         z3dipIosQd13c+AqCuuAywzLvyqiQ8E5X+v8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661496; x=1710266296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5YQCxQHduP3JvbhcqBfSHr7Q7jty3FaHYmIqmS0PXg=;
        b=DJQDTbhys5wT+DBHEj7Ihwn/n9ST0q+cZDQiftub8Mtycwk9oerdlpkb+nEqu3G3de
         v954Tx6M8Cu5wnr18xQvqBGwvu37N8Op6wphXZtHUYci11k7bh02rtAyMd5EQvQcRU+W
         eXBg696Nx0UcUvejDRGj/3WD5dXGf3wk5SP6eeLXdPEyvEXX4+fYbueEZvCEeVBOnWp/
         nPxnG7c+FhscQ8uaGwlFHIB5pDNtOa0c2m7K9nqgt+iiw0MTjtgIlNcZ3xAvpaICsYTQ
         BrR1BiubldSh+RaBMhwTZJe+low9XagZeACa247hyTFTJ52VpjCGEe5A2e7VUm3ag+dz
         JDJw==
X-Gm-Message-State: AOJu0YxTSxlBWgEDNKV3iDOO+x19tQX9ZRQB690WOpYvACuWxQ8i+D+F
	A1BshWRrMdCZDQjFBiWaJHHywx3ue0gjGkKCqis6IZbOdO/WbRYPsx8hebcFvmasfTiZ4dB5eIY
	83ob0mw==
X-Google-Smtp-Source: AGHT+IFPlvaDCW5UCaSCPYuAFb6nc4i/aEWdsegHuo7HEPvfoe9RJMukmOEzj6XmQ8eopaol/XtzPA==
X-Received: by 2002:ac2:4c8e:0:b0:513:2b10:cc28 with SMTP id d14-20020ac24c8e000000b005132b10cc28mr1765096lfl.9.1709661495669;
        Tue, 05 Mar 2024 09:58:15 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f12-20020a05651201cc00b00513360ebd22sm1677868lfp.118.2024.03.05.09.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 09:58:14 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513181719easo4166700e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:58:14 -0800 (PST)
X-Received: by 2002:a19:5509:0:b0:513:33ac:fe61 with SMTP id
 n9-20020a195509000000b0051333acfe61mr1884324lfe.60.1709661494071; Tue, 05 Mar
 2024 09:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp> <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
In-Reply-To: <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Mar 2024 09:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGn2hDpHDrgHEzGdicXLZMTgFq8iaH8p+HnZVWj32_VQ@mail.gmail.com>
Message-ID: <CAHk-=whGn2hDpHDrgHEzGdicXLZMTgFq8iaH8p+HnZVWj32_VQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

[ For the KMSAN people I brought in: this is the patch I'm NAK'ing:

    https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/

  and it looks like you were already cc'd on earlier versions (which
were even more broken) ]

On Tue, 5 Mar 2024 at 03:31, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Ping?

Please don't add new people and 'ping' without context. Very annoying.

That said, after having to search for it that whole patch is
disgusting. Why make duplicated complex conditionals when you could
have just had the tests inside one #ifndef.

Also, that patch means that a KMSAN kernel potentially simply no
longer works on admittedly crappy hardware that almost doesn't exist.

So now a debug feature changes actual semantics in a big way. Not ok.

So I think this patch is ugly but also doubly incorrect.

I think the KMSAN people need to tell us how to tell kmsan that it's a
memcpy (and about the "I'm going to touch this part of memory", needed
for the "copy_mv_to_user" side).

So somebody needs to abstract out that

        depot_stack_handle_t origin;

        if (!kmsan_enabled || kmsan_in_runtime())
                return;

        kmsan_enter_runtime();
        /* Using memmove instead of memcpy doesn't affect correctness. */
        kmsan_internal_memmove_metadata(dst, (void *)src, n);
        kmsan_leave_runtime();

        set_retval_metadata(shadow, origin);

kind of thing, and expose it as a helper function for "I did something
that looks like a memory copy", the same way that we currently have
kmsan_copy_page_meta()

Because NO, IT IS NEVER CORRECT TO USE __msan_memcpy FOR THE MC COPIES.

So no. NAK on that patch. It's completely and utterly wrong.

The onus is firmly on the KMSAN people to give kernel people a way to
tell KMSAN to shut the f&%^ up about that.

End result: don't bother the x86 people until KMSAN has the required support.

               Linus

