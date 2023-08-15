Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ADD77CF03
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjHOPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjHOPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:21:33 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8B1986;
        Tue, 15 Aug 2023 08:21:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7909307ecd1so191486339f.1;
        Tue, 15 Aug 2023 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692112891; x=1692717691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pixg2IlnzljSoCqHmpHhdY9MlQvI6m+ey5bT+PamgDs=;
        b=nKaXc9evzl/AAKvWG5961hsTtnzLDGKswb8QjPvSR8GskmEmURxK7Co6SJFNsCkCL7
         /T4a0R9eJ1iKnfeKX3n8Qgy6sL0GHxymbfdNuKZX+8EBFd4ZzxgUJiHaaob3SBF2qlBU
         W6fGLJuvO1L/2790w+6FUpEfz+aiyTWbqIhFGitV3Lpj+HEGlUhnW6P6Uv2oRr933Yd/
         KB71zkXxu7Oz+JxFpduop/90hlqdGrZp3nSVFZcVrDAf4ZERsgMbo94EwdwtOiTqCpho
         WTlmPcO8gi56pT8GsaygrDUA3vS73LCLpj+7DAl+stXqLA4CwAapm8UH0RTQvYK33LqL
         Z44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692112891; x=1692717691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pixg2IlnzljSoCqHmpHhdY9MlQvI6m+ey5bT+PamgDs=;
        b=DseyWZTTtZiR6IxRAwxpfBnaGmCiHEB+PsBt/VyX6AklKpS4Axlj5SQiwhz5KO3iNM
         wUJsSQKThVjhl8+A6wrDw61U/v5rWnINiB+06EPvdvVQVqyWLLT0wq4bbSP4vrwU0T2M
         DDdk8A5DCOfwUvt7BpKZ7ryMz4rPxY7iYJZ0AiL6qI+RrZb//yUpVMBekgCYdxuHR26u
         DG8bNpPnqo7snlsjE/ZMKrSG1FJDWmmsDOgvRjjxrlbx37mYYrQF3lQYSbe6wSbBgZ1f
         5WFZQxDPkvdaJuD7z+3ONCWUNTwkUpV7lMmVkZUxM8Yc8qMgDe/zTYQCrUjfs8BzuJqe
         gPgw==
X-Gm-Message-State: AOJu0YzZDMJTG00zNUWn+j3hmsg6/MSCMK44T7ne1M5D8nUED2w2n5Ux
        VxY46qRewH+OeeRL4FH01SQ=
X-Google-Smtp-Source: AGHT+IGdndPxxGyaB8/gIup3P1aVlZ0r3NpOO3sUBeJwAucO3w+5ZQuWsm2dXrIDqSNGp+LChEQPfw==
X-Received: by 2002:a05:6602:3308:b0:787:8d2:f15 with SMTP id b8-20020a056602330800b0078708d20f15mr16338869ioz.8.1692112890812;
        Tue, 15 Aug 2023 08:21:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3-20020a6bfe03000000b00785cfdd968bsm4094651ioh.5.2023.08.15.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:21:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Aug 2023 08:21:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>,
        Henning Schild <henning.schild@siemens.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the drivers-x86 tree
Message-ID: <e4eb2acd-7ed4-43f2-af9d-116cec77fc31@roeck-us.net>
References: <20230815165725.30a01fe9@canb.auug.org.au>
 <20230815165856.051fb20f@canb.auug.org.au>
 <2f9489b4-2414-9f03-4f66-9838b8ee6be0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9489b4-2414-9f03-4f66-9838b8ee6be0@redhat.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:59:45AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/15/23 08:58, Stephen Rothwell wrote:
> > Hi Stephen,
> > 
> > On Tue, 15 Aug 2023 16:57:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >> Hi all,
> >>
> >> The following commit is also in the watchdog tree as a different commit
> >> (but the same patch):
> >>
> >>   3fce06406c59 ("watchdog: make Siemens Simatic watchdog driver default on platform")
> >>
> >> This is commit
> >>
> >>   926df9ae133d ("watchdog: make Siemens Simatic watchdog driver default on platform")
> > 
> > in the watchdog tree.
> 
> Guenter, IIRC we agreed that I would merge this one through
> the pdx86 tree?
> 
I thought that applied to the rest of the series. I tagged this patch
with Reviewed-by: which generally means for Wim to pick it up. Ultimately
I don't really care either way. I'll drop the patch from my tree.
Note though that this doesn't mean that Wim will pick up the drop.

Guenter
