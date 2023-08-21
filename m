Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F40782DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjHUQFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHUQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:05:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E9A6E4;
        Mon, 21 Aug 2023 09:04:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5E2D2F4;
        Mon, 21 Aug 2023 09:05:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.4.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D27183F64C;
        Mon, 21 Aug 2023 09:04:57 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:04:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: Re: [PATCH] samples: ftrace: replace bti assembly with hint for
 older compiler
Message-ID: <ZOOLIsVkwk40X_Ex@FVFF77S0Q05N>
References: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
 <CABRcYmJkt3AYL1T57415JBLa7kT9LWuWx-oGZf5Lvn9nskyhSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABRcYmJkt3AYL1T57415JBLa7kT9LWuWx-oGZf5Lvn9nskyhSw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:41:21PM +0200, Florent Revest wrote:
> On Sun, Aug 20, 2023 at 1:10 PM GONG, Ruiqi <gongruiqi@huaweicloud.com> wrote:
> >
> > When cross-building the arm64 kernel with allmodconfig using GCC 9.4,
> > the following error occurs on multiple files under samples/ftrace/:
> >
> > /tmp/ccPC1ODs.s: Assembler messages:
> > /tmp/ccPC1ODs.s:8: Error: selected processor does not support `bti c'
> >
> > Fix this issue by replacing `bti c` with `hint 34`, which is compatible
> > for the older compiler.
> 
> I see this hint is already used in
> tools/testing/selftests/arm64/fp/rdvl.S but I'm curious why it isn't
> used in other parts of the kernel like
> arch/arm64/kernel/entry-ftrace.S or
> tools/testing/selftests/arm64/bti/syscall.S

For assembly files, the macro in arch/arm64/include/asm/assembler.h handles
this automatically. See commit:

  9be34be87cc8d1af ("arm64: Add macro version of the BTI instruction")

For inline asembly, we need to explicitly instantiate all of that in the inline
asm block, and since clang treats each asm block independently, we can'y just
define that in one place in a header somewhere.

I'll reply to the patch in a sec...

Mark.
