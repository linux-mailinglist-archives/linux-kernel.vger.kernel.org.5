Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE45801151
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjLAQtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLAQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:49:49 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3164CF;
        Fri,  1 Dec 2023 08:49:55 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cdd13c586fso2141752b3a.0;
        Fri, 01 Dec 2023 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701449395; x=1702054195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11ou66UluPNip5iPUEMz1bOTL6KFvy+e30+wBtqFO7k=;
        b=CUAy4dfTVnX5DrY48LOC1WY07/u6O1lv2J8O+QEgaP3tQM7+xUcdo4bVG1j3gfu/zw
         7qYss6g8R4ktwhrHZvoS/bKQHKTAWzBNQVsrPxI1gZnKy3ACr70adXBfaCbV/jfNZdvt
         y7f5jVV2n+caGywjHYdmU3TZ91gRoUhcm/CHx+LD5d295Fmof4Su1TT29b2yXgRPR5gH
         VDHc5Sy7T23lcoeuZKMCfsjNu5ORwEzggp4pyZiE8Fzg4lnaKXjehDN1DN5eGuGNwSE9
         vIgTD78QaQ6Ij5jMb9o9G/BAHv9jugObEWuwTZqB5b3hm6RKXpkzAGt4gblnAGfDU0M6
         fGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449395; x=1702054195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11ou66UluPNip5iPUEMz1bOTL6KFvy+e30+wBtqFO7k=;
        b=cwIJxQD/6SdhFj1bvNih4twjowubSrxoFQomaPE6zrCmxKbZoEzLFIsgut9eScOvmv
         rIXjdHYOpT5blvtHlCu5Jo101pVRuPomzEjMs+XpBmmyo4EbpMFR9atR+Hhny249tDqY
         uoojtNuJnkouOAC/e79MvCX/VJyF825P/2pQHhyEVRB3QDiQJFrqApJ448g5Gmb75Tlh
         dCpdK6iDoq3KEvjyRdbKf8RaSE9luL139y963INp7p/EQ43VqgSYIGf4TBjLIVz8dozP
         AiaerbfvwIC4PTXzLpEOrmN9TArYQcnv7l6lWP8VoFEm1ivlxnHdZg7IjLI0p/GAQ3sQ
         i/jQ==
X-Gm-Message-State: AOJu0YzzzzCENSKbxqFd1gkUtyXZ/oFvR8TteU5wJshVKsaDBrMSC5yz
        Hu/mgWmSRb1VaOGgBLUvrNY=
X-Google-Smtp-Source: AGHT+IGmo9alJqDNAbyy72Z1TYkvlIwxF3W9YJmNJvz2d2NFr4GBdh4nRx8GimlOEVnVBiMStIaBHg==
X-Received: by 2002:a05:6a00:1d01:b0:6be:4228:698b with SMTP id a1-20020a056a001d0100b006be4228698bmr28845548pfx.20.1701449395051;
        Fri, 01 Dec 2023 08:49:55 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b006cbb56d4e58sm3195075pfo.65.2023.12.01.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:49:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 1 Dec 2023 06:49:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix documentation for cpu.idle
Message-ID: <ZWoOsIH1QGW80kL6@slm.duckdns.org>
References: <20231201005203.309873-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201005203.309873-1-joshdon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:52:03PM -0800, Josh Don wrote:
> Two problems:
> 	- cpu.idle cgroups show up with 0 weight, correct the
> 	  documentation to indicate this.
> 	- cpu.idle has no entry describing it.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun
