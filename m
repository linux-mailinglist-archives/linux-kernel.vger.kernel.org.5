Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0247853AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjHWJR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjHWJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:09 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3DFDB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:04:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5B0086016E;
        Wed, 23 Aug 2023 11:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692781490; bh=rPOJhDsc2bW9CC7RfKRCtGGJbCzOoollOF7pyYU9Mc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=key+Nqd2vMut6hHx110y+Ne4P3+HjgYH+f3L0FmiIOWVXzDAOPztp1zFMTzM7xhwN
         vPa00kKe+MVA6akILiYu/1QnHQzz6AmkULo3bKsE7eFBtvBg6IkrRCVQCD51wn3WZI
         aKb0qH6EqYd+1wOYtGKQlM9vX+buwYKJkiLbn/btgCA1BKkyyHFGM8UG/802lrmlCP
         2A+mIJKxguP7RZ+vdke9BPtei5qtpzQ2enesgJ1ZwhU41Rckh+LGDVuCDTRGUG9bA7
         k9rsvA7EU6H4Afwx+4kXd29rtcaFwamrqnDdFsYyZ7fUw0PqNYg0lQaz9hVUEErkyL
         XTeFXeCc58I+g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8Djy6yN5OJ1w; Wed, 23 Aug 2023 11:04:48 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id DD0256015F;
        Wed, 23 Aug 2023 11:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692781488; bh=rPOJhDsc2bW9CC7RfKRCtGGJbCzOoollOF7pyYU9Mc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TMb/hd3Hfdcp03JufiXp2tdbrZ1eKwgQ0P+B4leB3BEhK2krc9tXM4zXQ71RsNk4A
         c1pFeckBLPmy6PUFdDjaz53t/GXh8SsM3yEvqKtiSfeQbpRE5WyXtw3icBX9FLOyrO
         FMYy+1g7CHLktN4yVq7KI31z3kcXWNWLkv1J2luJ8mhWhXnd+SYh30pplG2l3hxgbc
         eakcfryAV5HWm6gjnh7PKCwn5SswMJfWReKE3PdObvavyo0PcANvQ5y3mhsDgDQxdg
         EFkVYZjCMcalU6cN3HC3oSkjrk929CDTYBcxXvYn7S4SyDKntTUPjoOOI52fciudh+
         np1sd4wte5uCw==
Message-ID: <12ceee3a-44ed-4e70-99f2-c082282dae12@alu.unizg.hr>
Date:   Wed, 23 Aug 2023 11:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in process_one_work / process_one_work
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <6057c45f-d045-4772-db7c-3d706ada654f@alu.unizg.hr>
 <ZN6YVG114AZv9Yp8@slm.duckdns.org>
 <897214a4-ab16-a275-1023-4d38c3700b7d@alu.unizg.hr>
 <4ef130ef-b37b-2564-3cb3-6a930b2f729b@alu.unizg.hr>
 <ZOUR-Apz2Tws4d2c@slm.duckdns.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZOUR-Apz2Tws4d2c@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 21:52, Tejun Heo wrote:
> On Fri, Aug 18, 2023 at 01:58:27PM +0200, Mirsad Todorovac wrote:
>> Just as an exercise, this seems to work, but it is probably not very clean and not very scalable:
> 
> pwq is already per-cpu. It's not strictly accessed per-cpu because workers
> can go unbound but given that it's a stat counter, that doesn't really
> matter all that much. Sounds like it should be marked so that kcsan ignores
> it.
> 
> Thanks.

Hi, Mr. Heo,

Not at all.
  
Thanks for your review. The patch closed the KCSAN report, so I thought something was happening.

Kind regards,
Mirsad Todorovac
