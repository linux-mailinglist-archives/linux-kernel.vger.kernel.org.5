Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB8762BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGZGo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjGZGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:44:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77F1BF8;
        Tue, 25 Jul 2023 23:44:06 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9kml400PzCrWH;
        Wed, 26 Jul 2023 14:40:39 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:44:01 +0800
Subject: Re: [PATCH] USB:bugfix a controller halt error
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <2023072153-module-wannabe-5637@gregkh>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <bc2cd818-c7ad-9061-29ce-f5390d44d8ab@huawei.com>
Date:   Wed, 26 Jul 2023 14:44:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2023072153-module-wannabe-5637@gregkh>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/21 19:08, Greg KH Wrote:
> On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
>> On systems that use ECC memory. The ECC error of the memory will
>> cause the USB controller to halt. It causes the usb_control_msg()
>> operation to fail.
> 
> Why does ECC memory matter here?
>

This is a test conducted under a special test scenario.
ECC memory errors are caused by some test tools.

>> At this point, the returned buffer data is an abnormal value, and
>> continuing to use it will lead to incorrect results.
>>
>> Therefore, it is necessary to judge the return value and exit.
>>
>> Signed-off-by: liulongfang <liulongfang@huawei.com>
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
> 
> Are you sure this is correct?  How was this tested?  Seems to me that
> this will still return "success" if this code path ever happens, what am

You are right. I made a patch error here. The code modification should be like this:
if (r < 0) {
	retval = r;
	kfree(buf);
	goto fail;
}

thanks,

Longfang.
> I missing?
> 
> thanks,
> 
> greg k-h
> .
> 
