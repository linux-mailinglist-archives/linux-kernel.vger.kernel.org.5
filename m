Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7227A7912
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjITKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjITKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:21:26 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385194;
        Wed, 20 Sep 2023 03:21:20 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38KAKb2V096280;
        Wed, 20 Sep 2023 19:20:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Wed, 20 Sep 2023 19:20:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38KAKaKw096276
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Sep 2023 19:20:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp>
Date:   Wed, 20 Sep 2023 19:20:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
 <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
 <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
 <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/18 1:38, Casey Schaufler wrote:
> On 9/15/2023 11:32 PM, Tetsuo Handa wrote:
>> +/**
>> + * struct lsm_id - Identify a Linux Security Module.
>> + * @lsm: name of the LSM, must be approved by the LSM maintainers
>>
>> Why can't you understand that "approved by the LSM maintainers" is a horrible
>> requirement for LSM modules which cannot become one of in-tree LSMs?
>>
>> One of reasons for not every proposed LSM module can become in-tree is out of
>> the LSM community's resources for reviewing/maintaining (or failure to acquire
>> attention from the LSM community enough to get reviewed).
>>
>> + * @id: LSM ID number from uapi/linux/lsm.h
>>
>> Since the LSM community cannot accept all of proposed LSMs due to limited resources,
>> the LSM community is responsible for allowing whatever proposed LSMs (effectively any
>> publicly available LSMs) to live as out-of-tree LSMs, by approving the LSM name and
>> assigning a permanent LSM ID number.
>>
>> The only exception the LSM community can refuse to approve/assign would be that the name
>> is not appropriate (e.g. a LSM module named "FuckYou") or the name is misleading (e.g.
>> "selinux+", "smock", "tomato", "apparmour"). Otherwise, no matter how many times you repeat
>> "we don't care out-of-tree LSMs" or "I do not intentionally plan to make life difficult for
>> the out-of-tree LSMs", this patch is intended to lock out out-of-tree LSMs.
> 
> That is a false statement. There is a huge difference between apathy and malice. 

Dave Chinner wrote at https://lkml.kernel.org/r/ZQo94mCzV7hOrVkh@dread.disaster.area
as a response to "We don't care about out of tree filesystems.":

  In this case, we most certainly do care. Downstream distros support
  all sorts of out of tree filesystems loaded via kernel modules, so a
  syscall that is used to uniquely identify a filesystem type to
  userspace *must* have a mechanism for the filesystem to provide that
  unique identifier to userspace.

  Fundamentally, the kernel does not and should not dictate what
  filesystem types it supports; the user decides what filesystem they
  need to use, and it is the kernel's job to provide infrastructure
  that works with that user's choice.

Can you see? What you are trying to is NACKed by simple s/filesystem/LSM/g .

The kernel is ultimately there for users. The kernel is never there for doing patent
acquisition competition. If the LSM community accepts only LSMs which won the patent
acquisition competition as in-tree (as described in "ANN: new LSM guidelines"),
the LSM community is responsible for allowing any publicly available LSMs to live as
out of tree modules.

Unless the policy is updated to approve any publicly available LSMs and assign a unique
identifier (which can be passed to the syscalls introduced by this series) to each
publicly available LSM, this series is a regression.

The "[PATCH v15 01/11] LSM: Identify modules by more than name" is exactly doing
"LSM: allow only in-tree LSM modules, lock out out-of-tree LSM modules".
Nack, Nack, Nack, Nack, Nack!!!!!

> 
>>
>> + *
>> + * Contains the information that identifies the LSM.
>> + */
>> +struct lsm_id {
>> +	const char	*name;
>> +	u64		id;
>> +};
>>
>> Therefore, unless you change the policy for assigning LSM ID, I keep NACK on this change.
>>

