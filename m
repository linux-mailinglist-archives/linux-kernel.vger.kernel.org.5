Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59E7C808E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjJMIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJMIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:44:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AF295
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:44:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697186677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6qpyrjbi7SsYiD/GpQvvHIHQLyirAzOlg8n3pTOmEk=;
        b=IurACFJEh1Gn/xu0XJv4/IFNjysOHweMt8otGY9WY59C0i9Wldcn+elUDbgsmQSQY7Gt+1
        8bH4G0dxEx16d0FJ04hmLd1+3CfZybUJewhH/759xPdgY4ODsp2hgdtUd39CkjajTdZEsZ
        xf2Lj8O20JuMbv399v3l3JqLPNzKy9csn3oRJSgjWE5qJHwInQGW+iN652T+ucK7XVeVq9
        mvCujDCSqlTwDkvCXBCYCRY7HZHMvWtDKW7aunDPhOYdq32w4uvYZkJzXCKFiufWIlHfib
        c0t3VlQywH8oh7356yYVlvfmafFFqGZFVf2K+6zKaYGXuQaISfQD9uMy9FSUOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697186677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6qpyrjbi7SsYiD/GpQvvHIHQLyirAzOlg8n3pTOmEk=;
        b=TW8qBpQC4spYJzqhJhViQ4PSDUZgP5v7HBk5ZD8rkPA1afEu7125z49QKj1/sQpv7Rbn9N
        /acLKmVlW6sBzEAQ==
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] genirq: avoid long loops in handle_edge_irq
In-Reply-To: <ZSf3KrAk8fpyNEZr@MacBook-Pro-3.local>
References: <20230928100638.42116-1-gongwei833x@gmail.com>
 <87r0m3q32t.ffs@tglx> <ZSf3KrAk8fpyNEZr@MacBook-Pro-3.local>
Date:   Fri, 13 Oct 2023 10:44:36 +0200
Message-ID: <877cnqlxmz.ffs@tglx>
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

On Thu, Oct 12 2023 at 21:39, Wei Gong wrote:
> O Mon, Oct 09, 2023 at 04:32:10PM +0200, Thomas Gleixner wrote:
>> Now $COND is not true due to the affinity change and the edge handler
>> returns. As a consequence nothing acks the device and no further
>> interrupts are sent by the device.
>> 
>> That might not be true for your case, but that's a generic function and the
>> zoo of hardware which uses that is massive.
>> 
>> So no, we are not taking a risk here.
>> 
>> Thanks,
>> 
>>         tglx
>> 
>>     
> By maintaining the original loop exit condition, if a mask mismatch is 
> detected within the loop, we will not perform the unmask_irq operation. 
> Instead, we will wait until the loop exits before executing unmask_irq.
> Could this approach potentially solve the issue of lost interrupts?

How so exactly?

