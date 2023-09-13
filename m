Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59DB79F0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjIMSM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:12:28 -0400
Received: from sipsolutions.net (unknown [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241919B6;
        Wed, 13 Sep 2023 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=M5bGmoUyQupKtGvvQEF+4JyDxHWZgmyPOatv62PK+Lo=;
        t=1694628744; x=1695838344; b=fqtZmpMdJZCJxxa0Uu90BFUXm2D5DdfzjFeKWD8H+DEMpbN
        w6HA052efdF35jLmeq3PDMPbob2aB9ZBIiirWIgt/LpJyQfpFqNkfgnbzFT8Y+tuF4H6atJBMNz+0
        YFF5+DxMi7uXq1FVddLXkgLQaMdyylK75KSJFpvWZFQxoxw1DDdgPAlufHiT0ciDCbwJlm113wOX9
        w3cIg0lg+GfU85nF+24vqJy4qknNkrooz4NoStLrYr7u8rvg40dFO1FSqZwG7FO2y7VTTgjc3zx+Q
        /bNsNaL7zjvCUv6rkPWMc0aF1BWmvr3rDzFxxR94zohWPumB6fVPfN5TGMrfFKZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgUKz-00FFbN-1l;
        Wed, 13 Sep 2023 20:11:41 +0200
Message-ID: <515a7435bd83ecc8a9d63306d4bc076c762f22bf.camel@sipsolutions.net>
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heyi Guo <guoheyi@linux.alibaba.com>, netdev@vger.kernel.org
Date:   Wed, 13 Sep 2023 20:11:39 +0200
In-Reply-To: <a50218b6-fc42-7f12-155a-5e01fc8dd1a0@roeck-us.net>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
         <YuK78Jiy12BJG/Tp@slm.duckdns.org>
         <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
         <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
         <afa1ac2c-a023-a91e-e596-60931b38247e@I-love.SAKURA.ne.jp>
         <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
         <0a85696a-b0b9-0f4a-7c00-cd89edc9304c@I-love.SAKURA.ne.jp>
         <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
         <e0717628-e436-4091-8b2e-2f4dcb646ec8@roeck-us.net>
         <6b1c6996da5d215371e164b54e8854541dee0ded.camel@sipsolutions.net>
         <a50218b6-fc42-7f12-155a-5e01fc8dd1a0@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 08:59 -0700, Guenter Roeck wrote:
>=20
> So you are saying that anything running in a workqueue must not
> acquire rtnl_lock because cancel_[delayed_]work_sync() may be called
> under rtnl_lock.

No no, sorry if I wasn't clear. I mean this particular function / work
struct cannot acquire the RTNL because the cancel _for it_ is called
under RTNL.

It used to be that this was also tied to the entire workqueue, but this
is no longer true due to the way workqueues work these days.


> FWIW, it would be nice if the lockdep code would generate some other
> message in this situation. Complaining about a deadlock involving a
> lock that doesn't exist if lock debugging isn't enabled is not really
> helpful and, yes, may result in reporters to falsely assume that this
> lock is responsible for the potential deadlock.

Well, I don't know of any way to tell lockdep that, but I guess ideas
welcome? I mean, I'm not even sure what else it would tell you, other
than that you have a deadlock?

I mean, OK, I guess it's fair - it says "acquire lock" when it says

[    9.810406] ip/357 is trying to acquire lock:
[    9.810501] 83af6c40 ((work_completion)(&(&dev->state_queue)->work)){+.+=
.}-{0:0}, at: __flush_work+0x40/0x550

and it's not really a lock, but I'm not even sure how to phrase it
better? Note the scenario may be more complex than here.

I mean, perhaps we could add an optional message somehow and it could
say

"ip/357 is waiting for the work:"

but then we'd also have to update the scenario message to something like

[    9.813938]        CPU0                    CPU1
[    9.813999]        ----                    ----
[    9.814062]   lock(rtnl_mutex);
[    9.814139]                                run((work_completion)(&(&dev-=
>state_queue)->work));
[    9.814258]                                lock(rtnl_mutex);
[    9.814354]   wait((work_completion)(&(&dev->state_queue)->work));


which is really hard to do because how should lockdep know that the two
ways of "acquiring the lock" are actually different, and which one is
which? I'm not even convinced it could really do that.

In any case, I'd rather have a bug report from this than not, even if
it's not trivial to read.


... and here I thought we went through all of this 15+ years ago when I
added it in commit 4e6045f13478 ("workqueue: debug flushing deadlocks
with lockdep"), at which time the situation was actually worse because
you had to not only pay attention to the work struct, but also the
entire workqueue - which is today only true for ordered workqueues... Oh
well :)

johannes
