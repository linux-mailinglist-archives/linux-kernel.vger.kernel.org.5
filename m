Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E767EDE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjKPJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:55:20 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE01AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:55:16 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7afd45199so6825567b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700128516; x=1700733316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baj28rj0m1kOuDCTG+0KHDcj/t1NS6y3cMo9+0jrJJc=;
        b=vf0P6XS1GURBv+HM2aCIjFay7hHaXB+l4txiszJOIazULgEYbTpPZ1Up3L1eNW0Ccp
         6Dxs+ek0YrjL7q41pB6nROmWoaHpFUg/w83yGnlzsjz3m/djJq1Wa2Gc7bztkkYlOWhu
         esR3Gg5TSkWdQFUEWgm0eN6VyNFHT7zJXSYDFPL/AdP3+JxGc7Uw0A56WveGIZN9yPy/
         qmcciiVpbUxy1FIUD/UXPFGZLntDYdp76fnv85TvWI+BQ60Fm5sAhFVnWIe5AtsF2bNb
         FZJ6OUsbI0m4luXUvLPyi40JKDRqn8AowpHgHQn4hyrBq0Bl8dBmSjiecP5PRqphe6Gi
         cZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128516; x=1700733316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baj28rj0m1kOuDCTG+0KHDcj/t1NS6y3cMo9+0jrJJc=;
        b=TL6lqj48YeUFCz+TqlaZli498LcBCqEbiv4rJmXH/VUb8ZaNeFz0VhXTVy+kvRgw9y
         Qc4ETOBYgmRe+gqKXWyzCc5qdqzLL0VFcWKRXVUL9K77MSOcYcvle5sRJdkVEU868/Cy
         xQEo7bmcc2c25BqnH/4rzxEJTPuhzp/YuD1SVhWJn07QbiHgqodBtP13qRvCvbCDgiH3
         iZUUaJbd91AMufxijrcGrMTJF5LPyRG79wBXXWIK/u6FhomUOu0KU5Pirqr2gPKHBPXr
         PJEJopVXGbh2HI24HK/zWwNPL8+vkfOxVlzlSmkW9OG4EWha12kN4j9PU032VD3tblIW
         MMPg==
X-Gm-Message-State: AOJu0YzHL1J8w2Rc0rN5vMZHiyLYCbphsmB4LljYQB/FgQ203ebwkqzj
        Q9tAL6Cr7Bpch64lib4S5E1wnEiNxUGA/byXid+m/A==
X-Google-Smtp-Source: AGHT+IGkV65U7kgr5HXaKsUiw7kNWRKCsWMB345P39Pcp5E8uxIJFkGoztPTLYzdOJALjwOludoSGKAWKBy3ss7ZSGU=
X-Received: by 2002:a25:7a81:0:b0:d91:1296:947 with SMTP id
 v123-20020a257a81000000b00d9112960947mr13819109ybc.40.1700128515815; Thu, 16
 Nov 2023 01:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-15-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-15-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:54:39 +0100
Message-ID: <CAG_fn=WSq_r5ry-0uviR6CUx-6eqXo5tqCtYAL0nE3UYyA4=pg@mail.gmail.com>
Subject: Re: [PATCH 14/32] kmsan: Use ALIGN_DOWN() in kmsan_get_metadata()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
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

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Improve the readability by replacing the custom aligning logic with
> ALIGN_DOWN(). Unlike other places where a similar sequence is used,
> there is no size parameter that needs to be adjusted, so the standard
> macro fits.

Good catch, thank you!

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
