Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2522875FCD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGXRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjGXRCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30C126
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B32612C3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BE6C433C8;
        Mon, 24 Jul 2023 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690218152;
        bh=rLqU/nB+rUejTdVyQxhj4EwtasTp+9R+SPZMl9FIjNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m7LSK7wQro8BflGIDWOzGEudiMg1YiZFbRMcqPVTow6mPPmKAL5kJH0x4IBJiwzUo
         CUC4wI7eGx0h0kxAyI0WFApArC+lPQHdJXQRYbtUblHuynjoaZsd3BBCJDM4xWYShy
         JMxK4nWprLqxEZsHwUNexpPR6rPAc6ZccK28k2s4=
Date:   Mon, 24 Jul 2023 10:02:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Remove unused parameters in page_table_check
Message-Id: <20230724100231.94abdfb007bea270d607a760@linux-foundation.org>
In-Reply-To: <CA+CK2bBb1YPXSU_YswN6hmf5pqDcc0O6KMw7C3nNCM0ztqm76Q@mail.gmail.com>
References: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
        <CA+CK2bBb1YPXSU_YswN6hmf5pqDcc0O6KMw7C3nNCM0ztqm76Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 17:48:31 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> On Thu, Jul 13, 2023 at 5:25 AM Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> >
> > Hi all, this series remove unused parameters in functions from
> > page_table_check. The first 2 patches remove unused mm and addr
> > parameters in static common functions page_table_check_clear and
> > page_table_check_set. The last 6 patches remove unused addr parameter
> > in some externed functions which only need addr for cleaned
> > page_table_check_clear or page_table_check_set. There is no intended
> > functional change. Thanks!
> 
> NAK
> 
> Both, mm and addr are common arguments that are used for PTE handling
> in many parts of memory management even when they are not used in
> every function.
> 
> Currently, they are not used in page table check, but it is possible
> we may need to use them in the future when support for other arches or
> different types of page tables (i.e. extended page table) is added. It
> is going to be hard to again modify all arch dependent code to add
> these arguments back.
> 
> Also, internally at Google we are using these arguments, as we have a
> module that maps user memory in a way that is incompatible with
> upstream, and these arguments are used to support this module.
> 

I don't think these are very good arguments for carrying cruft in the
mainline kernel.

If such an architecture is introduced in the future or if google
upstreams that module then we can restore one or both of these
arguments at that time.  This is hardly insurmountable:

 arch/arm64/include/asm/pgtable.h | 12 +++---
 arch/riscv/include/asm/pgtable.h | 12 +++---
 arch/x86/include/asm/pgtable.h   | 16 ++++----
 include/linux/page_table_check.h | 66 ++++++++++++--------------------
 include/linux/pgtable.h          |  6 +--
 mm/page_table_check.c            | 50 +++++++++---------------
 6 files changed, 65 insertions(+), 97 deletions(-)


