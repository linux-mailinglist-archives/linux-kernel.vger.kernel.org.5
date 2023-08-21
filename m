Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0504783092
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHUS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHUS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96354ED2;
        Mon, 21 Aug 2023 11:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9870D6423C;
        Mon, 21 Aug 2023 18:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82723C433C9;
        Mon, 21 Aug 2023 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692643684;
        bh=Um5mFwcE5cVNHmWMTL+F+fXrhZmpdU1DH8xAEdxyQ8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PuldAdNm9nwcH6ymGQckb+V24C/yp1Z5osDjRGqWHtxcUiEdn7t2c1EahQSfzAnCi
         WPtUkgYrcZzYdhLGM9MgpY6h/jc6VrO2fEvtjBzZeFSRNXUgSuc3WcNjYwr+kHIZFE
         5mOsmi64Tf0DopK1nRJpSjlEdmPuJdBHdWZL0fkTy/xlQ1opV+Bx4mB+hxkwFqCPh2
         gyeWuaHxrdBsTo85WINZK7hEe+9QWl8h+aiX/Lif0RsZ+nozoh95VZ5/yAKoYQPvXc
         cdrOkSkgvvyvCvCBe+9xxNsaDLUCaHLno3V8M3qxl/aIeuwL1VkC7g6qk4lNNyhY/z
         uUyCY5Y0JK12w==
Date:   Mon, 21 Aug 2023 11:48:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
Message-ID: <20230821114802.1d1ce74b@kernel.org>
In-Reply-To: <CAM0EoM=fZVr4ROKZ+tA9A=yxcx6LnNVFzTb+_brFv9c-CiRfdA@mail.gmail.com>
References: <ZN5DvRyq6JNz20l1@work>
        <20230818193810.102a2581@kernel.org>
        <CAM0EoM=fZVr4ROKZ+tA9A=yxcx6LnNVFzTb+_brFv9c-CiRfdA@mail.gmail.com>
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

On Mon, 21 Aug 2023 10:35:29 -0400 Jamal Hadi Salim wrote:
> > Sure, but why are you doing this? And how do you know the change is
> > correct?
> >
> > There are 2 other instances where we allocate 1 entry or +1 entry.
> > Are they not all wrong?
> >
> > Also some walking code seems to walk <= divisor, divisor IIUC being
> > the array bound - 1?
> >
> > Jamal acked so changes are this is right, but I'd really like to
> > understand what's going on, and I shouldn't have to ask you all
> > these questions :S  
> 
> This is a "bug fix" given that the structure had no zero array
> construct as was implied by d61491a51f7e . I didnt want to call it out
> as a bug fix (for -net) because existing code was not harmful but
> allocated extra memory which this patch gives back.
> The other instances have a legit need for "flexible array".

Based on the link provided it seems like the Fixes comes in because
someone reported compilation issues. But from the thread it seems
like the problem only appears when sizeof_struct() is modified.
In which case - you're right, Fixes and Reported-by tags should go.
