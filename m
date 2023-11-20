Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14CF7F0F10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjKTJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTJ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:28:38 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3AAF2A7;
        Mon, 20 Nov 2023 01:28:34 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 9E0EA633B0343;
        Mon, 20 Nov 2023 17:28:30 +0800 (CST)
Message-ID: <5c98fc07-36a9-92cc-f8d6-c4efdc0c34aa@nfschina.com>
Date:   Mon, 20 Nov 2023 17:28:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] misc: mei: client.c: fix some error code problem in
 mei_cl_write
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tomas.winkler@intel.com, arnd@arndb.de, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        alexander.usyskin@intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <2023112010-ceremony-salad-145b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/20 17:14, Greg KH wrote:
> On Mon, Nov 20, 2023 at 04:53:45PM +0800, Su Hui wrote:
>> Clang static analyzer complains that value stored to 'rets' is never
>> read. Remove some useless code, and let 'buf_len = -EOVERFLOW' to make
>> sure we can return '-EOVERFLOW'.
>>
>> mei_msg_hdr_init() return negative error code, rets should be
>> 'PTR_ERR(mei_hdr)' rather than '-PTR_ERR(mei_hdr)'.
>>
>> Fixes: 0cd7c01a60f8 ("mei: add support for mei extended header.")
>> Fixes: 8c8d964ce90f ("mei: move hbuf_depth from the mei device to the hw modules")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/misc/mei/client.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
>> index 9c8fc87938a7..00dac0a47da0 100644
>> --- a/drivers/misc/mei/client.c
>> +++ b/drivers/misc/mei/client.c
>> @@ -2011,7 +2011,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
>>   
>>   	mei_hdr = mei_msg_hdr_init(cb);
>>   	if (IS_ERR(mei_hdr)) {
>> -		rets = -PTR_ERR(mei_hdr);
>> +		rets = PTR_ERR(mei_hdr);
> This looks like a bugfix, while the other changes here are just a normal
> cleanup.  Can you please split this up into different patches?
I will split this right now.
Thanks for your suggestion!

Su Hui

>
> thanks,
>
> greg k-h
