Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8521791A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbjIDP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbjIDP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73DDCC3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693841164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qn0Q7H7evoRHH4Nj4axR0mmpgO4f23pEiMyC9/o6s5w=;
        b=LTgJglC/pyWbGwJ6PtSS2wt2F+21Ao0ASTr0UdHTZoQfpnqm/Z3DMbyr0Tgrqk7zIf6YLt
        oywln2AdIkl5jANF4Q1CQeAwvGvMTRFDrb6/irP7fNCT1pF/c0nlpksxeFHuan2FwC/mkY
        BVA41NRrIpFGQkJw47prnRNPmsMqwQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-9jhrxafXNFKPiZSlWo4y5A-1; Mon, 04 Sep 2023 11:25:59 -0400
X-MC-Unique: 9jhrxafXNFKPiZSlWo4y5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDDCA868012;
        Mon,  4 Sep 2023 15:25:58 +0000 (UTC)
Received: from [10.22.8.119] (unknown [10.22.8.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28049200A86A;
        Mon,  4 Sep 2023 15:25:58 +0000 (UTC)
Message-ID: <c98e6c5b-d334-075f-71b8-1c2a3b73b205@redhat.com>
Date:   Mon, 4 Sep 2023 11:25:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/23 04:33, Rafał Miłecki wrote:
> As those hangs/lockups are related to so many different changes it's
> really hard to debug them.
>
> This bug seems to be specific to the slow arch clock that affects
> stability only when kernel locking code and symbols layout trigger some
> very specific timing.
>
> Enabling CONFIG_PROVE_LOCKING seems to make issue go away but it affects
> so much code it's hard to tell why it actually matters.
>
> Same for disabling CONFIG_SMP. I noticed Broadcom's SDK keeps it
> disabled. I tried it and it improves stability (I had 3 devices with 6
> days of uptime and counting) indeed. Again it affects a lot of kernel
> parts so it's hard to tell why it helps.
>
> Unless someone comes up with some magic solution I'll probably try
> building BCM53573 images without CONFIG_SMP for my personal needs.

All the locking operations rely on the fact that the instruction to 
acquire or release a lock is atomic. Is it possible that it may not be 
the case under certain circumstances for this ARM BCM53573 SoC? Or maybe 
some Kconfig options are not set correctly like missing some errata that 
are needed.

I don't know enough about the 32-bit arm architecture to say whether 
this is the case or not, but that is my best guess.

Cheers,
Longman

