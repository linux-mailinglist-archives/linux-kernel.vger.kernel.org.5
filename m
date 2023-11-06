Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF547E2CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjKFT2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:28:32 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA698
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:28:29 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so3157221a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1699298908; x=1699903708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mlzvkAJRzuQZnUx9+U36N20af1pAsethgx21gTjo+4o=;
        b=brfH2M5wBYZXqLt4JinyWrWM+NPX/Ps9+Jy08MnkU0W5VQJ7ayOOhtzEK/v3SfBj9Z
         caNi45PXXQzHixZRujGuNYuWjtolBMTdBkCZKmGw8lJtGgBamyIq/7snaHbHhTVYniYZ
         7gwB1onEiMR/BFQgASFgwsPQ2oWtRS7GOK1Z9zvXfOHeDg/yLIa7iR1WrOo8hHl7bQcZ
         5tIzvDQhYhLCchyd34MbWGl4xraypnen3AiPa1HMRVGxZwAF/hGMfGST+BOUT+bi/4y5
         oQUzq8HxjwHOjVCis2HbOpgLz+s+UfJy77CYqicTZvWpEHNE9h4T8vGUuK0oK1wcypvm
         nFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298908; x=1699903708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlzvkAJRzuQZnUx9+U36N20af1pAsethgx21gTjo+4o=;
        b=ZefW4nV9JYWozFM2UXW6K1mN188hRRY5GN3os5xj8twcLvGXUL0/Jx8fTafThRpVxx
         BNEuHIo0yVx4kdVL2QG6DKgM6DPCHCO1AlluBTzlFicvp610kCQXQQty/1MQFpDqloFi
         PqVv4vXoF31WVTRJ4ACnPCw5tApRfFk1rQIyzCIToJO3d7L9A3wl4QHyqOaY2AdDq5wb
         d13x639FKcEY5i1Euklz6tbjVpKnHss06h8HUtVKEoqkqgEGuXiePwJsy7ffSckpQg6Y
         1FL9le1t55j5ybgnO6KfkUA/IcFu/ofF/9lyEGkpDaNzwRHoXIz2gfu3M2V5HjRd58b7
         2vmw==
X-Gm-Message-State: AOJu0YxXcdfW2lEuhCfnkGELsdpkDB05XjfplDUMk61ZuiOC6W4YNAyB
        JqGHb/rqINWHD2VfBCibMNjtFg==
X-Google-Smtp-Source: AGHT+IGoMs3p/xp+2w/gcKq1uzQMmpxpoGkiwmFBR+1NzSnc9n7fN+/BGdPuKf2XBPGGt1/dGj4jPQ==
X-Received: by 2002:a05:6830:2b2a:b0:6d3:1f3e:4c4 with SMTP id l42-20020a0568302b2a00b006d31f3e04c4mr19267202otv.0.1699298908462;
        Mon, 06 Nov 2023 11:28:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:86b7])
        by smtp.gmail.com with ESMTPSA id jy5-20020a05622a818500b004181b41e793sm3660625qtb.50.2023.11.06.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:28:28 -0800 (PST)
Date:   Mon, 6 Nov 2023 14:28:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <20231106192827.GA3661273@cmpxchg.org>
References: <20231106181918.1091043-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106181918.1091043-1-shr@devkernel.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:19:18AM -0800, Stefan Roesch wrote:
> While qualifiying the 6.4 release, the following warning was detected in
> messages:
> 
> vmstat_refresh: nr_file_hugepages -15664
> 
> The warning is caused by the incorrect updating of the NR_FILE_THPS
> counter in the function split_huge_page_to_list. The if case is checking
> for folio_test_swapbacked, but the else case is missing the check for
> folio_test_pmd_mappable. The other functions that manipulate the counter
> like __filemap_add_folio and filemap_unaccount_folio have the
> corresponding check.
> 
> I have a test case, which reproduces the problem. It can be found here:
>   https://github.com/sroeschus/testcase/blob/main/vmstat_refresh/madv.c
> 
> The test case reproduces on an XFS filesystem. Running the same test
> case on a BTRFS filesystem does not reproduce the problem.
> 
> AFAIK version 6.1 until 6.6 are affected by this problem.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Co-debugged-by: Johannes Weiner <hannes@cmpxchg.org>

With the newline fix Willy pointed out, and CC: stable:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
