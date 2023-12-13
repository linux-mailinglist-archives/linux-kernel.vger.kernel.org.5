Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB3811035
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377662AbjLMLfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjLMLfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:35:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5647113
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:34:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BC4C433C8;
        Wed, 13 Dec 2023 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702467275;
        bh=FB61QkUhmBBoX1jpL4t7zTF9O9cz5293f+BUjVdgdW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZfPU5FvnLlC/I+TJW5gUU7zyoV7MBTQNtaFpkzsj9VeRiWrvdq3CMH1h0BOJ5ml0
         ufGA/f2+2nG3H/hNi4amKJKC2qJURsxYeCEWvdlxtSHxyQgQEWewxgH3erTU4pQraO
         TPqkNJJAnDB8/XdGC45i77mi+WDlVo4BEfsDIsbiOUsuX2rC1rFXDSZuBNUxLlLaom
         kcxWAn5+d/VFlIgUCxD6mP95YE/SYWqmxwiy0nMFMHDQTjhJrrbZk+W9MI05EvAO/E
         6K6E+gWBIz4RY99wpKrxQxQyypgrGzucaetlxwkVwNnWBEZqrENkTFf8Yby2AmbaFB
         XwybkoATIv6sw==
Date:   Wed, 13 Dec 2023 17:00:40 +0530
From:   Naveen N Rao <naveen@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/ftrace: Add test to exercize function tracer
 across cpu hotplug
Message-ID: <3juxoqz7kal42uowxfqvahtjpcla6mm6wv4dmoq7pxvjzg6f62@cwhzmibrqur4>
References: <20231212085607.1213210-1-naveen@kernel.org>
 <20231213094038.6c9518a2042b84c8388ec6ae@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213094038.6c9518a2042b84c8388ec6ae@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:40:38AM +0900, Masami Hiramatsu wrote:
> Hi Naveen,
> 
> On Tue, 12 Dec 2023 14:26:07 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
> 
> > Add a test to exercize cpu hotplug with the function tracer active to
> > ensure that sensitive functions in idle path are excluded from being
> > traced. This helps catch issues such as the one fixed by commit
> > 4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").
> > 
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> >  .../ftrace/test.d/ftrace/func_hotplug.tc      | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> > new file mode 100644
> > index 000000000000..49731a2b5c23
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
> > @@ -0,0 +1,30 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: ftrace - function trace across cpu hotplug
> > +# requires: function:tracer
> > +
> > +if ! which nproc ; then
> > +  nproc() {
> > +    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
> > +  }
> > +fi
> > +
> > +NP=`nproc`
> > +
> > +if [ $NP -eq 1 ] ;then
> > +  echo "We can not test cpu hotplug in UP environment"
> > +  exit_unresolved
> > +fi
> 
> This looks good, but can you find the 2nd online CPU before
> this test?
> I mean, there is a case that cpu1 is already offlined and others
> like cpu2 is onlined. So we need to use the 2nd online cpu.

Good point, thanks. I will send a v2.

- Naveen

