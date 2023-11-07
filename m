Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54CD7E4D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbjKGXaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjKGXaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:30:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B00B26A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:26:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc411be7e5so30815ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699399578; x=1700004378; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPPnskYZVL6mU7Q20mEI31+/XvVKTBOV8ZJ82vFZ/qQ=;
        b=uCH4VZunGoEi81bBKxmtxuk3uY2XzbgaeBI2+vNsESfUs09G1PRq5jKYTsRyVqiXjm
         Ms8+6q7SsbJYlWIwkvrH97YZlLGgTEX9r5Q2wzRC6jlFa9GlObjKga81v3tvIle8Hcpt
         hK9cfXzHKDDq2OiHMtawyEUV24pay4IICpxaLEt3vd42sG2Fnc1qClKBaGZmT8OqX1jf
         8A4B6R/twRP/nRzqnuvuIPtOVr4lUe9dMuZK1OGswg3s5B/BVVWyeP2/2emKPUaOU7KE
         BMaHFEuYQh6zaSyWsRjiOhajCTodi1hy+87S2xyD3C+LS67WFNuyAZo9TtxkMfPxIT9s
         r/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699399578; x=1700004378;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPPnskYZVL6mU7Q20mEI31+/XvVKTBOV8ZJ82vFZ/qQ=;
        b=ZklFLZP+qSjeDxE1MrQej1LSW7FTJbw+l28j8+u9iwMKou0pPh/9Yz8l3/HNwaa5Ja
         cfpcrH4S9sD7W/WGPykF12iD1LWLDfGrUDGzusEHs0Q9BQL9Lk/2dSskW0v1HaKYQ0MK
         6YoVpNzGZ4Pqg811wXvFNWFlW1Zf85Mr0tyOEEAmg+EFFYxlxWHB/CSJdfOFU3b+COkQ
         M/9GGhmqqavaHyVEG3RVFVfDouOicQLDb8d4GodxkxZ+fzGjdfiqB58wrnGsYpSDMLBg
         oh4KLi5BYjkaBAPCK5OQQqChdI2iO+bg2Jg7k4YRzTJdu2aIF/YC8JJVrWTwZV5+dxk4
         NbAg==
X-Gm-Message-State: AOJu0Yy4F/cQsLBHidJ8x43ZbjDQYNsSBkMHonOIGJEE9V/QfpSHYB8P
        JCMXrK1Ugu4vl2GUzw+qn+byN3m7aiXwyovww4IVMZp5
X-Google-Smtp-Source: AGHT+IHFsmQNwBUjEzHipgR3fAq4qBy4q9iht1RG03HgRtJsVGhoghnKBCawxutbEvgzUSHE/gC/Ig==
X-Received: by 2002:a17:902:8e82:b0:1cc:569b:1ddf with SMTP id bg2-20020a1709028e8200b001cc569b1ddfmr380249plb.18.1699399578086;
        Tue, 07 Nov 2023 15:26:18 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id cu1-20020a17090afa8100b0027d12b1e29dsm327114pjb.25.2023.11.07.15.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 15:26:17 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Barry Song <21cnbao@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/eevdf: Sort the rbtree by virtual deadline
In-Reply-To: <20231107090510.71322-3-wuyun.abel@bytedance.com> (Abel Wu's
        message of "Tue, 7 Nov 2023 17:05:08 +0800")
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
        <20231107090510.71322-3-wuyun.abel@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Tue, 07 Nov 2023 15:26:14 -0800
Message-ID: <xm26h6lxuovd.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abel Wu <wuyun.abel@bytedance.com> writes:

> Sort the task timeline by virtual deadline and keep the min_vruntime
> in the augmented tree, so we can avoid doubling the worst case cost
> and make full use of the cached leftmost node to enable O(1) fastpath
> picking in next patch.
>
> This patch also cleans up the unused max_vruntime() and adjusts pos
> for some functions.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---

I've run this through my tester and it agrees that it does fulfil the
EEVDF pick (though this implementation is trivial enough that that's
fairly obvious just by reading the code, which is a nice bonus upgrade).

And it makes sense that this would help for performance, and the
fastpath seems likely to trigger most of the time for even better
results.
