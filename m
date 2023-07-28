Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBDD7662C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjG1EJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjG1EJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259861BD5;
        Thu, 27 Jul 2023 21:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B8E61FB5;
        Fri, 28 Jul 2023 04:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE1DC433C7;
        Fri, 28 Jul 2023 04:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690517348;
        bh=uw0Xjt7/KMv5o/4UdrtIWciAkDGApwQ+7UzCn1CqA5g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p3Is/j119bril0PDN0qA5OJEw2nmlR2e+RcyQzjSfZz917JGE3cDUmeF3FHX10L/k
         rYD4MYnNeeXGNhnc0NM8Owv1582AZb9EH/dEINcR6bj6NIX4lT6CVrYXUfdmlYsPgR
         wG28HMtn7SzjrCq/X4SLXzPK1UbhRYIagygvJKbZ3Zto2kmFUoqaxJXA33ybhYpcW0
         CfSUXLsOADa1AzFrfbHJIkaEFC1pbsQPwTm6AVwHC2mO6Fd2jkzTrcwYrLWzRoNEEL
         VQLVtRGSaYW4n9rBt4UYyTgIXy5KvPRTd/Xp92/2y6QlI2iZ8OHzqTVfn6DcUu48dv
         Abb6SykABXp/g==
Message-ID: <3836423e-8f0f-1278-38e5-d35fbd7298e4@kernel.org>
Date:   Fri, 28 Jul 2023 13:09:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US
To:     TW <dalzot@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
 <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
 <48bc1736-5e4e-3a9b-3715-60509c333bb1@kernel.org>
 <f7e7b601-571f-bd2e-6410-a8a27e510c2f@gmail.com>
 <40365501-283a-408b-3514-48c29db36861@kernel.org>
 <d44e4057-0758-4cb8-ca29-02b5bb340b8b@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d44e4057-0758-4cb8-ca29-02b5bb340b8b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 11:49, TW wrote:
> Comparing to the 5.15 kernel which had almost no delay. They are HDDs 
> though, it was working flawlessly earlier but didn't want to top post 
> again. Tried a systemd suspend instead of from the Xfce4 logout menu and 
> everything works as intended. So I'd say that it's fixed now.

I think that asynchronous scsi suspend/resume using the PM infrastructure,
introduced in 5.16, is creating this additional delay. The reason is that now,
ata and scsi drivers do their resume operations from within the PM resume
process, resulting in some delays to reach "PM: suspend exit".

I am looking into improving this, but it may take some more time.

I will post officially the patch you tried and CC you. A "tested-by" tag from
you would be appreciated.

Thanks.

> 
> On 7/27/23 20:33, Damien Le Moal wrote:
>> "Slow coming back" -> Compared to which version of the kernel ? Do you 
>> have numbers ? If the devices are HDDs, resume will wait for these to 
>> spin up. That takes a while (about 10s normally).

-- 
Damien Le Moal
Western Digital Research

