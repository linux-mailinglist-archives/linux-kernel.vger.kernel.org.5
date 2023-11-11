Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719167E897D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjKKGVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 01:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKKGVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:21:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D11BD;
        Fri, 10 Nov 2023 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HjnXgPbnUna/oPgDe8pEjrr2CwDcTyuc+FlgnPW0cEU=; b=LEndJGQIQvi05zDNMiV2VbqNWw
        QtZjw7fZehxVtinobkFEIB0CmpZhTCBVAun9aIyFYPuY5ZZ/bdcEKeaxwJcuJBOAHC1hFp3JI2L3S
        uJg+zFEiMGAIuL0aZbs/60b3dpkki+9fC+Nuxyknv5K8bbWm2HynYnSjxG2zh/mEK3N4IihxzcinA
        Hj28C5DGl9xC6AWA9p0COKynwntiWbGP9Tav34JFfMiEwZfkx1DhKzXlC4mZmLMNIeMOH6ui6g0AK
        x2U8dgZoHix86uO3+8OmLMLkLI1GPpxuwS8Pd9WBmPFF71bZ5xUDGyAR+Z5tdyqLVBehBBAL8FFDV
        cbvopBIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1hMZ-000Kw2-Ej; Sat, 11 Nov 2023 06:20:59 +0000
Date:   Sat, 11 Nov 2023 06:20:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com,
        boris@bur.io, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: fix warning in create_pending_snapshot
Message-ID: <ZU8dS0dlOGOblbxf@casper.infradead.org>
References: <0000000000001959d30609bb5d94@google.com>
 <tencent_DB6BA6C1B369A367C96C83A36457D7735705@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DB6BA6C1B369A367C96C83A36457D7735705@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 01:06:01PM +0800, Edward Adam Davis wrote:
> +++ b/fs/btrfs/disk-io.c
> @@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
>  		goto out;
>  	}
>  
> -	*objectid = root->free_objectid++;
> +	while (find_qgroup_rb(root->fs_info, root->free_objectid++));
> +	*objectid = root->free_objectid;

This looks buggy to me.  Let's say that free_objectid is currently 3.

Before, it would assign 3 to *objectid, and increment free_objectid to
4.  After (assuming the loop terminates on first iteration), it will
increment free_objectid to 4, then assign 4 to *objectid.

I think you meant to write:

	while (find_qgroup_rb(root->fs_info, root->free_objectid))
		root->free_objectid++;
	*objectid = root->free_objectid++;

And the lesson here is that more compact code is not necessarily more
correct code.

(I'm not making any judgement about whether this is the correct fix;
I don't understand btrfs well enough to have an opinion.  Just that
this is not an equivalent transformation)
