Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A267803E66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjLDTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjLDT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:29:59 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7288B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:30:05 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58e256505f7so1496254eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701718205; x=1702323005;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rkh649P5swTHC96T9y/w4miqT3snggWcTsKeWpqgnz4=;
        b=iwkEH/GoI7xz6BMBum5Qd2lt/0GTr2XhAEb0pTljj5aQfH8LN++GuSAECV7IcSSV5/
         nQs7TkGRLD9GvSzWyA3oaK+KRPOT9SM81nY+JCoeIvSCySnceyW9y3wiwW4UofbA/RGr
         R4fg/q7qOvQDfCwwePu08cLPFrlATb1wE7ZZGlsa+XZon5QZjGWJQiurUyKrujtNfDRO
         hQ7oZu0rtip9DBRNMMk5kZKGTGE4P421QIAlsrxDcIL5Id1UXSzxq4ei37TI43OuJJ3/
         d/4DE9zQ3Z1O90l+6Ln/J3JH3BV9PG/KKKtoneZVk/sq+J+Bg9xskCLq8PacVIiL5pPx
         QkAQ==
X-Gm-Message-State: AOJu0YwVaJJ3N4DAsKXszfHe+vZEPt2gk4ADvg4GCklBDSN063JF7Q4T
        ngZo2G08u7eXwG1hJjUIzvqN3x1a+rgLPdN4
X-Google-Smtp-Source: AGHT+IGhccHy9SqwR+G0d2RpkPE6ELIl/0DoQRxnwLQM1LSotUDm+ILilCD03/nynymSgcDoG0PGpg==
X-Received: by 2002:a4a:b388:0:b0:58e:1c47:879e with SMTP id p8-20020a4ab388000000b0058e1c47879emr3426535ooo.19.1701718204674;
        Mon, 04 Dec 2023 11:30:04 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bn29-20020a05620a2add00b0077d5c5af0c1sm4463804qkb.6.2023.12.04.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:30:04 -0800 (PST)
Date:   Mon, 4 Dec 2023 13:30:01 -0600
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com,
        aboorvad@linux.vnet.ibm.com, yu.c.chen@intel.com
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Message-ID: <20231204193001.GA53255@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
> Changes
> -------
> 
> This is v3 of the shared runqueue patchset. This patch set is based off
> of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> bandwidth in use") on the sched/core branch of tip.git.
> 
> v1 (RFC): https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/
> v2: https://lore.kernel.org/lkml/20230710200342.358255-1-void@manifault.com/

Hello everyone,

I wanted to give an update on this, as I've been promising a v4 of the
patch set for quite some time. I ran more experiments over the last few
weeks, and EEVDF has changed the performance profile of the SHARED_RUNQ
feature quite a bit compared to what we were observing with CFS. We may
pick this back up again at a later point, but for now we're going to
take a step back and re-evaluate.

Thanks,
David
