Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B806762C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjGZG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGZG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:58:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF930D7;
        Tue, 25 Jul 2023 23:58:24 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9l8705F9z1GDHf;
        Wed, 26 Jul 2023 14:57:26 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:58:19 +0800
Subject: Re: [PATCH] USB:bugfix a controller halt error
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
Date:   Wed, 26 Jul 2023 14:58:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/21 22:57, Alan Stern Wrote:
> On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
>> On systems that use ECC memory. The ECC error of the memory will
>> cause the USB controller to halt. It causes the usb_control_msg()
>> operation to fail.
> 
> How often does this happen in real life?  (Besides, it seems to me that 
> if your system is getting a bunch of ECC memory errors then you've got 
> much worse problems than a simple USB failure!)
>

This problem is on ECC memory platform.
In the test scenario, the problem is 100% reproducible.

> And why do you worry about ECC memory failures in particular?  Can't 
> _any_ kind of failure cause the usb_control_msg() operation to fail?
> 
>> At this point, the returned buffer data is an abnormal value, and
>> continuing to use it will lead to incorrect results.
> 
> The driver already contains code to check for abnormal values.  The 
> check is not perfect, but it should prevent things from going too 
> badly wrong.
>

If it is ECC memory error. These parameter checks would also
actually be invalid.

>> Therefore, it is necessary to judge the return value and exit.
>>
>> Signed-off-by: liulongfang <liulongfang@huawei.com>
> 
> There is a flaw in your reasoning.
> 
> The operation carried out here is deliberately unsafe (for full-speed 
> devices).  It is made before we know the actual maxpacket size for ep0, 
> and as a result it might return an error code even when it works okay.  
> This shouldn't happen, but a lot of USB hardware is unreliable.
> 
> Therefore we must not ignore the result merely because r < 0.  If we do 
> that, the kernel might stop working with some devices.
> 
It may be that the handling solution for ECC errors is different from that
of the OS platform. On the test platform, after usb_control_msg() fails,
reading the memory data of buf will directly lead to kernel crash:

[ T14] Call trace:
[ T14] hub_port_init+0x280/0x9f0
[ T14] hub_port_connect+0x1d4/0xa40
[ T14] hub_port_connect_change+0xb8/0x2b0
[ T14] port_event+0x430/0x5d0
[ T14] hub_event+0x138/0x4a0
[ T14] process_one_work+0x1c8/0x39c
[ T14] worker_thread+0x150/0x3d0
[ T14] kthread+0xfc/0x130
[ T14] ret_from_fork+0x10/0x18
[ T14] Code: 528000c2 b9007fea 94002c9a b9407fea (39401f41)

thanks,
Longfang.
> Alan Stern
> 
>> ---
>>  drivers/usb/core/hub.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index a739403a9e45..6a43198be263 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -4891,6 +4891,16 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>>  					USB_DT_DEVICE << 8, 0,
>>  					buf, GET_DESCRIPTOR_BUFSIZE,
>>  					initial_descriptor_timeout);
>> +				/* On systems that use ECC memory, ECC errors can
>> +				 * cause the USB controller to halt.
>> +				 * It causes this operation to fail. At this time,
>> +				 * the buf data is an abnormal value and needs to be exited.
>> +				 */
>> +				if (r < 0) {
>> +					kfree(buf);
>> +					goto fail;
>> +				}
>> +
>>  				switch (buf->bMaxPacketSize0) {
>>  				case 8: case 16: case 32: case 64: case 255:
>>  					if (buf->bDescriptorType ==
>> -- 
>> 2.24.0
>>
> 
> .
> 
