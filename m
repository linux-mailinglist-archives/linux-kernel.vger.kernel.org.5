Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD1768542
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjG3MYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjG3MYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:24:42 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F61729;
        Sun, 30 Jul 2023 05:24:40 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9FD708693A;
        Sun, 30 Jul 2023 14:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690719878;
        bh=m4GxBbdxZgPVCT8FGvfcSlBhWXsZWZ4HZPNmP1kY8fg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=prXt/Mzg715VQmvmuwt5QJC8LBhng/44pyew9h4a/isB6RM8GN7PQ/nhpc4ptn7tr
         jka3YRgKZm1YQhGUA2DgYeGW1qhh5iuSR0/n8+FLKY1jV8MAk2/NaDAjyxPehQpUEx
         Qoh6lbDD4SryJf1cW9xaOBH/WWJ/DdpSxu5pWSGQwrgsxm04VhrfhoRsWv+Kn2SdMJ
         rcOk2FvK1+1jSxC+f0kXdoN47oZTLwfdPQ07IO7yENbx2o95wupY/qe6U6ue18C9cr
         eDLLhUFvih05gpYFsc8/YN+lAm0JyBcpz3khjM82O1Nc5Dsrp9iw7E3MHRzq16zdZI
         1wjb0IrsJNRJg==
Message-ID: <d4458111-9384-44df-9a33-e8e66e9c03ea@denx.de>
Date:   Sun, 30 Jul 2023 14:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/22] Input: ili210x - use device core to create
 driver-specific device attributes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-13-dmitry.torokhov@gmail.com>
 <fd975ac8-bea4-22ae-cb5f-cbdaa3566d25@denx.de>
 <2023073010-debunk-tripping-270a@gregkh>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <2023073010-debunk-tripping-270a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/23 13:38, Greg Kroah-Hartman wrote:
> On Sat, Jul 29, 2023 at 05:07:17PM +0200, Marek Vasut wrote:
>> On 7/29/23 02:51, Dmitry Torokhov wrote:
>>> Instead of creating driver-specific device attributes with
>>> devm_device_add_group() have device core do this by setting up dev_groups
>>> pointer in the driver structure.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> ---
>>>    drivers/input/touchscreen/ili210x.c | 15 +++++----------
>>>    1 file changed, 5 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
>>> index ad6828e4f2e2..31ffdc2a93f3 100644
>>> --- a/drivers/input/touchscreen/ili210x.c
>>> +++ b/drivers/input/touchscreen/ili210x.c
>>> @@ -876,7 +876,7 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
>>>    static DEVICE_ATTR(firmware_update, 0200, NULL, ili210x_firmware_update_store);
>>> -static struct attribute *ili210x_attributes[] = {
>>> +static struct attribute *ili210x_attrs[] = {
>>>    	&dev_attr_calibrate.attr,
>>>    	&dev_attr_firmware_update.attr,
>>>    	&dev_attr_firmware_version.attr,
>>> @@ -904,10 +904,11 @@ static umode_t ili210x_attributes_visible(struct kobject *kobj,
>>>    	return attr->mode;
>>>    }
>>> -static const struct attribute_group ili210x_attr_group = {
>>> -	.attrs = ili210x_attributes,
>>> +static const struct attribute_group ili210x_group = {
>>> +	.attrs = ili210x_attrs,
>>
>> Is all the renaming really necessary and relevant to this patch ?
> 
> Yes, it's needed for the __ATTRIBUTE_GROUPS() macro.

Ah ok
