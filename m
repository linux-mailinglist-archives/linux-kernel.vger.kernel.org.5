Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAEE7F59ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjKWIX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjKWIXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:23:55 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D4B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:23:37 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b845ba9ba9so389602b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700727817; x=1701332617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R14KQrnkHNFRdO9mhYlsM5M9jjV7l8QM7u5sQXfd9nU=;
        b=InXb7p0yjbXxPjRdkOpV2nqAxmYbM7Hue+5Z4zOeQ2QFf1EjDkGsCND8lcHuLNXOBk
         WXvgb5ZqP7sFgmA+3PWfwtJi5ZyXg9SXBUL2sBmn0Z77rHTuPfG8IOuV5YtG9nbMPML8
         AKUe+EeLMU93tV/lscKSHS/2T8zFOd2Cr/t5APB8miKrUqrRAQs9MLtRpiCHD1mWomfo
         JRYx/NbLOQVwudZ1LxKOOSi5dib6wRxtYnCMpM5bQh6AsZ5PeSZrCnqGaKCTNWaPpaXH
         5NcbOjTkOAiJ2sFogQp0hrF92mrpLcwC69Wuz+YfaTmoQiBbLeezqwlYuvI2kEaqOr0S
         CJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727817; x=1701332617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R14KQrnkHNFRdO9mhYlsM5M9jjV7l8QM7u5sQXfd9nU=;
        b=g8NXGS5XFhCuvyc1E6/9iWDmDPgznXQ4fP+f2eqlrIlBUS+1p8QdxsLw8H+Wvf7tvx
         T7Hf77lYv5x+neFrwIS8AZU89zgqmJCs5r2Solzi535NzpdNWxRNHLycZbKyvS7XfohR
         3brj7Ad0YBlJJKUKFrmpG0JLz+gFdNXLAkqxusZD+N/s4ujB1AxVUMXcTuSd5sB6vIc2
         ep6QSlEqtVrzBJcp/J2s0T4dXP6AlpqojgxofbMV+ukUECZLg/hIvW5Ie7eav52uFRjV
         VRZW+E2rpeE8uaTAQD43d8bclOPLOFHixLGWzMzDOouA83538NUynfDGPhMIDkTeRG6d
         B+cQ==
X-Gm-Message-State: AOJu0YwtlDCqMeT/ZXCA5NBQaRzCnEalYYWIgJ9HG0QmZWYshxyoMdTH
        qVtU25bzB1Tchkj7G5PUvB+0gQ==
X-Google-Smtp-Source: AGHT+IGPcLJ1KgHuH7jtX+GxplyfsA3kfJcfi1kWnHtlfZ+0Pnp0NwJ/f30Bs0VvEvvBNIwASZLvXw==
X-Received: by 2002:a05:6808:996:b0:3a7:55f2:552d with SMTP id a22-20020a056808099600b003a755f2552dmr5118500oic.58.1700727816986;
        Thu, 23 Nov 2023 00:23:36 -0800 (PST)
Received: from localhost.localdomain ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id v25-20020a62a519000000b006b76cb6523dsm689239pfm.165.2023.11.23.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:23:35 -0800 (PST)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org
Cc:     dianders@chromium.org, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, pmladek@suse.com, lizhe.67@bytedance.com
Subject: Re: [PATCH v2] softlockup: serialized softlockup's log
Date:   Thu, 23 Nov 2023 16:23:28 +0800
Message-Id: <20231123082328.7671-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231122140521.85c66b789625e8d270722b3c@linux-foundation.org>
References: <20231122140521.85c66b789625e8d270722b3c@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 14:05:21 -0800 akpm@linux-foundation.org wrote:

>> From: Li Zhe <lizhe.67@bytedance.com>
>> 
>> If multiple CPUs trigger softlockup at the same time with
>> 'softlockup_all_cpu_backtrace=0', the softlockup's logs will appear
>> staggeredly in dmesg, which will affect the viewing of the logs for
>> developer. Since the code path for outputting softlockup logs is not
>> a kernel hotspot and the performance requirements for the code are
>> not strict, locks are used to serialize the softlockup log output to
>> improve the readability of the logs.
>
>Seems reasonable, but...
>
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -28,6 +28,8 @@
>>  #include <linux/kvm_para.h>
>>  
>>  static DEFINE_MUTEX(watchdog_mutex);
>> +/* This lock is used to prevent concurrent actions of softlockup output logs */
>> +static DEFINE_SPINLOCK(watchdog_output_lock);
>
>It would be a little neater to reduce the scope of this - move the
>definition into that little code block in watchdog_timer_fn() where it
>is actually used.

Yes. For this patch, it is more appropriate to put the definition in
watchdog_timer_fn(). It can be moved out in subsequent patches if
necessary. I will send a v3 patch to move it in watchdog_timer_fn().
Thanks for your advice.

>>  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
>>  # define WATCHDOG_HARDLOCKUP_DEFAULT	1
>> @@ -514,6 +516,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>  		/* Start period for the next softlockup warning. */
>>  		update_report_ts();
>>  
>> +		spin_lock(&watchdog_output_lock);
>
>The hrtimer callout function is called from [soft]irq context, yes? 

Yes.

>Doesn't lockdep get upset when we take a spinlock in such a context?

My test results are the same as Doug Anderson's, things seemed OK.

>
>>  		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>>  			smp_processor_id(), duration,
>>  			current->comm, task_pid_nr(current));
>> @@ -523,6 +526,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>  			show_regs(regs);
>>  		else
>>  			dump_stack();
>> +		spin_unlock(&watchdog_output_lock);
>>  
>>  		if (softlockup_all_cpu_backtrace) {
>>  			trigger_allbutcpu_cpu_backtrace(smp_processor_id());
