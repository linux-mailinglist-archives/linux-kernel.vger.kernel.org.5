Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478FD77CDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjHOOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbjHOOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEFF1989
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34058617A8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BC2C433C8;
        Tue, 15 Aug 2023 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692109319;
        bh=bGBR8hi9e7WbnYTJUGiwSN8u2LUtojucL5S3dEaViFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5jEHBDxJI9CLcgjJ4FNbw2JO7KSGQ86v6l9Abw/ciLLK14qenC0Q5rmWad8eJxlz
         Xi+F0CWymanP+h1Tc+5nF0OCpCXQS6EzViEmvYLElLLbAVLvpALqKyi7Q3kUT4UkLM
         NDJfxcVV0JJPS7KR+cFah4lZDwRmLmA6qzcSirCpsPGWIe/c62PYaVmgdxyH+Vv5qD
         ndhAotfen85FXyMehmU25CJFhKOr3RBrChSbYAXN99M36uRm35a90MlQFNF2RVtAdN
         SHRZYQHrhz0oTxfOviBvylROdeL2oxG1iQR9aLU2jwkNvbri2ZqgklfhjvtPBPCXew
         SdCFAC6RlEkOw==
Date:   Tue, 15 Aug 2023 07:21:57 -0700
From:   Chris Li <chrisl@kernel.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to
 zswap_load
Message-ID: <ZNuKBfNc8mygBjJf@google.com>
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
 <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
 <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com>
 <CAOUHufZWReio1bwzLFeJhi1YVko=kjxcfHo1sS8cfnBZuPaHFQ@mail.gmail.com>
 <CAJD7tka17GHTgu9JZNW8-CCsH2OR67oj31h53oa-oPTTVnkQQQ@mail.gmail.com>
 <CAOUHufYk7ZV=YPk6uGE1+ysgTKRXdwV8T3s7qvEkpGYbGNKwEw@mail.gmail.com>
 <CAJD7tkZoE5is2_pBHs5w7-4Am8HuWdbkBn89OYoHfbRv5rSKsQ@mail.gmail.com>
 <c98b1c02-4a3e-4b69-ad36-e07100a67398@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98b1c02-4a3e-4b69-ad36-e07100a67398@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yin,

On Fri, Aug 11, 2023 at 01:21:21PM +0800, Yin, Fengwei wrote:
> OK. I will stick to the current patch.

I think remove that warning is fine.

Feel free to add:

Reviewed-by: Chris Li (Google) <chrisl@kernel.org>

Chris

