Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B687C782D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjHUP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjHUP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:26:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BDF1;
        Mon, 21 Aug 2023 08:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE985619C0;
        Mon, 21 Aug 2023 15:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EF2C433C7;
        Mon, 21 Aug 2023 15:26:48 +0000 (UTC)
Date:   Mon, 21 Aug 2023 11:27:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-ID: <20230821112703.23b1964b@gandalf.local.home>
In-Reply-To: <20230822001639.7a3cbedc3ad6e3938ee76e16@kernel.org>
References: <169262755804.106231.8245792908363050528.stgit@devnote2>
        <20230822001639.7a3cbedc3ad6e3938ee76e16@kernel.org>
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

On Tue, 22 Aug 2023 00:16:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> BTW, even with this fix, blocking splice still causes a strange behavior.
> If I set '400' to buffer_size_kb (so 100 pages) and '1' to buffer_percent,
> splice always returns 8192 (2 pages) to read. But I expected that should
> return 4096 (1 page). This means splice() waits longer than I thought.
> 
> I think the fullfilled percentage calculation will be a bit wrong.

Note, the percentage is when to wake up the task. If between the wakeup and
the read/splice, another ring buffer page gets filled more, then it will
give that as well. The buffer_percent is just how long to wait, not for how
much to read.

Now if you test this with just adding enough to fill one page, and it
doesn't wake up the reader, then that would be a bug.

-- Steve
