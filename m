Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE8880A541
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573930AbjLHOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573881AbjLHOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:18:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2822171E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:18:53 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77f3159d822so88937285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 06:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702045133; x=1702649933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4aUU7dNjS/w6j2yOU1hBuNM/NL6fqAI1SOBM3IICMA=;
        b=sosVTcFyu2GzDo3ZpJ9JYMr9x8cL+nfMjaYe5l6NX8B6UjAvCK8scD//SXdLHsQqws
         8jver1uwXhTGs3Brw/1qWLHLetD5hgsBf5HaZTlga6jQWFov3IlLaBKBU+g/++aPAvka
         IkhhPdieQJvvQduKvns0CaQ6/T1tVGY7TVWPzKdgWurcQ+bqI3XAVicUoqyyXYeES7Yr
         sy7h2SbV5iGg5IC/090vF8bmTMkF1ByDo0Qhtgg3TcDBqOqm7apNDxsla22HOA4c7fl0
         W03DqmLDlqNMuXrHeiy14+TMGkKSbv9dfog+IzqfpOO/JlXiLVEPPaxhI94SW8xe9ml5
         lB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045133; x=1702649933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4aUU7dNjS/w6j2yOU1hBuNM/NL6fqAI1SOBM3IICMA=;
        b=BbLeXupdYNpGq+VEbl60Rt3oK3nXJApKNTdAwMNfMFnbYV59duqE3KFoCCvZplo2tP
         7A70HU1j4d148ib8psgLC8eNxb2Y/JPMUgdixh9BqlioScypudLaTXsyPFj73ss1FVmu
         xw4bpizis8Zrr8i700aIgGLVHuQW/oFmIkeVEao+9V0CjlYeQyRbsTy1PYnKdImMB+E/
         w1LPSbdG5vjYB1GvztqvB8VvXziNtOfTR5/35aZ+24Y+4wHgq6Ufi0TychIFkGs2lKIM
         oR26Bgj8VvT2fN+NrstLq8RauWPz2j0n6Kn9J3CgtVQezHVUqGSsFHmCgzJjq1jENXFq
         7AmA==
X-Gm-Message-State: AOJu0YxS+ZAXO7Z1MUBZWj5yFo+Tx2riA0blw9+hyVTiY5VVF3C1Jt8t
        h+u1T5hY6r2EP2+sku/oJkdMLNgNIMhoBHrYtETPUQ==
X-Google-Smtp-Source: AGHT+IH8EMqb7H0OjwmlXGKXc/KMyqDWbzvWyGHpM5I7Qm/vaxWs0Al1SPzWhhi4fZH80FWJcx2+zkplz4DLr+7aWfs=
X-Received: by 2002:a05:6214:1023:b0:67a:be9a:e9df with SMTP id
 k3-20020a056214102300b0067abe9ae9dfmr23702qvr.17.1702045132939; Fri, 08 Dec
 2023 06:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-27-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-27-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 15:18:16 +0100
Message-ID: <CAG_fn=UBaF8SnvJ4t4wbBZKbNEBWRyGBY=FA+CTB+k2+pa2qEw@mail.gmail.com>
Subject: Re: [PATCH v2 26/33] s390/ftrace: Unpoison ftrace_regs in kprobe_ftrace_handler()
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
> s390 uses assembly code to initialize ftrace_regs and call
> kprobe_ftrace_handler(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on kprobe_ftrace_handler() entry. This causes
> KMSAN warnings when running the ftrace testsuite.
>
> Fix by trusting the assembly code and always unpoisoning ftrace_regs in
> kprobe_ftrace_handler().
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
