Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEAA7AE346
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjIZBVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIZBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:21:08 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5BDF910A;
        Mon, 25 Sep 2023 18:21:01 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 92714604DE905;
        Tue, 26 Sep 2023 09:20:58 +0800 (CST)
Message-ID: <8c2f8756-be5c-e2b3-e1a8-d2751a4531a0@nfschina.com>
Date:   Tue, 26 Sep 2023 09:20:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] cifs: avoid possible NULL dereference
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <1ae6c204-ed00-4626-8246-32d66ae7e232@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/25 23:07, Dan Carpenter wrote:
> On Mon, Sep 25, 2023 at 12:52:21PM +0800, Su Hui wrote:
>> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
>> index 2108b3b40ce9..37eed057ded0 100644
>> --- a/fs/smb/client/file.c
>> +++ b/fs/smb/client/file.c
>> @@ -4878,6 +4878,12 @@ void cifs_oplock_break(struct work_struct *work)
>>   	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
>>   						  oplock_break);
>>   	struct inode *inode = d_inode(cfile->dentry);
>> +
>> +	if (!inode) {
>> +		cifs_dbg(FYI, "%s : failed to find inode\n", __func__);
>> +		return;
>> +	}
>> +
> Are we allowing this in the middle of the declaration block these days?
Really sorry for this, I will modify it right now.
Thanks for your reminder!

Su Hui

>
>>   	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
>>   	struct cifsInodeInfo *cinode = CIFS_I(inode);
>>   	struct cifs_tcon *tcon;
>
> regards,
> dan carpenter
