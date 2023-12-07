Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909BD807F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjLGESD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGESB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:18:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F222D5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701922686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcdeWsLVE0ZLjCzsplESZkvtBaAPo5FuR7NkpRBEkQA=;
        b=d7C/InwbAT7IDH1/FSl6vaSm+aNM9Qm1qGkHQcouTzQrMI285QT4Qa08QBzx4U7G4OhNip
        WaixpCZhGGS4N8vilCfkzNRpFV8bOGJUZTgdR8f7flH6tuE1k0+A8YEzU347GfdbfE2JcN
        Xpc8xwNswNZqIUb2lCcqmNuXoA2rL3I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-9uXx9ycNPIuQy64WxMJy3g-1; Wed, 06 Dec 2023 23:18:04 -0500
X-MC-Unique: 9uXx9ycNPIuQy64WxMJy3g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6688F83B86A;
        Thu,  7 Dec 2023 04:18:04 +0000 (UTC)
Received: from [10.22.34.92] (unknown [10.22.34.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1885C492BC6;
        Thu,  7 Dec 2023 04:18:04 +0000 (UTC)
Message-ID: <d7e24393-540b-4fcc-84a8-3ad9daf26762@redhat.com>
Date:   Wed, 6 Dec 2023 23:18:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the cgroup tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231207143806.114e0a74@canb.auug.org.au>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231207143806.114e0a74@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/23 22:38, Stephen Rothwell wrote:
> Hi all,
>
> After merging the cgroup tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from <command-line>:
> kernel/cgroup/cgroup.c: In function 'cgroup_free_root':
> include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert_1792' declared with attribute error: BUILD_BUG_ON failed: !__is_kvfree_rcu_offset(offsetof(typeof(*(root)), rcu))
>    435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                             ^
> include/linux/compiler_types.h:416:25: note: in definition of macro '__compiletime_assert'
>    416 |                         prefix ## suffix();                             \
>        |                         ^~~~~~
> include/linux/compiler_types.h:435:9: note: in expansion of macro '_compiletime_assert'
>    435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>        |         ^~~~~~~~~~~~~~~~
> include/linux/rcupdate.h:985:17: note: in expansion of macro 'BUILD_BUG_ON'
>    985 |                 BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));   \

#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)

It looks like commit 77070eeb8821 ("cgroup: Avoid false cacheline 
sharing of read mostly rstat_cpu") has caused the offset of rcu to 
exceed the 4096 limit under such configuration. After I move the rcu 
field up, the compilation error was gone. So any change that makes the 
cgroup structure larger is likely to cause this problem again. The 
simple fix is just to move the rcu field up. I will send a patch to do that.

Cheers,
Longman


>        |                 ^~~~~~~~~~~~
> include/linux/rcupdate.h:957:29: note: in expansion of macro 'kvfree_rcu_arg_2'
>    957 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>        |                             ^~~~~~~~~~~~~~~~
> kernel/cgroup/cgroup.c:1318:9: note: in expansion of macro 'kfree_rcu'
>   1318 |         kfree_rcu(root, rcu);
>        |         ^~~~~~~~~
> In function 'cgroup_free_root',
>      inlined from 'cgroup_destroy_root' at kernel/cgroup/cgroup.c:1363:2:
> include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert_1792' declared with attribute error: BUILD_BUG_ON failed: !__is_kvfree_rcu_offset(offsetof(typeof(*(root)), rcu))
>    435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                             ^
> include/linux/compiler_types.h:416:25: note: in definition of macro '__compiletime_assert'
>    416 |                         prefix ## suffix();                             \
>        |                         ^~~~~~
> include/linux/compiler_types.h:435:9: note: in expansion of macro '_compiletime_assert'
>    435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>        |         ^~~~~~~~~~~~~~~~
> include/linux/rcupdate.h:985:17: note: in expansion of macro 'BUILD_BUG_ON'
>    985 |                 BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));   \
>        |                 ^~~~~~~~~~~~
> include/linux/rcupdate.h:957:29: note: in expansion of macro 'kvfree_rcu_arg_2'
>    957 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>        |                             ^~~~~~~~~~~~~~~~
> kernel/cgroup/cgroup.c:1318:9: note: in expansion of macro 'kfree_rcu'
>   1318 |         kfree_rcu(root, rcu);
>        |         ^~~~~~~~~
>
> Possibly caused by commit
>
>    77070eeb8821 ("cgroup: Avoid false cacheline sharing of read mostly rstat_cpu")
>
> I have used the cgroup tree from next-20231206 for today.
>
>
>

