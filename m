Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DE7F858D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjKXVna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXVn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:43:28 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D93173D;
        Fri, 24 Nov 2023 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Op8b0I8io/cQDemiwtxI1Z5ZjO+RqtdJ3vH9IjLNJc=; b=jGxtCFewdD+ATRtqBWnzy5/xU6
        l0e1EzcPpJQdrGpTLz0wqtsqL8X64FvuDSlyT0bkasNXw6z7dwmtrkOE1rEWheCcyQCEVLJtsM2Ia
        aZhfpjye5j1Zne9sn+N6S4w/RZYU/BVJV50irOefBUui+d4uCneLRN4WmPXIKUtu5QLRpEICMc6lV
        xUtSZmMUfletzSrI3znctClNB+D6ePslFfIz6rXT1X2TuM4FtSoWzUZ+v0hVdzXNwqru/bM0CopES
        L5w2sWlnWGH+o2R+PE1ITW+vsoLSKVv8gL7xEKgINclf9Wn+4GZTKUht4ugPnXDqbGmjW7wk43zRb
        LZoiyrXA==;
Received: from 201-92-23-238.dsl.telesp.net.br ([201.92.23.238] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1r6dxC-006pom-Bo; Fri, 24 Nov 2023 22:43:14 +0100
Message-ID: <66ab7a03-6794-28c5-5a92-548c8700ae7c@igalia.com>
Date:   Fri, 24 Nov 2023 18:43:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/5] pstore: add tty frontend and multi-backend
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tony.luck@intel.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
 <202309282030.8CE179EBB@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202309282030.8CE179EBB@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuanhe / Kees.

My apologies (and embarrassment) for responding almost 2mo later...


On 29/09/2023 00:49, Kees Cook wrote:
> [...]
>> Another problem is that currently pstore only supports a single backend.
>> For debugging kdump problems, we hope to save the console logs and tty
>> logs to the ramoops backend of pstore, as it will not be lost after
>> rebooting. If the user has enabled another backend, the ramoops backend
>> will not be registered. To this end, we add the multi-backend function
>> to support simultaneous registration of multiple backends.
> 
> Ah very cool; I really like this idea. I'd wanted to do it for a while
> just to make testing easier, but I hadn't had time to attempt it.

I found the idea of multi-backend quite interesting, thanks for that!!!
And to add on what's Kees mentioned, not sure others' opinions but seems
to me this is a bit more straightforward / path-of-less-resistance than
the the tty frontend, so I'd suggest split the series and focus first on
this and once accepted, hook the tty thingy.

Not that the series can't be sent altogether, reviews could work in
parallel...I just see them as a bit tangential one to the other, personally.

> [...]
> - The multi-backend will enable _all possible_ backends, and that's a
>   big change that will do weird things for some pstore users. I would
>   prefer a pstore option to opt-in to enabling all backends. Perhaps
>   have "pstore.backend=" be parsed with commas, so a list of backends
>   can be provided, or "all" for the "all backends" behavior.
> 
> - Moving the pstorefs files into a subdirectory will break userspace
>   immediately (e.g. systemd-pstore expects very specifically named
>   files). Using subdirectories seems like a good idea, but perhaps
>   we need hardlinks into the root pstorefs for the "first" backend,
>   or some other creative solution here.
>

Big +1 in these two, commas are a very nice idea and changing the sysfs
current way of exposing pstore logs would break at least kdumpst (the
Steam Deck/Arch pstore / kdump tool), besides systemd-pstore that was
already mentioned (and who knows what more tools / scripts out in the
field).

Overall, thanks a bunch for this work Yuanhe!
Cheers,


Guilherme
