Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19877F0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbjHQGwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348319AbjHQGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:52:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D72102;
        Wed, 16 Aug 2023 23:52:15 -0700 (PDT)
Date:   Thu, 17 Aug 2023 08:52:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692255133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6HGqXEI6+kkXONW2Fb2KoG1iVUbBSrioJF3EbDG7tE=;
        b=CIwZsCHYaj/8QAzvV3U8EsooaPHCKnhTWfJh8ZIBK0Nf0pHgbTyeEvD4rUaVLtIQcQuURq
        024/5gHsrZSbUB50tzzllorJnXbtq4WS6mll5Toco4SQ3zm+eiAxAF2R6CKaeTruEscpZR
        oU9qQ5IRSqSwV+cwEVApQInC8kFEhlpJ45XkR1PEoxoM1tsbcDuW2k+q83Bb3Pb1Y9tZ0D
        TxmJ/aLhAFnDQURGqa4U56wrNOIkIWrTVhd3zLXZoZYnYyBP78eLaL8SoG0x5bmUgGAKLm
        ZfbKlzJRbWnt4JS2WR/l8Kyfn2rWZjMdgfeb1lu4oEaj66iDLPQ6O8FyOZZaBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692255133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6HGqXEI6+kkXONW2Fb2KoG1iVUbBSrioJF3EbDG7tE=;
        b=qyiQhIx09SVXTUctmvjhLVNTzYKrsZ5u9HQ6CxLAqSO2NphDFyU1brdhNduUBPuleLv6f0
        /23IYZV5tJQI/KBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        dave@stgolabs.net, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] scsi: fcoe: Fix potential deadlock on
 &fip->ctlr_lock
Message-ID: <20230817065211.ajz8zcev@linutronix.de>
References: <20230816155524.5913-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816155524.5913-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 15:55:24 [+0000], Chengfeng Ye wrote:
> These flaws were found by an experimental static analysis tool I am
> developing for irq-related deadlock.

So you did not use lockdep or is the code path so unlikely that nobody
stumbled upon it before?

> The patch fix the potential deadlocks by spin_lock_irqsave() to
> disable hard irq.

Shouldn't this have

Fixes: 794d98e77f590 ("[SCSI] libfcoe: retry rejected FLOGI to another FCF if possible")

?

> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
