Return-Path: <linux-kernel+bounces-145750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FCC8A5A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1F11F22FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1A155A58;
	Mon, 15 Apr 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f7WPDdUE"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9C155A37
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207997; cv=none; b=UxH4cXDp+dgLfBO1k/XwJ2CHY4YiIrJhxpl5i0TK4XZvwt2Ybnf7l3GHnp9U/BaRenJXQcNorxSweLw4G+k70t73W3iFKi5Vx4Lq9GP5MB/UZ6sGPTtJM0wQbE1eGIjVBppI6hYb48H9oziaDEwFLAg4joxbObNT1NpiOxFTsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207997; c=relaxed/simple;
	bh=m0cv+vQ4FxsfF8+H/JsI6f1Z4BEinsqnnKmlS1cGG5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE2v6Z62jK2bf13uBS2O2GHPgKQ3rKgp2jeFQ0QbjN9h1NW3Aum5HLywAA2UcfKeTXW7dhBAs9TrUnVDNhQ7PCwLULtgJRVLROsuecYtWWs5yO7HbMsx/+oaRqwhCZML4pKzH8r1yvcY6jCCMffeR4bGYvyxfHH8hehwS7FbkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f7WPDdUE; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa22ebd048so2695476eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713207995; x=1713812795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+R/ybS65h0q9J8q+4GnE188fVdCairXnx6GTX1PC9g=;
        b=f7WPDdUEMQ9/mrxAdxUVprhRElk7OuaHb0kE6X3Fs8T/bRw0Rn6tlLGxDeYlZSt/hs
         5cU55log9yZMPbz+Cbaa6sMVjhO3xmYIjvsZd+5slrUk9sqZDxTvkh0e8T42E33Y7/SM
         LgTrBQ48Zs1nHvc4sSPvD8Ay9/Bv7b66EvyyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207995; x=1713812795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+R/ybS65h0q9J8q+4GnE188fVdCairXnx6GTX1PC9g=;
        b=H3Ksh939KAb2NXKdyfg0Myyn5ce7HBANCDdYdn2toZ3wm9x9iufZ3txnZsUaA1W8gb
         vx75Uv8lA9/A4+po+tP0FhREaGZ82hBWFqkqgIoPoSaHrc/T2fNdlWodzJRvCIHCgbvN
         NWOv3SK5JX0l7RU6mE/iXAebGXec80Zrah1EX/p8QNZyL/tM7QAdJOLwYeyMuNueFgEG
         aGYfVq0AIgPPnQcLyYr0b0SNPpoio3Ia/Tsdr17Ltcwq5tn0v0e7sh2BFvhoO825ivVG
         +0yNSOvi6BlhtLefQiyZyxpGs9J+M5ahwSjTlMFm7iuYOYwoEHM5iQWPifH/W7xgYD69
         B6dw==
X-Forwarded-Encrypted: i=1; AJvYcCXg/chxX9ckKt0+zm93NOtbJWI1VKvgJxBCVglzv+QO4FpJFXZ637fyFaT4gxCIjTg+vZHdzocNpMKO5Pw7hE/n5+8CJ5ILrYE5ctPe
X-Gm-Message-State: AOJu0YxL3euNZ/HrKhTqHJXq5sO23/oy9R3sHkOPwvSRxnvsazHDVGH7
	7vvm4I2miHnhceyQqrILYBmuNCDMU6ABplwXI1a36R0BI3md9xxb0ocsA2gHCKaxt/IhjQ/pkcW
	hE4EezHdJg0Remxag6e2Ya8hkgb33tC01E7N6
X-Google-Smtp-Source: AGHT+IFeZVlFC3hebTTY0W9m7/2weeINMaNykhc3VQBObIAt9ccZjDkiZxllqsbIVZX9tMYAc1TB6JHY+I3uT3kYIW0=
X-Received: by 2002:a05:6871:58aa:b0:222:8943:df2b with SMTP id
 ok42-20020a05687158aa00b002228943df2bmr12366733oac.16.1713207995078; Mon, 15
 Apr 2024 12:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-2-jeffxu@chromium.org>
 <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com> <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
In-Reply-To: <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 15 Apr 2024 12:06:24 -0700
Message-ID: <CABi2SkW+X4+m2odCHKVDzYYWPgvebxX_mr97NsKCRfkx641sHA@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] mseal: Wire up mseal syscall
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, corbet@lwn.net, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:21=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 15 Apr 2024 at 11:11, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> >
> > It isn't logical to wire up something which isn't present
>
> Actually, with system calls, the rules end up being almost opposite.
>
> There's no point in adding the code if it's not reachable. So adding
> the system call code before adding the wiring makes no sense.
>
> So you have two cases: add the stubs first, or add the code first.
> Neither does anything without the other.
>
> So then you go "add both in the same commit" option, which ends up
> being horrible from a "review the code" standpoint. The two parts are
> entirely different and mixing them up makes the patch very unclear
> (and has very different target audiences for reviewing it - the MM
> people really shouldn't have to look at the architecture wiring
> parts).
>
> End result: there are no "this is the logical ordering" cases.
>
> But the "wire up system calls" part actually has some reasons to be first=
:
>
>  - it reserves the system call number
>
>  - it adds the "when system call isn't enabled, return -ENOSYS"
> conditional system call logic
>
> so I actually tend prefer this ordering when it comes to system calls.
>
I confirm that the wire up change can be merged by its own, i.e. build
will pass, and  -ENOSYS will be returned at runtime.

Thanks Linus for clarifying this.
-Jeff


>                 Linus

