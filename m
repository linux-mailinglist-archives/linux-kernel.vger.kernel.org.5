Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC237AE391
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjIZCFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjIZCFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:05:32 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61460D8;
        Mon, 25 Sep 2023 19:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:Subject:To:Cc:References:From:
        Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
        Content-Transfer-Encoding:Content-Language; bh=5Gu+vcTqYl7eNcSUV
        XDQd477d05PsekaKufbjc8mL+c=; b=jorsoXQKJf1SrdW9owBKYUH8Qpa/orXPX
        JE5nIwwSkiJmQ1rnpguP1moX1l9hE1wSkmH/dqvM2f/88LIiOhQdoSyWUAsbQVE4
        OhHLR3z4oN25eA3efthwtGp0+7Skfl6xPvxZb2WXz5rN3/y0bALnRX3ZaFHPoqKS
        DcQhvHnzlw=
Received: from [192.168.0.100] (unknown [10.130.159.144])
        by coremail-app2 (Coremail) with SMTP id Nyz+CgCXVtxePBJlUMW6AA--.1828S3;
        Tue, 26 Sep 2023 10:05:18 +0800 (CST)
Subject: Re: [PATCH v2] usb: dwc2: fix possible NULL pointer dereference
 caused by driver concurrency
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hminas@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2023092521-shredder-sublime-97fe@gregkh>
From:   Jia-Ju Bai <baijiaju@buaa.edu.cn>
Message-ID: <32def881-6a8d-a3c8-be7f-dc3069c475e7@buaa.edu.cn>
Date:   Tue, 26 Sep 2023 10:05:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <2023092521-shredder-sublime-97fe@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Nyz+CgCXVtxePBJlUMW6AA--.1828S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry3Wr4rKryUKr1xAw4xJFb_yoW5Xw45pa
        1xKa4Syw4DZF47t347Jrs5XF48ArW3WrWUKr10q34fAanrurySqw4xtFWS9ayq9rZ5Ka10
        qr1jvrZ2yrWUXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU8IzuJUUUUU==
X-CM-SenderInfo: yrruji46exttoohg3hdfq/
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply!

I will follow the rules and revise the patch.


Best wishes,
Jia-Ju Bai

On 2023/9/25 20:08, Greg KH wrote:
> On Mon, Sep 25, 2023 at 06:07:41PM +0800, Jia-Ju Bai wrote:
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
>>
>> This possible bug is found by a static tool developed by myself.
> Because of this please follow the rules for such things as documented in
> Documentation/process/researcher-guidelines.rst
>
>> To fix this possible bug, "urb->hcpriv = NULL" should be executed with
>> holding the lock "hsotg->lock". Because I have no associated hardware,
>> I cannot test the patch in real execution, and just verify it according
>> to the code logic.
>>
>> Fixes: 33ad261aa62b ("usb: dwc2: host: spinlock urb_enqueue")
>> Signed-off-by: Jia-Ju Bai <baijiaju@buaa.edu.cn>
> My bot says:
>
> -----------
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>    older released kernel, yet you do not have a cc: stable line in the
>    signed-off-by area at all, which means that the patch will not be
>    applied to any older kernel releases.  To properly fix this, please
>    follow the documented rules in the
>    Documetnation/process/stable-kernel-rules.rst file for how to resolve
>    this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

