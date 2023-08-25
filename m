Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC97881A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbjHYIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbjHYIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D741FF6;
        Fri, 25 Aug 2023 01:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2690A66EEB;
        Fri, 25 Aug 2023 08:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4322C433C8;
        Fri, 25 Aug 2023 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692951025;
        bh=MZiSPi7PsqNW/QQ5weCras7ssRcqxOoTx+NhIZgDiWE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e5AOOo7hoVXLo7H1x5MKH+DqM5YhKYzGx9SYVUivQ2jx1ZmkcTiH/0/yk5IODk4uX
         UwBGX5K6sUD7af8uFQ6Fpnqi2Qnp3qPF0qmHPlSaMyQ01zo4gXZoPKVlhyHu5KeGOj
         p9XN5srdk1BZ3EVh4Fgb+wqi9tewoZPd600oG1o+iRZnHCQZXllgwTKVOU7mC3B62a
         8M1uUG/utLk/6SUH6XZ5tXeUyLKX9x0VPGYlFw7bnv3kAUFq3ecvYNleS+pAqjs/c2
         0PmQo++aUxAEO4Ug631QmPY5KLhPY4nX2aWevyIrQGXV3UibfymHaPH0ZzcKiz4ioc
         tBJtwgzjo57Kw==
Message-ID: <689cfe0d-a323-b48c-8543-4ddd74258fc0@kernel.org>
Date:   Fri, 25 Aug 2023 17:10:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ata: pata_ep93xx: fix error return code in probe
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
 <20230823-ep93xx_pata_fixes-v1-1-d7e7229be148@maquefel.me>
 <00462bc7-43ee-784a-3296-8051d69575df@kernel.org>
 <913a0bc0dfcd3ecd28f65fb52db789033097d831.camel@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <913a0bc0dfcd3ecd28f65fb52db789033097d831.camel@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 17:05, Nikita Shubin wrote:
> Hi Damien!
> 
> On Thu, 2023-08-24 at 08:07 +0900, Damien Le Moal wrote:
>> On 8/23/23 18:47, Nikita Shubin via B4 Relay wrote:
>>> From: Nikita Shubin <nikita.shubin@maquefel.me>
>>>
>>> Return -ENOMEM from ep93xx_pata_probe() if devm_kzalloc() or
>>> ata_host_alloc() fails.
>>>
>>> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>>
>> Doesn't this need a Fixes tag and Cc: stable ?
>>
>> This is not really a bug fix, but might as well be complete with the
>> fix :)
> 
> Well... This would be fix for:
> 
> ```
> commit 2fff27512600f9ad91335577e485a8552edb0abf
> Author: Rafal Prylowski <prylowski@metasoft.pl>
> Date:   Thu Apr 12 14:13:16 2012 +0200
> ```
> 
> v3.4-rc6-6-g2fff27512600
> 
> Are you sure we wanna tag so solid and time proven commit as Fixes: :)
> ?

Yeah, this is fine without the fixes tag. As I said, not exactly a bug fix but
rather an improvement :)

-- 
Damien Le Moal
Western Digital Research

