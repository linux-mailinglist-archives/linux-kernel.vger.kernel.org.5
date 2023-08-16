Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8F077E1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245348AbjHPMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245355AbjHPMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE1F26BF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692190144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=adn1Ibcuzmro6h0mZjjUOuSCSetkIOXADlWA5APX9qs=;
        b=hWDSc4c9AY7qINMZ3BDDsKo5lI4IjOGRroI5xPKCk6lAeNVCkoDkx2+xrnidmpeJDmjjuz
        ULiRoCdME0yGKzBGdSpBmZLVvBBzNNzIekzLa9EO0f3LAtxXIRtRBYRjkBSFLKWUVEIbX0
        s6+qYxIh2COOqD2FccQuZLAtiGjQWTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-w0OC9vnhPg-geDYRjRDpqQ-1; Wed, 16 Aug 2023 08:48:58 -0400
X-MC-Unique: w0OC9vnhPg-geDYRjRDpqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6E03185A793;
        Wed, 16 Aug 2023 12:48:56 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF661121314;
        Wed, 16 Aug 2023 12:48:51 +0000 (UTC)
Date:   Wed, 16 Aug 2023 08:48:48 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        boqun.feng@gmail.com, swood@redhat.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, jstultz@google.com,
        juri.lelli@redhat.com, mgorman@suse.de, rostedt@goodmis.org,
        vschneid@redhat.com, vincent.guittot@linaro.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/6] sched: Extract __schedule_loop()
Message-ID: <20230816124848.GA641857@lorien.usersys.redhat.com>
References: <20230815110121.117752409@infradead.org>
 <20230815111430.288063671@infradead.org>
 <20230815223301.GC602899@lorien.usersys.redhat.com>
 <20230816100154.k6cmHUUp@linutronix.de>
 <20230816113945.GA639355@lorien.usersys.redhat.com>
 <20230816122007.W7OJW3Fx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816122007.W7OJW3Fx@linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:20:07PM +0200 Sebastian Andrzej Siewior wrote:
> On 2023-08-16 07:39:45 [-0400], Phil Auld wrote:
> > I do.  Admittedly I'm not an expert in how the wchan unwinding works but
> > we have a slightly older version of this patch in our kernel (schedule_loop
> > not __schedule_loop). When I added __sched it fixed it.   Maybe there
> > is something else but that seemed pretty obvious. 
> > 
> > 
> > /* Attach to any functions which should be ignored in wchan output. */
> > #define __sched		__section(".sched.text")
> > 
> > I can't explain why you are not seeing it.
> 
> as peterz pointed out, it is marked __always_inline so the compiler
> shouldn't make a separate function out of it.
> Could you check with _this_ series? The schedule_loop variant is in RT
> and does not have this inline thingy. So it would be good if the issue
> you report actually exists in the series that has been posted.
>

Hhm, yes.  I was looking at the issue in our tree when these patches
came by. Sorry... I seem to have glossed over the __always_inline.
That would certainly work as well and, of course, does explain why you
aren't seeing it.

read more. talk less :)


Cheers,
Phil

> > Cheers,
> > Phil
> 
> Sebastian
> 

-- 

