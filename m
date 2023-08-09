Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1E775412
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjHIH1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjHIH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61F21BFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0df22T3q5S+wbDzDb9AuwCbUzUEW5/RXUQzh/Xw92mw=; b=AoNLHpfoAA3auVrHf+bkjugOwB
        HVy35wfIUOKK6UGj9e9yyfE1vujCiot7a2TxmyNw+HNM579jY0OQlB3xtXi8i0aVhmk2qzbXEqDjG
        o1YuYU8jNuStcizJuL9U0yqFgnS5+m0Wbq4RnRmcZpKYOTrZvoNQ3jHYxjvaZR2COmE8CQxwBUQE7
        YYkTAkIG5rsS8+2IoTHGkUQAPZzWhsdYsqSazO1pNbLGs0L8BcNuzIp217tzELOtdoHoGTAKnZDUP
        IceFrFgS06xW4Rp82Rtz7sYK/kNhYZ6majElpg8IocrtYDhJwn56rEEtbMNk21i48zxiAGDwX4yIp
        aQpYL76A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTdae-005TeI-2p;
        Wed, 09 Aug 2023 07:26:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D9F630014A;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 394AC201A5786; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809071218.000335006@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 00/17] Fix up the recent SRSO patches
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I wasn't invited to the party (even though I did retbleed), I get to
clean things up afterwards :/

Anyway, this here overhauls the SRSO patches in a big way.

I claim that AMD retbleed (also called Speculative-Type-Confusion -- not to be
confused with Intel retbleed, which is an entirely different bug) is
fundamentally the same as this SRSO -- which is also caused by STC. And the
mitigations are so similar they should all be controlled from a single spot and
not conflated like they are now.

As such, at the end of the ride the new kernel command line and srso sysfs
files are no more and all we're left with is a few extra retbleed options.

Aside of that; this deals with a few implementation issues -- but not all known
issues. Josh and Andrew are telling me there's a problem when running inside
virt due to how this checks the microcode. I'm hoping either of those two gents
will add a patch to address this.



