Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA48089A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442642AbjLGNzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442716AbjLGNzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:55:33 -0500
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA41708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:55:38 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 166F0480A23;
        Thu,  7 Dec 2023 08:55:37 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1701957337;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=7GBnXR+qL+q/UpJWyclWxRNiYvCwSDJBxzxViQmXbdg=;
 b=AnvDJv4m7jFWsdahxLboF2GUYPHsNIgzvFagVox1f3bRKj9KZglEoqRiOtJB5o4ZaYSXO
 dzWa6gQdT1LTjrWCw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1701957337;
        cv=none; b=Kuh42i9/Tc4d6JmvB+Wb9N1khi1SiyPMcf/NpA5tBhxMlXmMv/u2bOEApb4DuqlnOsZjXR9lmZQ4/qiWM90RQxztierc+CCC8FoLucllmKi2NxiFILNjRHDQqgWyrOv0oYFSnjQCMPGcP/rTOeuFCioJ0XMGR65ybWh6AEJsRYxj85FgvuVR0PQsMfgGojjaLyUXIg7wREoFHdmOFc+rHNIEl2IoAPj+IEgJLXT22FlE30mz6uvV4sF9G9jBdYbtFbRQUHzz66zh0BO4mh/mU0oXhUYyuXIxr/zoSbtDAoqHlHW3UHUlB7YVAarFxshysBuyBUVDoiPN1WAvEI4U5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1701957337; c=relaxed/simple;
        bh=5gAc//SJA0AzKde1x2UEFUi3xVjmF7jW4UIpsDnKqls=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=vUn2MNYlInzdGPMSB0HDqAbtE7P9flJXvC1ZllDiO0rsQIUGbcDmZIO2/Vb38ircr8VQekiookdGIt1eSFOEFiD/0Ild0TJyxRS7DznWTFvedm1k4rxoolWMXE6HVGKbinLqfxHAehYviQP9zHmHdw5q1+ZNJvsQTcSxb72WkucJAHTxpq2qeSbXV1MZHr6NwhiY+04SKG6wacjbqGFRWokIYomTtoSWo1mnQTjsEBThqrVe6ZZ/4/W5a0ZL51YqjzZX6/t5aLz96VWtabQxOL4EjnsePrx7HqVp92H0LEEZwNwWnB8eNtgLZLYWmpPJBq2/mpeNYaXYHOna4cWrTQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1701957337;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=7GBnXR+qL+q/UpJWyclWxRNiYvCwSDJBxzxViQmXbdg=;
 b=dLGBvAxfuiXNeNrn7SVcSApDwUsu7aOomKnuM02k1aBwcsMUGhlk+KBJPP7jMMfVdR1VD
 QuotNm7RDRoQwBe82pyKom/r9dTrg2lYkuVeBnsdhrPaELOvSgHhxN+NCA1Q+Lr3MenWHIJ
 MbURcDOmzx5YkP0qwbotE28zu4vkTy5n72VZTjEN3+pbQI0vUrJE0WjLIlYRe8qKwuBkh3I
 WzF6yLEddzNXsPUMyWEcIupdEcZpXHHlxf4S1LIQAiTWgql0NePz13aVXwYOITuiimiV6gs
 0blrMlg/I3OKYb1gOgCttfVTQGyDbcnse0pe31TVYlAxuJpHG1yviojDECUQ==
Message-ID: <be56b5df-fef8-4dbe-bb98-f6370a692d6e@sapience.com>
Date:   Thu, 7 Dec 2023 08:55:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: md raid6 oops in 6.6.4 stable
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, snitzer@kernel.org,
        song@kernel.org, yukuai3@huawei.com, axboe@kernel.dk,
        mpatocka@redhat.com, heinzm@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Bhanu Victor DiCara <00bvd0+linux@gmail.com>,
        Xiao Ni <xni@redhat.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
 <ZXHJEkwIJ5zKTMjV@archie.me>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <ZXHJEkwIJ5zKTMjV@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 08:30, Bagas Sanjaya wrote:
> On Thu, Dec 07, 2023 at 08:10:04AM -0500, Genes Lists wrote:
>> I have not had chance to git bisect this but since it happened in stable I
>> thought it was important to share sooner than later.
>>
>> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
>>
>>    commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
>>    Author: Song Liu <song@kernel.org>
>>    Date:   Fri Nov 17 15:56:30 2023 -0800
>>
>>      md: fix bi_status reporting in md_end_clone_io
>>
>> log attached shows page_fault_oops.
>> Machine was up for 3 days before crash happened.
>>
> 
> Can you confirm that culprit by bisection?
> 

That's the plan - however, turn around could be horribly slow if the 
average wait time to crash is of order a few days between each bisect.
Also machine is currently in use, so will need to deal with that as 
well. Will do my best.

Fingers crossed someone might just spot something in the meantime.

The commit mentioned above ensures underlying errors are not hidden, so 
it may simply have revealed some underlying issue and not be the actual 
'culprit'.

thanks

gene

