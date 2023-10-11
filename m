Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F07C5E92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjJKUlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjJKUlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:41:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7375C91;
        Wed, 11 Oct 2023 13:41:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85651C433C7;
        Wed, 11 Oct 2023 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697056871;
        bh=9EVT3HUYovZmBqwUKcOJz38R9MR6qb+rx5ZSOFAJ9lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02RpwIjpbOoci5puKNroyjLJgHAt6seKNkDwAusu4bGam+wq8f3YGxS7G+wBVqnuz
         Dw6oloGvQbw5TiygDfl1zByi+COf7BdLfGw3ZHTcjhe1N7VreagjPP/2eauIulOGWo
         lloPIOMBnqJARmSAQ6kpqzxtMuDzevzJz+PUK9Ow=
Date:   Wed, 11 Oct 2023 22:41:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <raymod2@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5] arch/x86: port I/O tracing on x86
Message-ID: <2023101129-dragonish-chaplain-ab30@gregkh>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
 <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
 <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
 <e92f5091-4e50-9241-5b60-39be101e70d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e92f5091-4e50-9241-5b60-39be101e70d6@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:22:14PM -0600, Dan Raymond wrote:
> On 10/7/2023 11:56 AM, Dan Raymond wrote:
> > Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
> > available on x86 via CONFIG_MMIOTRACE but that relies on page faults
> > so it doesn't work with port I/O.  This feature uses tracepoints in a
> > similar manner as CONFIG_TRACE_MMIO_ACCESS.
> > 
> > Signed-off-by: Dan Raymond <raymod2@gmail.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > V1 -> V2:
> >   - create header file for prototypes to silence new compiler warning
> >   - reduce CPU overhead to 2 instructions (no branching) when tracing disabled
> >   - fix imprecise IP logging by retrieving the IP off the stack instead of using
> >     compile time labels
> > 
> > V2 -> V3:
> >   - restore missing semicolon
> > 
> > V3 -> V4:
> >   - make GPL licenses consistent
> >   - change pointer arguments from (long) to (void *)
> >   - eliminate include guard checks and use -DDISABLE_TRACEPOINTS instead to
> >     disable tracepoints in arch/x86/boot/*
> >   - fix compiler warnings due to signed/unsigned mismatch in arch_cmpxchg64()
> > 
> > V4 -> V5:
> >   - add -DDISABLE_TRACEPOINTS to arch/x86/realmode/rm/Makefile
> 
> Can I get reviews on this please?

You sent it 3 days ago, please be patient, there is no need to demand
work from others so quickly, most of us are totally swamped.  If after 2
weeks or so with no review, then you can ask again.

In the meantime, to help us out, please do some patch review yourself on
the various mailing lists (the tty list can always use help.)  To ask
for work from others without helping out is not always good...

thanks,

greg k-h
