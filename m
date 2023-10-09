Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EC77BE1FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjJIOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376693AbjJIOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:00:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77249C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:00:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33379C433C8;
        Mon,  9 Oct 2023 14:00:37 +0000 (UTC)
Date:   Mon, 9 Oct 2023 10:01:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
Message-ID: <20231009100155.6d71490f@gandalf.local.home>
In-Reply-To: <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
References: <20230929021213.2364883-1-joel@joelfernandes.org>
        <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
        <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
        <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
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

On Sat, 7 Oct 2023 21:30:42 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Just checking how we want to proceed, is the consensus that we should
> prevent kernel crashes without relying on userspace stopping all
> processes? Should we fix regular reboot syscall as well and not just
> kexec reboot?

If you can show that we can trigger the crash on normal reboot, then I
don't see why not. That is, if you have a program that does the reboot
(without the SIGSTOP/SIGKILL calls) and triggers this crash, I think that's
a legitimate reason to fix it on normal reboot too.

-- Steve
