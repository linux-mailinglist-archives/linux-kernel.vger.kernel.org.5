Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29439768965
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 02:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGaAlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGaAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 20:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F359E5A;
        Sun, 30 Jul 2023 17:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1293360DE7;
        Mon, 31 Jul 2023 00:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CDFC433C7;
        Mon, 31 Jul 2023 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690764089;
        bh=Id9w+26JcA3ovoOCmq873Dz/XimrlDDtDX+h2mPVv1Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HVT1BwhXGDRxS21WFjAzyUa2Pv5ZOXtUdxpYAnQ7UFGX/YJcdaeoj4Wt+JbndEsxG
         A4IM3UQW49xYTIatHVmWxi4zNuw50oJ0QGzrheIli5FOd6qDnnRl4f82ZwVU1HfNQU
         rYLRqtroWcmk/pK3voKAwgvuZJcqug3cp+xPJGKB3mWym286roA69AKDRrnxWWR0b6
         /ZN9oq46aB8mdxhcacOxIAIQyHrbjugOIz+qkQoDoUkrL1dRDshmN1tnlYSTHkOQGw
         ocp/TczfNjQ6Vy30K7nWZAJ2bp4PQlL66mOsla5XoeaWU7JX1mEvMaMvbvBc5kTJLz
         fsfGFOBgcEqug==
Message-ID: <2b7e9239-fd48-0f74-f69b-e0039809c857@kernel.org>
Date:   Mon, 31 Jul 2023 09:41:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
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
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d44e4057-0758-4cb8-ca29-02b5bb340b8b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

I posted a proper patch and CC-ed you. A "Tested-by:" tag from you would be much
appreciated (please use your full name in that case, instead of only "TW").
Thanks.

> 
> On 7/27/23 20:33, Damien Le Moal wrote:
>> "Slow coming back" -> Compared to which version of the kernel ? Do you 
>> have numbers ? If the devices are HDDs, resume will wait for these to 
>> spin up. That takes a while (about 10s normally).

-- 
Damien Le Moal
Western Digital Research

