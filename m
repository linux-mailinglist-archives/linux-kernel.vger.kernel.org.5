Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC397D8D34
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbjJ0ClV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0ClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:41:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FE7B0;
        Thu, 26 Oct 2023 19:41:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so349486b3a.0;
        Thu, 26 Oct 2023 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698374477; x=1698979277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Y45Kg1FVvOUrUmxNTyFscKK00f1fFAimD2L0qeIY8U=;
        b=l9/Qy9MLJRqKimW9NrRSf0xDjxeedftA+YAAuZPOAPcFguZNb9AUD+S25+Qlr60zeq
         nzjmoxwdOQRv0Wo79T/5WWv1G9AcIDEta1E+Kdrmxr+yQKwWei8is7qQhjGGK709eX6I
         pTtsF/hXZHl0yw3YNrLrFJEhLQq8MqxVuppwPWqX9trdt/8evC4wrQnuRrEaZjlXJx3r
         NyBiREY/fJsIgkg0WiDsn27nwhQap/CxxIv90Q9Eyho3RHlv2/YEuRhmXzVIIlGxewbT
         WgOosh8QXBX/QyO+hL/W2Kv/9bBwbr0bP2lgA1OEZgLE8JTwPW/5s/S26PLbh0eIRqz8
         zsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698374477; x=1698979277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y45Kg1FVvOUrUmxNTyFscKK00f1fFAimD2L0qeIY8U=;
        b=VOX4IeQ5d47/vdWmcZ0vbRdHuT66AMC1xvL9OHwFfOdccNZtdAoRiKa/XA8r4J1Cdp
         RM9TfesxyKH8OoZn3B9fAqgw3Z4GDsG8F5UzHpgYb3PMGE6T24+UvLAmlAE6CLkz8Kft
         fJiwseiwghT5wegJ1NrdUQ3YmnuIoJeFCZzlUNyIJJdGck0vEcxWdwiTHcgZ52T89vKb
         grnVUM/6FTOUfjDDqcDS9tbaieICmZDWVURRXuknZPTTnTkZD3tohbrKKE571wwfJbAD
         IpVQqDjOlfsvb1hihG0NJNpqwvDe3h9Aa8R00IcUSEnx0UMIgDCXlVTzh7/eAUPu7xqn
         B9Kg==
X-Gm-Message-State: AOJu0YydnlhF5Bb5tHCfQQkkyXdDQUyvf8o0zM667EE1biYJTpYl0eDw
        YTSFtFrVKz71peglJQWs6uw=
X-Google-Smtp-Source: AGHT+IEdvyLE2DgnauF9a83HstUljP8iblHqKFnHxJKPWxoaD4Km4Z6EVpXrPAgNqUAmRCnnM75Sag==
X-Received: by 2002:a05:6a21:7899:b0:14e:2c56:7b02 with SMTP id bf25-20020a056a21789900b0014e2c567b02mr1928136pzc.0.1698374477451;
        Thu, 26 Oct 2023 19:41:17 -0700 (PDT)
Received: from [127.0.0.1] (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b001ca82a4a9c8sm366382pld.269.2023.10.26.19.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 19:41:16 -0700 (PDT)
Message-ID: <0f6ebc50-06d6-4e3d-b296-1045b0255c8a@gmail.com>
Date:   Fri, 27 Oct 2023 10:41:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: 9p: fix possible memory leak in p9_check_errors()
Content-Language: en-US
To:     asmadeus@codewreck.org
Cc:     ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jvrao@linux.vnet.ibm.com, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026092351.30572-1-hbh25y@gmail.com>
 <ZTpTU8-1zn_P22QX@codewreck.org>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <ZTpTU8-1zn_P22QX@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 19:53, asmadeus@codewreck.org wrote:
> 
> Hangyu Hua wrote on Thu, Oct 26, 2023 at 05:23:51PM +0800:
>> When p9pdu_readf is called with "s?d" attribute, it allocates a pointer
>> that will store a string. But when p9pdu_readf() fails while handling "d"
>> then this pointer will not be freed in p9_check_errors.
> 
> Right, that sounds correct to me.
> 
> Out of curiosity how did you notice this? The leak shouldn't happen with
> any valid server.

I just found that any attributes that require memory allocation are 
prone to errors when mixed with ordinary attributes.

> 
> This cannot break anything so I'll push this to -next tomorrow and
> submit to Linus next week

Agreed.

> 
>> Fixes: ca41bb3e21d7 ("[net/9p] Handle Zero Copy TREAD/RERROR case in !dotl case.")
> 
> This commit moves this code a bit, but the p9pdu_readf call predates
> it -- in this case the Fixes tag is probably not useful; this affects
> all maintained kernels.
> 
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   net/9p/client.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 86bbc7147fc1..6c7cd765b714 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -540,12 +540,15 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>>   		return 0;
>>   
>>   	if (!p9_is_proto_dotl(c)) {
>> -		char *ename;
>> +		char *ename = NULL;
>>   
>>   		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
>>   				  &ename, &ecode);
>> -		if (err)
>> +		if (err) {
>> +			if (ename != NULL)
>> +				kfree(ename);
> 
> Don't check for NULL before kfree - kfree does it.
> If that's the only remark you get I can fix it when applying the commit
> on my side.

I get it. I will revise it based on your and Christian's comments and 
send a v2.

Thanks,
Hangyu

> 
> 
>>   			goto out_err;
>> +		}
>>   
>>   		if (p9_is_proto_dotu(c) && ecode < 512)
>>   			err = -ecode;
> 
