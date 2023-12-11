Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148B480C709
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjLKKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbjLKKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:46:53 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99558130
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:46:59 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67aa0f5855cso17465776d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702291619; x=1702896419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbONbDTwPKE3MiL/eslKI++k2YglZ6miec7hwk3eDBk=;
        b=dEzGdL7xlsXH7EW80M8rGghMQumaP3K/HrcnondofZ92PBvX8AaCloCQeoqF5Oaj/e
         ULWt6O+3bKyauH/UFXMlKz6jp+L2yV81Jdm2qhNtmaQO7YZYfeGqYYK27qiViP08fc4t
         +aoHzfs9g5cT4R8xx+bsUJL57zR/hXlqJP2/h5JwpcogXcsb+4fOaRpvfzMCRPMZq/t9
         J7FLUhsE7q1ITm2IXEZR1fFZsPJcJD/hQWO6PRb7QtwkAB4U/tXvaSfbKx+fERn6Rwv6
         1kfoHUFmRDMrIip/3t1PW4Qs/0QxTx3QorOCqvh5wzdMahgmJ6qpzshkEywnpQYanMsv
         jH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291619; x=1702896419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbONbDTwPKE3MiL/eslKI++k2YglZ6miec7hwk3eDBk=;
        b=qd2VreDRZUTCqrOEVhgm6bCQE/TGycAICKjt3s342Usec/KTjJCyaTdhXVE0bZyaPH
         KvmrWsegVe2fUb8bqs8WUYh+91SrY0PYHU3P3Fp6qr9P79xNynfL1OmBEgH8K7GyxQvf
         lvgDOTbrWDQKhbQ/3GbjU9d/68QmxIPpQgTCH/XNVXLiynXIXPG0+niDowgpk3a5jiGi
         wXkAcHYWrAvvoZOhGsphJREBkJaDAWQfk9F69LCI21liRAAsdrVPgSYL65IJAFU+9tH1
         nfL9cS/H6p7gvQWkZiFcXNdQpyiPLshK4oo4LMEZfdBl4jZtd75PsWlmWXi6mQSPijc+
         PYHw==
X-Gm-Message-State: AOJu0YzojfBIg0R3ugTB1CfQoDJfHUBPg8Icb+2tyVJC6WNHk7JsyKl8
        VSWE14dgoHfxeBnE4ytHyCi0zjrnmMrhLMxTeaVIkA==
X-Google-Smtp-Source: AGHT+IE5iESTgLHPyjCFsdOQibZaw2Ip1V5W7Ud/9oJ2fo3N5TyPUEV+pEprZ6kielHId9pGivF+X38bX3Nk/2TuZAE=
X-Received: by 2002:a05:6214:20ee:b0:67a:d8ce:8e88 with SMTP id
 14-20020a05621420ee00b0067ad8ce8e88mr3089154qvk.110.1702291618597; Mon, 11
 Dec 2023 02:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-31-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-31-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 11:46:22 +0100
Message-ID: <CAG_fn=XyTZHU45EhinUSm-+Thux4VPCpT-jyf=cP7hNPcTbK8g@mail.gmail.com>
Subject: Re: [PATCH v2 30/33] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
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

On Tue, Nov 21, 2023 at 11:03=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> put_user() uses inline assembly with precise constraints, so Clang is
> in principle capable of instrumenting it automatically. Unfortunately,
> one of the constraints contains a dereferenced user pointer, and Clang
> does not currently distinguish user and kernel pointers. Therefore
> KMSAN attempts to access shadow for user pointers, which is not a right
> thing to do.
>
> An obvious fix to add __no_sanitize_memory to __put_user_fn() does not
> work, since it's __always_inline. And __always_inline cannot be removed
> due to the __put_user_bad() trick.
>
> A different obvious fix of using the "a" instead of the "+Q" constraint
> degrades the code quality, which is very important here, since it's a
> hot path.
>
> Instead, repurpose the __put_user_asm() macro to define
> __put_user_{char,short,int,long}_noinstr() functions and mark them with
> __no_sanitize_memory. For the non-KMSAN builds make them
> __always_inline in order to keep the generated code quality. Also
> define __put_user_{char,short,int,long}() functions, which call the
> aforementioned ones and which *are* instrumented, because they call
> KMSAN hooks, which may be implemented as macros.
>
> The same applies to get_user() as well.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

I think this patch makes sense, but I don't feel myself qualified
enough to stamp it. Hope Heiko's ack is enough.
