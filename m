Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130480A53A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573920AbjLHOQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573881AbjLHOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:16:45 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19B171E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:16:51 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a91a373edso12000556d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702045011; x=1702649811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0j5IioITwyG/4BP+tqSeHc4KXtugt22zIQNy6+j6UA=;
        b=WrWRZwAtpkfw4vfemJLPRLJrK69voIyMiJCRba03O6Lnsm5A9G3nMKpU+uygsSIXpG
         V0fw0KAteakWBw3coannnaJ5ioNyd4STAfGc5lCI2EHXEfVv5V2vDkB1GrKG93BayMsa
         55Qv1t7HqdUNnkjTJX0838kjCXtfn97lc3FzyrJD8IB0HyUQ8xCLQ3F0UTy5bhYPGnAP
         RfYAERTM8yZsc4ce+ZvlbcgNbC6TWFZLRdouczS5e6VEJNvJUh8EguZWFFoM1u61faii
         F7Uga2X42hbYCpkIecybPcdjz5IwW8NBvBU7jWwfBB/OmH/kzcmk3BRYKfGBvkG7YGoR
         iRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045011; x=1702649811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0j5IioITwyG/4BP+tqSeHc4KXtugt22zIQNy6+j6UA=;
        b=H9V96DY3uUchzNwn9TlwBzZH3bdp7GtzIx7sD42RYdip9gI65OY1mNbTuLThqF375Q
         koMcgipjcQApBF8yh0Dwne/DgwK4rasgR8uWR5X8cnN6AYYeg5y3WcuqNEok4v4vQ6t9
         FplNMLiW88VkjN8rNLTXQrMdM6anskHxVsjNZ74yGS2MIBTX4gT+CsKBvvpkfKDZE9Xu
         5g2Nza6b8pDmk5OLNQEeb8l8oRh56FFnn4g5Z1lZmzOTU+jAMohyeeoNiHeAceFJKjed
         Po549GSVElRY3BSuPCidzOvShGXb9CTQXxpurhWxg8jJvLaJNgM7+RlFGwr6DYka+zcx
         vrng==
X-Gm-Message-State: AOJu0YxdFJjkOg07icbjQEjuNMWWb0u3aGi9s9hC8bBhgkR4RpkhCbjG
        L2MH+DgXlvNDUJCdS8IZyqPEvAyyS8/Cm0g8i4iwtg==
X-Google-Smtp-Source: AGHT+IFKfJa8W1iCMwjchi2t+lHUhYWH09qaDJjCUhvv9aw60UsIUANSwwIZQ5lRRrqoFrKO1oLXig0+0+CIwOJDPpY=
X-Received: by 2002:a05:6214:4a50:b0:67a:a721:8309 with SMTP id
 ph16-20020a0562144a5000b0067aa7218309mr3763142qvb.99.1702045010694; Fri, 08
 Dec 2023 06:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-2-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-2-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 15:16:10 +0100
Message-ID: <CAG_fn=WHf0t=-OJL0031D+X7cX_D25G7TG0TqROsT34QcEnqsw@mail.gmail.com>
Subject: Re: [PATCH v2 01/33] ftrace: Unpoison ftrace_regs in ftrace_ops_list_func()
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
> Architectures use assembly code to initialize ftrace_regs and call
> ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> KMSAN warnings when running the ftrace testsuite.

I couldn't reproduce these warnings on x86, hope you really need this
change on s390 :)

> Fix by trusting the architecture-specific assembly code and always
> unpoisoning ftrace_regs in ftrace_ops_list_func.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
