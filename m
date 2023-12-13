Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7F8106DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377912AbjLMAn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjLMAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:43:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A8CAC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:44:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D94C433C8;
        Wed, 13 Dec 2023 00:43:58 +0000 (UTC)
Date:   Tue, 12 Dec 2023 19:44:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>,
        "Stanislav Kinsburskii" <skinsburskii@linux.microsoft.com>,
        <arnd@arndb.de>, <pbonzini@redhat.com>,
        <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/15] tracing: Introduce names for ring buffers
Message-ID: <20231212194441.2701c48b@gandalf.local.home>
In-Reply-To: <eb567d99-e03b-4718-9cc9-e27c5e408ea2@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
        <20231213000452.88295-9-graf@amazon.com>
        <20231212191546.603c0703@gandalf.local.home>
        <eb567d99-e03b-4718-9cc9-e27c5e408ea2@amazon.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 01:35:16 +0100
Alexander Graf <graf@amazon.com> wrote:

> > The trace_array is the structure that represents each tracing instance. And
> > it already has a name field. And if you can get the associated ring buffer
> > from that too.
> >
> > struct trace_array *tr;
> >
> >          tr->array_buffer.buffer
> >
> >          tr->name
> >
> > When you do: mkdir /sys/kernel/tracing/instance/foo
> >
> > You create a new trace_array instance where tr->name = "foo" and allocates
> > the buffer for it as well.  
> 
> The name in the ring buffer is pretty much just a copy of the trace 
> array name. I use it to reconstruct which buffer we're actually 
> referring to inside __ring_buffer_alloc().

No, I rather not tie the ring buffer to the trace_array.

> 
> I'm all ears for alternative suggestions. I suppose we could pass tr as 
> argument to ring_buffer_alloc() instead of the name?

I'll have to spend some time (that I don't currently have :-( ) on looking
at this more. I really don't like the copying of the name into the ring
buffer allocation, as it may be an unneeded burden to maintain, not to
mention the duplicate field.

-- Steve
