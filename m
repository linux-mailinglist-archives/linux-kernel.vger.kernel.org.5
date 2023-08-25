Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3038B788319
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbjHYJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbjHYJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:10:10 -0400
X-Greylist: delayed 2259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 02:10:08 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D31BF2;
        Fri, 25 Aug 2023 02:10:07 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RXDgG5J5jz4xPYg;
        Fri, 25 Aug 2023 17:10:02 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl2.zte.com.cn with SMTP id 37P99IOX020744;
        Fri, 25 Aug 2023 17:09:18 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 25 Aug 2023 17:09:20 +0800 (CST)
Date:   Fri, 25 Aug 2023 17:09:20 +0800 (CST)
X-Zmail-TransId: 2b0564e86fc074a-0da49
X-Mailer: Zmail v1.0
Message-ID: <202308251709208292077@zte.com.cn>
In-Reply-To: <ZOfhoLql0TYiD5JW@dread.disaster.area>
References: 202308241543526473806@zte.com.cn,ZOfhoLql0TYiD5JW@dread.disaster.area
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 37P99IOX020744
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64E86FEA.002/4RXDgG5J5jz4xPYg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
>> From: Cheng Lin <cheng.lin130@zte.com.cn>
>> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
>> directory to become unusable until the next xfs_repair run.
> Hmmm.  How does this ever happen?
> IMO, if it does happen, we need to fix whatever bug that causes it
> to happen, not issue a warning and do nothing about the fact we
> just hit a corrupt inode state...
Yes, I'm very agree with your opinion. But I don't know how it happened,
and how to reproduce it.
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
> This is obviously incorrect - whiteout inodes (RENAME_WHITEOUT) have an
> i_nlink of zero when they are removed from the unlinked list. As do
> O_TMPFILE inodes - when they are linked into the filesystem, we
> explicitly check for i_nlink being zero before calling
> xfs_iunlink_remove().
I am not familiar with the above process. You means there is such a
scenario, even if it is (i_nlink==0), it still needs to run drop_nlink()
in xfs_droplink()? But this will cause i_nlink to underflow to 0xffffffff.
>> +
>>      xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
>>
>>      drop_nlink(VFS_I(ip));
> Wait a second - this code doesn't match an upstream kernel. What
> kernel did you make this patch against?
It's kernel mainline linux-6.5-rc7

Thanks.
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
