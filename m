Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B81763E05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGZSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGZSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:00:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A3212F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:00:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99454855de1so1023253866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690394399; x=1690999199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bGK72/2uFFAFURzSmoidnNrT7qXYHkSsD+/Ej2DNnKc=;
        b=U5lXIfUUGy5e/4L7t9jOX9ORyZWME7szPi9/JKMXUJwaj9/BvVhJA8vwZL09B9v85B
         2CHK7NsPryrMaAlMhOvM4WkmaEDQbO0cabecWvCRmdsDz8qgtrq1y2XXOKzwYknbEBH+
         x7+MNQ7j8rVSeJnd/vsdU6wNuqwejo2xLQGK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690394399; x=1690999199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGK72/2uFFAFURzSmoidnNrT7qXYHkSsD+/Ej2DNnKc=;
        b=E1tmPHglVRu3EirlKpKa1eI+zqxIDlS4HhYC4DtPsfdGrIoJM24Dk/jI2zThDjBlzS
         Ope2V1Tl/nX9XkYdPd8m+Tko6Tl5clitrW1jGsBUn9ZoowBiCvF6MlW0UCDDTz5grZjf
         X2+G5+WVSX5vrm9NpZ+uGTh1Q6jRAHUh4xF2lj1iALLd18lTriFECMO4qKyEY4PbKqnP
         SywCkgiKoTbHttwrjDRKMZxiqap2QL+uRzf3H1xHrNkPA6UTVc5T8Q+DYpicgWraKm65
         sdeOJj4YdajY+805BQWcjZE256JCYvaACoXp4rdMIvYeVC0OfXacqrnkkDm1oTY7xUkM
         dVMQ==
X-Gm-Message-State: ABy/qLa8iaE5tdcd01277aSL8csfY9Aph2bLlMOResN1kUxTjoe3+WSm
        mrFGnYGemytduJIybzdNTKc48mb1nJaVYCpS/9nNjeEu
X-Google-Smtp-Source: APBJJlFHex4hFOIOOvEV5EqmdGAS3Qi8OfCPydg9+t9KvNVepr7aD+zO309vkr0LfyN7YfEdG2e2lA==
X-Received: by 2002:a17:906:8251:b0:99b:5ba6:f2cf with SMTP id f17-20020a170906825100b0099b5ba6f2cfmr2395086ejx.26.1690394399697;
        Wed, 26 Jul 2023 10:59:59 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id se13-20020a170906ce4d00b0099bce4ae3bfsm613885ejb.48.2023.07.26.10.59.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 10:59:58 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so50894a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:59:58 -0700 (PDT)
X-Received: by 2002:a05:6402:683:b0:522:2b76:1985 with SMTP id
 f3-20020a056402068300b005222b761985mr2046463edy.2.1690394398336; Wed, 26 Jul
 2023 10:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
 <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com> <cc502fe7-716b-8114-c9e6-439e3b9cf0f6@proxmox.com>
In-Reply-To: <cc502fe7-716b-8114-c9e6-439e3b9cf0f6@proxmox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Jul 2023 10:59:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivat-bcWsGnQOd3=ODx0zFnc7R82tiee=fSU+DF4tD5g@mail.gmail.com>
Message-ID: <CAHk-=wivat-bcWsGnQOd3=ODx0zFnc7R82tiee=fSU+DF4tD5g@mail.gmail.com>
Subject: Re: segfaults of processes while being killed after commit "mm: make
 the page fault mmap locking killable"
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, akpm@linux-foundation.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 01:19, Fiona Ebner <f.ebner@proxmox.com> wrote:
>
> Checking the status from waitpid, it does show that the process was
> terminated by signal 9, even if the segfault was logged.

Thanks for verifying. That's what I thought, and I had just entirely
forgotten about the logging of failed page faults.

This whole "fatal signals during IO can also cause a failed page
fault" has been true for a long long time, but because it's done later
by the actual VM code, there we actually end up going through
"fault_signal_pending()" and suppressing the logging of the page fault
failure that way.

> > But before we revert it, would you mind trying out the attached
> > trivial patch instead?
>
> The patch works for me too :) (after adding the missing tsk argument
> like Thomas pointed out)

So it turns out that not only did I forget the argument, I decided
that I put that test for fatal signals in the wrong place.

The patch obviously does fix the problem on x86, and we could do the
same thing for all the other architectures that do this signal
logging.

But there's actually a much better place to put the fatal signal
check, which will take care of all architectures: just do it in the
'unhandled_signal()' function.

So I fixed the missing argument, and moved the test to a different
place, but I still added your (and Thomas') "Tested-by:" even if you
ended up testing something that was a bit different.

Oleg, I took your Acked-by too. Despite the final patch being somewhat
different. Holler if you see something objectionable.

It's commit 5f0bc0b042fc ("mm: suppress mm fault logging if fatal
signal already pending") in my tree now.

And because it's a bit different from what you already tested, it
would be lovely to just get a confirmation that I didn't screw
anything up when I decided I needed to make a fix that covers more
than just x86.

Thanks,
                     Linus
