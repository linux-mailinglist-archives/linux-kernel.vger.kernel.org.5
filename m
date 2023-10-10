Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB17BF593
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442782AbjJJIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442750AbjJJITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:41 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2583CB4;
        Tue, 10 Oct 2023 01:19:37 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 8FB1D60637837;
        Tue, 10 Oct 2023 16:19:33 +0800 (CST)
Message-ID: <d0753768-874e-6f41-550d-c10dfc6f9c5b@nfschina.com>
Date:   Tue, 10 Oct 2023 16:19:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <56aa4f09-8f61-48f3-9836-687bf852b03a@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/10 15:51, Dan Carpenter wrote:
> On Sun, Oct 08, 2023 at 02:01:39PM +0800, Su Hui wrote:
>> with gcc and W=1 option, there's a warning like this:
>>
>> In file included from fs/9p/xattr.c:12:
>> In function ‘v9fs_xattr_get’,
>>      inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
>> include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
>> [-Werror=format-overflow=]
>>     55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>>        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> use "" replace NULL to silence this warning.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/9p/xattr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
>> index e00cf8109b3f..d995ee080835 100644
>> --- a/fs/9p/xattr.c
>> +++ b/fs/9p/xattr.c
>> @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>>   
>>   ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>>   {
>> -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
>> +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
> I'm pretty uncomfortable with this patch...  This code is 13 years old
> so it can't be too huge of a problem.  We're doing this for the printks,
> but now they're going to look weird first of all.
>
> Old: "file = (null)"
> New: "file = "
Agreed, this looks  really weird and the patch is just for avoiding 
gcc's warning.
Sorry for the noise.

Su Hui

>
> But also this must have some other effects on runtime right?
>
> regards,
> dan carpenter
>
