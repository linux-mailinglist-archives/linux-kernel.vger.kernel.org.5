Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFC57B6F67
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbjJCRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:17:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CCA9B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:17:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F52DC433C8;
        Tue,  3 Oct 2023 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696353438;
        bh=7LsMWSQjmcjLR3WKocjQFGJwVbFoZzFKlIA/G0yofL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yMP49xPvcS99rsgy005XjHRwxlRHA1gCpQC8Ni3WzIqkb+yf/n6tkn+lISYSI3LQe
         iO9WoTD2rzm/HT2cVC/79WpkQ2l6HjSj+8L1J72bVpfsGIMsLwy4S11SatRJVCItbs
         aR7txXxrDpNDODeKBftgt8cj7l/+RiZUOmTzT5L0=
Date:   Tue, 3 Oct 2023 10:17:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Gregory Price" <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH] mm/migrate: fix do_pages_move for compat pointers
Message-Id: <20231003101717.f57af0208431dba6dac0357e@linux-foundation.org>
In-Reply-To: <f8d621c8-f5eb-4ba6-ab25-d3f782562abd@app.fastmail.com>
References: <20231003144857.752952-1-gregory.price@memverge.com>
        <20231003094912.08cf57998135446ef475dd19@linux-foundation.org>
        <325de88f-1237-4910-aa2a-97707bedae26@app.fastmail.com>
        <f8d621c8-f5eb-4ba6-ab25-d3f782562abd@app.fastmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 19:01:45 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Oct 3, 2023, at 18:57, Arnd Bergmann wrote:
> > On Tue, Oct 3, 2023, at 18:49, Andrew Morton wrote:
> >> On Tue,  3 Oct 2023 10:48:56 -0400 Gregory Price 
> >> <gourry.memverge@gmail.com> wrote:
> >>
> >>> do_pages_move does not handle compat pointers for the page list.
> >>> correctly.  Add in_compat_syscall check and appropriate get_user
> >>> fetch when iterating the page list.
> >>
> >> What are the userspace visible effects of this change?
> >
> > It makes the syscall in compat mode (32-bit userspace, 64-bit kernel)
> > work the same way as the native 32-bit syscall again, restoring the
> > behavior before my broken commit 5b1b561ba73c ("mm: simplify
> > compat_sys_move_pages").
> 
> More specifically, my patch moved the parsing of the 'pages'
> array from the main entry point into do_pages_stat(), which left
> the syscall working correctly for the 'stat' operation (nodes = NULL),
> while the 'move' operation (nodes != NULL) is now missing
> the conversion and interprets 'pages' as an array of 64-bit
> pointers instead of the intended 32-bit userspace pointers.
> 

Thanks.  So is a cc:stable warranted?
