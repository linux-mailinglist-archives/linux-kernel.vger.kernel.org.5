Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C3806E24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377701AbjLFLhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbjLFLhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:37:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A31DD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:37:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso4296775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862675; x=1702467475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UsKZRR7fb35TZGm9xzU+NNHL9tg4Q2nzB0Mt74LhSX4=;
        b=aWHzB67HWlNZRZogXA9OZ7sLsBjI5xY+Gz2o2kO+y0Au6TJfeBL+XAwHHGnf4Te5Lk
         iIivZlFDDlrKu5llEmWU/g/K7v7H3YkMhDnFR1VTd9inPqGVE0YvVeWhxTrtvFYjy9v4
         IZ1zTjk2+f3K5glsXDNGf+Q1HBncRzdXdxv4nAiLjN5pUZnpP1GDFZLwD+6Vc9KPTRgP
         pTUjHj/dpBXmT1VxfxH5VhI4AOZiwfKS8SWgyOrX2D5eifY+9gYRxHkYje/0s+hzUztF
         gj30LtmbBKzdDcwpQCiO6IDXhecPdHCdpmgRqjMCJFCsWo84LgGnotELeDMDBsAxmkbN
         te3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862675; x=1702467475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsKZRR7fb35TZGm9xzU+NNHL9tg4Q2nzB0Mt74LhSX4=;
        b=W+pDVRRC7GPoxi8rtJV3tBTfBMeR2B6VPKNEBu8ohEvL7EnmOreg0t6O2yerfm8bzu
         JjNikuCBPXEgWrFaxc9imvGvubrzFHY/6yN8Rit9hM7kvq9X4ICBxWDwlO0t0DKC40xV
         3PZuzHCV5f6l6PRUU32SFYfjF8Fq7h1m5oqcQZspU6s67iV34sYSDAINK6Vy8IWoKMz4
         cHZOe8bBkxxtbj2tsAdWH6YxkgxXXVOysbVuVkCTPmQVsbeYvSzn3qLnU4tjPz808zUP
         dnv78ZzfA4zJAKIa7NOnZ0P8H9R2nJpixRoEaruVuAVBRlA8uWAQqWOgCIYU+RiUEdGi
         aMDA==
X-Gm-Message-State: AOJu0YwKR0uvaxexPCjViLYg2fP5d/+WhWnzSla5y82Y4x6Jaqd3FYjX
        7C2+7QPYGYUuRffPPUNzM+LLrQ==
X-Google-Smtp-Source: AGHT+IGtAUsYbhUVYEL0MZxwr4M0sLnELDMNsFle3FJdHz2OEGubCuMsgvDyo+NQ/Uio0wU7tRjUGg==
X-Received: by 2002:a05:600c:4749:b0:40b:5e26:2379 with SMTP id w9-20020a05600c474900b0040b5e262379mr1281084wmo.42.1701862675544;
        Wed, 06 Dec 2023 03:37:55 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b0040b54335d57sm17055244wmb.17.2023.12.06.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:37:55 -0800 (PST)
Date:   Wed, 6 Dec 2023 11:37:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-trace-kernel@vger.kernel.org, jason.wessel@windriver.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] trace: kdb: Replace simple_strtoul with kstrtoul in
 kdb_ftdump
Message-ID: <20231206113753.GB81045@aspen.lan>
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:41:57PM -0800, Doug Anderson wrote:
> Hi,
>
> On Sun, Nov 19, 2023 at 4:10 PM Yuran Pereira <yuran.pereira@hotmail.com> wrote:
> >
> > The function simple_strtoul performs no error checking in scenarios
> > where the input value overflows the intended output variable.
> > This results in this function successfully returning, even when the
> > output does not match the input string (aka the function returns
> > successfully even when the result is wrong).
> >
> > Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> > simple_strtoul(), and simple_strtoull() functions explicitly ignore
> > overflows, which may lead to unexpected results in callers."
> > Hence, the use of those functions is discouraged.
> >
> > This patch replaces all uses of the simple_strtoul with the safer
> > alternatives kstrtoint and kstrtol.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> >
> > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > ---
> >  kernel/trace/trace_kdb.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> > index 59857a1ee44c..3891f885e4a6 100644
> > --- a/kernel/trace/trace_kdb.c
> > +++ b/kernel/trace/trace_kdb.c
> > @@ -96,23 +96,21 @@ static int kdb_ftdump(int argc, const char **argv)
> >  {
> >         int skip_entries = 0;
> >         long cpu_file;
> > -       char *cp;
> > +       int err;
> >         int cnt;
> >         int cpu;
> >
> >         if (argc > 2)
> >                 return KDB_ARGCOUNT;
> >
> > -       if (argc) {
> > -               skip_entries = simple_strtol(argv[1], &cp, 0);
> > -               if (*cp)
> > +       if (argc)
> > +               if (kstrtoint(argv[1], 0, &skip_entries))
> >                         skip_entries = 0;
> > -       }
>
> Similar nit about braces as in patch #1. tl;dr is change the above to:
>
> if (argc && kstrtoint(argv[1], 0, &skip_entries))
>   skip_entries = 0;

Surely that should be:

if (...)
	return KDB_BADINT;

There seems little point switching to a "safer" API if we just ignore the
errors it provides us.


Daniel.
