Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42B7E2A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjKFRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjKFRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:06:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5D7D4D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:06:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699290362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZ3oZu5FL3iDnulyvyRySUZ+OPqqpbFeLzlANOh/grc=;
        b=s52TttkOLnmZQGf7EPUklZuD0TXWk1gi1FMyXTNlJF/jgcfVkOveVLztrr9osQj5L7n3ml
        4fUJj6sFZjs0Fiw2O0DYChfLBs/mhNCM2u4rZeBU8Rw8SnZsaI7ckKMwr2geCPhAeSiwYd
        eGKmuUJ8k2/f5p4JtJ/X3ng/C5uN4VPrrCsMBtKiz+qlxMGf+SxMzLeKr/8DT9nPxj2MG0
        NzR87j5qU179UTyRhW60pdwz6aSyYidvOaASlB/+1Fk/BBDZfmkt/Zclyk0IxsZx789P8E
        I5w3vmmtU0wd3oFuH5757y8RkEaq+NN0AvK/A3L6xJi38645+ffVys8Y5Y5FLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699290362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZ3oZu5FL3iDnulyvyRySUZ+OPqqpbFeLzlANOh/grc=;
        b=RKv6GAwcsVU207jCbt5AH8f2VwnTBfhmN+igtJzZNO1st0+sbTaaE0gPIMzD3pNQCWJzSh
        su3nsfnmP0zq8KBQ==
To:     James Tai <james.tai@realtek.com>, linux-kernel@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/6] irqchip: Introduce RTD1319 support using the
 Realtek Common Interrupt Controller Driver
In-Reply-To: <20231102142731.2087245-4-james.tai@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
 <20231102142731.2087245-4-james.tai@realtek.com>
Date:   Mon, 06 Nov 2023 18:06:01 +0100
Message-ID: <87r0l2hkw6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2023 at 22:27, James Tai wrote:
> +
> +enum rtd1319_iso_isr_bits {
> +	RTD1319_ISO_ISR_TC3_SHIFT = 1,
> +	RTD1319_ISO_ISR_UR0_SHIFT = 2,

Please use tabular formatting all over the place.

> +	RTD1319_ISO_ISR_LSADC0_SHIFT = 3,
> +	RTD1319_ISO_ISR_IRDA_SHIFT = 5,
> +


> +static const struct realtek_intc_info rtd1319_intc_iso_info = {
> +	.isr_offset = 0x0,
> +	.umsk_isr_offset = 0x4,
> +	.scpu_int_en_offset = 0x40,

Magic numbers. Defines exist for a reason.

