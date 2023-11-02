Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3B77DF497
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376741AbjKBOHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376733AbjKBOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:07:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66D134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:07:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so13387511fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698934020; x=1699538820; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJf14iFZ//z8oXdEN/5ALUTxste1nDRztPjEP/BYpBA=;
        b=M5b7RKAy+0x16zpqn+QdzNUJV24T/xTUUqs7k1KUcgA/Yc9xdifYvp3gyfHcFW3upA
         cIjCsPN/avFH07KQLsy2KghCNf5hQZJW3bdu0rX9SvBrE8VAmR/H4tXKYW2GTqf/fWQC
         NQ5/UxXfPls7ne10Y7aMdrw7fLNvZcGg51UMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934020; x=1699538820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJf14iFZ//z8oXdEN/5ALUTxste1nDRztPjEP/BYpBA=;
        b=vfhsAwUIycjYY/nIDxPDvcBQs3bFxqFrW19NwJcWoWRlz3lxJteZqaLI3wa+4/dDPk
         5UUQ+qL+rUTH+gKeTNVuQDHriF2zOsEff4F6GhGGk+2eC5YkXFdJuhjKvnzrynnmW2Zo
         Zp0gm4cbP+gsNkQLnW0fIKz7O4xKlBOBTzGOSUsuyAG8M05WokbdOtj1mmr0JTz5R+qi
         /BzKL9ua/NLHd0QRL5j687mSl4HjDWUN9baTT2ICwbQei+k/ulFZKr65WKTBZekzvYjO
         VSgoP8fRZ+pbP5YLxpAmjoYCfyZoyc8I5wx+lDxUXVJpmytW/8wosC9oxs0MrgRVV5Y7
         xhnQ==
X-Gm-Message-State: AOJu0YzgML2GGj0sVnsS/UUGh2k9oqWlrhUP1oHV2Y34jIU17Tb5dWga
        V5P7tfjn/Ka9NN/btd/jtNCSkQ==
X-Google-Smtp-Source: AGHT+IG5nPlWA7R7eGHPSGYhtovJ3d+E1Is+Q4YfPCn1bU+jStUlofIxBF3b+P0gmSVrbLUcMHxIug==
X-Received: by 2002:a2e:a417:0:b0:2bd:102c:4161 with SMTP id p23-20020a2ea417000000b002bd102c4161mr16534595ljn.43.1698934020332;
        Thu, 02 Nov 2023 07:07:00 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c068800b004094c5d92bdsm2933888wmn.31.2023.11.02.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:06:59 -0700 (PDT)
Date:   Thu, 2 Nov 2023 14:06:57 +0000
From:   Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 1/2] mmc: cqhci: Add a quirk to clear stale TC
Message-ID: <ZUOtAePhW5O_40wV@google.com>
References: <20231027145623.2258723-1-korneld@chromium.org>
 <20231027145623.2258723-2-korneld@chromium.org>
 <e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com>
 <CAD=Nsqzg2zRNFx7E800vnpNH6bZeHv9zdAnZksJjiRcXOQ4t=A@mail.gmail.com>
 <63e54bfd-9bb3-423b-a965-e0a9b399671c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e54bfd-9bb3-423b-a965-e0a9b399671c@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 01:01:22PM +0200, Adrian Hunter wrote:
