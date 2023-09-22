Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91A47ABC0D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIVW7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIVW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:59:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA979AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 15:59:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-415155b2796so59851cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695423541; x=1696028341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YUFnW5F6AjDRorOQG+NxrFzBEDzepZETjhjMFMDjtQ=;
        b=37LmicNJ2O9kT4szGI2fJDfOUWbvAudtqrdBjYyRFEbqn1A4YHEouEDn97nCPrIrAN
         sDdG+dmvUs2Nn78+RkHaAVD3Tpy2T36gGmhFS+ipypDjqegpMOgwZ+l6Q6CbfLDZnd22
         aPlinGxEkkSxjnE0H87nCLdIDznKrSk/3a+bVsSSEKi7II21w9WKRqjecCWkQNjBv7J/
         iPSboM5I5a89cuOGn0W7bMlgfrCqjVopuXN3jZB2mFXZ5DaXf1Ut/2V93pDb7qbLO+rb
         WwxyYgyjNJWD42KvNXUB94vLSDIrHS2JgsUFKo9b4ELNEXt/RMz1wMd1NememEKv4tnS
         m6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695423541; x=1696028341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YUFnW5F6AjDRorOQG+NxrFzBEDzepZETjhjMFMDjtQ=;
        b=YleShEDEMuIeR+SfAqW16UQ275ZgyvZdt2sRi8HiT7lw/3BCMldY2m9EMHRL4jgpDn
         JXZbrdRo+i2EBysz47DOSxscB7T4BSjgVOqzhyNlI0Y885NuXJtvzKjosE+aMa6li+LS
         2Rlv9jXovNcl8CwHJCUZMKPZL8fpKjcrg9A5uKTwXRAGJYIqyPjMadPM5gUCpfCsCvHl
         cMG1oh3dTvB3Zk3Efm/UUyjU+JzuiblClwCR3P6+ZCuEgjSYYSV443LSbHrdaFBZVFf1
         BOpYoxGFvbeHL8K7phllwvLZAMeEaVSNNMu8FnFRd0sQk7EcefQl8WFmIsyO8ibv3och
         7p9g==
X-Gm-Message-State: AOJu0YyF6gwTdCz8H4HwufUsQSR7U50VkHhmsuKkv8CTFPH/WkifgS3A
        f/qJmUnT3/fLyCspbgQ53qpY4jdey2cb2UcxqvKqtjccyI3OZm6dDXU=
X-Google-Smtp-Source: AGHT+IFJkezyS2xa7+WOE2dLaXWOu4l9zJ2uQGj4zWwc+cSbhCI/45fUBnGCwrqmh2wf9GSwqIaws401PpQfEW3WLKg=
X-Received: by 2002:a05:622a:1445:b0:417:b70f:1a6a with SMTP id
 v5-20020a05622a144500b00417b70f1a6amr84129qtx.28.1695423540744; Fri, 22 Sep
 2023 15:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230922013750.874131-1-joshdon@google.com> <ZQ1Ml8fudWETJkY6@gmail.com>
In-Reply-To: <ZQ1Ml8fudWETJkY6@gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 22 Sep 2023 15:58:48 -0700
Message-ID: <CABk29Nv8FPOaTeOsJMNrsiZYSGdLeCRazBsD6nLSwdZ+ha8NZg@mail.gmail.com>
Subject: Re: [PATCH v2] sched: fix warning in bandwidth distribution
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 22, 2023 at 1:13=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
> So instead of uglifying the code with seldom-tested !CONFIG_SMP #ifdefs,
> please fold the !SMP code into SMP code: make ->throttled_csd_list
> unconditional in a preparatory patch (even if it's essentially unused on
> !SMP), then add what is basically your v1 patch as a second patch in the
> series to fix the bug.
>
> We want to unify as much of the SMP and !SMP codepaths as possible, even
> when it casuses a bit of runtime overhead for !SMP.

Yep, makes perfect sense, I'll respin this patch.

Thanks,
Josh
