Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF12080C734
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjLKKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjLKKuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:50:07 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F84F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:55 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db4422fff15so3329481276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702291794; x=1702896594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcKQpflfU4B5TCVP/h08UJJZWjI+RvIJpIXiYwS5E2M=;
        b=Z82uxumJs410fLvWZ+MsX7MAn/uD3m9CJEIHdCGkswx4mTsRZFKb+t68brB8HGfQf6
         z4wEczY3Uk4d5Lt2iCfDm2IAqNr9HQXrEga+T+mUe3Ognhs0xW7fidenVB5zF5/3N1qL
         lf9QAOGAepwBq/jcUuOfrnRLZomaaR3W0waBr6Oa5Idx1t9Tju3wAFhC16vq2hmiBbpX
         IxqSFt1scuLNfZlxlc8Sv1x5ezO8E4xn25TX8Z7N37sOS7fyiq6z39BR1O50L/Aj3NKN
         4rtlIBEpkIcTCflcA7E1PErLN0oRWTNK/RcEw0dSE19MIVJmUUrtCUF+D2h138JZH5i0
         PhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291794; x=1702896594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcKQpflfU4B5TCVP/h08UJJZWjI+RvIJpIXiYwS5E2M=;
        b=feCgXvh1DDFOUVEk26xqAoNSTwxZhcNNvM65v29h6+5p0d/WGtFUnviA/451lUji9h
         iIjTV0dDYiwufzmvHDOROFnyhF3kWzgqp406W6sv2Ck+wdR0gKqfaHWT7RBp9U79n1zJ
         6HddZqji0EAkfVrlNHKfDuQK4ltAgV4TYS9rQc66r6oOLNW1tvIVmPtsZmJOC/0TIcZc
         LRjzvrGaN8w4gBvIvNOV9D9Qcnp7hnZGOGkGs0Xr4/2RbTAV7AYc539a62hoqJ/afQbq
         SbIde5kN0j+ccyNe/qn/3ljSk7Z9p2pEL0pkplbMzcPuHVLDsE6KaBHr6xnOvVktNP6M
         UTzA==
X-Gm-Message-State: AOJu0YwwLbXSeKeUYVipo8VowejN2oVE+KzXKuf9HUbC3vwElw7xUrKw
        zh8hNY8KGj26ZURQ/aqy0EgYX+q0DVuGK8X0mKSufg==
X-Google-Smtp-Source: AGHT+IGxEQoVh4ByA2qBjx0LydjxUGju9YawLR3Q97ogewINErRGg6NuNwBnUwitc38zjtVfZw57S5a8HV/G/pvaPFA=
X-Received: by 2002:a05:6902:1aca:b0:dbc:5dfc:9d6 with SMTP id
 db10-20020a0569021aca00b00dbc5dfc09d6mr2177747ybb.35.1702291794335; Mon, 11
 Dec 2023 02:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-29-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-29-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 11:49:18 +0100
Message-ID: <CAG_fn=WjEV4CP2RTX1xeuG=kd9Lj5X1Tf4QCRuNW-vzDUpzBGw@mail.gmail.com>
Subject: Re: [PATCH v2 28/33] s390/string: Add KMSAN support
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

On Tue, Nov 21, 2023 at 11:03=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Add KMSAN support for the s390 implementations of the string functions.
> Do this similar to how it's already done for KASAN, except that the
> optimized memset{16,32,64}() functions need to be disabled: it's
> important for KMSAN to know that they initialized something.
>
> The way boot code is built with regard to string functions is
> problematic, since most files think it's configured with sanitizers,
> but boot/string.c doesn't. This creates various problems with the
> memset64() definitions, depending on whether the code is built with
> sanitizers or fortify. This should probably be streamlined, but in the
> meantime resolve the issues by introducing the IN_BOOT_STRING_C macro,
> similar to the existing IN_ARCH_STRING_C macro.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
