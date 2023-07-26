Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B8764065
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGZUSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGZUSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F5D198D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B6661CBE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0FDC433C8;
        Wed, 26 Jul 2023 20:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690402719;
        bh=MMioSWLe0J+F5cA3VOGFUM/YW6sX+D23b5MfVPZqMwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BAp862XDg5jm4GYl6C/MPJCbU0NcJd6qPBVRi+my42pt/DpGQq+SWl6YIT7fPp2PL
         HcTDTo7GooY8BqKKq/e9K45b7acdnf/8e4JgzivN0rxkQUcPLhm+263tGJc5Oa2wxs
         G7HZ6q+3UPSjZyikhKl7/dD9hL3rjG9tai4JLO+c=
Date:   Wed, 26 Jul 2023 13:18:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrew Yang (=?UTF-8?B?5qWK5pm65by3?=) <Andrew.Yang@mediatek.com>
Cc:     "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Casper Li (=?UTF-8?B?5p2O5Lit5qau?=) <casper.li@mediatek.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] zsmalloc: Fix races between modifications of fullness
 and isolated
Message-Id: <20230726131822.22ac039ee4c696ea0726b510@linux-foundation.org>
In-Reply-To: <42f1209a686404ffd0f9dff05ed10a8d23383a11.camel@mediatek.com>
References: <20230721063705.11455-1-andrew.yang@mediatek.com>
        <20230726031846.GJ955071@google.com>
        <42f1209a686404ffd0f9dff05ed10a8d23383a11.camel@mediatek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 06:59:20 +0000 Andrew Yang (楊智強) <Andrew.Yang@mediatek.com> wrote:

> > Have you observed issues in real life? That commit is more than a
> > year
> > and a half old, so I wonder.
> > 
> Yes, we encountered many kernel exceptions of
> VM_BUG_ON(zspage->isolated == 0) in dec_zspage_isolation() and
> BUG_ON(!pages[1]) in zs_unmap_object() lately.
> This issue only occurs when migration and reclamation occur at the
> same time. With our memory stress test, we can reproduce this issue
> several times a day. We have no idea why no one else encountered
> this issue. BTW, we switched to the new kernel version with this
> defect a few months ago.

Ah.  It's important that such information be in the changelog!

I have put this info into my copy of the v1 patch's changelog.

I have moved the v1 patch from the mm-unstable branch into
mm-hotfixes-unstable, so it is staged for merging in this -rc cycle.

I have also added a cc:stable so that the fix gets backported into
kernels which contain c4549b871102.

I have added a note-to-self that a v2 patch is expected.
