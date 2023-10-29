Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896727DAC03
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjJ2K6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 06:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2K6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 06:58:42 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F276C0;
        Sun, 29 Oct 2023 03:58:40 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39TAw1YC028196;
        Sun, 29 Oct 2023 19:58:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 29 Oct 2023 19:58:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39TAw1hV028191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 29 Oct 2023 19:58:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c35322f3-3f89-40d2-a5fb-7226fb93d202@I-love.SAKURA.ne.jp>
Date:   Sun, 29 Oct 2023 19:57:59 +0900
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
 <2fb1a8cd-88d0-40f0-b3d8-cfa8b71e7dd9@I-love.SAKURA.ne.jp>
 <29fe1e5b-4bf3-4bb3-b8de-fbd8dfc25be3@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <29fe1e5b-4bf3-4bb3-b8de-fbd8dfc25be3@schaufler-ca.com>
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

On 2023/10/21 23:11, Casey Schaufler wrote:
>> If the system call returning LSM ID value for SELinux but does not tell
>> the caller of that system call whether a specific action might be permitted,
>> what information does LSM ID value tell?
> 
> It tells the caller that the LSM is active on the system. That's it.
> Just like reading /sys/kernel/security/lsm.

Then, the

  The calling application can use this list determine what LSM
  specific actions it might take. That might include choosing an
  output format, determining required privilege or bypassing
  security module specific behavior.

part should be removed from the description. Instead, the description should
emphasis that the numeric LSM ID values are there in order to allow
identifying what LSM modules are active without interpreting string LSM names
in /sys/kernel/security/lsm .



>> What does "choosing an output format", "determining required privilege",
>> "bypassing security module specific behavior" mean? How can they choose
>> meaningful output format, determine appropriate privilege, bypass security
>> module specific behavior (if the only information the caller can know from
>> the LSM ID value were what LSMs are enabled) ?
> 
> If Smack and SELinux not enabled on the system there is no point in
> setting up a netlabel configuration, for example.

I know nothing about netlabel. But can userspace make such assumption from
this granularity? For example, if TOMOYO and AppArmor start supporting
netlabel configuration, your assumption

  If Smack and SELinux not enabled on the system there is no point in
  setting up a netlabel configuration

becomes no longer true. It is also possible that a new LSM implementation
obtains an LSM ID for that LSM, and starts supporting netlabel configuration
some timer later. I don't know if we come to the point where we can enable
SELinux and Smack at the same time. But when it becomes possible to enable
SELinux and Smack at the same time, the userspace might have already written
code based on current situation that netlabel configuration are exclusive. Then,
someday starting to return both LSM ID for SELinux and LSM ID for Smack might
confuse userspace.

Thus, it might be safe to determine what LSMs are active from the LSM ID values
returned from the system call. But it is not safe to assume what functionality
is active (e.g. netlabel configuration is interpreted) from the LSM ID values
returned from the system call.

If you want to allow userspace to make such assumption using the system call,
the granularity the system call returns needs to be what access control mechanism
(not only LSM modules but also eBPF-based access control mechanisms) hooks which
LSM hooks. More information than interpreting string LSM names in 
/sys/kernel/security/lsm will be needed.

> 
>>> I wish we could stop people from saying "BPF-based LSM". BPF is the LSM. The
>>> eBPF programs that implement a "policy" are NOT a LSM. There needs to be a
>>> name for that, but LSM  is  not  it.
>> My understanding is that "BPF is not an LSM module but infrastructure for using
>> LSM hooks".
> 
> As BPF is implemented as a LSM I suggest your statement is incorrect.

Enumerating only LSM modules are not useful. "ID for access control mechanisms
that can be controlled via LSM hooks" will be needed.

> 
>>
>> The patch description lacks relationship between LSM ID value and data.
>> In other words, why LSM ID values are needed (and are useful for doing what).
>> If the only information the caller can know from the LSM ID value were
>> what LSMs are enabled (i.e. the content of /sys/kernel/security/lsm ), why
>> bother to use LSM ID values? (Yes, integer comparison is faster than string
>> comparison. But that is not enough justification for not allowing out-of-tree
>> LSMs and eBPF-based access control mechanisms to have stable LSM ID values.)
>>

I conclude that LSM ID values are pointless and are NOT needed.

