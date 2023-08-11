Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514B0778750
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjHKGQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKGQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:16:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F7C72D48;
        Thu, 10 Aug 2023 23:16:07 -0700 (PDT)
Received: from [192.168.5.50] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1D5C120FD073;
        Thu, 10 Aug 2023 23:16:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D5C120FD073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691734566;
        bh=p1s2g6vEJ1Twwe0mdUoYDxKmhQkIYtpm5zhaKOh73WE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EgTkTip86gNCpNNraKu2tapl1kNx4npnKbq5vz8mGLBty7SNk9rAbPOM2VgtPSJOj
         TIuCpdhTqhTb4NPj8XH91CYm5lQ0w4i9cbzHrRpKCnt1iZ3pDXjhjWVcV5DbI6N65j
         Jxd/pqbxT90HwsplMSbzpJRPwvXgct3z7a6nCjyg=
Message-ID: <55a22e2f-bc95-62e3-69b0-1f9daf64935d@linux.microsoft.com>
Date:   Thu, 10 Aug 2023 23:16:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230811054528.never.165-kees@kernel.org>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20230811054528.never.165-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 22:45, Kees Cook wrote:
> If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
> copy_data() was causing writes to truncate. This manifested as output
> bytes being skipped, seen as %NUL bytes in pstore dumps when the available
> record size was larger than 65536. Fix the cast to no longer truncate
> the calculation.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Reported-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Closes: https://lore.kernel.org/lkml/d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com/
> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Excellent.

I have verified on v5.10.

Tested-by: Vijay Balakrishna <vijayb@linux.microsoft.com>

Thanks,
Vijay 
