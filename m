Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB237DBCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjJ3Pkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjJ3Pka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:40:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5BADE;
        Mon, 30 Oct 2023 08:40:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc5b705769so4363385ad.0;
        Mon, 30 Oct 2023 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698680428; x=1699285228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPRLTSWuTrsZ1XKe1+EbPZ7W3J1mWgSbUoqx7ta8svE=;
        b=Imd4/4nAlvx0SbmN8SUvvCoJmfe74m/srOrF5PZlFEDTrN1POFtep4t0yjKf8G3h/R
         RMKZ50A/EV3qCkSmc61xaveB1Vk6XmUUZ2SFTDAC0T7o5sI3v3SpR9gHQSaujussF0JB
         77Kx+wKlxQwJicKjq71YVDq308n2GRd5dac0Z26hhezMxxdhGJ461KgFVfnQocSknwJZ
         bm2yToycRuif1EX+Z7m1nMcWFRo9TW4+76PkKONHcpDjXT038RUihfIScL9lOPoIemI5
         2I6egt5scWZM/HcJfpUCW18hz/92gGCBatQX+MHyHmUzHuEq4ttMSWXp6vT9SWYIvSop
         F/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680428; x=1699285228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPRLTSWuTrsZ1XKe1+EbPZ7W3J1mWgSbUoqx7ta8svE=;
        b=K/Np4Jx3CM1FK/vX5eB59fybHZGRKhUKdN9RfNOarFmiOkoB5vkvXiB/IuUzA2Sazq
         q4dkXGdHkvbdNjw3I7u5D+qkedY8NuLEfPD/O9OcuJtd5VXYc/RXpt5s06IrqmpYFN7X
         wEIYnBSQa9xf9krCOPjF9O3E+ZJc1GzyxUwyzETyZMiKbC1v1IGhxHeepFo9459rEv3r
         +sNUux3Nl3zj+ulz6TM2Reau9eRfDjQ8HgqT47TXtLm09U9YE0fTGOjeGuW+8/QWLchb
         bUdQQD4PNvPKItbc5HAifnbZ5pAFPL9nnOxfvYbDjjUfZBqCIKsGL51HxoVHSFTgdJYi
         zsHg==
X-Gm-Message-State: AOJu0YywLLEQJI+cG5aJOJz6eCB1ROfDPooaCKtYccO93Qtaswq9i9OA
        fb6DdekyTxyRj6sdeTl6s1Q=
X-Google-Smtp-Source: AGHT+IGkdxXcXZhNWzt6zXyZIfokX4mYgZMOOfyvR/9a8d85RMFYGJ5KWukB9siUh/E5/K7TW16gQQ==
X-Received: by 2002:a17:903:11cc:b0:1cc:5549:aab2 with SMTP id q12-20020a17090311cc00b001cc5549aab2mr1689200plh.36.1698680427752;
        Mon, 30 Oct 2023 08:40:27 -0700 (PDT)
Received: from [192.168.1.11] ([27.4.124.129])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001cc307bcdbdsm4648823plg.211.2023.10.30.08.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:40:27 -0700 (PDT)
Message-ID: <e38353e7-ea99-434b-9700-151ab2de6f85@gmail.com>
Date:   Mon, 30 Oct 2023 21:10:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dccp: check for ccid in ccid_hc_tx_send_packet
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
References: <20231028144136.3462-1-bragathemanick0908@gmail.com>
 <CANn89iJyLWy6WEa_1p+jKpGBfq=h=TX=_7p_-_i4j6mHcMXbgA@mail.gmail.com>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <CANn89iJyLWy6WEa_1p+jKpGBfq=h=TX=_7p_-_i4j6mHcMXbgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/10/23 14:29, Eric Dumazet wrote:
> On Sat, Oct 28, 2023 at 4:41 PM Bragatheswaran Manickavel
> <bragathemanick0908@gmail.com> wrote:
>> ccid_hc_tx_send_packet might be called with a NULL ccid pointer
>> leading to a NULL pointer dereference
>>
>> Below mentioned commit has similarly changes
>> commit 276bdb82dedb ("dccp: check ccid before dereferencing")
>>
>> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=c71bc336c5061153b502
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> ---
>>   net/dccp/ccid.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/dccp/ccid.h b/net/dccp/ccid.h
>> index 105f3734dadb..1015dc2b9392 100644
>> --- a/net/dccp/ccid.h
>> +++ b/net/dccp/ccid.h
>> @@ -163,7 +163,7 @@ static inline int ccid_packet_dequeue_eval(const int return_code)
>>   static inline int ccid_hc_tx_send_packet(struct ccid *ccid, struct sock *sk,
>>                                           struct sk_buff *skb)
>>   {
>> -       if (ccid->ccid_ops->ccid_hc_tx_send_packet != NULL)
>> +       if (ccid != NULL && ccid->ccid_ops->ccid_hc_tx_send_packet != NULL)
>>                  return ccid->ccid_ops->ccid_hc_tx_send_packet(sk, skb);
>>          return CCID_PACKET_SEND_AT_ONCE;
>>   }
>> --
>> 2.34.1
>>
> If you are willing to fix dccp, I would make sure that some of
> lockless accesses to dccps_hc_tx_ccid
> are also double checked and fixed.
>
> do_dccp_getsockopt() and dccp_get_info()


Hi Eric,

In both do_dccp_getsockopt() and dccp_get_info(), dccps_hc_rx_ccid are 
checked properly before access.

Thanks,
Bragathe

