Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA47A9009
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjIUAGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:06:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB6CC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:06:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-404f881aa48so51715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695254768; x=1695859568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InlWytXF+IYfaZeRySecmPSvosAEy+u9gXRr7RSRjxk=;
        b=Dt/asKASkmduDv+a1BHRk8T8ycScykc0XVmoOmRahR8r9RjhFyqKSiQoKfZ1r/HOma
         qiDMhVYMRu/ukpJ2vIZ2pBvpoeMYVqy14zO+1QptVUqXd5iRB2jbXupSVKOGSm0rMqyx
         BRrh6v1JQgGmYjjGRc79sSf8tzD12T66oSdnlbuPcpYJs9aDdeErrRcAbDWUWtpWRrkA
         eInp/BxvAtzOrebUOPAoSSZE5FKNnDaZddk0iEDaFTg7EnyZKhRengZBAOdtd5J0U418
         K2FHfezFjEfJOgVl2La58Ozq3kUP3ze50GOx00flFcqQKz/veUfoIsWa1oPCSmyNT4Dk
         D9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695254768; x=1695859568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InlWytXF+IYfaZeRySecmPSvosAEy+u9gXRr7RSRjxk=;
        b=m1VzUf0fHV0nLSoA6fSjBbiCTcP1BJjLiQktMuuKZyLEgdaSsY2EukvzSsKNY9gt5R
         8R5TQIlEb9VyakNDrVP+BA8lxTY+30FjFIF9rTLfx4wAzywbaBaXwFp00Hj1Q+DYXIfr
         3CvNbDoX/n7FLZLkuyZflG6fddCgJ191v8yvv2fklK6ICzj3xJ2F/UU90ZWGDB0j/zYO
         70SM6kZYBEReZZavNJcySwPIFqgZZs3AkI+IRxv7sFKXelg0Lk7nsOI8HSlcsyPfwOIq
         xk2fCKHhgPArDDjM/6BJK4lGXJe2ReppYQoksIHtgHnS3L4MXeZxp1tw+d9vnkDiEz4a
         c91Q==
X-Gm-Message-State: AOJu0YwrBpFdZBQ8/XLioIIFBh6oRty7K/tlEgVzPFyydsVX0JQFr7cv
        8ESop6duhV0nonj6u/FHJSwZpu7Uc6CRdbSqmXvw
X-Google-Smtp-Source: AGHT+IEgfCRIiBTGtWEcCpUkwHFuCsrGdLumAkihI/yhL+joC/EpghX1btxb0q5g+Vq6hgCMbCe5Uu/lu/zHQCubI+M=
X-Received: by 2002:a05:600c:4e43:b0:401:c94d:d6de with SMTP id
 e3-20020a05600c4e4300b00401c94dd6demr40014wmq.2.1695254768234; Wed, 20 Sep
 2023 17:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220909192848.963982-1-longman@redhat.com>
In-Reply-To: <20220909192848.963982-1-longman@redhat.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 20 Sep 2023 17:05:56 -0700
Message-ID: <CANDhNCpsDbz9ZT+h4Zcq-7QMJ-uqs3rW+MXCVcbi2A2hnTjBpQ@mail.gmail.com>
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 12:28=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> It was found that a circular lock dependency can happen with the
> following locking sequence:
>
>    +--> (console_sem).lock --> &p->pi_lock --> &rq->__lock --+
>    |                                                         |
>    +---------------------------------------------------------+
>
> The &p->pi_lock --> &rq->__lock sequence is very common in all the
> task_rq_lock() calls.

Thanks for sending this out! I've been hitting these lockdep warningns
a lot recently, particularly if I have any debug printks/WARN_ONs in
the scheduler that trip, so I'm eager to get a fix for this!

That said, running with your patch, I'm seeing bootup hang pretty
close to where init starts when I've had a fair amount of debug
printks go off. It's odd because the lockup detectors don't seem to
fire.
I'll try to debug further, but wanted to give you a heads up. Let me
know if you have any suggestions.

thanks
-john
