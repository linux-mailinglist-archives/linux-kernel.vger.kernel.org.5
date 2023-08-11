Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E89C7795E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjHKRLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjHKRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:11:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E3E54
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:11:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691773893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDdKdMKL7tDxHSjL9MEk9YTNW87Ut5Y78YgFu+JcYYg=;
        b=c08XpJTed6NQHYAMkzbpNB+KrTCGbyOwtzp9X649w5pUYDbwLS416g62XL/43gJHlwgyPT
        +4Rdyr0BBbEsUwXyMCntN2Yb1e53Yrh9p/dqhW6A6TRhPi8fD7QM7md8RvGlQ9agAuihZ2
        Im93AamGRo01DllSsJtIFn7vyw8Jfgp/Kp+46sLl6M2ROPA+mlvvLaUgSk5L+4yB/fZX96
        Q5Db1tBUAykKE1TzCZSrwbkjIjx3+hD7XWtGhzEHhJic6ESwQWY2sAkidslVUZap1Szc1U
        q1msdefcpeHbCVrbg/8SW3/PUHHDsA1EXTOoTIW8eS1LXKIjx+r+oZGGhw3c3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691773893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDdKdMKL7tDxHSjL9MEk9YTNW87Ut5Y78YgFu+JcYYg=;
        b=UtnkchQfVyOsQA+UVVWJZ3/LKRl1c7xZG3QGkv3n7PTJKV2uoAcdZYsFH7TEWI5mItp6Ne
        t+F3k8fiAEBjByCA==
To:     Pu Wen <pu_wen@foxmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V3 33/40] x86/cpu: Use common topology code for HYGON
In-Reply-To: <tencent_57C27F10612C62EDE4FEBAA942F8538BA305@qq.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.585648729@linutronix.de>
 <tencent_57C27F10612C62EDE4FEBAA942F8538BA305@qq.com>
Date:   Fri, 11 Aug 2023 19:11:33 +0200
Message-ID: <87h6p5h5bu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11 2023 at 21:00, Pu Wen wrote:
> On 2023/8/2 18:21, Thomas Gleixner wrote:
>> --- a/arch/x86/kernel/cpu/hygon.c
>> +++ b/arch/x86/kernel/cpu/hygon.c
>> @@ -20,12 +20,6 @@
>>   
>>   #define APICID_SOCKET_ID_BIT 6
>
> The macro should be removed, since it's no needed any more.

Indeed.
