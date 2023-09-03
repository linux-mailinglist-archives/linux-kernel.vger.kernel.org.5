Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF02790C8F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbjICOyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjICOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 10:54:12 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5067115;
        Sun,  3 Sep 2023 07:54:08 -0700 (PDT)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 2EB8C76370;
        Sun,  3 Sep 2023 14:54:08 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id 20DE542A0D;
        Sun,  3 Sep 2023 14:54:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id lcpRk2KAHnkr; Sun,  3 Sep 2023 14:54:07 +0000 (UTC)
Received: from [192.168.48.17] (host-104-157-209-188.dyn.295.ca [104.157.209.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 9E96942A0C;
        Sun,  3 Sep 2023 14:54:06 +0000 (UTC)
Message-ID: <7910a5e5-04f3-f585-e42d-4a0d7aa45f9d@interlog.com>
Date:   Sun, 3 Sep 2023 10:54:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
 <36a3daf7-d519-7669-13bf-4c59c11c2b97@wanadoo.fr>
 <46d3194a-af79-4076-b0a2-561d713a406e@t-8ch.de>
 <2776f856-94e4-1481-508a-db80db573be0@roeck-us.net>
 <290ebce4-54f0-8ac1-2a13-cbc806d80d64@interlog.com>
 <9151ab86-305e-9bb3-ee46-bfa8fd998c12@roeck-us.net>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <9151ab86-305e-9bb3-ee46-bfa8fd998c12@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-03 07:46, Guenter Roeck wrote:
> On 9/2/23 22:54, Douglas Gilbert wrote:
>> On 2023-09-02 18:56, Guenter Roeck wrote:
>>> On 9/2/23 15:29, Thomas Weißschuh wrote:
>>>> Hi,
>>>>
>>>> On 2023-09-02 18:36:17+0200, Christophe JAILLET wrote:
>>>>> Le 02/09/2023 à 09:47, Thomas Weißschuh a écrit :
>>>>>> POWER-Z is a series of devices to monitor power characteristics of
>>>>>> USB-C connections and display those on a on-device display.
>>>>>> Some of the devices, notably KM002C and KM003C, contain an additional
>>>>>> port which exposes the measurements via USB.
>>>>>>
>>>>>> This is a driver for this monitor port.
>>>>>>
>>>>>> It was developed and tested with the KM003C.
>>>>>>
>>>>>> Signed-off-by: Thomas Weißschuh 
>>>>>> <linux-9XfqOkM5JgxKQ7RDE2T8Pw@public.gmane.org>
>>>>>> ---
>>>>>
>>>>> ...
>>>>>
>>>>>> +static int powerz_probe(struct usb_interface *intf,
>>>>>> +            const struct usb_device_id *id)
>>>>>> +{
>>>>>> +    struct powerz_priv *priv;
>>>>>> +    struct device *hwmon_dev;
>>>>>> +    struct device *parent;
>>>>>> +
>>>>>> +    parent = &intf->dev;
>>>>>> +
>>>>>> +    priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
>>>>>> +    if (!priv)
>>>>>> +        return -ENOMEM;
>>>>>> +
>>>>>> +    priv->urb = usb_alloc_urb(0, GFP_KERNEL);
>>>>>> +    if (!priv->urb)
>>>>>> +        return -ENOMEM;
>>>>>> +    mutex_init(&priv->mutex);
>>>>>> +    priv->status = -ETIMEDOUT;
>>>>>> +    init_completion(&priv->completion);
>>>>>> +
>>>>>> +    hwmon_dev =
>>>>>> +        devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
>>>>>> +                         &powerz_chip_info, NULL);
>>>>>> +    usb_set_intfdata(intf, priv);
>>>>>> +
>>>>>> +    return PTR_ERR_OR_ZERO(hwmon_dev);
>>>>>
>>>>> Hi,
>>>>>
>>>>> If 'hwmon_dev' is an PTR_ERR, priv->urb leaks.
>>>>
>>>> Good catch, thanks!
>>>>
>>>>
>>>> Guenter,
>>>>
>>>> it seems the new hwmon-next with this driver has not yet been pushed to
>>>> git.kernel.org, so I can't generate the Fixes tag.
>>>>
>>>
>>> Rule is that I must not push anything into linux-next until
>>> after v6.6-rc1 has been released.
>>>
>>>> Can you modify the commit to also contain the changes below?
>>>> Or let me know if you prefer something else.
>>>>
>>>
>>> I'll update the patch and make the change.
>>
>> Hi,
>> While you are at it, you can make the driver detect the earlier model KM002C:
>>
> 
> Please send a separate patch to do that.

That would be easier if I could see a git repository with the powerz driver
in it. Looking at:
    https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/

or is there another url to use?

Doug Gilbert

