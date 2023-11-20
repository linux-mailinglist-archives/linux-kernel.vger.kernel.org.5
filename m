Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA7F7F0A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 02:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjKTBd7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Nov 2023 20:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjKTBd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 20:33:58 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283FAF;
        Sun, 19 Nov 2023 17:33:51 -0800 (PST)
X-UUID: a415da84ec33465490b3bf93b867497a-20231120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:971e500b-8345-482f-863e-990189d2dcff,IP:20,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-INFO: VERSION:1.1.32,REQID:971e500b-8345-482f-863e-990189d2dcff,IP:20,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:5
X-CID-META: VersionHash:5f78ec9,CLOUDID:87f5b5fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:23111917141437RVKK6Q,BulkQuantity:4,Recheck:0,SF:38|24|17|19|44|64|6
        6|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: a415da84ec33465490b3bf93b867497a-20231120
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1847431844; Mon, 20 Nov 2023 09:33:37 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
        by mail.kylinos.cn (NSMail) with SMTP id 867A9E0080FF;
        Mon, 20 Nov 2023 09:33:37 +0800 (CST)
X-ns-mid: postfix-655AB771-470563140
Received: from [172.20.12.156] (unknown [172.20.12.156])
        by mail.kylinos.cn (NSMail) with ESMTPA id 891A4E0080FF;
        Mon, 20 Nov 2023 09:33:35 +0800 (CST)
Message-ID: <313c7290-1f8c-4944-a420-be23d28e59fa@kylinos.cn>
Date:   Mon, 20 Nov 2023 09:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ksmbd: prevent memory leak on error return
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Pierre Mariani <pierre.mariani@gmail.com>
Cc:     Zongmin Zhou <min_halo@163.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        sfrench@samba.org, tom@talpey.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <CAKYAXd8qZTiSBR3aSUk4YRSo+LG-Z20FRJfGgV1Awf+Lep4kpg@mail.gmail.com>
 <20231109011725.1798784-1-min_halo@163.com>
 <b503d929-ff3a-4dc3-9de8-aa0eb00d181a@gmail.com>
 <CAKYAXd-2vR7KF=gwKWmA+a3XkAOG78ntPq__u4P5Kqo35N1D5Q@mail.gmail.com>
Content-Language: en-US
From:   Zongmin Zhou <zhouzongmin@kylinos.cn>
In-Reply-To: <CAKYAXd-2vR7KF=gwKWmA+a3XkAOG78ntPq__u4P5Kqo35N1D5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/19 22:17, Namjae Jeon wrote:
> 2023-11-19 18:14 GMT+09:00, Pierre Mariani <pierre.mariani@gmail.com>:
>> On 11/8/2023 5:17 PM, Zongmin Zhou wrote:
>>> When allocated memory for 'new' failed,just return
>>> will cause memory leak of 'ar'.
>>>
>>> v2: rollback iov_alloc_cnt when allocate memory failed.
>>>
>>> Fixes: 1819a9042999 ("ksmbd: reorganize ksmbd_iov_pin_rsp()")
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>> Closes: https://lore.kernel.org/r/202311031837.H3yo7JVl-lkp@intel.com/
>>> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
>>> ---
>>>   fs/smb/server/ksmbd_work.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
>>> index a2ed441e837a..44bce4c56daf 100644
>>> --- a/fs/smb/server/ksmbd_work.c
>>> +++ b/fs/smb/server/ksmbd_work.c
>>> @@ -123,8 +123,11 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work
>>> *work, void *ib, int len,
>>>   		new = krealloc(work->iov,
>>>   			       sizeof(struct kvec) * work->iov_alloc_cnt,
>>>   			       GFP_KERNEL | __GFP_ZERO);
>>> -		if (!new)
>>> +		if (!new) {
>>> +			kfree(ar);
>>> +			work->iov_alloc_cnt -= 4;
>>>   			return -ENOMEM;
>>> +		}
>>>   		work->iov = new;
>>>   	}
>>>
>> A few lines above, ar is allocated inside the 'if (aux_size)' block.
>> If aux_size is falsy, isn't it possible that ar will be NULL hence
>> we should have 'if (ar) kfree(ar);'?
> We need to initialize ar to NULL on that case. And Passing a NULL
> pointer to kfree is safe, So NULL check before kfree() is not needed.
Yes, ar should be initialized to NULL to avoid the case of  aux_size 
will be false.
Since kfree(NULL) is safe.
Should I  send another patch for this?

Best regards!
> Thanks.
