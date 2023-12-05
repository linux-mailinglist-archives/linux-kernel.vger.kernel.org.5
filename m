Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37B7804DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjLEJ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjLEJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:51 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76FB188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:44 -0800 (PST)
X-UUID: 2aa5a5f3ecf24832a2cd6db6e3ab7ebb-20231205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:550d1e5a-49cd-4e19-8ab4-4c8269f71884,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.33,REQID:550d1e5a-49cd-4e19-8ab4-4c8269f71884,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:364b77b,CLOUDID:871a2b96-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:2312041843482P8UAYLL,BulkQuantity:3,Recheck:0,SF:19|44|64|66|38|24|1
        7|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2aa5a5f3ecf24832a2cd6db6e3ab7ebb-20231205
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1414185240; Tue, 05 Dec 2023 17:28:31 +0800
Message-ID: <7be4a5ac-d0b8-4f5d-848a-b54ab3c67228@kylinos.cn>
Date:   Tue, 5 Dec 2023 17:28:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix null pointer dereference in cxl_get_fd
To:     Frederic Barrat <fbarrat@linux.ibm.com>, ajd@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
        mrochs@linux.vnet.ibm.com
Cc:     kunwu.chan@hotmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20231204020745.2445944-1-chentao@kylinos.cn>
 <c914f4ba-253d-4b57-bdd2-4c95d40bbf91@linux.ibm.com>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <c914f4ba-253d-4b57-bdd2-4c95d40bbf91@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fred,
Thanks for your reply.


But there is a question, whether we should return an error code in error 
path so that the caller of the 'cxl_get_fd' can know the specific 
reason. rather than just return NULL.
Such as:
-       int rc, flags, fdtmp;
+       int rc = 0, flags, fdtmp;
         char *name = NULL;

         /* only allow one per context */
-       if (ctx->mapping)
-               return ERR_PTR(-EEXIST);
+       if (ctx->mapping) {
+               rc = -EEXIST;
+               goto err;
+       }

         flags = O_RDWR | O_CLOEXEC;

         /* This code is similar to anon_inode_getfd() */
         rc = get_unused_fd_flags(flags);
-       if (rc < 0)
-               return ERR_PTR(rc);
+       if (rc < 0) {
+               goto err;
+       }
         fdtmp = rc;



         name = kasprintf(GFP_KERNEL, "cxl:%d", ctx->pe);
+        if (!name) {
+               rc = -ENOMEM;
+               goto err_fd;
+        }
         file = cxl_getfile(name, fops, ctx, flags);
         kfree(name);
@@ -434,6 +437,9 @@ struct file *cxl_get_fd(struct cxl_context *ctx, 
struct file_operations *fops,

  err_fd:
         put_unused_fd(fdtmp);
+err:
+       if (rc)
+               return ERR_PTR(rc);
         return NULL;


Thanks again,
Kunwu

On 2023/12/4 18:43, Frederic Barrat wrote:
> 
> 
> On 04/12/2023 03:07, Kunwu Chan wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: bdecf76e319a ("cxl: Fix coredump generation when cxl_get_fd() 
>> is used")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/misc/cxl/api.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
>> index d85c56530863..bfd7ccd4d7e1 100644
>> --- a/drivers/misc/cxl/api.c
>> +++ b/drivers/misc/cxl/api.c
>> @@ -419,6 +419,10 @@ struct file *cxl_get_fd(struct cxl_context *ctx, 
>> struct file_operations *fops,
>>           fops = (struct file_operations *)&afu_fops;
>>       name = kasprintf(GFP_KERNEL, "cxl:%d", ctx->pe);
>> +    if (!name) {
>> +        put_unused_fd(fdtmp);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
> 
> 
> That works, but you might as well follow the existing error path:
> 
>      name = kasprintf(GFP_KERNEL, "cxl:%d", ctx->pe);
>      if (!name)
>          goto err_fd;
> 
>    Fred
> 
> 
>>       file = cxl_getfile(name, fops, ctx, flags);
>>       kfree(name);
>>       if (IS_ERR(file))
