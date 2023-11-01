Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F24B7DE70F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbjKAUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348048AbjKAUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:44:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1310D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:44:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D932C433C8;
        Wed,  1 Nov 2023 20:44:17 +0000 (UTC)
Date:   Wed, 1 Nov 2023 16:44:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] Fix: rseq uapi: Adapt header includes to follow glibc
 header changes
Message-ID: <20231101164415.7f198500@gandalf.local.home>
In-Reply-To: <f5bd06bb-da51-48c1-bf79-d1ef92802adf@efficios.com>
References: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
        <202310271556.LunB8KLv-lkp@intel.com>
        <81d2fd04-572d-48cd-bb5c-9a77937a79a0@efficios.com>
        <20231027100641.52fbee5d@gandalf.local.home>
        <f5bd06bb-da51-48c1-bf79-d1ef92802adf@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 16:10:04 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> So what is the minimal change required to make things work on your 
> setup? I just tested with a Debian "testing" chroot (with libc 2.37-12) 
> and I cannot reproduce your issue.
> 
> Should I just submit a patch that removes "#include <asm/byteorder.h>" ? 
> I am really unsure which environments are affected though.
> 

I guess you can drop it :-p

When I tried to reproduce it with hand writing 'gcc', I couldn't. But when
I did:

 $ make foo

It gave me the error. I was confused for a bit. Then I looked at what my
Makefile was doing and what I was doing. The only difference was that the
make included:

   -I.

Removing that from the Makefile worked!

My Makefile added to the CFLAGS "-I." and I forgot that this directory has
a "linux/"  directory in it that I used years ago to test kernel functions.
The git history shows it was last touched in 2016 (when I was still at Red Hat)

Removing -I. now makes everything work.

I have no idea why it suddenly stopped working just a few months ago. Maybe
something was moved out of the gcc headers so my local headers no longer
see it. That is, perhaps the glibc headers moved something out and added a
#include to it, where my local headers did not have that change. I don't
know and I don't care.

Well, at least now I know why I was getting errors on my build, but
couldn't find anything on the internet showing why others were not!

Sorry for the noise. :-/

-- Steve

