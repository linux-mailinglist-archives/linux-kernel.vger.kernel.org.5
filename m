Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BBC77FC67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353764AbjHQQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353801AbjHQQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:57:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5272D67
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:57:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf0b24d925so18795ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692291433; x=1692896233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jBteD18pe63JA7nhN088a/1muJJtAStcr5mOX/vhfA=;
        b=inaDJWW8I+mpguLQ2GzQ+qwcaoqTtUbPgrf2yHqs5EK4qwPc8SjXADrCpy+Bdvm4/M
         g4OC019YJUkkXR6SDD0oQ34YAs9nBXEGo1ruWXaah+cJ4McdhIuZO8E440d7LE4bQyZK
         K5BcOVdABp1xZcPvK16dsaIVjeI+sWF5uXi24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291433; x=1692896233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jBteD18pe63JA7nhN088a/1muJJtAStcr5mOX/vhfA=;
        b=F5PTohLpiSJtxldhcTG6KL750Bhp9focE9yGRNilNF8YTvdU9hOnE7UCoFIlisbirR
         GOl5Ykgv0z0nfW+5Fp/Jy4wvGVENSmNFPDU8pHowY0/eav0OUlSV0CC/Wkb7VuJkhZMI
         xcZ+lfXA4HxhYB0s5dVKNO30SWyb+UYDOdCx2ZVr4ULq7qDIRkjVaaHctzVQ2dNZgqbA
         rNz94+wmQJZKCgX7I65sGXmmuLZdK31CIvtyrehVI3H6vFccqxIrm/SpYXt2FL47uod9
         LW+wqP6ekprZ0bogjbIXAmDeWOb5XS+9DbMEiK3VkxLVixkzX4IhQHrqXFItcHogtz9L
         NpUA==
X-Gm-Message-State: AOJu0YyCo6m8IrqGC1eU5UOs4osSBlUmG2gUKSL1oavvqBG3gyxUyuxY
        HAhgiEguNIGpBkM/a+gtZ/27gw==
X-Google-Smtp-Source: AGHT+IGXiHai907yblQ4LJTd3jAsNR4lqc80bcNlEM4qD1hVRR/CqQRXK5Hyw8IoW/cXSZLVi5WANg==
X-Received: by 2002:a17:903:2794:b0:1bb:c64f:9a5e with SMTP id jw20-20020a170903279400b001bbc64f9a5emr4769029plb.5.1692291433571;
        Thu, 17 Aug 2023 09:57:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jd17-20020a170903261100b001bf095dfb79sm2201447plb.235.2023.08.17.09.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:57:12 -0700 (PDT)
Date:   Thu, 17 Aug 2023 09:57:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Petr Skocik <pskocik@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mike Christie <michael.christie@oracle.com>,
        Marco Elver <elver@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "haifeng.xu" <haifeng.xu@shopee.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC] signal: Add KUnit tests
Message-ID: <202308170956.B7CA2B8BDB@keescook>
References: <20230814210508.never.871-kees@kernel.org>
 <87bkf68g5m.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkf68g5m.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:08:21PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > This is a continuation of the proposal[1] for mocking init_task for
> > KUnit testing. Changing the behavior of kill_something_info() is moving
> > forward[2] and I'd _really_ like to have some unit tests in place to
> > actually test the behavioral changes.
> >
> > I tried to incorporate feedback from Daniel and David, and I think the
> > result is fairly workable -- the only tricky part is building valid
> > task_struct instances. :)
> >
> > Notably, I haven't actually gotten as far as testing the actual proposed
> > behavioral change since I wanted to make sure this approach wasn't going
> > to totally crash and burn.
> >
> > Thoughts?
> 
> Overall this looks like a nice start.  More comments below.
> 
> I do wonder though.  Would it perhaps be easier to create a pid
> namespace with just the processes you want in it?

Do you have a short example of how I could do this correctly? It's not
obvious to me how to actually set all that up (and tear it down).

> I am wondering because you failed to mock find_vpid and so you
> are actually testing sending signals to kernel threads.

Hah. Eek.

-- 
Kees Cook
