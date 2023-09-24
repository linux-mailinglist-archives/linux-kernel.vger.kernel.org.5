Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B47AC7F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIXMQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:16:20 -0400
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A90FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=wW0fsRw7EYcij+1N7xjVLAT1acKLYpEaD/gSjMzJs4s=; b=AFljQZncfHJN+Ozfw2IKiKh8oO
        D9DjDMw3E7BwV4V+fbJamtcIYqjIXArxS0L33XtN8MCaQ1k+KHGsvUIilf86r6nTlbMXr+H/cQ6Uo
        rgL1Iif3Y9qpiXIY1h3RwsY6TLzlwJTuHyjTjo5H9LGE4XCGmaKLvYXKDAKpq+zZBRqY9bBySQMmC
        1+3RF4Vnt2xdTEZ6irDJ1MI5igrh1qdYOw9kABVY6gltaktLZxuvwZ9yJKh63PI7PtOQJzXasDcq9
        H+NNMjnigtXAoBYSpWmVYK9/HIC8YeBv3xfB5KSy2blqnVKPCdpmn2ojGAhyuE9gFTJyN2RrxppBO
        bvXoimvw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
        (envelope-from <dg@treblig.org>)
        id 1qkO1w-001A0c-0e;
        Sun, 24 Sep 2023 12:16:08 +0000
Date:   Sun, 24 Sep 2023 12:16:08 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     matthew.brost@intel.com, mgreer@animalcreek.com,
        linux-kernel@vger.kernel.org, airlied@gmail.com,
        intel-gfx@lists.freedesktop.org
Subject: Re: ERR_PTR(0) in a couple of places
Message-ID: <ZRAoiGafRSv7SM6C@gallifrey>
References: <ZQ+Fo9WKyGphwI8R@gallifrey>
 <b3813a4e-3956-254c-a7cf-0fca65dc2cdd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b3813a4e-3956-254c-a7cf-0fca65dc2cdd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 12:06:53 up 8 days, 15:05,  2 users,  load average: 0.03, 0.03, 0.00
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Kozlowski (krzysztof.kozlowski@linaro.org) wrote:
> On 24/09/2023 02:41, Dr. David Alan Gilbert wrote:
> > Hi,
> >   I randomly noticed there are a couple of places in the kernel that
> > do
> >    ERR_PTR(0);
> > 
> > and thought that was odd - shouldn't those just be NULL's ?
> > 
> > 1) i915
> >   drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c : 47
> > 
> >     if (i <= 1)
> >       return ERR_PTR(0);
> > 
> >   from f9d72092cb490 
> > 
> > 2) trf7970a
> >   drivers/nfc/trf7970a.c : 896
> > 
> >       trf->ignore_timeout =
> >          !cancel_delayed_work(&trf->timeout_work);
> >       trf->rx_skb = ERR_PTR(0);
> 
> I would guess that code is relying on rx_skb being valid pointer or ERR
> (if (!IS_ERR(...))).

If seems mixed, that function calls trf7970a_send_upstream which has
both:

  if (trf->rx_skb && !IS_ERR(trf->rx_skb) && !trf->aborting)
    print_hex_dump_debug("trf7970a rx data: ", DUMP_PREFIX_NONE,
             16, 1, trf->rx_skb->data, trf->rx_skb->len,
             false);
and
    if (!IS_ERR(trf->rx_skb)) {
      kfree_skb(trf->rx_skb);
      trf->rx_skb = ERR_PTR(-ECANCELED);
    }

It's not clear to me whether it's expecteing that 2nd if to happen or
not.

I notice err.h gained a IS_ERR_OR_NULL to help that case as well.

Dave

> Best regards,
> Krzysztof
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
