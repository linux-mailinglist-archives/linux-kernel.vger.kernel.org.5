Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271D27B467E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjJAJNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJAJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:13:36 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E818BC6;
        Sun,  1 Oct 2023 02:13:33 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id mKShqDMZSMZBkmsW5q6tIg; Sun, 01 Oct 2023 09:13:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id msW4qwZeCXQGamsW4qvGiu; Sun, 01 Oct 2023 09:13:32 +0000
X-Authority-Analysis: v=2.4 cv=DJGcXgBb c=1 sm=1 tr=0 ts=6519383c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=LGO97N6URhV1HzgtwBkA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4g2DqY1HQzg9VHDk8bpfbsxVxIS5o6CwTE1YY6fEQ3g=; b=AUvFBCRUB7J4vAcINYNmf8AedX
        vVjpv9aSEIHk6sHw8Z03zs4zmYb0n26Zz4ENctk+kwTyZxdREssUFaiHh8iqt6+n/F+XAhbguP5BD
        xaNImehj3L+M6hDG4ekFPG/4y7kZ3s3INLLpGO1fHDVcSHmzSDjdFU4Uv9WNlnE8CZhxYqCKbYa1k
        kHRn2OZVJde+6EotWeVQ1c+fvtrEzNM2GpiRQAw4lBWyEv1zZqipiev6SRBPmUSRAH/o8PqVYwLNt
        j1UDYIofGl95WzJ1RNGbqD6ZBURjfRP8+JfsHaSEhS1X7fGgFBS1iZDhwXJVDacDFbnAc1e0Grd3Y
        UhEt5mXQ==;
Received: from [94.239.20.48] (port=48332 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qmqOy-001eje-0E;
        Sun, 01 Oct 2023 01:58:04 -0500
Message-ID: <d81a2187-a2ff-c741-8f35-a1af54652ebd@embeddedor.com>
Date:   Sun, 1 Oct 2023 08:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH][next] media: usb: siano: Fix undefined behavior bug in
 struct smsusb_urb_t
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZRbwU8Qnx28gpbuO@work>
 <CAG48ez2SJMJSYrJQ9RVC44hbj3uNYBZeN0yfxWa7pqX9Fp2L7g@mail.gmail.com>
 <2023093029-primary-likewise-9579@gregkh>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2023093029-primary-likewise-9579@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qmqOy-001eje-0E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:48332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOBNRepxkbBW5oTCh0rxhMzN0x/4rQbyN1ExUDG0Yn4Z0S/O6iJ5NDER4VYcRRTP8KkhuIasKPH6ssj+2egE8I/6bhavg1i0ATX0Pr+V8xuB5nbP2YZw
 jvTPnVrtac/gAWvCY+3fLsfzha6We/4v0SNJQ2zRoY6aA15gutLLCZuiibW9S+ir8m4uL0/sjjTCzmd7TD9BJG657sK3uqDl1Wd00RLvgNjfHWjaltJk76qA
 wx583CU3F+a2OSCPcXq0esn8Fxnf1qjkD8+uNjTyEK/ZLxuZw+53u5xZHKQqtzFm3FvfhgNx4kCTZgEEsh3f+uY+pv9jAJF57PUsb0U1lk/3yWoiJqrrFugq
 zpyf009w
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/23 09:01, Greg Kroah-Hartman wrote:
> On Fri, Sep 29, 2023 at 06:20:10PM +0200, Jann Horn wrote:
>> On Fri, Sep 29, 2023 at 5:42 PM Gustavo A. R. Silva
>> <gustavoars@kernel.org> wrote:
>>> `struct urb` is a flexible structure, which means that it contains a
>>> flexible-array member at the bottom. This could potentially lead to an
>>> overwrite of the object `wq` at run-time with the contents of `urb`.
>>>
>>> Fix this by placing object `urb` at the end of `struct smsusb_urb_t`.
>>
>> Does this really change the situation? "struct smsusb_device_t"
>> contains an array of "struct smsusb_urb_t", so it seems to be like

Yeah. I noticed that too.

Probably what Greg suggests (dynamically create the urb) can fix this, too.

I haven't taken a deep dive into this particular case. So, let me go and
figure something out.

>> you're just shifting the "VLA inside a non-final member of a struct"
>> thing around so that there is one more layer of abstraction in
>> between.
>>
>> Comments on "struct urb" say:
>>
>>   * Isochronous URBs have a different data transfer model, in part because
>>   * the quality of service is only "best effort".  Callers provide specially
>>   * allocated URBs, with number_of_packets worth of iso_frame_desc structures
>>   * at the end.
>>
>> and:
>>
>> /* (in) ISO ONLY */
>>
>> And it looks like smsusb only uses that URB as a bulk URB, so the flex
>> array is unused and we can't have an overflow here?
>>
>> If this is intended to make it possible to enable some kinda compiler
>> warning, it might be worth talking to the USB folks to figure out the
>> right approach here.
>>
>>> Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>   drivers/media/usb/siano/smsusb.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
>>> index 9d9e14c858e6..2c048f8e8371 100644
>>> --- a/drivers/media/usb/siano/smsusb.c
>>> +++ b/drivers/media/usb/siano/smsusb.c
>>> @@ -40,10 +40,10 @@ struct smsusb_urb_t {
>>>          struct smscore_buffer_t *cb;
>>>          struct smsusb_device_t *dev;
>>>
>>> -       struct urb urb;
>>> -
>>>          /* For the bottom half */
>>>          struct work_struct wq;
>>> +
>>> +       struct urb urb;
>>>   };
> 
> Yeah, this is going to get messy.  Ideally, just dynamically create the
> urb and change this to a "struct urb *urb;" instead.

Probably, yes.

Thanks
--
Gustavo
