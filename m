Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5A7878F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbjHXTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbjHXTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:47:46 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCAE19A1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:47:44 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68a48df712bso321566b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692906464; x=1693511264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6JCfcLVO4SvmssOWNOksTxj1g6uZP7ewn4ZDSyF/b3U=;
        b=XjIFp0J59schxAEL01+EX9vJFIxm7OIpZXXJSnQhpXrn/fk2S2Jo4N0KTRYW3HFrMm
         Na07NOjHhedPyUZxX9Qy7YPS9uZcaCWU8NpHDEyQOdArZUH0mPZ4A1wqLxGBRVk+DXK7
         5+0Y0LlAsWJchFp/Gw0Qbn2yfZrwDxhqADfvTj3P/SqfjAAlgsThq6Imiv5y7IyP6zZB
         EdM8sLsVupfTv6XvgQHIR0fy5fC969oGiasYj3n0YtIPoM4JmQFz20yUhInTqJevXs5O
         UM5kLCoVCqg1no+9gKaWRaBJJPPN0N2qlDDMUIR+gbt6TaKyNT4N3pSBYl+0HqfnpWmw
         iK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692906464; x=1693511264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JCfcLVO4SvmssOWNOksTxj1g6uZP7ewn4ZDSyF/b3U=;
        b=G2/DHUsLYko8wa4yxmFFppLUkQdDbjLtFUBd6mNnv2+NMpL4NKfZA9QgrwPAyrGZvM
         tpaOSntw9mjXswsprY9I5tr3WkN9xHY6i+Ditznm+e36iXn50xOPDeT2pkGgwrrBDRGa
         PC3344Hl1kYvvbRxkyu506FOPTn9ikLhwowdLHWSC3gHznP5hb3JmeOE4bYnD4D1y04p
         QBvsnCmDgVAkB9WgFsDqqhYOkMWZc8gMsvTVRZg+9l6gHLop8MucPMgC0Tvghsmd+Lvh
         8T6lZ0YIz2jOIZ2jr9s/X+0WtsTnys6F1Y7W+m9parAoTshEgLDShbzi2oo3DLlvi5g5
         A09A==
X-Gm-Message-State: AOJu0YwwMsRcVG7z2DNNC4In0lR3BnvbW9PWIzjbBcTZAudyiRnRZ5fw
        4x3zvsup8EfDjcZUfjVW3ZdPARxuRRvwGg==
X-Google-Smtp-Source: AGHT+IFm3X/6AkbfmLyZZu2pCfdu8F6MCSiGC5VhI3AeNB1oY/sAdFdYyeeW0gA9yYkOBM0x/4tpyHtgwdvW4Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:1592:b0:68a:4bef:5faa with SMTP
 id u18-20020a056a00159200b0068a4bef5faamr6673227pfk.0.1692906463657; Thu, 24
 Aug 2023 12:47:43 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:47:41 +0000
In-Reply-To: <20230824181212.GA278867@cmpxchg.org>
Mime-Version: 1.0
References: <20230823225430.166925-1-nphamcs@gmail.com> <20230824181212.GA278867@cmpxchg.org>
Message-ID: <20230824194741.jodbu4v3m4gsqzow@google.com>
Subject: Re: [PATCH] memcontrol: ensure memcg acquired by id is properly set up
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        kernel-team@meta.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        yosryahmed@google.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 02:12:12PM -0400, Johannes Weiner wrote:
> +CC Shakeel
> 
> On Wed, Aug 23, 2023 at 03:54:30PM -0700, Nhat Pham wrote:
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > In the eviction recency check, we attempt to retrieve the memcg to which
> > the folio belonged when it was evicted, by the memcg id stored in the
> > shadow entry. However, there is a chance that the retrieved memcg is not
> > the original memcg that has been killed, but a new one which happens to
> > have the same id.
> > 
> > This is a somewhat unfortunate, but acceptable and rare inaccuracy in
> > the heuristics. However, if we retrieve this new memcg between its
> > allocation and when it is properly attached to the memcg hierarchy, we
> > could run into the following NULL pointer exception during the memcg
> > hierarchy traversal done in mem_cgroup_get_nr_swap_pages():
> > 
> > [ 155757.793456] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> > [ 155757.807568] #PF: supervisor read access in kernel mode
> > [ 155757.818024] #PF: error_code(0x0000) - not-present page
> > [ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
> > [ 155757.839985] Oops: 0000 [#1] SMP
> > [ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > [ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 00 48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 74 42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
> > [ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
> > [ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: ffff888280183000
> > [ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: ffff888bbc2d1000
> > [ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: ffff888ad9cedba0
> > [ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: ffff888b23a7b000
> > [ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 000007ffffc71354
> > [ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000) knlGS:0000000000000000
> > [ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 00000000007706e0
> > [ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 155758.091376] PKRU: 55555554
> > [ 155758.096957] Call Trace:
> > [ 155758.102016]  <TASK>
> > [ 155758.106502]  ? __die+0x78/0xc0
> > [ 155758.112793]  ? page_fault_oops+0x286/0x380
> > [ 155758.121175]  ? exc_page_fault+0x5d/0x110
> > [ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
> > [ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > [ 155758.148060]  workingset_test_recent+0xda/0x1b0
> > [ 155758.157133]  workingset_refault+0xca/0x1e0
> > [ 155758.165508]  filemap_add_folio+0x4d/0x70
> > [ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
> > [ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
> > [ 155758.191738]  filemap_read+0x68d/0xdf0
> > [ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
> > [ 155758.207981]  ? __napi_schedule+0x55/0x90
> > [ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
> > [ 155758.224601]  do_syscall_64+0x3d/0x80
> > [ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > [ 155758.242473] RIP: 0033:0x7f62c29153b5
> > [ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f7 ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
> > [ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
> > [ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 00007f62c29153b5
> > [ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 0000000000000076
> > [ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 0000000064d5230c
> > [ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 000000000003c041
> > [ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 000000000027d450
> > [ 155758.376661]  </TASK>
> > 
> > This patch fixes the issue by moving the memcg's id publication from the
> > alloc stage to online stage, ensuring that any memcg acquired via id
> > must be connected to the memcg tree.
> > 
> > Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs refault container")
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > Cc: stable@vger.kernel.org

Acked-by: Shakeel Butt <shakeelb@google.com>
