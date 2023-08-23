Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356F47850F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjHWG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjHWG5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:57:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8171CDD;
        Tue, 22 Aug 2023 23:57:29 -0700 (PDT)
Date:   Wed, 23 Aug 2023 08:57:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692773847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwENDnUXusXaGXwfjjp9jYNee0+I/s+o/pwpgVQnDFc=;
        b=OJAMPZR6BqAi/T+N2Lc0k4RlOALHfOAbheDBp6DUFx1LOxs1lxAcPNNlT+W4+NsAXlOhz9
        Kz+ypRFKDHo2SkW5tN+v3TtKrYZt8cYRCkvHvgOgBK7rLBjKwm7S2VYnwDR+VapoVxet6m
        WXfo9K2ksVFym2R1Xb5R/F7kDBN+D/5UG3ww3GU6YNZN6KWz36O28sXkfmRShrZHy75Hc1
        ukbx9Cq+6zEbp+F9QGAb7CY/xztU+HpUKt3pOAlnjt5n1VXB2bps5J3MKMGx6uNsafzNEN
        tAEuZT/Ilkv6K54KXGcghVut4sqjv2r82TkbExhEkL/Zr1e7fFyqomtVPL5k8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692773847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwENDnUXusXaGXwfjjp9jYNee0+I/s+o/pwpgVQnDFc=;
        b=TV8+HqieS09mM7rvwiz3Kr2oZ3ZrGuVO+nmucIz7SQyxdwXEbqWOsHQpodDBUwR6Py3Y3Z
        wjU3csylDi5l4fBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230823065723.AsI2jjKp@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org>
 <20230817131612.M_wwTr7m@linutronix.de>
 <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
 <20230818145734.OgLYhPh1@linutronix.de>
 <20230818092111.5d86e351@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818092111.5d86e351@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-18 09:21:11 [-0700], Jakub Kicinski wrote:
> As tempting as code removal would be, we can still try to explore the
> option of letting backlog processing run in threads - as an opt-in on
> normal kernels and force it on RT?
> 
> But it would be good to wait ~2 weeks before moving forward, if you
> don't mind, various core folks keep taking vacations..

No problem.  Let me repost it then in two weeks as optional and not
mandatory.

Sebastian
