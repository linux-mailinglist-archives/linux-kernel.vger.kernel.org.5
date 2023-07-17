Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D20756CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGQTAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGQTAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B418D;
        Mon, 17 Jul 2023 12:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B6E6120F;
        Mon, 17 Jul 2023 19:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C4CC433C8;
        Mon, 17 Jul 2023 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689620403;
        bh=xjUB7DSURlJVjw3aTLenO28aYfhi1Ynx5o2zj6uvl60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TCDX9mW2xTLLu2LpNLd88vbiS8AodhLwHViU6S9XU59ioLwM7CQFHYKTL8BYnk0Hy
         sr0fapooSzCsU/NffQuwhj9RLQilImtBbNZYG7zs5GdJRQF4QcMFbqsk31WNLPVLOF
         b/EpHyG9DfMuetTy4CfzdyQoyJIkFPaQJ/Tbkz+s=
Date:   Mon, 17 Jul 2023 12:00:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix hardware poison check in
 unpoison_memory()
Message-Id: <20230717120002.8da3920c4006295bfb5234cb@linux-foundation.org>
In-Reply-To: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
References: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 11:18:12 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> It was pointed out[1] that using folio_test_hwpoison() is wrong
> as we need to check the indiviual page that has poison.
> folio_test_hwpoison() only checks the head page so go back to using
> PageHWPoison().

Please describe the user-visible effects of the bug, especially
when proposing a -stable backport.
