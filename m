Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61457756B59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGQSK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjGQSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:10:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30610D9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:10:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9891c73e0fbso990801266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689617415; x=1692209415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/gQWf/Lh1O+SDhuqheIyYLq5Uzd1/LSa61GJbvgmlmE=;
        b=Ywfh0Qp3Sm7REwjcZZLDm//OW0h3u/cR9sbe1N4/dU2fi+SRRxNpYMY060hBB2eOS7
         ypwUnpPwFGBBzgCQTWEDzkyK00smpBOXjPhzKjXTtu2cuuzPGZBzdXKyDvZfnZ/kaFrP
         zDG5CKC/cwUvdtyBIRB35K8zJ8qqI0FJaaPmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689617415; x=1692209415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gQWf/Lh1O+SDhuqheIyYLq5Uzd1/LSa61GJbvgmlmE=;
        b=GL/JeMboZr+zcthI+0C3p/lA5TjceUYekG1ncG45EpIvBCGrivjZpWNatfYrSBG2PJ
         JkfR++MIB/0bO+6uBT07bkdi3f5Cu1gpqsgk17ivYfiRToYKhRP3BQUj+6ql9j6zC/hx
         08dFlwK/Ryn1Q6XFExrdsVZ5j/dqGXYxFz7d/IeEYGwJYuaCV0FUuy4w2gRjsUsVH+Ls
         TVdhxpWemEqq6vnKtUAK5zprCtuv7zR9py5jFURqLhDvQ0BWCPbrN0YMEOv2CTAurmgW
         Rf/fIlDvWJLB46uMdBFmRguk1qtLAwQN9xXHpJMvErGxK7COgqihv2CTPMu7PkCHe1Nu
         BkCg==
X-Gm-Message-State: ABy/qLagsByXAlf3idWW+GwGmYc1la6VIF07xSFu1LrfzqpXDAFhYaOl
        0JUeYdVE3E6hZ6PugnjJ6ByOZ4IL+k+mvHDpgo+E4g==
X-Google-Smtp-Source: APBJJlF9XGS0+Lm83FhcYesynC5VAu615M3xyts7cwhDS7+bc2yByPLlK1l/aFBCzr278YGsrzS6Yg==
X-Received: by 2002:a17:907:7ba8:b0:989:21e4:6c6d with SMTP id ne40-20020a1709077ba800b0098921e46c6dmr11895823ejc.28.1689617415748;
        Mon, 17 Jul 2023 11:10:15 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7d992000000b0050bc4eb9846sm10400874eds.1.2023.07.17.11.10.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 11:10:13 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so9960087a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:10:13 -0700 (PDT)
X-Received: by 2002:a05:6402:34c2:b0:51e:5206:d69e with SMTP id
 w2-20020a05640234c200b0051e5206d69emr12317922edc.10.1689617412904; Mon, 17
 Jul 2023 11:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop> <20230717180317.1097590-3-paulmck@kernel.org>
In-Reply-To: <20230717180317.1097590-3-paulmck@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jul 2023 11:09:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqX8r3EaaO48dgi=wEBZxJETg1m67HrScRbH1FK7GTRw@mail.gmail.com>
Message-ID: <CAHk-=whqX8r3EaaO48dgi=wEBZxJETg1m67HrScRbH1FK7GTRw@mail.gmail.com>
Subject: Re: [PATCH rcu 3/6] srcu,notifier: Remove #ifdefs in favor of SRCU
 Tiny srcu_usage
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        atthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 11:03, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> +// Dummy structure for srcu_notifier_head.
> +struct srcu_usage {
> +       char srcuu_dummy;
> +};
> +
> +#define __SRCU_USAGE_INIT(name) { .srcuu_dummy = 0, }

You really should be able to just do

   struct srcu_usage { };
   #define __SRCU_USAGE_INIT(name) { }

which is something we've done for ages for spinlocks in

    include/linux/spinlock_types_up.h

because while we had a gcc bug wrt empty structures, that was ages ago
(ie "gcc-2.x").

See commit a1365647022e ("[PATCH] remove gcc-2 checks") from 2006.

So we've already had these kinds of empty dummy structs for literally
over a decade in active use. Exactly so that you can avoid having to
use #ifdef's etc, and can just always assume you have a spinlock, even
if it doesn't generate any code or any data overhead.

               Linus
