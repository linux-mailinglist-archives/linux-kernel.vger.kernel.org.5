Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FB7B96AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbjJDVmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjJDVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:42:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553EC1;
        Wed,  4 Oct 2023 14:42:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F1C433C8;
        Wed,  4 Oct 2023 21:42:13 +0000 (UTC)
Date:   Wed, 4 Oct 2023 17:43:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004174321.5afa2fb6@gandalf.local.home>
In-Reply-To: <2f749ade-7821-00fa-ba34-e2d25cbad441@oracle.com>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
        <20231004092205.02c8eb0b@kernel.org>
        <20231004123524.27feeae7@gandalf.local.home>
        <20231004095431.1dd234e6@kernel.org>
        <20231004132955.0fb3893d@gandalf.local.home>
        <2f749ade-7821-00fa-ba34-e2d25cbad441@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 22:35:07 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> One thing we've heard from some embedded folks [1] is that having
> kernel BTF loadable as a separate module (rather than embedded in
> vmlinux) would help, as there are size limits on vmlinux that they can
> workaround by having modules on a different partition. We're hoping
> to get that working soon. I was wondering if you see other issues around
> BTF adoption for embedded systems that we could put on the to-do list?
> Not necessarily for this particular use-case (since there are
> complications with trace data as you describe), but just trying to make
> sure we can remove barriers to BTF adoption where possible.

I wonder how easy is it to create subsets of BTF. For one thing, in the
future we want to be able to trace the arguments of all functions. That is,
tracing all functions at the same time (function tracer) and getting the
arguments within the trace.

This would only require information about functions and their arguments,
which would be very useful. Is BTF easy to break apart? That is, just
generate the information needed for function arguments?

Note, pretty much all functions do not pass structures by values, and this
would not need to know the contents of a pointer to a structure. This would
mean that structure layout information is not needed.

-- Steve
