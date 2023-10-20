Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571837D13FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377860AbjJTQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377777AbjJTQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:28:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B58CA;
        Fri, 20 Oct 2023 09:28:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056B9C433C7;
        Fri, 20 Oct 2023 16:28:36 +0000 (UTC)
Date:   Fri, 20 Oct 2023 12:28:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Message-ID: <20231020122833.647bbc49@gandalf.local.home>
In-Reply-To: <9216f694-cce0-2b95-df34-e5b60538644a@quicinc.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
        <9216f694-cce0-2b95-df34-e5b60538644a@quicinc.com>
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

On Fri, 20 Oct 2023 09:03:59 -0600
Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:

> > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > index f78aefd2d7a3..3afa90a204fd 100644
> > --- a/drivers/bus/mhi/host/init.c
> > +++ b/drivers/bus/mhi/host/init.c
> > @@ -20,6 +20,9 @@
> >   #include <linux/wait.h>
> >   #include "internal.h"
> >   
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/mhi_host.h>  
> 
> This feels redundant to me.  A few lines ago we included internal.h, and 
> internal.h includes trace/events/mhi_host.h

It's not redundant. The #define CREATE_TRACE_POINTS enables the magic of
creating the tracepoints and trace events via the TRACE_EVENT() macro.

It should never be done in a header file, only in .c code!

The header file include of trace headers are used for having access to the
declarations of the functions. That is (trace_*()) in the code.

-- Steve
