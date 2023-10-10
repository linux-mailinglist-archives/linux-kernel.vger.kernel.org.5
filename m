Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310E97BEF91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379197AbjJJAOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379115AbjJJAOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:14:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48AA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:14:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE39C433C8;
        Tue, 10 Oct 2023 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696896875;
        bh=zQK6y7u6qjXeMUWj/O9jsTYxx+DpeLYJg5CFzqy8x0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kwVhcizAsN80h0tCt2iFYIUN7yrErpynGIp1vjSejGl9TmwbhGgAINMH6t+xazN2D
         lEZTBL7xALnNa86mD3nica8e30tilKKsk0MWRVKM0UkxDVMPFeoJTHMD5kZO/ivbl/
         6chrKYnyZvzMQAZAb3IPmigGqjtSPW8raNPQNwGs=
Date:   Mon, 9 Oct 2023 17:14:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCHv5] mm: optimization on page allocation when CMA enabled
Message-Id: <20231009171415.cfc26b45c2f9f4489afe16c2@linux-foundation.org>
In-Reply-To: <CAGWkznHqQHMN1QXz7os7AQTYdzc3+LEq+z2bWOzLbiseV=560A@mail.gmail.com>
References: <1683782550-25799-1-git-send-email-zhaoyang.huang@unisoc.com>
        <20231006141750.5423083520f74bc0746fd249@linux-foundation.org>
        <CAGWkznHqQHMN1QXz7os7AQTYdzc3+LEq+z2bWOzLbiseV=560A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2023 15:54:40 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> > Roman previously asked
> >
> > : Also I'm a bit concerned about potential performance implications.
> > : Would be great to provide some benchmarks or some data.  Probably it's
> > : ok because of we have pcp caches on top, but I'm not 100% sure.
> >
> > Are you able to perform such testing and tell us the result?
> I have applied this patch in a v5.4 based ANDROID system and got no
> regression problem. Actually, this commit is aimed to have
> alloc_pages(GFP_USER) use CMA instead of stealing U&R(could lead to
> GFP_KERNEL fail) only when zone's free pages and free cma are around
> WATERMARK_LOW/MIN which would NOT affect most scenarios.

OK, thanks.

Could the appropriate people please take a look at this?  It has been
in mm-unstable since May.

Thanks.
