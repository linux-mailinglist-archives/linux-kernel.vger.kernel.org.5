Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FEC77C95A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjHOI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjHOIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:25:54 -0400
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FCC1998
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:25:46 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:6284:0:640:e19:0])
        by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 8A14A5F1D7;
        Tue, 15 Aug 2023 11:25:44 +0300 (MSK)
Received: from [IPV6:2a02:6b8:82:604:9245:1a8e:bce8:ecc7] (unknown [2a02:6b8:82:604:9245:1a8e:bce8:ecc7])
        by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gPav002OguQ0-9CB1RcOK;
        Tue, 15 Aug 2023 11:25:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692087943; bh=YcCsm+6XynL0/qyOh1llq4Wf32JEiyRoXmpXmc7c2SQ=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=WiTbnO6C1V1UENLqF+qlCO2KSKbHDkMUp5HECKvtfUJfIdABjy7p0Ygntz/kYgUMf
         vYNktEs+5O5pRIp5pzFxZodcFG/Z69rtEO07Gv2YnpX9U+lFzaoGs0dryNSo1vsmn/
         gRByMCAjd+6SCOAZQBKzHVTFa7SxOkFi5ANUsC1A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <2d3960a6-34fc-1951-b39b-ce41674bb4d0@yandex-team.ru>
Date:   Tue, 15 Aug 2023 13:25:42 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] kernfs: implement custom llseek method to fix userspace
 regression
To:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
References: <20230814190850.948032-1-valesini@yandex-team.ru>
 <64da880166403_5ea6e29449@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: ru, en-US
From:   Valentin Sinitsyn <valesini@yandex-team.ru>
In-Reply-To: <64da880166403_5ea6e29449@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.2023 01:01, Dan Williams wrote:
> Valentine Sinitsyn wrote:
>> Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"),
>> mmapable sysfs binary attributes have started receiving their
>> f_mapping from the iomem pseudo filesystem, so that
>> CONFIG_IO_STRICT_DEVMEM is honored in sysfs (and procfs) as well
>> as in /dev/[k]mem.
>>
>> This resulted in a userspace-visible regression: lseek(fd, 0, SEEK_END)
>> now returns zero regardless the real sysfs attribute size which stat()
>> reports. The reason is that kernfs files use generic_file_llseek()
>> implementation, which relies on f_mapping->host inode to get the file
>> size. As f_mapping is now redefined, f_mapping->host points to an
>> anonymous zero-sized iomem inode which has nothing to do with sysfs
>> attribute or kernfs file representing it. This being said, f_inode
>> remains valid, so stat() which uses it works correctly.
> 
> Can you say a bit more about what userspace scenario regressed so that
> others doing backports can make a judgement call on the severity?

We've encountered this regression in the code which used lseek() to 
determine the size of PCI region. It was roughly equivalent to:

#define SYSFS_DEVICE_DIR "/sys/bus/pci/devices/<some id>/"

int fd = open(SYSFS_DEVICE_DIR "/resource0", O_RDWR);
off_t size = lseek(fd, 0, SEEK_END);
assert(size != 0)

Calling lseek() with whence argument other than SEEK_END and non-zero 
offset on this fd returns an error as the kernel considers it as seeking 
past EOF.

I'll add this explanation to v2 commit message.

> 
>>
>> Fixes the regression by implementing a custom llseek fop for kernfs,
>> which uses an attribute's file inode to get the file size,
>> just as stat() does.
>>
>> Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
>> ---
>>   fs/kernfs/file.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
>> index 180906c36f51..6d81e0c981f3 100644
>> --- a/fs/kernfs/file.c
>> +++ b/fs/kernfs/file.c
>> @@ -903,6 +903,21 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
>>   	return ret;
>>   }
>>   
>> +static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
>> +{
>> +	/*
>> +	 * This is almost identical to generic_file_llseek() except it uses
>> +	 * cached inode value instead of f_mapping->host.
>> +	 * The reason is that, for PCI resources in sysfs the latter points to
>> +	 * iomem_inode whose size has nothing to do with the attribute's size.
>> +	 */
>> +	struct inode *inode = file_inode(file);
> 
> My only concern is whether there are any scenarios where this is not
> appropriate. I.e. do a bit more work to define a kernfs_ops instance
> specifically for overriding lseek() in this scenario.

Not sure I'm getting you here: do you mean something like this?

struct inode *inode = is_f_mapping_redefined(file) ? file_inode(file) : 
file->f_mapping->host;

My understanding is file->f_inode should always be non-NULL and point to 
the inode corresponding the path of the opened file, so it should be 
safe to call regardless what f_mapping->host is. Do I miss anything?

Best,
Valentin

> 
>> +
>> +	return generic_file_llseek_size(file, offset, whence,
>> +					inode->i_sb->s_maxbytes,
>> +					i_size_read(inode));
>> +}
>> +
>>   static void kernfs_notify_workfn(struct work_struct *work)
>>   {
>>   	struct kernfs_node *kn;
>> @@ -1005,7 +1020,7 @@ EXPORT_SYMBOL_GPL(kernfs_notify);
>>   const struct file_operations kernfs_file_fops = {
>>   	.read_iter	= kernfs_fop_read_iter,
>>   	.write_iter	= kernfs_fop_write_iter,
>> -	.llseek		= generic_file_llseek,
>> +	.llseek		= kernfs_fop_llseek,
>>   	.mmap		= kernfs_fop_mmap,
>>   	.open		= kernfs_fop_open,
>>   	.release	= kernfs_fop_release,
>> -- 
>> 2.34.1
>>
> 
> 

