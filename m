Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD478755A07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGQDPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGQDOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:14:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129DEE46;
        Sun, 16 Jul 2023 20:13:55 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R46bX3ndFz18LfQ;
        Mon, 17 Jul 2023 11:13:12 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 11:13:52 +0800
Subject: Re: [PATCH 5.15] ovl: fix null pointer dereference in
 ovl_get_acl_rcu()
To:     Amir Goldstein <amir73il@gmail.com>
CC:     <miklos@szeredi.hu>, <linux-unionfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <sashal@kernel.org>
References: <20230710032730.2049748-1-chengzhihao1@huawei.com>
 <CAOQ4uxg3_SGyOvy7gSQ_1=V9Zr1PxZyLUpHMK=nN+mr0do8cvg@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <901c2673-b91b-5a06-35e7-5b353a42ed71@huawei.com>
Date:   Mon, 17 Jul 2023 11:13:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg3_SGyOvy7gSQ_1=V9Zr1PxZyLUpHMK=nN+mr0do8cvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/7/17 2:26, Amir Goldstein 写道:
> On Mon, Jul 10, 2023 at 6:29 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> [ Upstream commit f4e19e595cc2e76a8a58413eb19d3d9c51328b53 ]
>>
>> Following process:
>>           P1                     P2
>>   path_openat
>>    link_path_walk
>>     may_lookup
>>      inode_permission(rcu)
>>       ovl_permission
>>        acl_permission_check
>>         check_acl
>>          get_cached_acl_rcu
>>           ovl_get_inode_acl
>>            realinode = ovl_inode_real(ovl_inode)
>>                                drop_cache
>>                                 __dentry_kill(ovl_dentry)
>>                                  iput(ovl_inode)
>>                                   ovl_destroy_inode(ovl_inode)
>>                                    dput(oi->__upperdentry)
>>                                     dentry_kill(upperdentry)
>>                                      dentry_unlink_inode
>>                                       upperdentry->d_inode = NULL
>>              ovl_inode_upper
>>               upperdentry = ovl_i_dentry_upper(ovl_inode)
>>               d_inode(upperdentry) // returns NULL
>>            IS_POSIXACL(realinode) // NULL pointer dereference
>> , will trigger an null pointer dereference at realinode:
>>    [  205.472797] BUG: kernel NULL pointer dereference, address:
>>                   0000000000000028
>>    [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
>>                   6.3.0-12064-g2edfa098e750-dirty #1216
>>    [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
>>    [  205.489584] Call Trace:
>>    [  205.489812]  <TASK>
>>    [  205.490014]  ovl_get_inode_acl+0x26/0x30
>>    [  205.490466]  get_cached_acl_rcu+0x61/0xa0
>>    [  205.490908]  generic_permission+0x1bf/0x4e0
>>    [  205.491447]  ovl_permission+0x79/0x1b0
>>    [  205.491917]  inode_permission+0x15e/0x2c0
>>    [  205.492425]  link_path_walk+0x115/0x550
>>    [  205.493311]  path_lookupat.isra.0+0xb2/0x200
>>    [  205.493803]  filename_lookup+0xda/0x240
>>    [  205.495747]  vfs_fstatat+0x7b/0xb0
>>
>> Fetch a reproducer in [Link].
>>
>> Use the helper ovl_i_path_realinode() to get realinode and then do
>> non-nullptr checking.
>>
>> There are some changes from upstream commit:
>> 1. Corrusponds to do_ovl_get_acl() in 5.15 is ovl_get_acl()
>> 2. ovl_i_path_real is not imported in 5.15, we can get realinode by
>>     ovl_inode_real
>> 3. CONFIG_FS_POSIX_ACL checking is dropped in commit
>>     ded536561a3674327dfa4bb389085705cae22b8a ("ovl: improve ovl_get_acl()
>>     if POSIX ACL support is off"), we still keep it in 5.15.
> 
> Zhihao,
> 
> Can you please provide also the backport for 6.1.
> 

Sure, I sent it out, please refer to 
https://lore.kernel.org/stable/20230717030904.1669754-1-chengzhihao1@huawei.com/T/#t.

> Basically, the same as this one without the CONFIG_FS_POSIX_ACL check.
> 
> Thanks,
> Amir.
> 
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217404
>> Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
>> Cc: <stable@vger.kernel.org> # v5.15
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Suggested-by: Christian Brauner <brauner@kernel.org>
>> Suggested-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> ---
>>   fs/overlayfs/inode.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>> index d41f0c8e0e2a..65e5e6eb761a 100644
>> --- a/fs/overlayfs/inode.c
>> +++ b/fs/overlayfs/inode.c
>> @@ -453,7 +453,15 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
>>          const struct cred *old_cred;
>>          struct posix_acl *acl;
>>
>> -       if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
>> +       if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
>> +               return NULL;
>> +
>> +       if (!realinode) {
>> +               WARN_ON(!rcu);
>> +               return ERR_PTR(-ECHILD);
>> +       }
>> +
>> +       if (!IS_POSIXACL(realinode))
>>                  return NULL;
>>
>>          if (rcu)
>> --
>> 2.39.2
>>
> .
> 

