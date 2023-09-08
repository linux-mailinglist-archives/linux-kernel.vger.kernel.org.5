Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900357982BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjIHGwD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjIHGwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:52:01 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7419AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 23:51:53 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5925e580e87so16902457b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 23:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694155912; x=1694760712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA3Qqh4mhsiPoQBLV2r7oediryAOFsUbH13RohOWuFA=;
        b=RgOjARzsTLGAF/JEeMOgiiddCcMDjEo0HOWEpQ5X2LgfRdsoH4BIrt1SiqM+vq46Mb
         RTLy2FFG8NFlBRqxwn4zn98z916nKxRNc8ZSodB0nLzPRJYNy1f0ajjzBdPIwf8Mz3zo
         dWqWIqnNAXpdaXwOplG+2b/OcdAAvIzLGqIEy7QE9ZdBuwTcUjBGw97gCwDcJFZxs18V
         XCs7H0jEixVvto8+C3TviSOImlV3GWW5g8HzFGxwanwR/opfoBzheapHDSw5SMieEYC+
         11RN93NAAOuovyE1BpuS0PaYryC6tjhTteorMWoj6gE/f7iO1SKDh4caYhM/pt7G52iR
         OtYQ==
X-Gm-Message-State: AOJu0Ywqz7vYuzObucjrrgN1yNIprCYbBgl0iJX9YbdMCdypiUhGgjh3
        6RkEFFnFKOj+ma/xqZZ0nzZvmPmzayFc8A==
X-Google-Smtp-Source: AGHT+IHWDefOO7hZgPT1mEzFGT8PczIERRjk2EDoKsRRbxX5NmNv0PH0WKLFtH4a4jGUsC/D590rQw==
X-Received: by 2002:a81:6d41:0:b0:595:80be:fc6b with SMTP id i62-20020a816d41000000b0059580befc6bmr1613834ywc.18.1694155912097;
        Thu, 07 Sep 2023 23:51:52 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id z62-20020a0dd741000000b005869f734036sm296333ywd.19.2023.09.07.23.51.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 23:51:51 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso1659660276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 23:51:50 -0700 (PDT)
X-Received: by 2002:a25:e64d:0:b0:d4a:5fc2:dbcd with SMTP id
 d74-20020a25e64d000000b00d4a5fc2dbcdmr1365104ybh.28.1694155910756; Thu, 07
 Sep 2023 23:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694093327.git.geert@linux-m68k.org> <5406d0829d8204841c8cb8d265ca91a52cd22d2d.1694093327.git.geert@linux-m68k.org>
 <6e46156f-5a81-d245-63cd-8091605deee1@linux-m68k.org>
In-Reply-To: <6e46156f-5a81-d245-63cd-8091605deee1@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Sep 2023 08:51:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8HMSgxAPFUSoCnKDs=y8T9w+5K+sTMUzmi37=ynH5FQ@mail.gmail.com>
Message-ID: <CAMuHMdU8HMSgxAPFUSoCnKDs=y8T9w+5K+sTMUzmi37=ynH5FQ@mail.gmail.com>
Subject: Re: [PATCH 25/52] m68k: apollo: Replace set but not used variable by READ_ONCE()
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Sep 8, 2023 at 1:37 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:
> > --- a/arch/m68k/apollo/config.c
> > +++ b/arch/m68k/apollo/config.c
> > @@ -146,13 +146,11 @@ void __init config_apollo(void)
> >
> >  irqreturn_t dn_timer_int(int irq, void *dev_id)
> >  {
> > -     volatile unsigned char x;
> > -
> >       legacy_timer_tick(1);
> >       timer_heartbeat();
> >
> > -     x = *(volatile unsigned char *)(apollo_timer + 3);
> > -     x = *(volatile unsigned char *)(apollo_timer + 5);
> > +     READ_ONCE(*(volatile unsigned char *)(apollo_timer + 3));
> > +     READ_ONCE(*(volatile unsigned char *)(apollo_timer + 5));
> >
> >       return IRQ_HANDLED;
> >  }
> >
>
> I believe the volatile cast is redundant here, as READ_ONCE does that.

Yes it does.  I didn't drop the volatile out of fear of introducing
some higher W-level warning about casting away volatility, but upon
closer look, the apollo_timer definition itself does not use volatile.

> Perhaps the remaining cast could be deduplicated like so:
>
> -       volatile unsigned char x;
> +       unsigned char *at = (unsigned char *)apollo_timer;
>
>         legacy_timer_tick(1);
>         timer_heartbeat();
>
> -       x = *(volatile unsigned char *)(apollo_timer + 3);
> -       x = *(volatile unsigned char *)(apollo_timer + 5);
> +       READ_ONCE(*(at + 3));
> +       READ_ONCE(*(at + 5));

Thanks for the suggestion!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
