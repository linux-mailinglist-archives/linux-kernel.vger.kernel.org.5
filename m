Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960477BF02A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379274AbjJJBUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379258AbjJJBUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:20:19 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1F9F0DA;
        Mon,  9 Oct 2023 18:20:16 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id C0BAE60313E9A;
        Tue, 10 Oct 2023 09:20:13 +0800 (CST)
Message-ID: <e54d667c-58a5-4456-dda8-3a01d25c2489@nfschina.com>
Date:   Tue, 10 Oct 2023 09:20:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Content-Language: en-US
To:     Christian Schoenebeck <linux_oss@crudebyte.com>, ericvh@kernel.org,
        lucho@ionkov.net, asmadeus@codewreck.org, v9fs@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <13910281.Zj71IQSfG8@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/10 02:34, Christian Schoenebeck wrote:
> On Sunday, October 8, 2023 8:01:39 AM CEST Su Hui wrote:
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
>>   }
>>   
>>   static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
>>
> Mmm, that's not the same is it? Have you tested this change?
Oh, sorry.  That's not the same and I just tested compilation.
>
> Currently this function causes a 'Txattrwalk' 9p message to be sent to 9p
> server with its name[s] field being NULL, and the latter being the magical
> hint to 9p server to not send an attribute, but rather the list of attributes.
>
> With your change I would assume that it would rather ask server for one
> attribute called "". I have not tested myself, just worrying that it might
> break behaviour.
Got it, I made a mistake there. Thanks for your explanation.
Sorry for the noise again.

Su Hui


