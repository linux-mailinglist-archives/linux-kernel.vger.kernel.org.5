Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03237E19BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjKFFus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjKFFuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:50:46 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 89CBAFA;
        Sun,  5 Nov 2023 21:50:42 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id E3FB8602A9F16;
        Mon,  6 Nov 2023 13:50:09 +0800 (CST)
Message-ID: <26575f23-2ccb-98b8-df85-af829460ffd1@nfschina.com>
Date:   Mon, 6 Nov 2023 13:50:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] HID: wacom_sys: add error code check in
 wacom_feature_mapping
Content-Language: en-US
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <871qd31qkx.fsf@protonmail.com>
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

On 2023/11/6 11:57, Rahul Rameshbabu wrote:
> On Fri, 20 Oct, 2023 17:02:38 +0800 "Su Hui" <suhui@nfschina.com> wrote:
>> hid_report_raw_event() can return error code like '-ENOMEM' if
>> failed, so check 'ret' to make sure all things work fine.
> I can agree with adding logging for error cases personally.
>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/hid/wacom_sys.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 3f704b8072e8..1f898d4ee708 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -320,6 +320,8 @@ static void wacom_feature_mapping(struct hid_device *hdev,
>>   			if (ret == n && features->type == HID_GENERIC) {
>>   				ret = hid_report_raw_event(hdev,
>>   					HID_FEATURE_REPORT, data, n, 0);
>> +				if (ret)
>> +					hid_warn(hdev, "failed to report feature\n");
> I think we should report the returned error information as well.
Agreed, I will send v2 soon.
Thanks for your suggestions!

Su Hui

>
>    https://docs.kernel.org/core-api/printk-formats.html#error-pointers
>
> Typically what I do is use ERR_PTR in tandem with the %pe modifier for
> printing errors.
>
>>   			} else if (ret == 2 && features->type != HID_GENERIC) {
>>   				features->touch_max = data[1];
>>   			} else {
>> @@ -381,6 +383,8 @@ static void wacom_feature_mapping(struct hid_device *hdev,
>>   		if (ret == n) {
>>   			ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT,
>>   						   data, n, 0);
>> +			if (ret)
>> +				hid_warn(hdev, "failed to report feature\n");
>>   		} else {
>>   			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
>>   				 __func__);
> --
> Thanks for the patch,
>
> Rahul Rameshbabu
>
