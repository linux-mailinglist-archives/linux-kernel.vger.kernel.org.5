Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989B3793214
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbjIEWn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIEWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:43:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5912E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:43:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34f17290a9cso2464805ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693953830; x=1694558630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOTcI+9//H2lUESDf8fGU/u6Gg9kO1Rtidgzn+n90N4=;
        b=R4D83kFSz85SHYtdj1ECfwAvbwDEUXhEx90rxgxgZAMJHavtnFueJp0oBrGKxuNTPf
         pBFQzyQUmx3XhiPzQrgjA3LRUwM4NUzMMAg8Fw5I2FNU+B1E6z6srOZ4ekUSLag4GLiB
         ySqdr6Pb5A5i3BsRdCm7OAzuT9PPr58c59CS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693953830; x=1694558630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOTcI+9//H2lUESDf8fGU/u6Gg9kO1Rtidgzn+n90N4=;
        b=MOPZ2b0EOURzhHtGwSdrSjNaY6tXnQ8wVFMUUrceYN6I6YV3p/6ImJ79QzxNdo+HKW
         fGb015hj3WIXTU5EAr/N/fU0SflI86mNZ2X8yghW0CkwGBPdnPMcWxEzJxMHnlTL4pHm
         agmAGDEtJ0jKFfneJd+o8TsLQWOWcMzHuiQnrNAKTRcoCCAlgYBJ68o3/DUFjRgLJWdn
         KT/TCkZr/3nhXspWecMxtvt9CLJs5zXqQ5dXnA0yxJ92tDXrYd4ja6qWVryUgj3iUUkc
         QWKL+1BOqH7U8HdVMcb5HqZECJ3YC+jRNFV65JSBuEb3MjRZfeYJ+7vrxkC4kRvzWXqn
         D38w==
X-Gm-Message-State: AOJu0YwKCyaZQJv4Y933A0xA4cK5i4FxtJ0Nlc4Jx9Mj0PRca1ePc9Nt
        18jAdOSSxgA7nr75I+Lu+NQ+ig==
X-Google-Smtp-Source: AGHT+IGV7huz8CTpzeedsJJ9k3WQc+9GgYXsqJm9TAT1KbJlKxeNY5RfhRa5UAm+a1XMJSTC+q+GAA==
X-Received: by 2002:a05:6602:1588:b0:792:9b50:3c3d with SMTP id e8-20020a056602158800b007929b503c3dmr16196656iow.1.1693953830046;
        Tue, 05 Sep 2023 15:43:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y9-20020a02a389000000b0042b144abf71sm4390653jak.179.2023.09.05.15.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 15:43:49 -0700 (PDT)
Message-ID: <602d648b-a32b-fa97-a527-d924f74578cb@linuxfoundation.org>
Date:   Tue, 5 Sep 2023 16:43:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Content-Language: en-US
To:     Zheng Yejian <zhengyejian1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Ye Weihua <yeweihua4@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
 <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
 <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
 <20230710183741.78f04c68@gandalf.local.home>
 <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 06:54, Zheng Yejian wrote:
> On 2023/7/11 06:37, Steven Rostedt wrote:
>>
>> Shuah, can you take this?
>>
> 
> Kindly ping and bug report :)
> 

I am sorry for the delay. Looks this one got buried deep
when I was away on vacation.

Applied now for my next Linux 6.6 update.

thanks,
-- Shuah

