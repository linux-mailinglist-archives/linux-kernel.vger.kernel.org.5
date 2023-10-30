Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737A27DBFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjJ3SVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJ3SVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:21:14 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F518E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:20:50 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso2390179fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698690049; x=1699294849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1J6ayX3xWRXn3jFh+UicP6oQyrfRWq421uUTUoQ+rs=;
        b=bBy2NxYWbwO7tQIC3nMLGdzixXNd3xOpds5eS8prDVpLJz9ofQCUOHTGSyUmKbzFuH
         WkfzgbVtEdulu2nPLgPCmSRlDIsLVwLRasR9ARP0iplb4WnGuUjtqe39Ul3hXsF2WfGh
         g+4XiVDv5wMwfZejki/dmmYBYICd0uCT65hgLkXPEiYRcEeGScfOJR+9zFh2Rhrgd6sH
         PvKN47ufMIkKjaV7Gtxvk2a6kOMv3szBVRXqsumjb4u0AsGiaPk2ZY7Jl1dtYPjpCIZw
         cKGBZkAG5tCCOs0kysQOR9p3I61B5WoOUXOwzLjQFBT1cFJT1Fq4H89QzMdiyZFAFYoi
         DGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698690049; x=1699294849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1J6ayX3xWRXn3jFh+UicP6oQyrfRWq421uUTUoQ+rs=;
        b=wx4VV+SmtkZGlLtWaFSNrS/vwdd/B6nAjPV/gyktkjzW41AEym4wMM4s/GeieYnIQY
         06vVRLfNt2grSnNXtl7SqHTerjsTa3xgYMwk0P1JlmXHYZ4TXJSjVtZcdoOVH/8t1E6O
         ObT9vkw8dGdYajR/CVA2MTViG/8K0zfHZ4/uSUNDBhZOO4kb6BNaPQ0aAu5CZRuVGaNg
         73hZl6AFyhbpYYfW8dwV8mBcgyERm6ZcVHLkg795icXdtKkpKRFygq/F48cfRQWD4uy1
         kM1+MAkblo6AVX4+sBcSwZSDK5lRBK1LkUMhDHnN4nhqN/XROkmwLgyezKpNj164QrIN
         LSCw==
X-Gm-Message-State: AOJu0YwKNsTivlc3FJtC3ZBK+ggZJY4sPVzraKAAHQFLoTDWrVmxytLp
        dJKtLsso3/UcvgXMhvNDlf0y8PLhBR0ExV1JChP59g==
X-Google-Smtp-Source: AGHT+IE/wYH2nJOygVOxBR+Ydhxd4KaPiyeEuu6mze9iI9opDdaANSiaRAOS6fPZKFMVz8Mg6Vx1WA==
X-Received: by 2002:a05:6870:b689:b0:1e9:8bd9:7aaa with SMTP id cy9-20020a056870b68900b001e98bd97aaamr276774oab.12.1698690048774;
        Mon, 30 Oct 2023 11:20:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d4c83000000b006b87f593877sm1503470otf.37.2023.10.30.11.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:20:48 -0700 (PDT)
Date:   Mon, 30 Oct 2023 11:20:45 -0700
From:   Deepak Gupta <debug@rivosinc.com>
To:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>, nd@arm.com
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZT/z/b9P8KLuZEFh@debug.ba.rivosinc.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
 <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
 <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
 <ZTuj565SqIb9KjQr@arm.com>
 <ZTxGovqKdhA5hYMz@debug.ba.rivosinc.com>
 <ZT+V5VlXg/PsIfpM@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZT+V5VlXg/PsIfpM@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:39:17AM +0000, Szabolcs.Nagy@arm.com wrote:
>The 10/27/2023 16:24, Deepak Gupta wrote:
>> On Fri, Oct 27, 2023 at 12:49:59PM +0100, Szabolcs.Nagy@arm.com wrote:
>> > no. the lifetime is the issue: a stack in principle can outlive
>> > a thread and resumed even after the original thread exited.
>> > for that to work the shadow stack has to outlive the thread too.
>>
>> I understand an application can pre-allocate a pool of stack and re-use
>> them whenever it's spawning new threads using clone3 system call.
>>
>> However, once a new thread has been spawned how can it resume?
>
>a thread can getcontext then exit. later another thread
>can setcontext and execute on the stack of the exited
>thread and return to a previous stack frame there.
>
>(unlikely to work on runtimes where tls or thread id is
>exposed and thus may be cached on the stack. so not for
>posix.. but e.g. a go runtime could do this)

Aah then as you mentioned, we basically need clear lifetime rules around
their creation and deletion.
Because `getcontext/swapcontext/setcontext` can be updated to save shadow
stack token on stack itself and use that to resume. It's just lifetime
that needs to be managed.

>
>> By resume I mean consume the callstack context from an earlier thread.
>> Or you meant something else by `resume` here?
>>
>> Can you give an example of such an application or runtime where a newly
>> created thread consumes callstack context created by going away thread?
>
>my claim was not that existing runtimes are doing this,
>but that the linux interface contract allows this and
>tieing the stack lifetime to the thread is a change of
>contract.
>
>> > (or the other way around: a stack can be freed before the thread
>> > exits, if the thread pivots away from that stack.)
>>
>> This is simply a thread saying that I am moving to a different stack.
>> Again, interested in learning why would a thread do that. If I've to
>> speculate on reasons, I could think of user runtime managing it's own
>> pool of worker items (some people call them green threads) or current
>> stack became too small.
>
>switching stack is common, freeing the original stack may not be,
>but there is nothing that prevents this and then the corresponding
>shadow stack is clearly leaked if the kernel manages it. the amount
>of leak is proportional to the number of live threads and the sum
>of their original stack size which can be big.
>
>but as i said i think this lifetime issue is minor compared
>to other shadow stack issues, so it is ok if the shadow stack
>is kernel managed.

