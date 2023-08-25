Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32057881AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbjHYILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243293AbjHYILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:11:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74FCEE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:11:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692951076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XJRtvpQEliy7UKqzC3hX33sKU743WXGH85rqgN6rrg=;
        b=HQroLTE9X+NMJQQXtGZS1CYBCkslr2P4F77QksA+mSsOY6G4qgtV2Qapno8Vsy/fBePAga
        sRA01UNRXptP1InWv0ndl36yMsaiDnMPA26LEFBbukOpDJv0hP4AO5l/5QukV0ifk05h/2
        c/fvt3WXgNAcfRQI+EDh3TYLLie2dIifxs638o9LW2bygqC3aAnSnD/esrOnKw3RA2Txwk
        vyFL4qFMMwvcVDyoqOmlM2dicc8Wwq7jpBT6lmLiwxVotBzHtjBNFsQNvdxNalZ7LqHZb8
        XTdqdJp2MXkZ7+gv04mBdBARgy6b6msIcbxhYOMWIXf2U/HVO56Qr4FK4cbCyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692951076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XJRtvpQEliy7UKqzC3hX33sKU743WXGH85rqgN6rrg=;
        b=Rl5HL2bcqIMq9yIxK7Hi7WIugEQnzkVy8Y2NKir61qJ+nQWogXQ55jdVs57BJYg5TnHgPi
        LpvHnH6+u1DN1vBA==
To:     brgl@bgdev.pl
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
References: <20230814093621.23209-1-brgl@bgdev.pl>
 <20230814093621.23209-3-brgl@bgdev.pl> <875y54ci86.ffs@tglx>
 <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
Date:   Fri, 25 Aug 2023 10:11:16 +0200
Message-ID: <873507cziz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25 2023 at 00:36, brgl@bgdev.pl wrote:
> On Thu, 24 Aug 2023 22:12:41 +0200, Thomas Gleixner <tglx@linutronix.de> said:
> Here a GPIO device - that is also an irq chip - is unbound (this is a testing
> module unbound during a test-case but it can be anything else, like an I2C
> expander for which the driver is unloaded) while some users called
> request_irq() on its interrupts (this is orthogonal to gpiod_get() and doesn't
> take a reference to the module, so nothing is stopping us from
> unloading it)

You just described the real problem in this sentence. So why are you
trying to cure a symptom?

Thanks,

        tglx


