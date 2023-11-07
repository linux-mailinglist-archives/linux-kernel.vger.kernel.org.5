Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8437E41AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjKGORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:17:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5DB7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:16:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7161EC433C8;
        Tue,  7 Nov 2023 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699366617;
        bh=R9OA8mhF5RghtqDJjribVRkp7fFko3YunNCGXQmTRBk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HfkY3eYpgEsTR5dXAgY2XDtrW1QNCGxNKiRZWC2JIGrzN2mcsnitFAjyqEca46oeG
         IZG8hahZEf6lti9KywdC5+yelpLHThmga18uhCh062gapZqclRp98mOeLVsrQlQz5K
         JTZpZ/xtgvB0bXykGOtnbsY3ksz1gdFAz0H5D2k0et76qwlXLUodWbZVnq0bzrJMm1
         bOx0/blFr7Dk0SA668opAG/9F7YEaJ6RJiVgjL9TzVJTylpofgDgY6yFoFfPee5jz7
         qCheczoAkyI3TJuVuthpyRwE0u79UDYviTv4nCKmLdVmeRTM1qWHkktGSA+GKe7s7+
         Wbo7Nx8YwxV0g==
Message-ID: <46d5e083-6e85-1e92-8123-3d0c7579c79f@kernel.org>
Date:   Tue, 7 Nov 2023 22:16:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] f2fs: use inode_lock_shared instead of inode_lock in
 f2fs_seek_block()
Content-Language: en-US
To:     zhangxirui <xirui.zhang@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231021121907.2908801-1-xirui.zhang@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231021121907.2908801-1-xirui.zhang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/21 20:19, zhangxirui wrote:
> inode_lock_shared() -> down_read(&inode->i_rwsem)
>         inode_lock() -> down_write(&inode->i_rwsem)
> 
> Inode is not updated in f2fs_seek_block(), so there is no need
> to hold write lock, use read lock for more efficiency.
> 
> Signed-off-by: zhangxirui <xirui.zhang@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
