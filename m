Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DAA7BA215
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjJEPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJEPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:12:11 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754176983;
        Thu,  5 Oct 2023 07:43:17 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 395Cwfl1025108;
        Thu, 5 Oct 2023 21:58:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 05 Oct 2023 21:58:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 395CwfX9025104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Oct 2023 21:58:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e391877d-cd10-3c6d-1f57-0aaa32846a8e@I-love.SAKURA.ne.jp>
Date:   Thu, 5 Oct 2023 21:58:41 +0900
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
        mic@digikod.net
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230912205658.3432-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/13 5:56, Casey Schaufler wrote:
> Create a struct lsm_id to contain identifying information about Linux
> Security Modules (LSMs). At inception this contains the name of the
> module and an identifier associated with the security module.  Change
> the security_add_hooks() interface to use this structure.  Change the
> individual modules to maintain their own struct lsm_id and pass it to
> security_add_hooks().

I came to worry about what purpose does the LSM ID value (or more precisely,
"struct lsm_id") is used for. If the LSM ID value is used for only switch
{reading,writing} /proc/self/attr/ of specific LSM module's information, only
LSM modules that use /proc/self/attr/ will need the LSM ID value.

But this series uses "struct lsm_id" as one of arguments for security_add_hooks(),
and might be reused for different purposes.

Then, BPF-based LSMs (which are not considered as in-tree LSM modules, for
only BPF hook is considered as in-tree LSM module) might receive unfavorable
treatment than non BPF-based LSMs? 

[PATCH v15 05/11] says

  Create a system call to report the list of Linux Security Modules
  that are active on the system. The list is provided as an array
  of LSM ID numbers.
  
  The calling application can use this list determine what LSM
  specific actions it might take. That might include choosing an
  output format, determining required privilege or bypassing
  security module specific behavior.

but, at least, name of BPF-based LSMs won't be shown up in lsm_list_modules()
compared to non BPF-based LSMs? Then, the calling application can't use this
list determine what BPF-based LSM specific actions it might take?

