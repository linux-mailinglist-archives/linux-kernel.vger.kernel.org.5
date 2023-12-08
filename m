Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2380A9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjLHQ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjLHQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:57:01 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94EE98
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:57:05 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67acdcb3ccdso14273936d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702054625; x=1702659425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7eBdMYz2oO1gCYv2gO3b03vyzDyBixdRfjwy6xmbYk=;
        b=PmK2XbxCIv3dIWNCXiX6whjWumGAUc6xF5Vo/I/DNguZMP6/AsTyAAF33DgKQjsU69
         Hy+a+8Vsqf1eFR+dvvO4N0R8iA3lHLf2z2xLk2ioso4X+JVX7PvxpNZk9aA861nTMOGC
         ozE1gdUK5vTQESIwfQS8jZHFUp8l9inF7ABOzL1Q06E/iNKqmcDt80fC495/+NtimrBa
         PkeRnJKPT8ws4rzxnaIZVHfwnvDf0NtKq+CoACtgp7v+RMfUSdJv4tCLgrf46MJ4eATg
         oiopZPdry7Iuxvi2BJFBMxINisVddJ4Ue5X1R7GgwP/WJppiEA2XEMD7yYx8/KMD50y0
         XnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054625; x=1702659425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7eBdMYz2oO1gCYv2gO3b03vyzDyBixdRfjwy6xmbYk=;
        b=byfixxc3wPQTkvyudQDr2sAHGJPboDNqiCovpDI6Aug3myJype3+sDLFKtLCMs86+e
         ZZN78WrpAUXtBLmmZ3qC9wzpPyRZBVSj0UGJAkCi+iygJnLNQjbSRtttT9UXm8gq8HHC
         wrB+cURh/t42CT/+b3luVlnUoNSMtESLd/nsN5SwSGyhVdaUqBCOhsA644IdCMHtq5xj
         wiwDztBzzcm1/pfN5NPlffh7So60e87/ym+mlBhp+azMh3XZfasqpbWnh7vNzMeDIn53
         R/vSGW0wA0d2B3QwIFMJIvztD8/++QplaHqgLwSolvNka1xB4kIMIKJ2L7VIcIbb+zFF
         T0Zw==
X-Gm-Message-State: AOJu0YyTGJyZSwkcp23FQtkCgP0FLlMRjQ53LiMUgIvVDkdnYmW8sMao
        DHrNHvi6h5HHmTQ0dlklohkghatMT6SS8FFz9ByICQ==
X-Google-Smtp-Source: AGHT+IFqYgMXAGDwUGZm2GmXNNwAMogbqw1hEfBIGvEGXG3bN5nU/GorXmHvariAzFFNL09Kz1paH2mUu+0Ssar9SoY=
X-Received: by 2002:a05:6214:d0:b0:67a:49c5:8cc3 with SMTP id
 f16-20020a05621400d000b0067a49c58cc3mr269853qvs.32.1702054625028; Fri, 08 Dec
 2023 08:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-24-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-24-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 17:56:29 +0100
Message-ID: <CAG_fn=UBt2A75bOgZmh7q_dS08d0PD8wJRHpoJyUDXRPRk_exA@mail.gmail.com>
Subject: Re: [PATCH v2 23/33] s390/boot: Add the KMSAN runtime stub
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> It should be possible to have inline functions in the s390 header
> files, which call kmsan_unpoison_memory(). The problem is that these
> header files might be included by the decompressor, which does not
> contain KMSAN runtime, causing linker errors.
>
> Not compiling these calls if __SANITIZE_MEMORY__ is not defined -
> either by changing kmsan-checks.h or at the call sites - may cause
> unintended side effects, since calling these functions from an
> uninstrumented code that is linked into the kernel is valid use case.
>
> One might want to explicitly distinguish between the kernel and the
> decompressor. Checking for a decompressor-specific #define is quite
> heavy-handed, and will have to be done at all call sites.
>
> A more generic approach is to provide a dummy kmsan_unpoison_memory()
> definition. This produces some runtime overhead, but only when building
> with CONFIG_KMSAN. The benefit is that it does not disturb the existing
> KMSAN build logic and call sites don't need to be changed.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
