Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2877C49E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjHOArw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjHOAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D31710
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E7A61DBA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C6AC433C7;
        Tue, 15 Aug 2023 00:47:24 +0000 (UTC)
Date:   Mon, 14 Aug 2023 20:47:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/synthetic: use union instead of casts
Message-ID: <20230814204723.0fd326c0@gandalf.local.home>
In-Reply-To: <de9b98fe665f4062b5a7eeaa726c547d@AcuMS.aculab.com>
References: <20230809071459.2004931-1-svens@linux.ibm.com>
        <20230809085449.453b632a@gandalf.local.home>
        <de9b98fe665f4062b5a7eeaa726c547d@AcuMS.aculab.com>
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

On Mon, 14 Aug 2023 11:34:20 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> > No need to create a structure around a single element union. Also, I would
> > like to name it for what it is for.
> > 
> > union trace_synth_field {
> > 	u8				as_u8;
> > 	u16				as_u16;
> > 	u32				as_u32;
> > 	u64				as_u64;
> > 	struct trace_dynamic_info	as_dynamic;
> > };
> > 
> > Other than that, the patch looks good. Although I still need to test it.  
> 
> I was wondering if you need the u8 and u16 members at all?
> Can't the values just be treated as 32bit?
> Both char and short aren't really 'proper' arithmetic types.

Not sure what you mean by "arithmatic types".

If you do something like:

 ~# echo 's:skb u16 protocol; u64 delta;' >> /sys/kernel/tracing/dynamic_events
 ~# echo 'hist:keys=skbaddr:ts=common_timestamp.usecs' >> /sys/kernel/tracing/events/net/netif_receive_skb/trigger
 ~# echo 'hist:keys=skbaddr:delta=common_timestamp.usecs-$ts:onmatch(net.netif_receive_skb).trace(skb,protocol,$delta)' >> /sys/kernel/tracing/events/skb/kfree_skb/trigger

Where it records the protocol as u16, I'm guessing that if we didn't use
this union, it might break on BIG_ENDIAN machines.

For reference, the kfree_skb event looks like:

system: skb
name: kfree_skb
ID: 1735
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:void * skbaddr;   offset:8;       size:8; signed:0;
        field:void * location;  offset:16;      size:8; signed:0;
        field:unsigned short protocol;  offset:24;      size:2; signed:0;
        field:enum skb_drop_reason reason;      offset:28;      size:4; signed:0;

-- Steve
