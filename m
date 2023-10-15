Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9336A7C993E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjJONzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 09:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJONzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 09:55:00 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C7B7;
        Sun, 15 Oct 2023 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HeLSDR+Sozk/FfhSf8rg92vqdhkO661vM3ya5zaMH5U=; b=dBH80M+EB+uzCY+jsCfyJJajSu
        avIQe39UNTT4H89h2zGlhJ+CeY0HtZ0Cfk6Vmp4oMv8pDmdglNxfoEoh6gGprKk2+S5GfR/NWhccI
        cFPY33XJNcE+im1+9tWTLgOY1GzVpCz+vSbB3EC4NpovOSy7vg7Rq6p3pisBoa3DS6VHL7h9LVgyy
        RKt1Aw8WgN0uO65iRGr6lVdHhG4SgD0Y+FZNfVimyE9NMRhHYdEYeih0aFJ3pN1+RzaWTsfODg0Jv
        qDl+d51du/A49xMnP/9UbDTTVFHC7L5lz5IvUXCoRLYqHP8F9Ozm4DsLyKBB/9JKJ5B5IOvlU8Bf0
        IkZlxY2w==;
Received: from [192.168.12.176]
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qs1Zx-000lCB-PP; Sun, 15 Oct 2023 15:54:49 +0200
Message-ID: <f5837e2d-2fbd-34f2-37eb-11701db4464e@igalia.com>
Date:   Sun, 15 Oct 2023 15:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5] alpha: Clean-up the panic notifier code
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-alpha@vger.kernel.org, mattst88@gmail.com,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <richard.henderson@linaro.org>,
        Petr Mladek <pmladek@suse.com>
References: <20230902165725.3504046-1-gpiccoli@igalia.com>
 <alpine.DEB.2.21.2310100109100.48714@angie.orcam.me.uk>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <alpine.DEB.2.21.2310100109100.48714@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 02:16, Maciej W. Rozycki wrote:
> On Sat, 2 Sep 2023, Guilherme G. Piccoli wrote:
> 
>> So, let's clean the code and set the notifier to run as the
>> latest, following the same approach other architectures are
>> doing - also, remove the unnecessary include of a header already
>> included indirectly.
> 
>  FWIW my understanding is our current policy is not to rely on indirect 
> inclusions and if a given source relies on declarations or definitions 
> provided by a header, then it is supposed to pull it explicitly.
> 
>  And in any case such an unrelated self-contained change is expected to be 
> sent as a separate patch, in a series if there's a mechanical dependency.
> 
>   Maciej
> 

Hi Maciej, thanks for your review!

I'm not sure how the indirect inclusion is happening here. The only
notifier present in this file is a panic notifier, and for this one, we
have the "panic_notifier.h" header. It's like this for many others (if
not all) panic notifiers in the kernel.

Usually the indirect inclusion would happen if some other notifier block
was used for any other reason, and we dropped the "notifier.h" include,
which then would indirectly rely on "panic_notifier.h". In case I'm
talking silly things, let me know! I might not have understood properly
your point (and if so, apologies).

Regarding split in another patch, it can easily be done, but I think
it's quite self-contained now, a simple patch that cleans-up the alpha
notifier. I've done that for other notifiers so far, but I'm OK either
way, as long maintainers are happy and community agrees =)

Cheers,


Guilherme
