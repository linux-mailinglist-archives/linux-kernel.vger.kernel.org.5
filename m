Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A79774CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjHHVRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjHHVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB864421E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6994562C17
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 20:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A39C433C8;
        Tue,  8 Aug 2023 20:05:50 +0000 (UTC)
Date:   Tue, 8 Aug 2023 16:05:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: use union instead of casts
Message-ID: <20230808160547.59e6efd9@gandalf.local.home>
In-Reply-To: <yt9dv8dpphgt.fsf@linux.ibm.com>
References: <20230808142148.2652883-1-svens@linux.ibm.com>
        <20230808132726.08cabfbc@gandalf.local.home>
        <yt9dv8dpphgt.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 19:33:06 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > The "dynamic" I was using wasn't about the fields were dynamic (union), but
> > because the field the offset/len combo represents is of dynamic size. It's
> > used all over the trace_events code.
> >
> > I would have in include/linux/trace_events.h (right above struct trace_entry):
> >
> > /* Used to find the offset and length of dynamic fields in trace events */
> > struct trace_dynamic_info {
> > #ifdef CONFIG_CPU_BIG_ENDIAN
> > 	u16 offset;
> > 	u16 len;
> > #else
> > 	u16 len;
> > 	u16 offset;
> > #endif
> > };
> >
> > And then it kernel/trace/trace.h:
> >
> > union trace_synthetic_field {
> > 	u8				as_u8;
> > 	u16				as_u16;
> > 	u32				as_u32;
> > 	u64				as_u64;
> > 	struct trace_dynamic_info	as_dynamic;
> > };  
> 
> Ok.
> 
> > I could work on the part of the trace_dynamic_info if you want.  
> 
> Whatever you prefer. Should i update my patch and send it again, or do
> you want to adjust it?
>

How quickly do you need it. I can hopefully start working on it this week.

-- Steve

