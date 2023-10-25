Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235CB7D70F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjJYPeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344230AbjJYPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:34:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B14012A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:34:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ba081173a3so919387766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1698248047; x=1698852847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBo1ApkgfdKsgDTFhS3SS7v+ogxu/lxLmTI2wTaTITw=;
        b=dwIh3jMqPiNk83VoAs0k0NG82I4jbwq+qf0/IiOyWdur6YCmijmTj94LWWosyy0TY6
         TeZO3TAqA1b+6kzCuzb6LDHIwqC00im6BLsEOeaEZ//JF2lqJAwR6vs7MeykUhVrPyTq
         cmeBbgWAx3FOEgp9M/HjNC3m3N4il0zoQTPCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698248047; x=1698852847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBo1ApkgfdKsgDTFhS3SS7v+ogxu/lxLmTI2wTaTITw=;
        b=sYF5ysSK9PsImZfsrm2B07Dxurid6uiHkhEyZpOMpuuFcKJXz84mQro/FbbMSbILGs
         lf3Ue9EHyp4oguAv4QPcQRVzJyxpsIjNA5tXCv9NRiWFkv76bEYuU2QsbaUd3UHIBAjV
         MYjurrg5DWzNPZatD3deoeM0urcMOzaFJ5CUFqQbu2kwpZYjQq6k6SyPfxllq8ewDVeI
         XZWO4fVOuztePAZ9uCT0qNauob6MUqFEaikBkMCSBrTxbhFmYOQIThRybIa1Oz6T0y4B
         JIcyI9C2H1kwN07NIHWb5ah+btNOrILGKXJB1i1vFoJVSpWKfqZ7rJTY8RIflnjubY9j
         byeA==
X-Gm-Message-State: AOJu0Yy6DUzjIkgFmOJ1JEB3ivCB/K5yRVSO9iseWqaB1uPjDWkzem9f
        0tHqONDhH77BsBHtkrrXrLhnUw==
X-Google-Smtp-Source: AGHT+IGxOAGMfYaY/ObsvmYgfZMoVmMQWfrVsQtYyMxpyUs2XRaeNy6S5HboVQznT/KzmMva/vXlBg==
X-Received: by 2002:a17:906:c109:b0:9c4:4b20:44a9 with SMTP id do9-20020a170906c10900b009c44b2044a9mr12682145ejc.65.1698248047473;
        Wed, 25 Oct 2023 08:34:07 -0700 (PDT)
Received: from [192.168.1.28] (77.33.185.10.dhcp.fibianet.dk. [77.33.185.10])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906081300b009c3827134e5sm10034477ejd.117.2023.10.25.08.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 08:34:07 -0700 (PDT)
Message-ID: <676c08bc-3714-4824-8743-cf98b45a5ab9@rasmusvillemoes.dk>
Date:   Wed, 25 Oct 2023 17:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Content-Language: en-US, da
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
References: <20231025054219.1acaa3dd@gandalf.local.home>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20231025054219.1acaa3dd@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 11.42, Steven Rostedt wrote:

> So, bit 1 is for user space to tell the kernel "please extend me", and bit
> two is for the kernel to tell user space "OK, I extended you, but call
> sched_yield() when done".
I'm not qualified to have an opinion on this. But this sounds quite
similar to
https://lore.kernel.org/lkml/1395767870-28053-1-git-send-email-khalid.aziz@oracle.com/
.

  "A thread sends the scheduler this request by setting a flag in
a memory location it has shared with the kernel.  Kernel uses bytes in
the same memory location to let the thread know when its request for
amnesty from preemption has been granted. Thread should yield the
processor at the end of its critical section if it was granted amnesty
to play nice with other threads."

Rasmus

