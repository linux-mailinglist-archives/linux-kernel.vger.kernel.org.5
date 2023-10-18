Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881FB7CE4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjJRRiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjJRRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE57D48
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:37:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697650658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdORHOZKIIst7Qtd7c7OcYKZKJ7FX1GB6/yge3JzlJM=;
        b=Qt8PKnoZRQkppNeTu2PXqYTJGU3zOa2xwEzd9hU9UFSRJpi5LiltnWB22DZrA0tYTTuQGM
        uSevzKwA5g13RKLwCPqXNN005zB0+vH8Ae3OLmHIRStk8fgvGOa2+hvznqjeal7fa87S9K
        4nA4D/Mh1DqeBKe1nA+bLF6yfHVNzRHYALatnQuBgZhjbzOVTSQjnaoQ2JB+hMfz3iw3XW
        1kmn55GSab//8kykdHTtimR5h95aJIJX3zQPWFQ15mbj1mFTJCL+RhHg9JeEl+gGV267yT
        Cd5WGUBQfT4y6ZjPANJs9/mXzBuf3K8ldO8XrgopyWigjC2R6S2ercrXL4UH0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697650658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdORHOZKIIst7Qtd7c7OcYKZKJ7FX1GB6/yge3JzlJM=;
        b=2hTP6c8HwaDwOr5Swco7wDaNMNxorROnHJ9jRfE/dCNtPhIkrkir2vXeCB4gt3pial/+0m
        asaTHEWVn3dBJuCQ==
To:     Al Viro <viro@zeniv.linux.org.uk>,
        gus Gusenleitner Klaus <gus@keba.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] amd64: Fix csum_partial_copy_generic()
In-Reply-To: <20231018154205.GT800259@ZenIV>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
Date:   Wed, 18 Oct 2023 19:37:37 +0200
Message-ID: <87edhr4yse.ffs@tglx>
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

On Wed, Oct 18 2023 at 16:42, Al Viro wrote:

> On Wed, Oct 18, 2023 at 06:18:05AM +0000, gus Gusenleitner Klaus wrote:
>> The checksum calculation is wrong in case of an source buffer
>> containing zero bytes only. The expected return value is 0, the
>> actual return value is 0xfffffff.
>
> Expected where?  The actual checksum is defined modulo 0xffff, so
> 0 and 0xffffffff represent the same final value.

Duh. I really should have read the RFC first :)
