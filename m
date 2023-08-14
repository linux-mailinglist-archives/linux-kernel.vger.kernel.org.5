Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6A77BFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjHNSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjHNSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAEB0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 463786436B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4621FC433C8;
        Mon, 14 Aug 2023 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692037462;
        bh=mTsh7sEfcY4Xi6rqdzYQ2cR/F9LjcZ/p4SiMZsPCS6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLK/rc3Url0zWUdgLDCCDxZ4ECT2Q1IbZ2RAqHOxGpPW8T2x6d8t9s0JwyHngNoem
         7UOdSNe5W6eCl2iloAwQgxIS3i5/LSjEuAjVzwvxuFSzXlpZW2eCYrp/RA5N0WZ5Df
         uOPMnGPWWEodskE/GQCKoXPwcPJA8jlIixWWG409LfX5IJPIGNEnpNtXCtsiVDDCjY
         Xv4VrJ5qt+fAAns6JDscC/GidtXYH2kXPXQMI2T8TuYKXLx8694FhZylhhtr4bH2Fy
         iokx4Y3ctDfBmVee65Bhdud84ikHNGNmxjgBcdvnXeB17WJv6UBZcJHjGn+OcGQEVf
         CMBXgSOJu9WcQ==
Date:   Mon, 14 Aug 2023 11:24:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230814112421.5a2fa4f6@kernel.org>
In-Reply-To: <20230814093528.117342-1-bigeasy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 11:35:26 +0200 Sebastian Andrzej Siewior wrote:
> The RPS code and "deferred skb free" both send IPI/ function call
> to a remote CPU in which a softirq is raised. This leads to a warning on
> PREEMPT_RT because raising softiqrs from function call led to undesired
> behaviour in the past. I had duct tape in RT for the "deferred skb free"
> and Wander Lairson Costa reported the RPS case.

Could you find a less invasive solution?
backlog is used by veth == most containerized environments.
This change has a very high risk of regression for a lot of people.
