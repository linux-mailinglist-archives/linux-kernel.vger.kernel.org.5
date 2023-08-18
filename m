Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F410781037
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378586AbjHRQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378628AbjHRQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC69030F1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 525C261D97
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55132C433C8;
        Fri, 18 Aug 2023 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692375672;
        bh=F4hu+ZSGYoWCRdUdfsCxfVt10gS2gebSaptHFSyZ0rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cjDtFUU8eNav46CbF/zksDLJ6ng2War+LGduWysDW0s+Lmkcq0/Ke9m7Z18+YGblP
         /oWBnuokIWWyib8Mn6QEdc8eXYAzMZih5TbtFr0jR2yDbxfinK0rNJdM/hK/MIMG5W
         aPnFZ7D01SZc3UFJAhPhCvdGD+EL9pJx0RhnSl2ZKqwfAxZR9m5S50CtMA6N8h9ZGo
         Hu4FbDMijaPofsi6x1jLdLik5IoFWNUlGaa6ISTa5yZ+kR1rNI8AeLGAva2tPVk3iF
         dXKkydImC+K2Zp9302csEoN7KQSu3pZ652ghYJIHFbRyKBrpzOCPar0rHdQWsXUo+V
         awXViSsjHW7wQ==
Date:   Fri, 18 Aug 2023 09:21:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230818092111.5d86e351@kernel.org>
In-Reply-To: <20230818145734.OgLYhPh1@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
        <20230814112421.5a2fa4f6@kernel.org>
        <20230817131612.M_wwTr7m@linutronix.de>
        <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
        <20230818145734.OgLYhPh1@linutronix.de>
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

On Fri, 18 Aug 2023 16:57:34 +0200 Sebastian Andrzej Siewior wrote:
> As of now Jakub isn't eager to have it and my testing/ convincing is
> quite limited. If nobody else yells that something like that would be
> helpful I would simply go and convince PeterZ/tglx to apply 2/2 of this
> series.

As tempting as code removal would be, we can still try to explore the
option of letting backlog processing run in threads - as an opt-in on
normal kernels and force it on RT?

But it would be good to wait ~2 weeks before moving forward, if you
don't mind, various core folks keep taking vacations..
