Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918C380C5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjLKKII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjLKKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:07:44 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A605EA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:07:50 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-677fba00a49so34208896d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702289269; x=1702894069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQbib7KuYZwXSs7TOXR8fysQbrU5Bbc58V4j1zKqFv0=;
        b=3oPM32MWcY8r3m5sBp4v1VNAomGU5lj7AxiNK+O0xMiSzwfAKUPlxDcrC+x4vbKYAO
         l+9pCqXKq6sYAqeISnCZbUM4m+Uri3nTRbYWK4WQZde9bOze32l/RvDvTo7isRHBj2/O
         qB+hUTqacDqDX9ZzpI37vdz/0kEQQMRq1FHHwNwD/3vOuNGG/yJ5mWfAIKhtZrCZtDLu
         yenJ+mFitN/m4aQa5b7eHtBO8CG9/lHSOuS0wGV30J0s44Ugwkzw482n9PzRd9ZJqS9r
         rSnnUIn2rtyZXDfLdZtQGsO23nSg315limxo8LprB6eNTM9s0KKcaagGr6IVXzyz34Fs
         GNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289269; x=1702894069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQbib7KuYZwXSs7TOXR8fysQbrU5Bbc58V4j1zKqFv0=;
        b=hbLZbL2fi72zARpHy/spRAGvoT1nOnbdGnJTjst/CJPbk6pQVAxswvwoqX0D/U33Ta
         N9eaSBnKvfx85MnMQV0w0JagsV52H/gjgXMhlsv5M+m4EALSS8RsyBp3MG4OMMKT3zdO
         3CsdsbmW3u6Y3w4Se4Be/2UD2OV21NCm+Aw4sooE28nL4cRaw90EugnW/4Hk/Fc/f/ZA
         CL9gEdAoQZGT5fju+39tLQ8jYb6uAlfPXyfMEb9lXfdj4HQDfqxZnNpTsIr+8OrXOk7l
         HSIQsGi01sKxhVKKWq0uLyoaKab3Lq/7k3zpax494s27NR6aPc+l5upCRjqEM3RfdML9
         c7xg==
X-Gm-Message-State: AOJu0YwSG7cIZYX5yY3cSGjpCrwRuFq21ItSxMZFKWySxiFBMlgfqDf/
        PJY1YOm2iRZWV+vGrEdWGN/VPKQs+N5OMxAA33Av5g==
X-Google-Smtp-Source: AGHT+IEy7sdK9NHIsRzMOTl1p7qUMH4EfMKrMOKxVRFyC96ArAp5QDcDdvRP7e3vCBuus6OXQDRK9VpDPAJXYCPOaGo=
X-Received: by 2002:a0c:cdce:0:b0:67a:9440:2b26 with SMTP id
 a14-20020a0ccdce000000b0067a94402b26mr7123627qvn.20.1702289269049; Mon, 11
 Dec 2023 02:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-11-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-11-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 11:07:13 +0100
Message-ID: <CAG_fn=WVfh_E+5uFs1GXfQCVMj3EBvNGFTrJ6_DxVb4t3WnVPA@mail.gmail.com>
Subject: Re: [PATCH v2 10/33] kmsan: Expose kmsan_get_metadata()
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

> +static inline void *kmsan_get_metadata(void *addr, bool is_origin)
> +{
> +       return NULL;
> +}
> +
>  #endif

We shouldn't need this part, as kmsan_get_metadata() should never be
called in non-KMSAN builds.
