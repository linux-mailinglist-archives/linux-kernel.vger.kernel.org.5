Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0F7B98E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbjJDXtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbjJDXs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:48:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E09CE;
        Wed,  4 Oct 2023 16:48:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EAFC433C7;
        Wed,  4 Oct 2023 23:48:53 +0000 (UTC)
Date:   Wed, 4 Oct 2023 19:50:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Raymond <raymod2@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-serial <linux-serial@vger.kernel.org>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH v3] arch/x86: port I/O tracing on x86
Message-ID: <20231004195001.76a57417@gandalf.local.home>
In-Reply-To: <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
        <2023100344-dart-jailbreak-c371@gregkh>
        <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 16:54:20 -0600
Dan Raymond <raymod2@gmail.com> wrote:

> With one exception io.h is included from boot.h or misc.h which is where
> the include guards are defined:
> 
> # find arch/x86/boot -type f -print0 | xargs -0 grep "#include.*[^a-z]io\.h"
> arch/x86/boot/boot.h:#include "io.h"
> arch/x86/boot/compressed/misc.h:#include "../io.h"
> arch/x86/boot/compressed/tdx.c:#include "../io.h"
> arch/x86/boot/io.h:#include <asm/shared/io.h>
> 
> I agree this is fragile but the problem is not confined to this patch.
> If I add a call to rdmsr() or wrmsr() in arch/x86/boot/compressed/misc.c
> I get the same compiler error.  It has something to do with the inline
> assembly inside arch/x86/include/asm/jump_label.h.

Doesn't arch/x86/boot/* code create an image that is separate from the core
vmlinux? That is, that code doesn't implement jump label logic nor sections.

> 
> I've copied Steven Rostedt who is the maintainer of tracefs to see if he
> has any comment.  I just noticed arch/x86/boot/msr.h and I see that it
> redefines rdmsr() and wrmsr() and omits the tracepoints.  A comment there
> explains:
> 
> /*
>  * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
>  * boot kernel since they rely on tracepoint/exception handling infrastructure
>  * that's not available here.
>  */
> 
> We could do something similar for inb()/outb() and redefine them in
> arch/x86/boot/io.h instead of including <asm/shared/io.h> there.

That would be a saner approach.

-- Steve

