Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484587F4FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbjKVSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:51:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E7BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:51:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B139CC433C7;
        Wed, 22 Nov 2023 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700679086;
        bh=76BHoCxrsrTi+cmBAEZpQM1SFPdFzrrN19PgkN1SjQM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pj3rfBdFR3HV/NrtPuedqTQGUoja5aeucEC9LDpP8+afGo5bkR0B/O6mIOOUV96QQ
         iEU4tscaNHpaG4QLjwvscrmbI2YTnMX5m4Ty6T0Fs2GlZy6Gg0AdhL7KRs/EUFV1JC
         Z9/tVxYMqV2SaHAfN8R/JRUXgG1AA++C8U5TWtymUVZrMex+rbxPvAzQ0z1X4qMyHh
         8vXx9ZuD5F+8X+xJt0TEkaaDLW5rKKmh+JlatGGrLEfzcNYw5BdppA6kpV90bruPaD
         kMK/N87PHHmVjqJpqwUcJFk6/DNIYOUYCEtQSqxuVyhCmbu0FzAvXgJrRyf02Sfcsh
         jcXf2bJE3HjpQ==
Message-ID: <40a08bfe-6470-4fe0-8540-81db17c2bbc4@kernel.org>
Date:   Wed, 22 Nov 2023 10:51:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Kunwu Chan <chentao@kylinos.cn>,
        Tom Herbert <tom@herbertland.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jkbs@redhat.com, kunwu.chan@hotmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231122071924.8302-1-chentao@kylinos.cn>
 <ZV2sWSRzZhy4klrq@infradead.org>
 <37452b03-9c24-42a7-bb4f-ed19f622f0ef@kylinos.cn>
 <ZV3EmcsEqfFuvW4P@infradead.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <ZV3EmcsEqfFuvW4P@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 1:06 AM, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 05:04:49PM +0800, Kunwu Chan wrote:
>> Hi Christoph,
>> Thanks for your reply.
>> I also can't guarantee that it's the right thing to do. Just wanted to
>> dispel this warning. If you have any better way, please let me know.
> 
> The most likely reason is that it needs an endianess conversion.  I
> don't know the answer either, but actually spending a few minutes
> trying to understand the code should allow you to find it out quickly.
> 
> Removing a warning for it's own sake when you don't understand it is
> never a good idea.
> 

We should be able to set flow_label to __be32 in flow_dissector_key_tags
(and remove a couple ntohl).

Tom: any reason not to do that?
