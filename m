Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2238094DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjLGVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjLGVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:46:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5AA10D8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:46:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82810C433C8;
        Thu,  7 Dec 2023 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701985580;
        bh=+fl5qkjwkyyMabRO9KAPlA6pbDn3eiAn7N0EPxruPWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iCpHFd8ZdxULNz4m+zE/TMzDhAC7/t5yV6DaYENPwXY/O//QuIkZOn84nL13ML8KU
         QbSJQRL5Ea7aSsINp7jfXo+xVS5wGrXoGxY/d5FOG+jtmij58UyluG50yyrooBAZby
         odvViUpFceH5v//h1j0T4YyottgJWklRLznYE9sQ=
Date:   Thu, 7 Dec 2023 13:46:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 0/6] lib/group_cpus: rework grp_spread_init_one() and
 make it O(1)
Message-Id: <20231207134619.52545aaf4e5f393618a92c41@linux-foundation.org>
In-Reply-To: <20231207203900.859776-1-yury.norov@gmail.com>
References: <20231207203900.859776-1-yury.norov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 12:38:54 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> grp_spread_init_one() implementation is sub-optimal because it
> traverses bitmaps from the beginning, instead of picking from the
> previous iteration.
> 
> Fix it and use find_bit API where appropriate. While here, optimize
> cpumasks allocation and drop unneeded cpumask_empty() call.

Thanks.  This isn't my playground, but I'll grab the patches to at
least get them some testing.  Review from those who have worked
on this code would be appreciated.
