Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8118277676E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHIShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjHIShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3DC1FCC;
        Wed,  9 Aug 2023 11:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB1764371;
        Wed,  9 Aug 2023 18:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191A5C433C7;
        Wed,  9 Aug 2023 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691606254;
        bh=1MHKH+VT4pP3zt6uWdZ73JYnRTASX2BWF0tTKLUP1nQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNtv4qri17Ilzavg6eK79JpHSCs4yVQaN0POB4npvphxrfHheCZxNaUVAZcx982u8
         aBTguFR50/2cMS4Hin9uWhHg0LK6poWe+uDpSCHhwdk2/3hbuQ7ZS/9sI22a4zH58s
         2XVYQjXiZm0GTlwnRPnkke0Tx4pbHKBGkwOiF7SWJitLeZH/ti8bYGzJzA8o35zIFC
         w1RIxtRA2yp7S+dddvVJk81/2pnt5a29A09jIlb2Q4PRRu6GFoENQbCPcN5LV0+hwZ
         25DAnNpq9CfGSY8OaMw5X/qPk2WutiikDVNnPWGjp2EdBebJilmViNhU/UqTzeRG5S
         N5/pu5GRnf+Kw==
Date:   Wed, 9 Aug 2023 11:37:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "edumazet@google.com" <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>
Subject: Re: Error 'netif_napi_add_weight() called with weight 256'
Message-ID: <20230809113732.5806b550@kernel.org>
In-Reply-To: <ba9b777754f7493ba14faa2dab7d8d59@realtek.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
        <20230731111330.5211e637@kernel.org>
        <673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
        <8fcbab1aa2e14262bea79222bf7a4976@realtek.com>
        <20230807093727.5249f517@kernel.org>
        <ba9b777754f7493ba14faa2dab7d8d59@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 13:11:57 +0000 Hayes Wang wrote:
> I think it depends on the platform.
> Most of the platforms don't have the same situation.
> Besides, I think the platform with 100Gbps device may
> have faster CPU than that one which I test.
> 
> What would happen, if I set the weight to 256 on the platform
> which runs well for the weight of 64?
> Doesn't it only influence the slow platform?

High weight will cause higher latency for other softirq and RT
processing, it's not a good idea. Even with weight/budget of 64
if there's no higher prio work to do the driver will be polled
again immediately if it consumed the budget and has more packets.

Do you have some actual data on how the device performs with budget 
of 64 and 256? And maybe perf traces to show where the difference goes?
