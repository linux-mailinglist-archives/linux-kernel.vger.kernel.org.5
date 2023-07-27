Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CF176441F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjG0DEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjG0DEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:04:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F021BF2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:04:07 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7656652da3cso42786885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690427046; x=1691031846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/oHz7SF+qwhqvee7uyeb/W9ByFEOLluyp4QtOuQF0c=;
        b=auwRtS+nCYvKPYlB9gt4rmjiPJplX/Wxv7LXJaMQF1Pobzrz/a2b0k/2jVu6c2MNlU
         vJAXF372FjA9k6ztO9uvdHqdv4/IJD6Y3BB/3KReMvoa8uf91X6zlPTgW8fKa4YCS+U4
         jaxmph1g8niylOTrLnegFMXnhpLUUFFdcOi+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690427046; x=1691031846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/oHz7SF+qwhqvee7uyeb/W9ByFEOLluyp4QtOuQF0c=;
        b=NlSkyIxjWB1Q4KW23OT3ZWjV60NzMX+YjXMUKGKuCOqAA+6GFNPcdBCcVTYkqo0Oc3
         KvAb4WdG/RD/CVIYB0uDamkPyTqB2sYsuyV8hvfPUbtSJHdJ2PanyAkgglM4QglLj4nE
         fq/c30fl3P9T4LYPomKHStFN9ZvmRCyyTamx+TrctrPiyGhp3ph4U/G5y+9yEvl3WKD4
         Lqj1FGQG/sHqjZgrI+hKDJnhxtGlzPQ38fMv/+zwyv3lMAlyHLh5P9adduSA/DqG4hgE
         TnG0WfcSqY0p6HIs9oTbbT4AZVOSNRRTY8k8U9BfKrBAjFo9m1mcbZzYFSpWVj+I2ubq
         doIw==
X-Gm-Message-State: ABy/qLagopIpSy20gW6/JxN5gD7PFBESe3IR6iVpEq+iCv5exFHqMczr
        wHSwamsA/Gp8z9ADq/baWsOq7FiCDZNRe0UdZqE=
X-Google-Smtp-Source: APBJJlFCsgXb/RnxmYQBOFvvpj2nZDj3UANGHwIwcUC+Kmr8vzA3/K/Mo8BEmlDuzrip7jTuHRBnpw==
X-Received: by 2002:a05:620a:29ce:b0:768:11ff:7899 with SMTP id s14-20020a05620a29ce00b0076811ff7899mr5034967qkp.64.1690427046480;
        Wed, 26 Jul 2023 20:04:06 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u4-20020ae9c004000000b00767d2870e39sm114658qkk.41.2023.07.26.20.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 20:04:05 -0700 (PDT)
Message-ID: <d7d0f4c2-dd88-4ad2-8405-3c9b5d8cbb39@joelfernandes.org>
Date:   Wed, 26 Jul 2023 23:04:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] srcu: Fix error handling in init_srcu_struct_fields()
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "open list:SLEEPABLE READ-COPY UPDATE (SRCU)" <rcu@vger.kernel.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-3-joel@joelfernandes.org>
 <1943e34c-3c8e-411c-a677-33f8c5b4b0e5@paulmck-laptop>
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <1943e34c-3c8e-411c-a677-33f8c5b4b0e5@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 17:07, Paul E. McKenney wrote:
>> -				free_percpu(ssp->sda);
>> -				ssp->sda = NULL;
>> -				kfree(ssp->srcu_sup);
>> -				return -ENOMEM;
>> -			}
>> -		} else {
>> +		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
>> +			goto err_free_sda;
>> +		else
>>  			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
> Given that the "then" clause is a goto, what is the "else" clause doing
> for us?
> 

Not much. Agreed we can get rid of "else" and reduce indent of the
WRITE_ONCE that follows.

Would you mind making this fixup in the patch for your apply, or would
you like me to refresh the patch? Let me know either way, thank you!

 - Joel
