Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA07EEA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjKQA1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjKQA1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF57EA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700180827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1vabiUQkyRjMFxmuwYzB40m10wAtVww8oPkZTrFAYo=;
        b=Yv5t55+xtE2PrdUJcTeBqNa7MtZz16ETqiuLMaxYyKNgS8o4E8Q93FeiA5t3oMft0zBcOm
        17iHzeGw10GN0oxjPsbKLr6wiGlV5/f/0JjNI54xQ9aRZyqcq+zTOpOJXM/DV6EeGi4deu
        QoeagIMULWv8RC4IVihgJTaXI4MSpPw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-t0XqLR5CNF2g5AOu-TjdQA-1; Thu, 16 Nov 2023 19:27:06 -0500
X-MC-Unique: t0XqLR5CNF2g5AOu-TjdQA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c415e09b2cso1710948b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700180825; x=1700785625;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O1vabiUQkyRjMFxmuwYzB40m10wAtVww8oPkZTrFAYo=;
        b=cyPC6c+GBEtvt1lIX3hDY9X3t55jj4/bvUgEmZz2ZJOymkq36kFr8di2fW1ruZgRjS
         QCrUcJY2Js4Pu9OriI6pISQ9CE6NXbt35B3LIVN60UZhGQxlFjUHYr9rTpanr/joDmtU
         WIUUr9KTdhSR3nGiQMnZ3IJv3NeQarndunL6TPYjexSInG+Qfi/SVhKcGNEUZn03KhAc
         spldKxt5jRzvwjqkMT+F3RSah6ctxeo4/pNvnN74ZWNSZMXY7Mhz7L1JJ+jPIwYkd8ka
         r9T1hhpgw5nYaa2Crs2ky5N48SQgx1m9l+oHhcAG5jwHEhluoMsxURkDIrIYUldfmMer
         KR9Q==
X-Gm-Message-State: AOJu0Yye45aGrO0Y2qzEp3RAkrlWVw2ASiysotc7dxqIhkhoQzPLNrry
        kVmgABvAkK7bv6VudwUo08zSkvaHIjDgsI/6qMh9N2b/whaq1XYUM0EBkfxjP7TBdGv8Iw7uKTO
        cTLU7ZfTT2xrU6P1yBCaru08Z
X-Received: by 2002:a05:6a20:1454:b0:186:9a3f:f2fd with SMTP id a20-20020a056a20145400b001869a3ff2fdmr14627065pzi.32.1700180825076;
        Thu, 16 Nov 2023 16:27:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEflQTfcCaHfzKpnBP5HQanYDNbLK8tWkPPQA9DXFyaIArDWyQhG/jmRyuY535FSGx/7f1fXw==
X-Received: by 2002:a05:6a20:1454:b0:186:9a3f:f2fd with SMTP id a20-20020a056a20145400b001869a3ff2fdmr14627046pzi.32.1700180824781;
        Thu, 16 Nov 2023 16:27:04 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:f0fd:a9ac:beeb:ad24])
        by smtp.gmail.com with ESMTPSA id r8-20020a62e408000000b006934350c3absm308757pfh.109.2023.11.16.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 16:27:04 -0800 (PST)
Date:   Fri, 17 Nov 2023 09:26:58 +0900 (JST)
Message-Id: <20231117.092658.1793984163746462941.syoshida@redhat.com>
To:     pabeni@redhat.com
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Remove redundant call to TLV_SPACE()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <59083303fc79497b2658ff15ac3c18b985e270ab.camel@redhat.com>
References: <20231114144336.1714364-1-syoshida@redhat.com>
        <59083303fc79497b2658ff15ac3c18b985e270ab.camel@redhat.com>
X-Mailer: Mew version 6.9 on Emacs 28.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 10:46:30 +0100, Paolo Abeni wrote:
> Hi,
> 
> On Tue, 2023-11-14 at 23:43 +0900, Shigeru Yoshida wrote:
>> The purpose of TLV_SPACE() is to add the TLV descriptor size to the size of
>> the TLV value passed as argument and align the resulting size to
>> TLV_ALIGNTO.
>> 
>> tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
>> tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
>> call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
>> redundancy.
>> 
>> Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> The patch LGTM, but I think this is more a cleanup then a fix, please
> re-submit it for net-next, dropping the Fixes tag (so it will not land
> in stable tree).
> 
> With the above you can add:
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Hi Paolo,

Thanks for your feedback! I'll resubmit the patch for net-next.

Thanks
Shigeru

>> ---
>>  net/tipc/netlink_compat.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
>> index 5bc076f2fa74..db0365c9b8bd 100644
>> --- a/net/tipc/netlink_compat.c
>> +++ b/net/tipc/netlink_compat.c
>> @@ -167,7 +167,7 @@ static struct sk_buff *tipc_get_err_tlv(char *str)
>>  	int str_len = strlen(str) + 1;
>>  	struct sk_buff *buf;
>>  
>> -	buf = tipc_tlv_alloc(TLV_SPACE(str_len));
>> +	buf = tipc_tlv_alloc(str_len);
>>  	if (buf)
>>  		tipc_add_tlv(buf, TIPC_TLV_ERROR_STRING, str, str_len);
>>  
> 

