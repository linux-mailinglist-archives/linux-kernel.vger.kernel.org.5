Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7E7929FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354039AbjIEQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354231AbjIEKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:13:51 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5318D;
        Tue,  5 Sep 2023 03:13:44 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Rg1Yb3HrXz9spR;
        Tue,  5 Sep 2023 12:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1693908819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwy3Wn4HAyhcZ+X2rFN5+szTEY2owO70dhUnqcdje/E=;
        b=ULiqjIKb0Q+2GOone/Fy+az7Q0foq75ZVenkefWE5MFShINpjUQOvrHC5fWLEF0ftSyMY+
        exSPaoqk5pk3fgmvMOWPbT/3sSmvNAat/wlYBBpwFG+VwiyHiHJO6XEkxMNLC0Drdjod2+
        6Fow5hrECrH2DZB0jucg+CvmoTt3qaAZ1vYVEfntCU+puqWcw2S2cy5Q7MlP6dc3t7OkqW
        sFQ7smR3FWLypr93JLAkgss14QUWDbLPRWGHAg8kZrmTzPpVKgt5SX5MD7liT/+4/nKVg3
        DAWHkMd9AuygaHWZ6mwgh3w43lm8qfjHHR5knbUudT1sRbXmKegA2Ta8JlbFsA==
Message-ID: <d1cf5a66-03e1-44b8-929d-ac123b1bbd7b@sylv.io>
Date:   Tue, 5 Sep 2023 12:13:36 +0200
MIME-Version: 1.0
Content-Language: en-US, de-DE
To:     Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0490137bbc24e95eadf01bed9c31eb1d0a856a21.1693823464.git.sylv@sylv.io>
 <a88c3486dafcc9e7a8cb5eecf14b6e6b93a13c65.camel@redhat.com>
From:   Marcello Sylverster Bauer <sylv@sylv.io>
Subject: Re: [PATCH v2 1/1] xfrm: Use skb_mac_header_was_set() to check for
 MAC header presence
In-Reply-To: <a88c3486dafcc9e7a8cb5eecf14b6e6b93a13c65.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 9/5/23 11:59, Paolo Abeni wrote:
> On Mon, 2023-09-04 at 12:32 +0200, Marcello Sylvester Bauer wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> Add skb_mac_header_was_set() in xfrm4_remove_tunnel_encap() and
>> xfrm6_remove_tunnel_encap() to detect the presence of a MAC header.
>> This change prevents a kernel page fault on a non-zero mac_len when the
>> mac_header is not set.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Please include a suitable fixes tag.
> 
> Please also include in the commit message the stacktrace:
> 
> https://lore.kernel.org/netdev/636d3434-d47a-4cd4-b3ba-7f7254317b64@sylv.io/
> 
> trimming the asm code and lines starting with ' ? '

Sure, will be added to the next version in addition to a cover letter to 
give additional context to this patch.

> 
> I think the real issue could be elsewhere, we should not reach here
> with mac_len > 0 && !skb_mac_header_was_set().
> 
> Could you please try the following debug patch in your setup, and see
> if hints at some other relevant place?

Unfortunately the person with the hardware is OOO for two weeks. But I 
could ask him to test it when he gets back.

Thanks,
Marcello

> 
> Thanks,
> 
> Paolo
> 
> ---
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 4174c4b82d13..38ca2c7e50ca 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2793,6 +2793,7 @@ static inline void skb_reset_inner_headers(struct sk_buff *skb)
>   
>   static inline void skb_reset_mac_len(struct sk_buff *skb)
>   {
> +	WARN_ON_ONCE(!skb_mac_header_was_set(skb));
>   	skb->mac_len = skb->network_header - skb->mac_header;
>   }
>   
> 
