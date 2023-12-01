Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77C800AB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378796AbjLAMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378776AbjLAMSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:18:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946EF1B4;
        Fri,  1 Dec 2023 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FAas7mu+OH2ZpUNv/i/XfzAOSAkuh02Ju9j9sSGd80U=; b=D57ulvjQDCI++VntFACHyMIkYN
        yX+n3xXk3VNW5qwCVy2GxdeSSyDeoHDSKQmLy36obgS4Z4RP0VwaBwRzIivwoErbxnj1ZKoZUKfba
        8/m2FSeUG18nPOUP0MhBPEuctsb2QsBS1V1ZERwH5nphcSq+AMS9x5oEOAhBj3KLSmYR3Z2ecPDDV
        zMrVqq+F2zo5O0tb8/Fim4fMDpRyXC+NWpNLtDbgq7nPPnwt3dOw1H2WSS6zMhnQ3VLrD9wf+zZXk
        QXThbq9e41Y/JVkPbiAqMGIffmxuyUtFmpar2J6ydnxWGzpwpQ/zkdngPhg7ngjyFblX9OIT2jogA
        nTCxCNtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r92TB-002CIy-35;
        Fri, 01 Dec 2023 12:18:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 958A230040C; Fri,  1 Dec 2023 13:18:08 +0100 (CET)
Date:   Fri, 1 Dec 2023 13:18:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Jann Horn <jannh@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/core] locking/mutex: Document that mutex_unlock()
 is non-atomic
Message-ID: <20231201121808.GL3818@noisy.programming.kicks-ass.net>
References: <20231130204817.2031407-1-jannh@google.com>
 <170142744948.398.4203675877225809071.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170142744948.398.4203675877225809071.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:44:09AM -0000, tip-bot2 for Jann Horn wrote:

> --- a/Documentation/locking/mutex-design.rst
> +++ b/Documentation/locking/mutex-design.rst
> @@ -101,6 +101,12 @@ features that make lock debugging easier and faster:
>      - Detects multi-task circular deadlocks and prints out all affected
>        locks and tasks (and only those tasks).
>  
> +Releasing a mutex is not an atomic operation: Once a mutex release operation

I still object to this confusing usage of atomic. Also all this also
applies to all sleeping locks, rwsem etc. I don't see why we need to
special case mutex here.

Also completion_done() has an explicit lock+unlock on wait.lock to
deal with this there.
