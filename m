Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622347FC142
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjK1REv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjK1REu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:04:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C9510DF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HZdUDbEkCdxX7hgdMslzFvwF0wocTCuceHQlXsXEJWs=; b=ZSQ4hDkTuuQZQqPApK6FimXsMm
        lkaWn+EcACkIjtUQ1qFXrT7EILxGBVm+a/QGY32qxgQXMAbNZptJVMEh0hUuqLkuMB2dF/0zEgYVE
        zmfu2ue9oMRDeS0woOvCdp57PMdcBcq9J5XZSgYJzUGECRIpijmCQPbnepdXNumGBJkEtzhAZ+IzE
        ojbFyDGhNy42dWa4eYdWx0/3CLbKN0Y9dHQyAyIXRV6vrs5ajb9cTBawCtXjjH/iWM6rcZV8O/HUi
        VEWvlcRT+Z2iIm4KXd8v55nMGZMtm3V3rfnwc4oh8ANvYWUU151wxEh/cNrrvcm342lm6lHEu1h1+
        8nGVaSBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r81DM-00CXQf-D9; Tue, 28 Nov 2023 16:45:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C78E3003F0; Tue, 28 Nov 2023 17:45:35 +0100 (CET)
Date:   Tue, 28 Nov 2023 17:45:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     George Stark <gnstark@salutedevices.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, andriy.shevchenko@linux.intel.com,
        jic23@kernel.org, linux-kernel@vger.kernel.org,
        kernel@salutedevices.com
Subject: Re: [RFC PATCH 1/1] locking: introduce devm_mutex_init and
 devm_mutex_destroy
Message-ID: <20231128164535.GT8262@noisy.programming.kicks-ass.net>
References: <20231128000910.73784-1-gnstark@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128000910.73784-1-gnstark@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:09:10AM +0300, George Stark wrote:
> Using of devm API leads to certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init() and devm_mutex_destroy().
> 

Aside of the issue raised by Waiman, it is also very undesirable to
introduce EXPORT'ed symbols without a user. Please group this with a
patch that actually makes use of it.

No in-tree users, no export.
