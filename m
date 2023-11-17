Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECCB7EF946
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKQVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:13:12 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84115D5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:13:08 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2f2b9a176so1563236b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700255588; x=1700860388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PKz01wcVX8Bxs3KR+NJBt3hwfdvhmPYzaTZtcibwsZc=;
        b=jeghf2rJzclJzmiMiYweFiK2yBMmI83nH0JL+BaLEEjrzuMR8gAVxET00ZfzKhjfG4
         EN0iZiMHgHaSkHFd/odjJYM3/s93jrJQVwfUW3IO3Y0quEWdKtWPtSWDAIEZvERGq5vo
         TVGfwmg7JChgq8xrfcqmA8bZ0Ae7kT/x9I7ass/3h3V5IhT1F3lVw++7cEC4X++P1JWd
         uU+gCH+MTYePUFhRppVYHN+wFC0sLPEJmMWINoaex8sYl3R+xiyZkQ4K+vtVU5yAQZte
         x+yVLwgQ6ClbRJ2ym8zSxUcsH17Acv60AH24H8CfvGCizvKnOzLjlNFApubFFMfKnE4x
         jr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255588; x=1700860388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKz01wcVX8Bxs3KR+NJBt3hwfdvhmPYzaTZtcibwsZc=;
        b=Yv3CmjaH3ONwI7xzLlxXC9ZFckslN1NWcIiBp0hk4a6lxc/4qYQZeK96ZRM1Fo4tNz
         W6XFkNVAiVXffeP/GOoB1vRU7mRYFipzACV+x+ldDPqSlwKzbQfjO5YhwlrMryzLbOXb
         8e1+v5Bqp2ilBpm0z5ThEzI4kR/wq8/TN8+X5wpYZSfYa2tBV8+AtfCjqSZojC62YVkO
         iLsHpHJytJxVQjX055vWIbmM5DT0tfqlReVcWrdbknlhifkM3MZ9mGdSh7tORQope1wf
         Jw3eBaYB/89yTvgGpkC8Ir0NBL66JlNkd4mvtdkrZMmjhdmkwwF+YxLJHKVXkqNf1OUY
         0zmA==
X-Gm-Message-State: AOJu0YzUOSI1P7M2NvkUUdbbvjbbHcOTKYI5EWXWBzdlibN/kLo+dryx
        qNoIyCAmgxJY70BvlcyVebRYXg==
X-Google-Smtp-Source: AGHT+IHkJxAw4BCtYb7vtqTpvYzYdZ/WV9j6uSsTfqp9w+14kwuRXNQnpMN39mmIJPuH7mhfyy/qGA==
X-Received: by 2002:a05:6808:429a:b0:3b2:e2d1:34d2 with SMTP id dq26-20020a056808429a00b003b2e2d134d2mr516718oib.47.1700255587791;
        Fri, 17 Nov 2023 13:13:07 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o18-20020a05680803d200b003ae425fc9bdsm408308oie.23.2023.11.17.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:12:53 -0800 (PST)
Date:   Fri, 17 Nov 2023 13:12:46 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Message-ID: <ZVfXTmVestrAwIkN@debug.ba.rivosinc.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
 <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 11:11:58PM +0000, Edgecombe, Rick P wrote:
>On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:
>> +static void test_shadow_stack_supported(void)
>> +{
>> +        long shadow_stack;
>> +
>> +       shadow_stack = syscall(__NR_map_shadow_stack, 0,
>> getpagesize(), 0);
>
>Hmm, x86 fails this call if user shadow stack is not supported in the
>HW or the kernel, but doesn't care if it is enabled on the thread or
>not. If shadow stack is not enabled (or not yet enabled), shadow stacks
>are allowed to be mapped. Should it fail if shadow stack is not yet
>enabled?
>
>Since shadow stack is per thread, map_shadow_stack could still be
>called on another thread that has it enabled. Basically I don't think
>blocking it will reduce the possible states the kernel has to handle.
>
>The traditional way to check if shadow stack is enabled on x86 is the
>check for a non zero return from the _get_ssp() intrinsic:
>https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/x86-control-flow-protection-intrinsics.html
>
>It seems like there will be a need for some generic method of checking
>if shadow stack is enabled. Maybe a more generic compiler
>intrinsic/builtin or glibc API (something unrelated to SSP)?

Exposing a new file under procfs would be useful?
Something like "/proc/sys/vm/user_shadow_stack_supported"

`map_shadow_stack` can return MAP_FAILED for other reasons.
I think `kselftests` are fine but I don't want people to pick up this
as test code and run with it in production :-)

So kernel providing a way to indicate whether it supports shadow stack
mappings in user mode via procfs would be useful and arch agnostic.

>
>> +       {
>> +               .name = "Shadow stack on system with shadow stack",
>> +               .flags = 0,
>> +               .size = 0,
>> +               .expected = 0,
>> +               .e2big_valid = true,
>> +               .test_mode = CLONE3_ARGS_SHADOW_STACK,
>> +               .filter = no_shadow_stack,
>> +       },
>> +       {
>> +               .name = "Shadow stack on system without shadow
>> stack",
>> +               .flags = 0,
>> +               .size = 0,
>> +               .expected = -EINVAL,
>> +               .e2big_valid = true,
>> +               .test_mode = CLONE3_ARGS_SHADOW_STACK,
>> +               .filter = have_shadow_stack,
>> +       },
>>  };
>>  
>I changed x86's map_shadow_stack to return an error when shadow stack
>was not enabled to make the detection logic in the test work. Also
>changed the clone3 Makefile to generate the shadow stack bit in the
>tests. When running the 'clone3' test with shadow stack it passed, but
>there is a failure in the non-shadow stack case:
>...
># Shadow stack not supported
>ok 20 # SKIP Shadow stack on system with shadow stack
># Running test 'Shadow stack on system without shadow stack'
># [1333] Trying clone3() with flags 0 (size 0)
># I am the parent (1333). My child's pid is 1342
># I am the child, my PID is 1342
># [1333] clone3() with flags says: 0 expected -22
># [1333] Result (0) is different than expected (-22)
>not ok 21 Shadow stack on system without shadow stack
># Totals: pass:19 fail:1 xfail:0 xpass:0 skip:1 error:0
>
>The other tests passed in both cases. I'm going to dig into the other
>parts now but can circle back if it's not obvious what's going on
>there.
