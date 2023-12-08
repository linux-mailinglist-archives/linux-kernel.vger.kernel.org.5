Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A380A57D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573963AbjLHObA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 09:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573929AbjLHOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:30:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0251738
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:31:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF08C433C7;
        Fri,  8 Dec 2023 14:31:01 +0000 (UTC)
Date:   Fri, 8 Dec 2023 09:31:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2 01/33] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
Message-ID: <20231208093133.62aae274@gandalf.local.home>
In-Reply-To: <CAG_fn=WHf0t=-OJL0031D+X7cX_D25G7TG0TqROsT34QcEnqsw@mail.gmail.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
        <20231121220155.1217090-2-iii@linux.ibm.com>
        <CAG_fn=WHf0t=-OJL0031D+X7cX_D25G7TG0TqROsT34QcEnqsw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 15:16:10 +0100
Alexander Potapenko <glider@google.com> wrote:

> On Tue, Nov 21, 2023 at 11:02 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > Architectures use assembly code to initialize ftrace_regs and call
> > ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> > ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> > KMSAN warnings when running the ftrace testsuite.  
> 
> I couldn't reproduce these warnings on x86, hope you really need this
> change on s390 :)

On x86, ftrace_regs sits on the stack. And IIUC, s390 doesn't have the same
concept of a "stack" as other architectures. Perhaps that's the reason s390
needs this?

-- Steve
