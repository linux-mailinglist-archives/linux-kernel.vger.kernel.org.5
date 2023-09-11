Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100F79C32B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbjILCmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbjILCl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:41:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E80104881;
        Mon, 11 Sep 2023 19:07:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BC2C433AD;
        Mon, 11 Sep 2023 21:09:14 +0000 (UTC)
Date:   Mon, 11 Sep 2023 17:09:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: suspicious RCU usage warning on tracing/urgent
Message-ID: <20230911170929.1b0ede14@gandalf.local.home>
In-Reply-To: <20230911120053.ca82f545e7f46ea753deda18@kernel.org>
References: <20230911120053.ca82f545e7f46ea753deda18@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 12:00:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> But it seems correctly taking srcu_read_lock().
> 
>     452 
>     453         ei = ti->private;
>     454         idx = srcu_read_lock(&eventfs_srcu);
>     455         list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
>     456                 create_dentry(ef, dentry, false);
>     457         }
>     458         srcu_read_unlock(&eventfs_srcu, idx);
>     459         return dcache_dir_open(inode, file);
>     460 }
>     461 
> 
> This may false-positive warning, or srcu_read_lock() is not enough for
> list_for_each_entry_rcu(). In latter case, maybe we need to use a
> mutex instead of srcu for update the ef.

Oops, that should be list_for_each_entry_srcu().

Thanks!

> 
> BTW, the ftracetest itself passed without any problem.

Thanks for testing as well!

-- Steve
