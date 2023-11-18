Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0AE7F0151
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjKRRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:35:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394112B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:35:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA61C433C7;
        Sat, 18 Nov 2023 17:35:03 +0000 (UTC)
Date:   Sat, 18 Nov 2023 17:35:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 1/2] kmemleak: drop (age <increasing>) from leak record
Message-ID: <ZVj1xcqVRDr7gZYP@arm.com>
References: <20231116224318.124209-1-jim.cromie@gmail.com>
 <20231116224318.124209-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116224318.124209-2-jim.cromie@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:43:17PM -0700, Jim Cromie wrote:
> Displaying age is pretty, but counter-productive; it changes with
> current-time, so it surrenders idempotency of the output, which breaks
> simple hash-based cataloging of the records by the user.
> 
> The trouble: sequential reads, wo new leaks, get new results:
> 
>   :#> sum /sys/kernel/debug/kmemleak
>   53439    74 /sys/kernel/debug/kmemleak
>   :#> sum /sys/kernel/debug/kmemleak
>   59066    74 /sys/kernel/debug/kmemleak
> 
> and age is why (nothing else changes):
> 
>   :#> grep -v age /sys/kernel/debug/kmemleak | sum
>   58894    67
>   :#> grep -v age /sys/kernel/debug/kmemleak | sum
>   58894    67
> 
> Since jiffies is already printed in the "comm" line, age adds nothing.
> 
> Notably, syzkaller reads kmemleak only for "unreferenced object", and
> won't care about this reform of age-ism.  A few moribund github repos
> mention it, but don't compile.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
