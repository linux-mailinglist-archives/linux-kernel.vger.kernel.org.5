Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F077C5EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjJKVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJKVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:15:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEF90;
        Wed, 11 Oct 2023 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vvi3y4Zo7BDr9Td0Xoqv7JTQTD0+hR4I6WbM3XPMj6w=; b=iKqqbqbIvJ1m6jWJxdwmmo5djA
        JfgqCqmRUjDjJXleEioLr6WuRpH+Lt8gL4C32vXd0pnZeahUsvVFZj8vUggmQZaPY7qU1EEhDBv08
        5egBn3sVzG709ADYqgxGD++qAauOyxARlFHA3xJn2H9z3PIH0Cs1TriiVL4FTJaCsT2kzF7MG+Mpq
        X/3EDo0WcnSgIHrJ4Zz2kH2Cifj/phSSHEEmiIceLox/iyQw3xwog1PdPn0vUjG2TiEeuQc4BYzaJ
        rGeMnkmBREOV9Zprb10DjD6u4lNCvc8cC+HploEhGO4dDawYfQE2pYG2Pxqwm0y37ng0dH5avDugk
        NwE5kiAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqgXm-00CzJT-7I; Wed, 11 Oct 2023 21:15:02 +0000
Date:   Wed, 11 Oct 2023 22:15:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, akpm@linux-foundation.org,
        sthanneeru@micron.com, ying.huang@intel.com,
        gregory.price@memverge.com
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted
 interleaving
Message-ID: <ZScQVjDzu0ttYPwC@casper.infradead.org>
References: <20231009204259.875232-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009204259.875232-1-gregory.price@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:42:56PM -0400, Gregory Price wrote:
> == Mutex to Semaphore change:
> 
> The memory tiering subsystem is extended in this patch set to have
> externally available information (weights), and therefore additional
> controls need to be added to ensure values are not changed (or tiers
> changed/added/removed) during various calculations.
> 
> Since it is expected that many threads will be accessing this data
> during allocations, a mutex is not appropriate.
> 
> Since write-updates (weight changes, hotplug events) are rare events,
> a simple rw semaphore is sufficient.

Given how you're using it, wouldn't the existing RCU mechanism be
better than converting this to an rwsem?
