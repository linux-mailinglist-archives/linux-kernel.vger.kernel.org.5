Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1C756EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGQVF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:05:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F636118
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:05:26 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a412653335so3025122b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689627926; x=1692219926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awzkgsvZFBo842DWA8GT/abxr3wtZvlfdq0myNlPQ4k=;
        b=mFzPuiGUM3XUBeafgaWUcyhQG0QPZ4O9svf8FTOYItCo8R/TZ59+X/6HzsD1g/WYvy
         b1KXc/bEpADFYnFcxlzqDV7JkHpJD64k/G4lVHvHu3kRlffFJppqTljN5qcxQ/X+Ow46
         jN8QK8uNYyHzkFwYEs272eWNzpHYoWjbzb3Nb8pX0MPRBq7F/F9tuWNlFPkNoRR+m19/
         YqiszErwzKl6l5uWhrsGsS7QquDU5kCtJqY3oSvCHdL8p7RqeJgCkSzMZW9vAJTDIBZx
         QBQirr29HNXBPlF4mdiXzIdjtr597PNWLiJ7mhVK8UYR7YK9MFqnnxreNrsJtmqK0ZoT
         N15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627926; x=1692219926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awzkgsvZFBo842DWA8GT/abxr3wtZvlfdq0myNlPQ4k=;
        b=NJ29tlObsBAd5EzG64+UkSzOPbjdFWKsL93+MsbkQFKYSQK4EmBaHB6ku+AhgcO1wi
         bVDrfjqIJDjJfNbdCLUvdNvQO4CQwUp2Fo3Lk7a0heBGNXKEt8QtnAz3PncN9jeqBvnJ
         bMhBKVlqplTHgy1R2bWOJZdc8drg/3vSrWnonatpqwwvbHMmYsK4UUrawLVawihRt+qy
         ZK7YF53pUPqLChCHOliNSSNp1fy3giYS6Q65TK+GRMISjzT2VCPWnfC5TtPxzHqz7po/
         305qBl3A+ynX5G0yIBKPXlhAL7K0OhhGHXqSQjl+dRflob44LBdYHEE3y5v3A4m+yBBo
         Serg==
X-Gm-Message-State: ABy/qLbojb3nPxa3YMJNP7SXByNxTsVKGADWBRucWM0lL0UZY34+T+Ir
        qFq2xSwvmHQenOKazuKm9uAUHP9QpPMdNg==
X-Google-Smtp-Source: APBJJlFKSOND1F33J/v+4OdmvuxGHksMnvG+758Ztby9qh3hCqyUqoXyGkwOLkpopxnFYkuBPAAUfA==
X-Received: by 2002:a05:6808:1b24:b0:3a1:ee4b:b8ee with SMTP id bx36-20020a0568081b2400b003a1ee4bb8eemr14664284oib.53.1689627925732;
        Mon, 17 Jul 2023 14:05:25 -0700 (PDT)
Received: from geday ([2804:7f2:8006:9fa1:c980:8323:c7fc:1b46])
        by smtp.gmail.com with ESMTPSA id x9-20020a056808144900b0039ee1de4e6esm127677oiv.38.2023.07.17.14.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:05:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 18:05:15 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot <syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [alsa?] memory leak in snd_seq_create_port
Message-ID: <ZLWtCzdW8lbdzZ4Z@geday>
References: <00000000000098ed3a0600965f89@google.com>
 <87v8ekattg.wl-tiwai@suse.de>
 <ZLQ/zKgTGMHy/6Jn@geday>
 <CACT4Y+bXLZf9iAgiLcxo7coNsOCsn_1C26zuvNBa48qLp2Juxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bXLZf9iAgiLcxo7coNsOCsn_1C26zuvNBa48qLp2Juxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:02:07AM +0200, Dmitry Vyukov wrote:
> 
> Hi Geraldo,
> 
> What exactly is cryptic in the report? Is there anything that can be
> done to make it less cryptic?

Hi again, Dmitry.

Perhaps also a bad choice of words. Cryptic borders on the undecipharable
while esoteric is the more proper word here. Those kernel hackers with
esoteric C and assembly skills like Takashi Iwai or you will quickly
infer that a kfree() is missing in such and such scope.

In my other message, I meant to say that such esoteric knowledge is
barely possessed by a novice kernel hacker, and they end up adding noise
to the lists specially if they are involved in the patch acceptance
process, specially as author of the patch, which I'm neither in this
case.

Now, if somebody were to apply LLMs to the build and checker bots and
actually get to a point where they were getting good patch propositions
from the machine rather than a bunch of hallucinations, that would be
quite the feat. It's only a faint dream right now, but you did
specifically ask for the "vision" :)

Thank you,
Geraldo Nascimento
