Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1737BA803
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjJER3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjJER2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:28:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CBC46B6;
        Thu,  5 Oct 2023 10:25:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50325ce89e9so1668604e87.0;
        Thu, 05 Oct 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696526755; x=1697131555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwuh9qbI3t/i2L7CtvhDqNH2748w3jNlmQxfZg9+oss=;
        b=iGD/hVwvXkJLd3ctyvRTuUCpnRZylLmF/NgJYSeA6Ed6trJF5zUN1R12UBgeaZai3q
         1Sa1TkqYwlJfotPleLdQOlsG4G4XDvrDWDQjMV3pqAhfvxuj5YMYLhTAmfe1bUn0s2TA
         vs4drfqQvWCFXb6NQOAP/YsEuGpfMtySjALEZBAmxUp3dFHb4QiE0GmeAJIiBiaCb7sU
         aWmGueHyoB/3ohUChW7j4aWYPBOlBnnfDhwdyazvv7nVzeyxMvthPVc+20CvGtZV2evR
         yfxPOd/hmJwyrOVY7KudpVoZHYHAd5owL0Wr8mc+xNZmf3gwI9q5SRY4KoLEZafIqEme
         zt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526755; x=1697131555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vwuh9qbI3t/i2L7CtvhDqNH2748w3jNlmQxfZg9+oss=;
        b=DcqU7t4KBHCAF3PK/7ySBiC67K4LqBrydCm1qSqA/wvkUf0TPU5qCzYjBGni41Te7n
         vqINfjEqFpM2hgeIIQTfaD9ZFsR1cNybB7NQZN22nvv9YF4efhcwvDd9zdi8uNM2VUWN
         8wKsrxT/jgYskGiFOQysKgwnLyYtMRgkBNW1iEqLq9wUSvMgKJz8MvayTvbM6k2vox4y
         nqxdh+mbpWQFZx456Tq1NUPHyCWANPqqvQm0N8/KHEHAGLiHdTrtBBch5QAE6kRIewxJ
         cU4in3lkofzIZ6PtLtIJCvlL8/ZvGD9WeSL+x2MMPwOXYQNwWAHF3HcRliTY6Q5KJixC
         HHPg==
X-Gm-Message-State: AOJu0YxspntRDglaou6m1EYIxqrN6eAe3Ar5H0liwxuwP0Hd5RxND7Ou
        S132OjiTH8reUEkzPpdxi7xhk657dQBZBQ==
X-Google-Smtp-Source: AGHT+IGYNuEqpaEY81R6vdiIIQWLN+Pw4qUhgy0AUWwYAG9Gxss3b1GS1iu2gXgDWd8P2e5LlzOqnQ==
X-Received: by 2002:a05:6512:545:b0:4f8:71cc:2b6e with SMTP id h5-20020a056512054500b004f871cc2b6emr5173730lfl.33.1696526754397;
        Thu, 05 Oct 2023 10:25:54 -0700 (PDT)
Received: from pc.localnet (c-7e17235c.012-196-6c6b701.bbcust.telenor.se. [92.35.23.126])
        by smtp.gmail.com with ESMTPSA id y8-20020ac24468000000b00502e01d1383sm381238lfl.27.2023.10.05.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:25:53 -0700 (PDT)
From:   Henrik =?ISO-8859-1?Q?Lindstr=F6m?= <lindstrom515@gmail.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     Florian Westphal <fw@strlen.de>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: macvtap performs IP defragmentation,
 causing MTU problems for virtual machines
Date:   Thu, 05 Oct 2023 19:25:53 +0200
Message-ID: <3259970.44csPzL39Z@pc>
In-Reply-To: <20231004080037.GC15013@breakpoint.cc>
References: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
 <2197902.NgBsaNRSFp@pc> <20231004080037.GC15013@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On onsdag 4 oktober 2023 10:00:37 CEST Florian Westphal wrote:
> Can you submit this formally, with proper changelog and Signed-off-by?
> See scripts/checkpatch.pl in the kernel tree.
Sure, i can give it a shot. How do i properly credit you if i submit your
patch with some small changes of my own?

> You could also mention in changelog that this is ipv4 only because
> ipv6 already considers the interface index during reassembly.
Interesting. I've been trying to understand the code and it seems like
ipv6 does defragmentation per-interface, while ipv4 does it "per-vrf"
(correct me if i'm wrong). Is there any reason for this difference? 

I also did some more testing with the diff from my previous mail. It 
looks like the problem remains for interfaces under vrfs. I think simply
doing the bcast/mcast check first fixes that though, something like this:
	if (skb->pkt_type == PACKET_BROADCAST || skb->pkt_type == PACKET_MULTICAST) {
		if (dev)
			return dev->ifindex;
	}

	return l3mdev_master_ifindex_rcu(dev);
Does that look reasonable?
The idea being that bcast/mcast packets are always defragmented
per-interface, and unicast packets always "per-vrf".

Thanks,
Henrik


