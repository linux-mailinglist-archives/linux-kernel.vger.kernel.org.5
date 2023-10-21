Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B87D1D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJUMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 08:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 08:21:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F0D51;
        Sat, 21 Oct 2023 05:21:25 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39LCKoos088110;
        Sat, 21 Oct 2023 21:20:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sat, 21 Oct 2023 21:20:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39LCKoIw088106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 21 Oct 2023 21:20:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2fb1a8cd-88d0-40f0-b3d8-cfa8b71e7dd9@I-love.SAKURA.ne.jp>
Date:   Sat, 21 Oct 2023 21:20:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <e391877d-cd10-3c6d-1f57-0aaa32846a8e@I-love.SAKURA.ne.jp>
 <30d1110a-7583-4fa1-85c8-d6ce362f5ae2@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <30d1110a-7583-4fa1-85c8-d6ce362f5ae2@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/21 4:52, Casey Schaufler wrote:
> On 10/5/2023 5:58 AM, Tetsuo Handa wrote:
>> On 2023/09/13 5:56, Casey Schaufler wrote:
>>> Create a struct lsm_id to contain identifying information about Linux
>>> Security Modules (LSMs). At inception this contains the name of the
>>> module and an identifier associated with the security module.  Change
>>> the security_add_hooks() interface to use this structure.  Change the
>>> individual modules to maintain their own struct lsm_id and pass it to
>>> security_add_hooks().
>> I came to worry about what purpose does the LSM ID value (or more precisely,
>> "struct lsm_id") is used for. If the LSM ID value is used for only switch
>> {reading,writing} /proc/self/attr/ of specific LSM module's information, only
>> LSM modules that use /proc/self/attr/ will need the LSM ID value.
>>
>> But this series uses "struct lsm_id" as one of arguments for security_add_hooks(),
>> and might be reused for different purposes.
>>
>> Then, BPF-based LSMs (which are not considered as in-tree LSM modules, for
>> only BPF hook is considered as in-tree LSM module) might receive unfavorable
>> treatment than non BPF-based LSMs? 
>>
>> [PATCH v15 05/11] says
>>
>>   Create a system call to report the list of Linux Security Modules
>>   that are active on the system. The list is provided as an array
>>   of LSM ID numbers.
>>   
>>   The calling application can use this list determine what LSM
>>   specific actions it might take. That might include choosing an
>>   output format, determining required privilege or bypassing
>>   security module specific behavior.
>>
>> but, at least, name of BPF-based LSMs won't be shown up in lsm_list_modules()
>> compared to non BPF-based LSMs? Then, the calling application can't use this
>> list determine what BPF-based LSM specific actions it might take?
> 
> That is correct. Just as knowing that your system is using SELinux won't
> tell you whether a specific action might be permitted because that's driven
> by the loaded policy, so too knowing that your system is using BPF won't
> tell you whether a specific action might be permitted because that's driven
> by the eBPF programs in place.

If the system call returning LSM ID value for SELinux but does not tell
the caller of that system call whether a specific action might be permitted,
what information does LSM ID value tell?

The patch description lacks relationship between LSM ID value and data.
In other words, why LSM ID values are needed (and are useful for doing what).
If the only information the caller can know from the LSM ID value were
what LSMs are enabled (i.e. the content of /sys/kernel/security/lsm ), why
bother to use LSM ID values? (Yes, integer comparison is faster than string
comparison. But that is not enough justification for not allowing out-of-tree
LSMs and eBPF-based access control mechanisms to have stable LSM ID values.)

What does "choosing an output format", "determining required privilege",
"bypassing security module specific behavior" mean? How can they choose
meaningful output format, determine appropriate privilege, bypass security
module specific behavior (if the only information the caller can know from
the LSM ID value were what LSMs are enabled) ?



> I wish we could stop people from saying "BPF-based LSM". BPF is the LSM. The
> eBPF programs that implement a "policy" are NOT a LSM. There needs to be a
> name for that, but LSM  is  not  it.

My understanding is that "BPF is not an LSM module but infrastructure for using
LSM hooks".

Say, an access control implementation consists of two parts; "code" and "data".
The "code" is written by developers and is determined at compile time and is
interpreted by CPU, and the "data" is written by administrators and is interpreted
by "code". The "data" part can be either built-in (determined at compile time) or
loadable (configurable at run-time).

eBPF-based access control implementations (which can be loaded via bpf() system
call after boot) consists of "code" and "data". BPF will remain no-op unless
eBPF-based access control implementations are loaded via bpf() system call.
Thus, I believe that an eBPF-based access control implementation should be
considered as an LSM module (like SELinux etc.)

