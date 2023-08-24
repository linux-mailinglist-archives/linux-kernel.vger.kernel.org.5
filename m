Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF478792A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbjHXUNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243443AbjHXUMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:12:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE681BF5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:12:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692907962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZR1rQxXBixoxsSPe6VXswNM3XPHkojfsxvQaD4S7OyY=;
        b=Y+zbm5i+W9wD1GIxwOTBDINKvd24QRfYh/JfBid/4BlAS5F3Hz5oZa516G8oy8zgz32Qr0
        qTngbnf11w9qdW4DkiaOk7uGUPpYeFh7GyCgluooStBnL0FXQS/QOoF2JKtkoR5lp41PDQ
        gXAedgdjRdngnfXNcoKVnRRQFE6nzKtg3Sg2kS6B8cq1icCzhEbJbN92RO0C8kAltpZrKU
        wUZFd+vZX/YQmmgJmWjryHA12jdeuYPcLT+71zaZSljuEQTzEzbv3M7mPdwU88tP65Dhg5
        oP1bzEds/J6jiG9ttKcZHV4tz46+a60jiJcvREkhcKhJHzhHpE5nUpdykH3v1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692907962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZR1rQxXBixoxsSPe6VXswNM3XPHkojfsxvQaD4S7OyY=;
        b=/McinkJ51DZk1XSHyrCMjsvktwhI0VQ3J7+Kwh4nhhOkKW3sMwyjd9RPPXRS5cxEENIpWG
        GPKoFffIju91WuCg==
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <20230814093621.23209-3-brgl@bgdev.pl>
References: <20230814093621.23209-1-brgl@bgdev.pl>
 <20230814093621.23209-3-brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 22:12:41 +0200
Message-ID: <875y54ci86.ffs@tglx>
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

On Mon, Aug 14 2023 at 11:36, Bartosz Golaszewski wrote:

Please read and follow the guidelines of the tip tree:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> When removing the proc entry for a desc that still has active users, we
> will leak the irqaction entries. Let's remove them in
> unregister_irq_proc().

How exactly is an interrupt descriptor freed which has still active
users?

If that happens then the procfs entry leak is the least of your worries.

Thanks,

        tglx


