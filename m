Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABD280A479
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjLHNcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjLHNct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:32:49 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A21718
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:32:55 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5908a63a83fso359430eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702042375; x=1702647175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL1EkEt0qsAoRDwtVA7bs3ZuCI4ZBobSjrqprT3lLqo=;
        b=HWYga+h6Y/OrNxvsQNQKV44owCXJEFQh8Oo+zcKO/Yz5Z2g7+WWdW2pLwpzJBChGNf
         aRo5/KZ22AwHqxKwlgV44Di8H8U8JXRVulqYZoZJeLb0lZ13UIk8fw8EQsbSyuK/nSZR
         m2gOwrhezjVrbOpMIz9OxWmW+N7pwmY833k3k5AnJPVGCe4X6HRPppqO5UZc7nmtm71D
         zvpFAKhlm555YrRxvSLJvmUk5u30knz9WYSMI2Udxzs56aun/AjF1H14Z8epTobcOArf
         odKTPT2UVsIjInvxPytFfJqhzzbUWkP0bYmOCAZUH+5K3ZatN3aOr1w+UQ+eU72SoI22
         QZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042375; x=1702647175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pL1EkEt0qsAoRDwtVA7bs3ZuCI4ZBobSjrqprT3lLqo=;
        b=mZe6iYJyff5b+MXgffdovj8Y2g8JiNEByMzpYSmJ3ecWYiWsBA8M010ZSNniiIKqam
         XF7YJVMp1rv/8KsRX5TY1hU38Fd95/EBPLQugMWtlz1VbaZav1aN1rjJGLH9/3K4b9Tn
         clOMaknv73MFv4m7NgsUMXWq4VH7CFTxE3I3thONljzBQDpM1dnvcAWa8zTTR1UcXrbc
         Honhhk9gC+Fg3BqcrAPXOylVY88xYh4g+PtzlsV5qn+AeS01R8Yn8REmwMk9DUtxXff5
         7CuHkjiJ549T1oP7Ar+3BOI2QuoIkUIuYehnklkbOwl37Jnf+dmSnZ8tRWebV2uUvf/U
         J6lw==
X-Gm-Message-State: AOJu0Yx7016UT0EuI2LyD/hRNNMPGjXzMJafZpgQdmZ45sYvLzFWSR4k
        Fp0HGSox7RDSQ/pzKxBjIemA/llCvjUbGMH42tNqAg==
X-Google-Smtp-Source: AGHT+IGRSBnBoc2BG0FsV541PbbYtbMc1RoW0fnIT845DKwurdtswNYXWxoNJcxnqfNgHmHrHSrHprdH/0NINlfzFLY=
X-Received: by 2002:a05:6359:6196:b0:170:22f1:d0a2 with SMTP id
 sb22-20020a056359619600b0017022f1d0a2mr3474879rwb.56.1702042374871; Fri, 08
 Dec 2023 05:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-20-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-20-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 14:32:15 +0100
Message-ID: <CAG_fn=WiT7C2QMCwq_nBg9FXZrJ2-mSyJuM1uVz_3Mag8xBHJg@mail.gmail.com>
Subject: Re: [PATCH v2 19/33] lib/zlib: Unpoison DFLTCC output buffers
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

On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> The constraints of the DFLTCC inline assembly are not precise: they
> do not communicate the size of the output buffers to the compiler, so
> it cannot automatically instrument it.

KMSAN usually does a poor job instrumenting inline assembly.
Wouldn't be it better to switch to pure C ZLIB implementation, making
ZLIB_DFLTCC depend on !KMSAN?
