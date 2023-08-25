Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E9788D08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbjHYQNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343731AbjHYQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2F91BCD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26b41112708so695967a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979961; x=1693584761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3K9GAzZPmrf69JfCVKUGLeyRxUQaU+/aTKM9BOzOE0=;
        b=cYNfp9vLbjf8tVTE47Bc7cP/0E/Xwx0j7tnAYEARoRhzTwEYc0ufZryAlt1ur8TmII
         MLZkGn1N1dyP1dYJnuTjfLonzEgoEb0Yu+hTIQKnPlffIeyqIJhvG28i7kXPC5u0Ajcb
         FLgj2CoL7k6bdFRKEGMADSGtdhTVmTo4OahsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979961; x=1693584761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3K9GAzZPmrf69JfCVKUGLeyRxUQaU+/aTKM9BOzOE0=;
        b=TGfHXs3tjmy4FhbDKdXaqlR9F9dN9Y+WQ50l1xkTd06oACqf1gvkMdEVGe/uj8l67B
         FORF52j7cOQw/IvgvHuCmeww7uEuVuEk7QsJ2tGylIhXHm96o4/KAC6w+OAQEHsp8hlV
         LYVT5cf9m6ihe5ZT5TpkYt3MlanWDKVYT2q2W/KgPTVA958L14JOlSKg/aoo5XVqQ/YC
         jaqFL+oYMAgYnY6jxxkrCLL9MoKaP8Bk7tBQBvTS3i5wE4r0r3LUjiUdROM+WRudMAQg
         4G4AkcUxU59gjLslfavVZDZaSqX4i7yTNCdmkOcHdgr310YnmmiF0gJCOTyf5x99CJJ1
         3+Pg==
X-Gm-Message-State: AOJu0YxC7V+st2h3s3kGAinTvXKiiIsiXLFMqio2xFltn51WWyG/eXCQ
        KSU32al+06pkYGuVFtouEGqe5HD9hLfvpebFRkL7EQ==
X-Google-Smtp-Source: AGHT+IGVZOa2Il9SMW0TIYGfWLMiPG8S6YwqeylIfeo4abOQtStvAldvxSg6EWjVVD7VGXHSdNLWhT8f1dSEqXg4gbI=
X-Received: by 2002:a17:90b:1486:b0:268:1dd3:695e with SMTP id
 js6-20020a17090b148600b002681dd3695emr15524004pjb.49.1692979960981; Fri, 25
 Aug 2023 09:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280382895.282662.14910495061790007288.stgit@devnote2>
In-Reply-To: <169280382895.282662.14910495061790007288.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:12:14 +0200
Message-ID: <CABRcYmJcii6UzJR+jksg9SMYAYZRNqEhKoHp=V2xiPYh76Q2vg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] Documentation: tracing: Add a note about argument
 and retval access
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 5:17=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fp=
robetrace.rst
> index 8e9bebcf0a2e..e35e6b18df40 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -59,8 +59,12 @@ Synopsis of fprobe-events
>                    and bitfield are supported.
>
>    (\*1) This is available only when BTF is enabled.
> -  (\*2) only for the probe on function entry (offs =3D=3D 0).
> -  (\*3) only for return probe.
> +  (\*2) only for the probe on function entry (offs =3D=3D 0). Note, this=
 argument access
> +        is best effort, because depending on the argument type, it may b=
e passed on
> +        the stack. But this only support the arguments via registers.

supports*

Otherwise:
Acked-by: Florent Revest <revest@chromium.org>
