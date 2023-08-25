Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EB788219
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjHYIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241520AbjHYIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:32:52 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A9C19AC;
        Fri, 25 Aug 2023 01:32:48 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4RXCrB1xYPz5Sg6;
        Fri, 25 Aug 2023 16:32:42 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4RXCqz20NLz7C4m3;
        Fri, 25 Aug 2023 16:32:31 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RXCqr4NNVz8XrRB;
        Fri, 25 Aug 2023 16:32:24 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 37P8WKY6071336;
        Fri, 25 Aug 2023 16:32:20 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 25 Aug 2023 16:32:22 +0800 (CST)
Date:   Fri, 25 Aug 2023 16:32:22 +0800 (CST)
X-Zmail-TransId: 2b0564e86716ffffffff803-b2b5c
X-Mailer: Zmail v1.0
Message-ID: <202308251632226430480@zte.com.cn>
In-Reply-To: <20230824161248.GM11263@frogsfrogsfrogs>
References: 202308241543526473806@zte.com.cn,20230824161248.GM11263@frogsfrogsfrogs
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <djwong@kernel.org>
Cc:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 37P8WKY6071336
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64E86729.000/4RXCrB1xYPz5Sg6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
>> From: Cheng Lin <cheng.lin130@zte.com.cn>
>> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
>> directory to become unusable until the next xfs_repair run.
>>
>> Introduce protection for drop nlink to reduce the impact of this.
>> And produce a warning for directory nlink error during remove.
>>
>> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
>> ---
>>  fs/xfs/xfs_inode.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 9e62cc5..536dbe4 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
>>      xfs_trans_t *tp,
>>      xfs_inode_t *ip)
>>  {
>> +    xfs_mount_t     *mp;
>> +
>> +    if (VFS_I(ip)->i_nlink == 0) {
>> +        mp = ip->i_mount;
>> +        xfs_warn(mp, "%s: Deleting inode %llu with no links.",
>> +             __func__, ip->i_ino);
>> +        return 0;
>> +    }
>> +
>>      xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
>>
>>      drop_nlink(VFS_I(ip));
> I'm not sure how nlink would ever get to 0xFFFFFFFF since the VFS won't
> let a link count exceed s_max_links, and XFS sets that to 0x7FFFFFFF.
> Unless, of course, you did that outside of Linux.
In VFS drop_nlink() only produce a warning, when (inode->i_nlink == 0),
not prevent its self-reduce(inode->__i_nlink--), cause it underflow
from 0 to 0xffffffff. In the old kernel version, this situation was
encountered, but I don't know how it happened. It was already a scene
with directory errors: "Too many links".

 kernel: WARNING: CPU: 12 PID: 12928 at fs/inode.c:286 drop_nlink+0x3e/0x50
 kernel: CPU: 12 PID: 12928 Comm: gbased Tainted: G        W  OE  ------------ T 3.10.0-693.21.1.el7.x86_64 #1
 kernel: Hardware name: HPE ProLiant BL460c Gen10/ProLiant BL460c Gen10, BIOS I41 01/23/2021
 kernel: Call Trace:-------------------
 kernel: [<ffffffff816c5fce>] dump_stack+0x19/0x1b
 kernel: [<ffffffff8108dfa8>] __warn+0xd8/0x100/*
 kernel: [<ffffffff8108e0ed>] warn_slowpath_null+0x1d/0x20
 kernel: [<ffffffff8122cdfe>] drop_nlink+0x3e/0x50
 kernel: [<ffffffffc03cdc78>] xfs_droplink+0x28/0x60 [xfs]
 kernel: [<ffffffffc03cf87a>] xfs_remove+0x2aa/0x320 [xfs]
 kernel: [<ffffffffc03c9f7a>] xfs_vn_unlink+0x5a/0xa0 [xfs]
 kernel: [<ffffffff8121f19c>] vfs_rmdir+0xdc/0x150
 kernel: [<ffffffff81221e41>] do_rmdir+0x1f1/0x220
 kernel: [<ffffffff81223046>] SyS_rmdir+0x16/0x20
 kernel: [<ffffffff816d86d5>] system_call_fastpath+0x1c/0x21
> That said, why wouldn't you /pin/ the link count at -1U instead of
> allowing it to overflow to zero?
> Could you please take a look at this patch that's waiting in my
> submission queue?
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=inode-repair-improvements&id=05f5a82efa6395c92038e18e008aaf7154238f27
I think the XFS_NLINK_PINNEED(~0U) can be used prevent Overflow in inc_nlink().
Is it better to compare i_nlink with (0U) in drop_nlink() to prevent Underflow?
(like this patch does, do not make i_nlink underflow from 0 to 0xffffffff)

Thanks.
> --D
>> @@ -2442,7 +2451,12 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
>>       */
>>      if (is_dir) {
>>          ASSERT(VFS_I(ip)->i_nlink >= 2);
>> -        if (VFS_I(ip)->i_nlink != 2) {
>> +        if (VFS_I(ip)->i_nlink < 2) {
>> +            xfs_warn(ip->i_mount,
>> +            "%s: Remove dir (inode %llu) with invalid links.",
>> +                 __func__, ip->i_ino);
>> +        }
>> +        if (VFS_I(ip)->i_nlink > 2) {
>>              error = -ENOTEMPTY;
>>              goto out_trans_cancel;
>>          }
>> --
>> 1.8.3.1
