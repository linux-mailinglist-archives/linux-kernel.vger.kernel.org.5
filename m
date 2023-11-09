Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E627E649F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjKIHql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKIHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:46:40 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B134268D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:46:38 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f0f94a08a0so332592fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 23:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699515997; x=1700120797; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/+JlupkDMkqoU5uCh+PzR+ir4Ss/6wqjM2z/ZkKVT8=;
        b=LzvQSO+CgLZL3JP9JqE92Dfgrfry3wxqJ+rAa/fI2m1mqLvCTa0s8hvzfDn4eIMTtU
         RKdNRUPfDdykEzPQ6lICerqtFS3BHIbskFIriykqvodSWb8e79MuEPavnY/B7oMezvjD
         ukHS0zZWPoItpbZq0GETdc+lpgponbnzkIntz92CaD3qmvmvgJOe6fsXo+S7PbGbhbHw
         0CtDlds9tQ9tPuZmuP/H4Kv70/6UiLpTM8IM5tbug06hQgISMpiUkjpnm5U6KVdXXddu
         /46UQdBAbJ3FdbKpUOuFsdtKtkCvjMa/KGD4ndFF4cMPghfa5645Y2+Y/mLq7XrMj7TN
         a3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699515997; x=1700120797;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/+JlupkDMkqoU5uCh+PzR+ir4Ss/6wqjM2z/ZkKVT8=;
        b=LBj11447waEO9nwF9QLVvJv0dqYDQx2ZfDVHSSgPffsbUDveOJoOoup9MsnqC/aefb
         FzmQ3G467Ro0JH3sIOOlVRkVlYBDfcipEILD5LccpLNSe5Tt598bjGsElpr47Y5rcIGz
         Q+LQfJbSZenSrAUQzR0ei+zUyU0VTqWcx5/KaXAWGRFtE5eS2Wk1VFAfDZsLQwFznqiB
         5Mh4pVBAd3j4rqTveq1wUXys8/yMB5F/z/g/GZPAH/0MJahyQ98trc9hXfvzd6ibIFN+
         1PMSyAcpl0WXq2wW8juDEx0LFmMwtN3LSMnr0ZTn1/QvTEGRzpxxDhNLBQNlQ7bOjMn6
         rNxA==
X-Gm-Message-State: AOJu0Yw7fKFMs47Ft/HnH/fN0Lx5M9GrIMjasUjrfU8d57Tp+JLtvpC+
        KCM/k4lmrSdVV1hLfxIv5biqDxvHAssUczAkZxVDrg==
X-Google-Smtp-Source: AGHT+IFcvxX9FePStob/4xGAqXiLZnp72OF2HSNFxQO6szCfZH6z4KkXFDHNv0NB60K8V2ew2JbakA==
X-Received: by 2002:a05:6870:11c4:b0:1ef:f14e:6f4c with SMTP id 4-20020a05687011c400b001eff14e6f4cmr4149504oav.2.1699515997237;
        Wed, 08 Nov 2023 23:46:37 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g21-20020a056870a71500b001d6e9bb67d2sm629396oam.7.2023.11.08.23.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 23:46:36 -0800 (PST)
Date:   Wed, 8 Nov 2023 23:46:25 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Omkar Wagle <ov.wagle@gmail.com>
cc:     Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: shmem: Remove code sytle warnings
In-Reply-To: <20231109062228.10227-1-ov.wagle@gmail.com>
Message-ID: <134bb70e-db8a-0892-0a3c-d00ad57fcece@google.com>
References: <20231109062228.10227-1-ov.wagle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm not MM, style not sytle.

On Wed, 8 Nov 2023, Omkar Wagle wrote:

> Remove most of the code style warnings
> 
> Signed-off-by: Omkar Wagle<ov.wagle@gmail.com>
> ---
>  mm/shmem.c | 51 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 18 deletions(-)

Thanks for trying, but I'm sorry: very little of this is an improvement.

Almost all of it is just adding a blank line in between declaration and
code in some small block (including at least one from Linus himself).

checkpatch does a good job of encouraging tidy patches, but it makes no
claim to being right; and that particular nag annoys me more often than
any other (though I often grudgingly give in to it, just for a quiet life
- Cc'ing Matthew because I suspect he resents it even more than I do).

And look at those fsparams: Al and others have gone to the trouble of
lining them up nicely, but you've decided to undo their work.

I believe it's explained somewhere (but admit that a quick look in
Documentation didn't show me where), that checkpatch is something to run
to tidy up your patches, or new source files (or perhaps even staging);
but please don't send its advice on well-established source files.

Hugh
