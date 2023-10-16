Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEB7CA2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjJPIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjJPIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:55:05 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD5AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:55:03 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B1E5A240104
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697446500; bh=lcNO8RF8USGnm28CYJPW25RzcPZaulI87Ufu5MZHyDw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:
         Content-Transfer-Encoding:From;
        b=jNLOewiDEgdZnDPeEfYUIhkZbGReuru7naU2nd7Heeezn0Gc1HZUYupFHyg3vY/Zo
         +A1rhac77W+buyP/lUB2Ev0FvzHDw8rd/TvzGFIgU6+IjFAwEInF2Tu5+SqW0oprAY
         Ff7WGYU6Gy5Nl4NSEYIbRIdEB8X+EcrEg09R4+g1v40fokppYEZXKLyviJ8yE0/GxM
         6TINvIoFFHoO8YfLAzmYb3IJPkOCVpqKx+M5b07wco+bjmWiicJ9kBgsitDzkmRLxU
         Z/N3yHD5RjslV3S7gy0nnfPt7hJ9teY4PTiKxbctfRrdH41VDHbaO2w1Z9RGMwKYsx
         EEsSiJPVuqNIw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S89st09KMz9rxY;
        Mon, 16 Oct 2023 10:54:57 +0200 (CEST)
Message-ID: <7e3e0394-c644-4f7c-b7c8-849d459b3931@posteo.net>
Date:   Mon, 16 Oct 2023 08:54:57 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] nvme-auth: use transformed key size to create resp
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org,
        Akash Appaiah <Akash.Appaiah@dell.com>
References: <20231013202827.2262708-1-shiftee@posteo.net>
 <20231013202827.2262708-2-shiftee@posteo.net>
 <c60d34b1-5e2f-4b32-8519-c4a4ff89060a@suse.de>
From:   Mark O'Donovan <shiftee@posteo.net>
In-Reply-To: <c60d34b1-5e2f-4b32-8519-c4a4ff89060a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2023 12:41, Hannes Reinecke wrote:
> On 10/13/23 22:28, Mark O'Donovan wrote:
>> This does not change current behaviour as the driver currently
>> verifies that the secret size is the same size as the length of
>> the transformation hash.
>>
>> Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
>> Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
>> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>> ---
>>   drivers/nvme/host/auth.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index daf5d144a8ea..e7d478d17b06 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -418,6 +418,14 @@ static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
>>       return size;
>>   }
>> +static int nvme_auth_dhchap_transformed_key_len(struct nvme_dhchap_key *key)
>> +{
>> +    if (key->hash)
>> +        return nvme_auth_hmac_hash_len(key->hash);
>> +
>> +    return key->len;
>> +}
>> +
>>   static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>>           struct nvme_dhchap_queue_context *chap)
>>   {
>> @@ -442,7 +450,8 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>>       }
>>       ret = crypto_shash_setkey(chap->shash_tfm,
>> -            chap->host_response, ctrl->host_key->len);
>> +            chap->host_response,
>> +            nvme_auth_dhchap_transformed_key_len(ctrl->host_key));
>>       if (ret) {
>>           dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>>                chap->qid, ret);
> 
> Hmm. Yeah, hash size vs secret size always gets me.
> However, wouldn't it be better to return the key size from
> nvme_auth_transform_key and us that directly?
> (cf the attached patch)
> 
> Cheers,
> 
> Hannes

Hi Hannes,

I gave this a try and it ended up being easier to put it in struct nvme_dhchap_key.
V2 also does the nvme target code, and this means the length is stored in the same place.
Let me know if this works for you.

Thanks,
Mark
