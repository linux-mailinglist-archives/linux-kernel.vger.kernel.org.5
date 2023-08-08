Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05047737B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHHD2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjHHD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:28:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF6712D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:26:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so28435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691465206; x=1692070006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuB7YbnqC7c4FNO5OdgtRU4+dJJH4sy8Gmu+1ZKvXqM=;
        b=AXuZeK3ldhdaatptZvUTwjzjLSZQOp8LYNPZ048zPT9Hf00RmeqwuH31u02hhlA7+/
         0YogXDwAehqv5uH0vl6LQ+skudap6jxdmQ5h3DIfM4068LJxMeJmvBpY98VQAWcXY7t3
         aZp2GtRHhhcW7bnVUN5xOxYTVt81R/+nEpCFct1aLAjt7NL5aAJ5/4fobWiAnImBwukO
         GrC7nUo86PX0TdDGiCqYXdJUZfr91na793dHAY3b6Y5zGfVpOC5JoCQM2uoPLRBWDCOo
         OwYB7IzEfEFWJYsQIEsMR8qvlgaQJV3Q2BN7+Yt4mI/LkBOlrXwQgkjdr7iLrAlJgKVa
         MKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465206; x=1692070006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuB7YbnqC7c4FNO5OdgtRU4+dJJH4sy8Gmu+1ZKvXqM=;
        b=gHGkP5RyHFD60kvgPKgrj9mfDKtCH7j8qHJRXmFwIU8tE2oIjCFIGtUxZ6YHVCw0ix
         xSG4jbHJSWu2s5ktsW/Tl8LQRGLsnTv8M5o7jGDASCDRaPX7uSh8ct7UK+ZbkfBfc72w
         aeeND0o1Oya+kw2GJ92Q4xPS4p/2shk36FGneXwvyvgf60lA6cUV5DzLTm8jG1szR4aT
         2yiD7Fl67fnmgz6aQzR4KYPXmqiN6cibOzLIggk6p79y51w2xrDb7GHeXqYOA4pUWbvD
         9ATSmrsAd7T+yU6Lumcsg0lwd6smO5tQG0FHa9AU4jDbHvk7ejOdmd6qEzZm/vpvfkmz
         rfGA==
X-Gm-Message-State: AOJu0Yx3wbH/+N9P2UUcEf0CeWN1blVzaGWnTQzsGpbbmbO1rrNY+WAu
        0+j/Nx5tNeSQyNRmHYzRpDIK4tguHGWDAiQdSMS4
X-Google-Smtp-Source: AGHT+IGRFITSpr6ACBR1/rbLIy0Cxs8MPgIs2YrgQ1eiCvqppxu+V90ISFxTnFmo2ezgQvxoUn7T+ud+gaxTCqzT7sI=
X-Received: by 2002:a05:600c:4e4b:b0:3fd:e15:6d5 with SMTP id
 e11-20020a05600c4e4b00b003fd0e1506d5mr292786wmq.2.1691465206339; Mon, 07 Aug
 2023 20:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop> <20230728032232.816584-1-paulmck@kernel.org>
In-Reply-To: <20230728032232.816584-1-paulmck@kernel.org>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 7 Aug 2023 20:26:34 -0700
Message-ID: <CANDhNCqTNNG=EVVgKruDEkbbSAArPP5=d=HsueYeScfyxQqXCA@mail.gmail.com>
Subject: Re: [PATCH rcu 1/2] torture: Add a kthread-creation callback to _torture_create_kthread()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 8:22=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> This commit adds a kthread-creation callback to the
> _torture_create_kthread() function, which allows callers of a new
> torture_create_kthread_cb() macro to specify a function to be invoked
> after the kthread is created but before it is awakened for the first time=
.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: kernel-team@android.com

Thanks for improving the patch this way!

Acked-by: John Stultz <jstultz@google.com>
