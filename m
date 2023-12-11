Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AAF80C547
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjLKJw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:52:56 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A208E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:53:01 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1ef36a04931so2989316fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702288381; x=1702893181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkurISIjMkn+2I3PnXKwVyMchslMNcfqaTJxR0Aia2Q=;
        b=udy+8h0q8QeRXLg6Y8Lf1YaXitekzhJ6Fuy8N8wiD1ZtVKdAj1LtzAiourNjqmAqx6
         tBJeWHglUuQFV0Gn2tT2iRpWaGKbRZF5awcJtJdZ3A46oU7GSFyvi0Gtl7c6q8T2uIPC
         p+NVuX9kKXc3lifBaXq34GtoBLQztFF3CYGJhOaJqH3/EIRkfD2iGW/sxUy3goEy1/WY
         EGAMzUAE+7tZR8wm6NraWDBqa3HcFqdrgJ2i9cBwANf/kFVxoyg6XA4x4MEtMKikxW90
         yPFn4vH9pcnBooUehdBW3XPsT96jXeftx59DcSwUUVTo3eHXydZ6fQhvr8PsI/QV7s1h
         /9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288381; x=1702893181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkurISIjMkn+2I3PnXKwVyMchslMNcfqaTJxR0Aia2Q=;
        b=SoGGi1jAmgazIt+4Gv8LUNguDYf/bQHWJYEEI0xNfM0G/rAOTtpz3A8JlRCx9At0KV
         Wl+GBUqFPOFla4aVHbng+O06L77gN8bNAZ5lW7gCBRJtkAm2+34ArPU0wjMq0l1VUhql
         8zkSl/2bTIvT+Oyltygs1o+5ZcvSkxNYcvBTw5mR8H/pWqila1tqWiKlHTAW4QVfyT1M
         J81p0o+x1WdwsDKCWeigmNllCqJo5JV6875pn7F3sgs42va8xksxaOia5HpSTRKJpJC4
         F7hmSZ+SJ+oVjRMDu5040Y/YHcyQeLtYrdegwkI7AAvshFkycBKNBHPzWneP+AQ/Hriw
         12kg==
X-Gm-Message-State: AOJu0YxldYBJj3O2lZ8FYNpO1LhIyV+nTzVSkwJp4EIfl9azd5Utuqp1
        3N8Y2wGd9RObl+HGBG3rvqYdzPk0M/4uhFMSQiEmTQ==
X-Google-Smtp-Source: AGHT+IHBzcyPtkbQDFQr+6LIt2oxnTSj1NsMCf/LD4g/EkcctNVYyjvt6+1REaXUAWomwb2Qz0o/56s8V04JUzAkCQ8=
X-Received: by 2002:a05:6870:418c:b0:1fa:406c:219 with SMTP id
 y12-20020a056870418c00b001fa406c0219mr4019357oac.28.1702288380928; Mon, 11
 Dec 2023 01:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-6-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-6-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 10:52:20 +0100
Message-ID: <CAG_fn=UZs3-J-ay9yOovUZZr60vbQz+HC0-peRxuKPvq6N5Gwg@mail.gmail.com>
Subject: Re: [PATCH v2 05/33] kmsan: Fix is_bad_asm_addr() on arches with
 overlapping address spaces
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Comparing pointers with TASK_SIZE does not make sense when kernel and
> userspace overlap. Skip the comparison when this is the case.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
