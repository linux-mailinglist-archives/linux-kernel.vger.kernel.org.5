Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6190E7865D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbjHXDbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjHXDbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC770E7B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 805D263363
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D95C433C7;
        Thu, 24 Aug 2023 03:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692847882;
        bh=2MxDhV6CHEltlY23Xu4O5PADIqsFvP60GAhGKOsthbM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ind9fMCZOuF0I/Zri5pudAvh2EZZ2MqNKvNno6SYRbtDwJuQw2Wn6TaU2ergX2AP3
         c0Ngv0sIvTN8Zi/a7Lgb2SW3GZsy5DN5qvAZVgtK6YrOodWk8YkzlxnrE7fZtf9X3N
         rrkyRuGjeXCh22ckIKaAUc0I7S19PZpv9K3PMYqOg0F2UgvaLd/zn8z+3i+3wB0Ha3
         ZNk3usAGueU6+nr42Tw+lFBdviThU8sD5OnZgwaEOTG4j7sQ4Nj/HHdZ6p1p5+xKpE
         ZwlhlUkFYVi+njp9/b0nfKm2MJ0sFZ9mWZ+gVO7CJJwWyz5+6PeeZJ4yCHHWifTu+o
         N6vQl8Rgpp/PA==
Message-ID: <90a27f82-ff90-f8ce-ccf3-e1d8909b744d@kernel.org>
Date:   Wed, 23 Aug 2023 20:31:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Content-Language: en-US
To:     Gal Pressman <gal@nvidia.com>,
        Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        aleksander.lobakin@intel.com, lixiaoyan@google.com,
        lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
 <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
 <b45cedc6-3dbe-5cbb-1938-5c33cf9fc70d@kernel.org>
 <d4cc1576-f4c3-a074-9bf4-937cdd3ff56d@nvidia.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <d4cc1576-f4c3-a074-9bf4-937cdd3ff56d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 7:43 AM, Gal Pressman wrote:
>> With veth and namespaces I expect up to 25-30G performance levels,
>> depending on the test. When something fundamental breaks like this patch
>> a drop to < 1G would be a red flag, so there is value to the test.
> Circling back to this, I believe such test already exists:
> tools/testing/selftests/net/udpgro_fwd.sh
> 
> And it indeed fails before Richard's fix.
> 
> I guess all that's left is to actually run these tests 😄?

hmmm... if that is the case, the Makefile shows:

TEST_PROGS += udpgro_fwd.sh

so it should be run. I wonder why one of the many bots did not flag it.
