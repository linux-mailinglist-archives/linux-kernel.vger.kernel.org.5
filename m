Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8377EDDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbjKPJqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjKPJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:46:37 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B31196
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:46:34 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9beb865a40so536671276.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700127993; x=1700732793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2IE4TMhLsEPKM/hSail2p58dx/qbJfsgHuokbxSXhI=;
        b=fwNN4VsEBk8G0CE69ZjqDJd2/Nfxczd10kYiYELxzMtFKhgZQ1dHCQSbu7413a5E8C
         HZUFtKem9agXLZzG7VI100keMvojDs/du3tcI+IyVdGjOt0HpFnNljo8aJ1GR3kU47aW
         BTxjMsddMRyB9lUmVBSQDmFFUopBgAoDTL7sw0YcbmQ8Pymp15i579D9L8Q4tJI5PlRw
         Ld90NpzN2Q5QzCT+yh9Z8TgikFzdgtQ7xEMDyQwTgGzBmqp8BKDaTyeUWwB/SCDt/Qu+
         fZ8d7lsLjcZ08g4nRZRt6WgLvUHFf87fAkyshcSTONhEpFjssjERBWafNbmypHvkZg76
         G0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127993; x=1700732793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2IE4TMhLsEPKM/hSail2p58dx/qbJfsgHuokbxSXhI=;
        b=ZuJ/KoBlpNO7kP0h509k6DUgzsHZw2A+gdBkOsYF6wCjHaua7FJqME1CtDZ0qmYE2o
         H8/SooUamihd8RV5sxqHzN7HkxJeln0McDzLZdnpQKWcLRaSnNF2t/tPOGvDXm0YQ6Hk
         y3jsNWiLw+la5/jvCApnoACgXT9Bvxn+vp+m05SAi9kAbZUe3Br7hEmDKgO3ZKGFqcgJ
         Z9gC20hfJ23Fx81AZKs4NUj7DIT+KUsaP6NZv61SAtltKiu3S103lNTptbpzvDGMIrYt
         L66CJxkd3/PjOkacQkGD2TNqkbOOgNgEmX47jDXLT8u+NJcs/YzbxEwhlFlhLmf3CHq3
         wu7g==
X-Gm-Message-State: AOJu0YxLZjMLPjah2jVCaC3Mv3H1bcjFME0dIWnCcQhCYlTOIU1RXeY/
        pZiDIbquQaV+Pn1vS/RqKl7HXsRATgKtDYHYrb2HjQ==
X-Google-Smtp-Source: AGHT+IEaGLOE138vjmqsqGe39mSoH/QW0BpxK1QQmicQZENCOk0z+Iv7+fnx4jrisMz1JiuwrRl9i2WhI1MB38wOZNM=
X-Received: by 2002:a25:ad27:0:b0:d9a:5ff4:cfde with SMTP id
 y39-20020a25ad27000000b00d9a5ff4cfdemr15547906ybi.13.1700127993266; Thu, 16
 Nov 2023 01:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-22-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-22-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:45:57 +0100
Message-ID: <CAG_fn=UyvxneFvXPyWhsiKQLrRh0aPpPKORh6J5HJ0t2ZHo4jw@mail.gmail.com>
Subject: Re: [PATCH 21/32] s390: Use a larger stack for KMSAN
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
> Adjust the stack size for the KMSAN-enabled kernel like it was done
> for the KASAN-enabled one in commit 7fef92ccadd7 ("s390/kasan: double
> the stack size"). Both tools have similar requirements.
>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
