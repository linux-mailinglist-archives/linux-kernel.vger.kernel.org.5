Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718BE76FD4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjHDJaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjHDJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:30:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209530EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1636961EBE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5BDC433C7;
        Fri,  4 Aug 2023 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691141408;
        bh=LEzM9G3hCkmW57EJI+SwefMcALPoyoAqXr/zZx0/GPw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sIGAu88hByPr2pePZ9Q6D3Op+OdIxyXOdviLitcorwMWrv8SrX0NOW/EDrU5LDMRu
         hbC7eG8xmtLQf+t62qRsaSoAEwpDcb1klZN6MFIfPJiCvpF/2GOTg7fidd0TiMIe3s
         TgLaTMxQvbTEMyrZ3dp3/jqeJxlPeyTi+F4GJHh+mU5+pz+mKvRL0dY/knGbTdvr26
         Jetk/KBw7uzKMLQa8BIUZ3MuzFJ1hR98N0GM7SLCFrCndR0/I6S3MJV5J/kYCbPPHZ
         XmxwbxAs2V855E3W7I+pwkz8Jaq4Z8N7SK70s1QU2+HqqZRpM39LnD0og0yM2QRggL
         NxhvBslhPcR7Q==
Message-ID: <224e100b-6874-2993-a743-0a93ca0201fd@kernel.org>
Date:   Fri, 4 Aug 2023 11:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed
 the packet size limit
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, dsahern@gmail.com,
        jbrouer@redhat.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20230801220710.464-1-andrew.kanner@gmail.com>
 <2cb34364-0d7c-cf0a-487f-c15ba6568ac8@kernel.org>
 <CACGkMEvukuV5UZqb=MOaPqWfuJKOokZW1986GE4cRwt=Vx9Unw@mail.gmail.com>
 <64cbe991.190a0220.b646b.04c1@mx.google.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <64cbe991.190a0220.b646b.04c1@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2023 19.53, Andrew Kanner wrote:
>>> Question to Jason Wang:
>>> Why fall back (to e.g. tun_alloc_skb()) when size is above PAGE_SIZE?
>>>
>>> AFAIK tun_build_skb()*can*  create get larger packets than PAGE_SIZE
>>> from it's page_frag.  Is there a reason for this limitation?
>> >> I couldn't recall but I think we can relax.
> > Jesper already sent enough info for this idea in v2, I will use it for
> the next patch/series.
> 

I have some more input and considerations when selecting the new
constant that replace PAGE_SIZE.

Lets see if Eric Dumazet or Alex Duyck disagree?
("inventors" of page_frag scheme)

The function tun_alloc_skb() uses a page_frag scheme for allocation.
The maximim size is 32768 bytes (Order-3), but using something that is
close to this max alloc size can cause memory waste and fragmentation.

My suggestion would be to use the constant SKB_MAX_ALLOC (16KiB).

Maybe Eric or Alex would recommend using something smaller? (e.g. 8192)

page_frag limit comes from:
  #define SKB_FRAG_PAGE_ORDER get_order(32768)


> Jesper, I will add this tag for this next patch/series if you don't
> mind:
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>

ACK

