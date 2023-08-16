Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5277EB22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbjHPU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346323AbjHPU5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:57:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886F271D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:57:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26b7c16556eso1461287a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219437; x=1692824237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTnRjDgF03Eifi7sf3kpv96X0kZ1CgBBnY922J5YppA=;
        b=YrnJuLkKAUI9GOoFGUyMxaW0N4JvwWCdrMEG+WXxw28UwGdvMagNkGayO+D+VNRv7W
         tdSXtKKS34K9MQ4zDTHtW6q2rQmnBOa1Cm/YWl1qMYvmdTxQHD3MejqhxJNse7BFpFZ4
         taJO9DBM9v9B7HzFifZ/3iQ27MxXyE1MvyhG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219437; x=1692824237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTnRjDgF03Eifi7sf3kpv96X0kZ1CgBBnY922J5YppA=;
        b=WDtsKO/Ptri9kLDSWwg2Tuj3VdcENgatPrywRjrnR9wH1iHxF77A2rH0obPQ1eFCry
         C+f4bm9m8p8v/dUCLI/UZzQTiW8DtMNFXb4EfZsN6iSP19XcrQzgUoARpdS5zbHuYca+
         UboHeC2kh5O6qQr9p02ECFdyMQVXp5zdgVn8qXP1VNAymk0FtCPVbrf/QBhQRbJrEAcb
         faFcHtj3goo8uo998rgGJetHRdBfLycdxpKFBC1iqVSuwbf3v4yyNfqAcmdMt19Z4rK5
         ra0G6yDJ5BvtKSlpXGY+qdKF//nQsz00BzpQc3IZNHooiFfi/mFa1wDWQryjeLPr/joo
         3Rzw==
X-Gm-Message-State: AOJu0YxkygquwR64AXMZOfQ1JB0xf4SNXQc4srBk0EL1HTYZC7ALh5cB
        Z499LQkgWU0qA/W9cLzCPthCUw==
X-Google-Smtp-Source: AGHT+IG3SG9qeo0oZfUja9go8C9ZZOvux73Nr1ZbS1VQ53Pv2p6wh5BCDdxyWq4rcnvjgBR0dMyodw==
X-Received: by 2002:a17:90a:e38a:b0:268:e43a:dbfd with SMTP id b10-20020a17090ae38a00b00268e43adbfdmr2746938pjz.1.1692219436996;
        Wed, 16 Aug 2023 13:57:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b002680f0f2886sm158262pjb.12.2023.08.16.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:57:16 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:57:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <202308161356.4AED47263E@keescook>
References: <ZN02iLcZYgxHFrEN@work>
 <ZN02wFqzvwP2JI-K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN02wFqzvwP2JI-K@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:51:12AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 16, 2023 at 02:50:16PM -0600, Gustavo A. R. Silva wrote:
> > Change the notation from pointer-to-array to pointer-to-pointer.
> > With this, we avoid the compiler complaining about trying
> > to access a region of size zero as an argument during function
> > calls.
> 
> Haha, I thought the functions were actually accessing the memory. This can't
> be an intended behavior on the compiler's side, right?

I think it's a result of inlining -- the compiler ends up with a case
where it looks like it might be possible to index a zero-sized array,
but it is "accidentally safe".

-- 
Kees Cook
