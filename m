Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60C80DBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbjLKUh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjLKUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:37:25 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3174DE5;
        Mon, 11 Dec 2023 12:37:31 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so4220663b3a.0;
        Mon, 11 Dec 2023 12:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327050; x=1702931850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+9l+SpFLDPAFs+h4yF9rq05J7khf5DbMgJkI+fNBbk=;
        b=eAAPCS7ipSRjCO9dM6RcOb7ubwmWCQc7PbG4pqgyShXRMBa2v55zyBgVZZsQzfO1fs
         izROhDvvXxWtEfvShkADTGtnG2jLbMdZPDpnXMqt90scqqChpdl++cg9W6q57D314wsz
         7KxesxEubBM3kqcYyLEvvkMbMjzrHm87n8DW/4303EChY6kmplZgE8ZR+r15r0GIqPYv
         JbCGmQAw1E6MPDASwVV7DeRUv+rHU2FlvO82109/MAt84x0n+3xOSnrRxlvklwiYwJTB
         kRD68gTcwQUM5gCV6AIm1PnXWunWLVCYg1w/HrTNT5MjEUeJl29wodJEUOhwdZeuB7xL
         y8qQ==
X-Gm-Message-State: AOJu0Yz8LUWjwEebBy+dGZ6Bub0s5sXoMayXlbcqXggublfQtEHPC3bC
        EimH1uva1k30bx/CL932OW4=
X-Google-Smtp-Source: AGHT+IGqn+AlZGFr8LP8XVA4q8H6VhQDRCLkIp9M96YCQjtt81s4MMcYD0nE7RIFoHXfWtmV1uRc9w==
X-Received: by 2002:a05:6a00:218f:b0:6cb:d2cb:5234 with SMTP id h15-20020a056a00218f00b006cbd2cb5234mr6173755pfi.32.1702327050472;
        Mon, 11 Dec 2023 12:37:30 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3431:681a:6403:d100? ([2620:0:1000:8411:3431:681a:6403:d100])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7880c000000b006ce7ff254b9sm6718639pfo.68.2023.12.11.12.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 12:37:30 -0800 (PST)
Message-ID: <3ce6068e-c08b-419c-b78c-3897332f8669@acm.org>
Date:   Mon, 11 Dec 2023 12:37:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: fcoe: replace deprecated strncpy with strscpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-1e0026ee032d@google.com>
 <9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org>
 <CAFhGd8oQ-Z8e65-TOZPmNHR-rsPVRXNY8UZMDFcUScKZ6bbtJQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFhGd8oQ-Z8e65-TOZPmNHR-rsPVRXNY8UZMDFcUScKZ6bbtJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 12:08, Justin Stitt wrote:
> Hi,
> 
> On Tue, Oct 24, 2023 at 1:01 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 10/24/23 12:52, Justin Stitt wrote:
>>> diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
>>> index e17957f8085c..7a3ca6cd3030 100644
>>> --- a/drivers/scsi/fcoe/fcoe_sysfs.c
>>> +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
>>> @@ -279,12 +279,10 @@ static ssize_t store_ctlr_mode(struct device *dev,
>>>        if (count > FCOE_MAX_MODENAME_LEN)
>>>                return -EINVAL;
>>>
>>> -     strncpy(mode, buf, count);
>>> +     strscpy(mode, buf, count);
>>>
>>>        if (mode[count - 1] == '\n')
>>>                mode[count - 1] = '\0';
>>> -     else
>>> -             mode[count] = '\0';
>>>
>>>        switch (ctlr->enabled) {
>>>        case FCOE_CTLR_ENABLED:
>>
>> Please consider to remove the code for copying the sysfs string and to
>> use sysfs_match_string() instead.
>>
> 
> Sorry, I'm not too familiar with sysfs strings here.
> 
> Let me know what you think of this patch [1].

I don't use FCoE so I will leave it to an FCoE user to review that patch.

Thanks,

Bart.

