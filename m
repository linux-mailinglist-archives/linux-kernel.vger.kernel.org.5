Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6C80BB8F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjLJORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:17:39 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9209F4;
        Sun, 10 Dec 2023 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702217865;
        bh=95FOqqEVlvMpVu60xKcTVHAxKd+ad692k9vCay/7OIc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SmGi6NmMr8M8UM9SD93vDg7+H16lkzxZdbVZdUOSatOmwq0RRnP7D8ItJLGmLth6g
         MuRFqYbO0B82vEExpJ8fjRpe/ahu15CUQfWpiZotn1/7fDIuMY0J+76xyM45/VOx/r
         VcD9qhLu1WR9H1yb89kYapLAQ5zXCgpevNlfFXL5t8A3wIiNvIhY1tcc96gPnH4Eoi
         TBKnN5iSi1etbYHoDHF3WQdCCFW9lvHbjvH6CfxrZbBWQfDlxb6pLDucIV1bTM8dKm
         617ArDJcUam1f3728aghyIvZQkMVkT+qGlKP96QLDbr6le4gJ5gPgZmXld0Pjxfqah
         WShryYQuXOS7g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sp6Qw6jlVzFr3;
        Sun, 10 Dec 2023 09:17:44 -0500 (EST)
Message-ID: <76797ddd-bb87-4af9-9703-1ec00a0d318c@efficios.com>
Date:   Sun, 10 Dec 2023 09:17:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] ring-buffer/tracing: Allow ring buffer to have
 bigger sub buffers
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20231210035404.053677508@goodmis.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231210035404.053677508@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-09 22:54, Steven Rostedt wrote:
[...]
> 
> Basically, events to the tracing subsystem are limited to just under a
> PAGE_SIZE, as the ring buffer is split into "sub buffers" of one page
> size, and an event can not be bigger than a sub buffer. This allows users
> to change the size of a sub buffer by the order:
> 
>    echo 3 > /sys/kernel/tracing/buffer_subbuf_order
> 
> Will make each sub buffer a size of 8 pages, allowing events to be almost
> as big as 8 pages in size (sub buffers do have meta data on them as
> well, keeping an event from reaching the same size as a sub buffer).

Specifying the "order" of subbuffer size as a power of two of
number of pages is a poor UX choice for a user-facing ABI.

I would recommend allowing the user to specify the size in bytes, and
internally bump to size to the next power of 2, with a minimum of
PAGE_SIZE.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

