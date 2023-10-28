Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697C77DA820
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjJ1Qsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJ1Qsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:48:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0440CE;
        Sat, 28 Oct 2023 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pKU+y/cebogC5d3kvaZU4QNtM5iPWmgULniCim14DXE=; b=p805N/GI2MB9BwL30W+TUfq3QF
        wYsC9exlj0h3hK3wKSfpRj+ysoaKR6GZTJWOrbiWDKsWOLCzlvMsVltIryEyee53u4n/YeGkqdkET
        Dq0iOZCCfOjfwSaAYK6bmLiFX23KS5yD24dL1QlASXec9rVRK4WcHrqg3BihlweDNFLvbEe2q6pNB
        zf1Z2inuml9rtCZbwGVzfSsjUePbosZUSQPo7zZ5bQtAdPzEcqfdTSOU6n6l3zki5DH8wc4xGe1rf
        OQabisFkg/0q5eNS3l6lLVz0qhNNxYr5Sw8hiIz/ViHP9cV1xiqxjQjQgVxGZjorPEd1gc1GB6JP4
        H4dgR40g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwmUG-000f7k-2t;
        Sat, 28 Oct 2023 16:48:36 +0000
Message-ID: <d6f016fe-963b-40ba-9146-de69e4fe0052@infradead.org>
Date:   Sat, 28 Oct 2023 09:48:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: sleep: Expose last succeeded resumed timestamp in
 sysfs
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     suleiman@google.com, briannorris@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <169849758243.1357961.4105003693126485611.stgit@mhiramat.roam.corp.google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <169849758243.1357961.4105003693126485611.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/28/23 05:53, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Expose last succeeded resumed timestamp as last_success_resume_time
> attribute of suspend_stats in sysfs. This timestamp is recorded in
> CLOCK_MONOTONIC. So user can find the actual resumed time and
> measure the elapsed time from the time when the kernel finished
> the resume to the user-space action (e.g. display the UI).

Can you go into the use-case a bit more, please?
You have said "what", but not "why".
What do you (or google) plan to do with this?

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Add (unsigned long long) casting for %llu.
>   - Add a line after last_success_resume_time_show().
>  Changes in v2:
>   - Use %llu instead of %lu for printing u64 value.
>   - Remove unneeded indent spaces from the last_success_resume_time
>     line in the debugfs suspend_stat file.
> ---
>  Documentation/ABI/testing/sysfs-power |   10 ++++++++++
>  include/linux/suspend.h               |    2 ++
>  kernel/power/main.c                   |   15 +++++++++++++++
>  kernel/power/suspend.c                |    1 +
>  4 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index a3942b1036e2..63659765dee1 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -442,6 +442,16 @@ Description:
>  		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
>  		This number is measured in microseconds.
>  
> +What:		/sys/power/suspend_stats/last_success_resume_time
> +Date:		Oct 2023
> +Contact:	Masami Hiramatsu <mhiramat@kernel.org>
> +Description:
> +		The /sys/power/suspend_stats/last_success_resume_time file
> +		contains the timestamp of when the kernel successfully
> +		resumed from suspend/hibernate.
> +		This floating number is measured in seconds by monotonic

What does "floating" mean here?  Not floating point...


> +		clock.
> +
>  What:		/sys/power/sync_on_suspend
>  Date:		October 2019
>  Contact:	Jonas Meurer <jonas@freesources.org>

[snip]

Thanks.
-- 
~Randy
