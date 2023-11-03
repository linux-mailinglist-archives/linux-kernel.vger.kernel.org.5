Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C27E096B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377584AbjKCTV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345958AbjKCTV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE14D6C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699039223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbdNnm6glXxbCyQwbEBZPF6AJpykiqEuJJGlXI5aA50=;
        b=hdxyfPm5MNgAcT3F7g/KU3bYIXdEvqhONrUnNGm+5U7vbfUXC247wPJaz3zQrpR23k2zcP
        X8Say60nUclZNMstPSppJ3h0RK9KK0Q43YFxpeHL8FKeEuK7HiavgQJJELjZQihA/1rd7F
        ZjOdoZmODHpOs4W4wjrxucbvavR4Rko=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-f-Wz3s8BMsOB2MhrNrLqag-1; Fri, 03 Nov 2023 15:20:21 -0400
X-MC-Unique: f-Wz3s8BMsOB2MhrNrLqag-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9dd58f58281so51545266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 12:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039220; x=1699644020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbdNnm6glXxbCyQwbEBZPF6AJpykiqEuJJGlXI5aA50=;
        b=QTxVAcxwhUtHE53TO/w0rRtwgcr4DTVU7okN7zLSt/auYOY/Tiks51PjV2yLtA7KWP
         tCVT6Sde/Bk0/ZUOU9vi7cWyg+mApX440+x3t0jy7P1g3GPOOeEEQsa9h/u7ii630uEy
         boblsQnJSr5P0pijEyQAsZ431muMbbMNZSpk78LFLEKbVRF4yFjQwzAGGboA7M+1yNkb
         WYj8JU0wgHUG7srQTNttkJvP81ASGyeHG5YZ9WJaKgY3EWGUBTLPwKTvAi/h34yOzMQW
         y5vthau6g1w1HD3yxwAgB2KOXYNv8ckH1GzrpU5HNmMS2DmT2PM8iDEgQSZiElOCV9vE
         b4Qw==
X-Gm-Message-State: AOJu0YwtrDc9Ref5RGBT8CHjrKqvNJg598bnXDjMpfWonZLXXN0CYHVy
        afNOCV/7d8O09OJ3GfL6x6H4p5m1zKUvNZbk0gDX1QA+rAYNGdDsNcUgn9mOwalxzh0ps7AtogQ
        arKKF18Nh9O3BVNKwiiBXlOnTZzcf7mBKmRRp49e0
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id do21-20020a170906c11500b009d263ab6d4fmr8437342ejc.55.1699039220549;
        Fri, 03 Nov 2023 12:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVIlIiqTO8tXZwIEKnjzqKfHT36dgMA9qvb6+IwjXIIIl9wGqAGV0UwCtlu6/BMDIefpRHV4mH736kQorZILo=
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id
 do21-20020a170906c11500b009d263ab6d4fmr8437329ejc.55.1699039220274; Fri, 03
 Nov 2023 12:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231103161635.1902667-1-aahringo@redhat.com> <20231103185414.GD8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231103185414.GD8262@noisy.programming.kicks-ass.net>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 3 Nov 2023 15:20:08 -0400
Message-ID: <CAK-6q+hQnTgmO_2qfNDzyYW36T1aH+a5q285G+Rfo+sN4dfEfA@mail.gmail.com>
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 3, 2023 at 2:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Nov 03, 2023 at 12:16:34PM -0400, Alexander Aring wrote:
>
> > diff --git a/lib/refcount.c b/lib/refcount.c
> > index a207a8f22b3c..e28678f0f473 100644
> > --- a/lib/refcount.c
> > +++ b/lib/refcount.c
> > @@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
> >  }
> >  EXPORT_SYMBOL(refcount_dec_not_one);
> >
> > +bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockpt=
r),
> > +                           void (*unlock)(void *lockptr),  void *lockp=
tr)
> > +{
> > +     if (refcount_dec_not_one(r))
> > +             return false;
> > +
> > +     lock(lockptr);
> > +     if (!refcount_dec_and_test(r)) {
> > +             unlock(lockptr);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +EXPORT_SYMBOL(refcount_dec_and_lockptr);
>
> This is terrible, you're forcing indirect calls on everything.
>

Okay, I see. How about introducing a macro producing all the code at
preprocessor time?

- Alex

