Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48C774FED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjHIAmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjHIAl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:41:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B81995
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:41:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f38692b3so6196339b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691541717; x=1692146517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gO70/E4EaG4t7+XkuG0UPt3Gj33okm9THhusBvGtMF0=;
        b=k7wLKeBM6labbIjgfzhnYc+u3rrEg6qAh4FoPMk4G4C+OPk78v0vfyUYD1F7DKjnnn
         npLRG+4n+4LZH9AwiWu5tqP75GYbz/m4F8Pd/vK9hNRwG6K2uDLkfbnW5DjAq45h8ynS
         EdpQjuJNUoQOqWiuCbCh0dVdnDOdIhoa9InBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541717; x=1692146517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gO70/E4EaG4t7+XkuG0UPt3Gj33okm9THhusBvGtMF0=;
        b=WrS0RMFB7wDYpN8FFhiqDIWgD6mau2IKac/Kj3b2oxTDE878jSFaaX5v0NGzn0teDF
         UsdIUIEZq95s0j4gzsVveE1zm1d1QDjkOYepphK6CGEEBRszYqjfPxp7dMtIf/uaVQRJ
         Md7JhXEChTbj1jKl0CrEwKPSHwJhouunSQwa0QCf9FEjeKG9zlUGAsKqyBourh1xS0U4
         y3dbK2hqPXUlIri0FfD50wcToOniI4mLmEIuSgxMHwDh+a/kvp2rOWtdWUVlFwEN54X1
         4Z6RCLmWf85eeQ/ani54Or77QB3Oq/MNFJLf0XAmzrmlfgKvQ5FESxqYOvsFpfx/9gGI
         UmeQ==
X-Gm-Message-State: AOJu0Yzr2sIn+h/uM0NZfBDhwZe509ZyXHFDb6g428cHfhpzojdsYSUO
        MXDw4WysbhrveOBLn9hniqlfmQ==
X-Google-Smtp-Source: AGHT+IHUfGme03tY4sw4mZxOh2mRx8YqmqNpdDuu11qg/Cqnc0DIUC6MT//VqcDAxNmuy9HVi9DmIw==
X-Received: by 2002:a05:6a20:8e09:b0:140:a6ec:de6b with SMTP id y9-20020a056a208e0900b00140a6ecde6bmr1585165pzj.51.1691541717032;
        Tue, 08 Aug 2023 17:41:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902bd0700b001b3bf8001a9sm9606285pls.48.2023.08.08.17.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:41:56 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:41:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: refactor deprecated strncpy to strtomem
Message-ID: <202308081708.D5ADC80F@keescook>
References: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
 <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com>
 <202308071636.AF290F0@keescook>
 <CAFhGd8oSGJ5=fk58wOSgbuXX_VaP14q0Re=Xfom=rdOR6fT1rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8oSGJ5=fk58wOSgbuXX_VaP14q0Re=Xfom=rdOR6fT1rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:28:57AM -0700, Justin Stitt wrote:
> On Mon, Aug 7, 2023 at 4:40 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Aug 07, 2023 at 03:36:55PM -0700, Bill Wendling wrote:
> > > On Mon, Aug 7, 2023 at 2:18 PM Justin Stitt <justinstitt@google.com> wrote:
> > > >
> > > > Use `strtomem` here since `console_buf` is not expected to be
> > > > NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`
> >
> > How is it known that console_buf is not a C-string?
> There are a few clues that led me to believe console_buf was not a C-string:
> 1)  `n = min((size_t) len, ARRAY_SIZE(console_buf));` means that `n`
> can be equal to size of buffer which is then subsequently filled
> entirely by the `strncpy` invocation.
> 2) console_buf looks to be a circular buffer wherein once it's filled
> it starts again from the beginning.
> 3) ARRAY_SIZE is used on it as opposed to strlen or something like
> that (but not sure if ARRAY_SIZE is also used on C-strings to be fair)
> 4) It has `buf` in its name which I loosely associate with non
> C-strings char buffers.
> 
> All in all, it looks to be a non C-string but honestly it's hard to
> tell, especially since if it IS a C-string the previous implementation
> had some bugs with strncpy I believe.

I took a look at this. It's only used in that one function, and it's
always working from the start, and uses at max ARRAY_SIZE(console_buf),
as you mentioned. Then it's passed to mconsole_reply_len() with "len",
so we can examine that:

	do {
		...
                len = MIN(total, MCONSOLE_MAX_DATA - 1);
		...
                memcpy(reply.data, str, len);
                reply.data[len] = '\0';
                total -= len;
		...
	} while (total > 0);

It's sending it as NUL-terminated, possibly breaking it up. If this used
the whole MCONSOLE_MAX_DATA, it would send MCONSOLE_MAX_DATA - 1 bytes
followed by NUL, and then 1 byte, followed by NUL. :P

Anyway, point being, yes, it appears that console_buf is a nonstring.
But it's a weird one...

In your v2 patch, you use strtomem(), which is probably close, but in
looking at the implementation details here, I'm starting to think that
strtomem() needs to return the number of bytes copied. Initially I was
thinking it could actually just be replaced with memcpy(), but there
are some side-effects going on in the original code.

First:

static void console_write(..., const char *string, unsigned int len)
	...
                n = min((size_t) len, ARRAY_SIZE(console_buf));
                strncpy(console_buf, string, n);

The 'n' is being passed in, so it's possible that "string" has NUL-bytes
in it. (Though I would assume, unlikely -- I haven't tracked down the
callers of console_write() here...)

That means that strncpy() will stop the copy at the first NUL and
then NUL pad the rest to 'n', and that's what gets passed down to
mconsole_reply_len() (which is specifically using memcpy and will carry
those NUL bytes forward). So we should not lose the NUL-padding behavior.

Additionally, when "len" is smaller than MCONSOLE_MAX_DATA, the padding
will only go up to "len", not MCONSOLE_MAX_DATA. So there's a weird
behavioral difference here where the new code is doing more work, but,
okay fine.

I find this original code to be rather confused about whether it is
dealing with C-strings or byte arrays. :|

So now I wanted to find the callers of struct console::write. My
Coccinelle script:

@found@
struct console *CON;
@@

*       CON->write(...)

show hits in kernel/printk/printk.c, which is dealing with a
NUL-terminated string constructed by vsnprintf():

	console_emit_next_record

Technically there could be NUL bytes in such a string, but almost
everything else expects to be dealing with C-strings here. This looks
really fragile.

So, I'm back around to thinking this should just be memcpy():

-		strncpy(console_buf, string, n);
+		memcpy(console_buf, string, n);


-- 
Kees Cook
