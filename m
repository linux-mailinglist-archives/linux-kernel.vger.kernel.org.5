Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3DD7816BA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbjHSCi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjHSCiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B31BB;
        Fri, 18 Aug 2023 19:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C074622D9;
        Sat, 19 Aug 2023 02:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180A0C433C8;
        Sat, 19 Aug 2023 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692412691;
        bh=oSkCuPAKXtvGAJIRmzBOrV+jlKSk2VzCCDit/Nm5mbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kZle1zR3yL3S8NsbcSOizysqQjSY0B1GiZFlJAH8CoXUvTzjgMN+gralGiVI6//cu
         IdZoYXRMQPG7Dm/PlqQ9AY8W5QEZNXYtYW55WcGFmUdTobLtiXKRbGxR4S0sDQUXPt
         xuvBvWiKrHN0Z7dl1VJQOOpU2H9pdJ9fZ/rgWU/ONxebV71FTDiA7pPC1uQeV7ZpfO
         vNA9miObq54SV4zVNbpP958nhJRXykhp7X4vQCe9X2+2Seo3lqzpIYzY3P52r8SWIz
         8Pb22Ebjpelc7ZUK6q66VjFQP5hcxmhTRmtjhnPcb89e47VKT79kmF+C5TcNGJlscc
         W60FWbi8W0Y+g==
Date:   Fri, 18 Aug 2023 19:38:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
Message-ID: <20230818193810.102a2581@kernel.org>
In-Reply-To: <ZN5DvRyq6JNz20l1@work>
References: <ZN5DvRyq6JNz20l1@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 09:58:53 -0600 Gustavo A. R. Silva wrote:
> Subject: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
> Date: Thu, 17 Aug 2023 09:58:53 -0600
> 
> Replace struct_size() with sizeof(), and avoid allocating 8 too many
> bytes.

What are you fixing?

> The following difference in binary output is expected and reflects the
> desired change:
> 
> | net/sched/cls_u32.o
> | @@ -6148,7 +6148,7 @@
> | include/linux/slab.h:599
> |     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
> |                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
> |-    2cfc:      mov    $0x98,%edx
> |+    2cfc:      mov    $0x90,%edx

Sure, but why are you doing this? And how do you know the change is
correct?

There are 2 other instances where we allocate 1 entry or +1 entry.
Are they not all wrong?

Also some walking code seems to walk <= divisor, divisor IIUC being
the array bound - 1?

Jamal acked so changes are this is right, but I'd really like to
understand what's going on, and I shouldn't have to ask you all 
these questions :S
-- 
pw-bot: cr
