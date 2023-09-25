Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEA7AD58C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjIYKLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjIYKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:11:28 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD9D5A3;
        Mon, 25 Sep 2023 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:Subject:To:Cc:References:From:
        Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
        Content-Transfer-Encoding:Content-Language; bh=weCv7YPsVd0pOthcO
        GIJ62Z7sXgKnGmtrtBdDaS9X7M=; b=weoL8i8XgYKNw9S18Lpjo6mCvxocMdrbt
        OWU79RvyH8zhpWA5nkZrsJUotTaON9loZmcnoeobdAeq+wpIjEOioMCQYnArnHZ4
        ZHZbY9k7xZM2SQRCuxpVUX/YoT07bdYl0Ajp8sDPZ+n5Wsp7zw0BhfrbVMmx+6JF
        4x6sLXdLv8=
Received: from [192.168.0.100] (unknown [10.130.159.144])
        by coremail-app2 (Coremail) with SMTP id Nyz+CgCnaN64XBFloH+vAA--.3197S3;
        Mon, 25 Sep 2023 18:11:04 +0800 (CST)
Subject: Re: [PATCH] usb: dwc2: fix possible NULL pointer dereference caused
 by driver concurrency
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hminas@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2023092552-tulip-yo-yo-cbb3@gregkh>
From:   Jia-Ju Bai <baijiaju@buaa.edu.cn>
Message-ID: <e8ee2457-0d43-834c-8bdb-69791dc9fc34@buaa.edu.cn>
Date:   Mon, 25 Sep 2023 18:11:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <2023092552-tulip-yo-yo-cbb3@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Nyz+CgCnaN64XBFloH+vAA--.3197S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7tr48KF4UtFWrAFy3twb_yoW8uryDpF
        4xJa4Ika1qvanxt3y5XFs5WF15Jws8WryUur4xtayrAwn7uryxJ3WfGFWS9rZY9rs3Cana
        vF1jvr4xCrWDta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07jbrc-UUUUU=
X-CM-SenderInfo: yrruji46exttoohg3hdfq/
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply :)

On 2023/9/25 17:38, Greg KH wrote:
> On Mon, Sep 25, 2023 at 05:17:41PM +0800, Jia-Ju Bai wrote:
>> In _dwc2_hcd_urb_enqueue(), "urb->hcpriv = NULL" is executed without
>> holding the lock "hsotg->lock". In _dwc2_hcd_urb_dequeue():
>>
>>      spin_lock_irqsave(&hsotg->lock, flags);
>>      ...
>> 	if (!urb->hcpriv) {
>> 		dev_dbg(hsotg->dev, "## urb->hcpriv is NULL ##\n");
>> 		goto out;
>> 	}
>>      rc = dwc2_hcd_urb_dequeue(hsotg, urb->hcpriv); // Use urb->hcpriv
>>      ...
>> out:
>>      spin_unlock_irqrestore(&hsotg->lock, flags);
>>
>> When _dwc2_hcd_urb_enqueue() and _dwc2_hcd_urb_dequeue() are
>> concurrently executed, the NULL check of "urb->hcpriv" can be executed
>> before "urb->hcpriv = NULL". After urb->hcpriv is NULL, it can be used
>> in the function call to dwc2_hcd_urb_dequeue(), which can cause a NULL
>> pointer dereference.
> Odd trailing spaces in your changelog text, is that intentional?

They are caused by the configuration of my file editor, and I changed it 
just now.

>
>> To fix this possible bug, "urb->hcpriv = NULL" should be executed with
>> holding the lock "hsotg->lock".
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju@buaa.edu.cn>
>> ---
>>   drivers/usb/dwc2/hcd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>> index 657f1f659ffa..35c7a4df8e71 100644
>> --- a/drivers/usb/dwc2/hcd.c
>> +++ b/drivers/usb/dwc2/hcd.c
>> @@ -4769,8 +4769,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
>>   	if (qh_allocated && qh->channel && qh->channel->qh == qh)
>>   		qh->channel->qh = NULL;
>>   fail2:
>> -	spin_unlock_irqrestore(&hsotg->lock, flags);
>>   	urb->hcpriv = NULL;
>> +	spin_unlock_irqrestore(&hsotg->lock, flags);
>>   	kfree(qtd);
>>   fail1:
>>   	if (qh_allocated) {
>> -- 
>> 2.34.1
>>
> What commit id does this fix?
>
> And how did you test this to verify it works properly?
>
> And how was it found?

I sent a v2 patch to add these details and fix the mistakes about 
trailing spaces.


Thanks,
Jia-Ju Bai