> On 2/11/23 11:21, Kornel Dulęba wrote:
> > On Mon, Oct 30, 2023 at 8:31 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 27/10/23 17:56, Kornel Dulęba wrote:
> >>> This fix addresses a stale task completion event issued right after the
> >>> CQE recovery. As it's a hardware issue the fix is done in form of a
> >>> quirk.
> >>>
> >>> When error interrupt is received the driver runs recovery logic is run.
> >>> It halts the controller, clears all pending tasks, and then re-enables
> >>> it. On some platforms a stale task completion event is observed,
> >>> regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.
> >>>
> >>> This results in either:
> >>> a) Spurious TC completion event for an empty slot.
> >>> b) Corrupted data being passed up the stack, as a result of premature
> >>>    completion for a newly added task.
> >>>
> >>> To fix that re-enable the controller, clear task completion bits,
> >>> interrupt status register and halt it again.
> >>> This is done at the end of the recovery process, right before interrupts
> >>> are re-enabled.
> >>>
> >>> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
> >>> ---
> >>>  drivers/mmc/host/cqhci-core.c | 42 +++++++++++++++++++++++++++++++++++
> >>>  drivers/mmc/host/cqhci.h      |  1 +
> >>>  2 files changed, 43 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> >>> index b3d7d6d8d654..e534222df90c 100644
> >>> --- a/drivers/mmc/host/cqhci-core.c
> >>> +++ b/drivers/mmc/host/cqhci-core.c
> >>> @@ -1062,6 +1062,45 @@ static void cqhci_recover_mrqs(struct cqhci_host *cq_host)
> >>>  /* CQHCI could be expected to clear it's internal state pretty quickly */
> >>>  #define CQHCI_CLEAR_TIMEOUT          20
> >>>
> >>> +/*
> >>> + * During CQE recovery all pending tasks are cleared from the
> >>> + * controller and its state is being reset.
> >>> + * On some platforms the controller sets a task completion bit for
> >>> + * a stale(previously cleared) task right after being re-enabled.
> >>> + * This results in a spurious interrupt at best and corrupted data
> >>> + * being passed up the stack at worst. The latter happens when
> >>> + * the driver enqueues a new request on the problematic task slot
> >>> + * before the "spurious" task completion interrupt is handled.
> >>> + * To fix it:
> >>> + * 1. Re-enable controller by clearing the halt flag.
> >>> + * 2. Clear interrupt status and the task completion register.
> >>> + * 3. Halt the controller again to be consistent with quirkless logic.
> >>> + *
> >>> + * This assumes that there are no pending requests on the queue.
> >>> + */
> >>> +static void cqhci_quirk_clear_stale_tc(struct cqhci_host *cq_host)
> >>> +{
> >>> +     u32 reg;
> >>> +
> >>> +     WARN_ON(cq_host->qcnt);
> >>> +     cqhci_writel(cq_host, 0, CQHCI_CTL);
> >>> +     if ((cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)) {
> >>> +             pr_err("%s: cqhci: CQE failed to exit halt state\n",
> >>> +                     mmc_hostname(cq_host->mmc));
> >>> +     }
> >>> +     reg = cqhci_readl(cq_host, CQHCI_TCN);
> >>> +     cqhci_writel(cq_host, reg, CQHCI_TCN);
> >>> +     reg = cqhci_readl(cq_host, CQHCI_IS);
> >>> +     cqhci_writel(cq_host, reg, CQHCI_IS);
> >>> +
> >>> +     /*
> >>> +      * Halt the controller again.
> >>> +      * This is only needed so that we're consistent across quirk
> >>> +      * and quirkless logic.
> >>> +      */
> >>> +     cqhci_halt(cq_host->mmc, CQHCI_FINISH_HALT_TIMEOUT);
> >>> +}
> >>
> >> Thanks a lot for tracking this down!
> >>
> >> It could be that the "un-halt" starts a task, so it would be
> >> better to force the "clear" to work if possible, which
> >> should be the case if CQE is disabled.
> >>
> >> Would you mind trying the code below?  Note the increased
> >> CQHCI_START_HALT_TIMEOUT helps avoid trying to clear tasks
> >> when CQE has not halted.
> > 
> > I've run a quick test and it works just fine.
> 
> Thank you!
> 
> > Your approach looks better than what I proposed, since as you
> > mentioned, doing it like this avoids some weird side effects, e.g. DMA
> > to freed memory.
> > Do you plan to include it in the other series that you posted yesterday?
> 
> Yes I will do that

Feel free to add "Tested-by: Kornel Dulęba <korneld@chromium.org>" and
maybe "Reported-by".
