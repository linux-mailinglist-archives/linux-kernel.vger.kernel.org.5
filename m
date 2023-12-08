Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A28080A9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjLHQvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjLHQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:51:21 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A92212B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:51:11 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a9febb2bfso13033716d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702054270; x=1702659070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIcp9jypYULc/a0PN4uogFYiIDljiHAuDtNHVxk71mg=;
        b=YDDwHLv7SUyZKqLAN3Dp3qQ2a+bpKXd61JPV9sC/ojIs/BY69CbfdAf/3HMmJtKvIo
         xOYIXIpEKPRmzEzOTeLerjXq1EUeuggZUlkssAXPSYqJsxVruf5wXoBgtC+qxQ+u1Nsj
         J+vN5onqVkCDgZ/PvwNBbjR8gaIbVE5Vf/xJu+HRU1F1RjxEprenqLznBT+SJPkW5DrJ
         cFFtkUTSQVtTcB8D4yTMp88UUD84FXuAawzAr4qaxMNjkeX8YlzjJggChl5AEVWPO1+i
         OEmcw7+vZgO8zYqBF2XfNMHgoTFGriK98bH+3ci++yyTgwB24VRQUs5Z+RI28GAjV5E1
         jEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054270; x=1702659070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIcp9jypYULc/a0PN4uogFYiIDljiHAuDtNHVxk71mg=;
        b=cD4Zoc5DuwOB9Lwzt37j3Q8vdvEX4ERMRqSFs6g85gWgGQHmZa3dNS532c07BOg19z
         61JSkBB0loHowYkQH9w+nWJ4xluXly8gBzFIrirkQvryrgz6srToCbRBPEsLqUdc4Q5p
         jbfeLSDlWxzgOtUf15wXeuswG+nBPnUEiVsGQ6BttiJHUxqQznvqzTBZ0RgWr6Psx47B
         NZ1MmmlyuecqMk+9kzNgSNs73opnt6piW3TY87Aq1tc2QbZ2q+3h9Zyzsbcih+6RZ1L0
         ZbY+JZBGwvOpg/vIhZidkG/F400VcTwIYgHpcjqM+C50kaByFVXHcSTMp0XMV9fvd3EM
         4LcQ==
X-Gm-Message-State: AOJu0YwgbLIDJBIdYp786ESNF6ZQ1F63EkeZY/39cUnDETXyR9TFL759
        bPvs2PV+KofqczM3oepIN2eYWWc/0/iBw9ExaazlIw==
X-Google-Smtp-Source: AGHT+IE/6Nwbhf4SS9TLr4ojb1XW8J/22KVeKosnXzUvx9TzWSmL9hJNlMtz5gJPuHi3WKCMxewFNFHWT3ygW1WZWRI=
X-Received: by 2002:a0c:ea88:0:b0:67a:9a7d:ee10 with SMTP id
 d8-20020a0cea88000000b0067a9a7dee10mr256389qvp.0.1702054270555; Fri, 08 Dec
 2023 08:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-19-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-19-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 17:50:30 +0100
Message-ID: <CAG_fn=XQkhecLYFmJugOG+GawvDQ5Xsj5fTRbOAhU8Z5CfsjPA@mail.gmail.com>
Subject: Re: [PATCH v2 18/33] lib/string: Add KMSAN support to strlcpy() and strlcat()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Currently KMSAN does not fully propagate metadata in strlcpy() and
> strlcat(), because they are built with -ffreestanding and call
> memcpy(). In this combination memcpy() calls are not instrumented.

Is this something specific to s390?

> Fix by copying the metadata manually. Add the __STDC_HOSTED__ #ifdef in
> case the code is compiled with different flags in the future.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  lib/string.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/string.c b/lib/string.c
> index be26623953d2..e83c6dd77ec6 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -111,6 +111,9 @@ size_t strlcpy(char *dest, const char *src, size_t si=
ze)
>         if (size) {
>                 size_t len =3D (ret >=3D size) ? size - 1 : ret;
>                 __builtin_memcpy(dest, src, len);

On x86, I clearly see this __builtin_memcpy() being replaced with
__msan_memcpy().
