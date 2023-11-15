Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACE07E10B4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjKDTNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKDTNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:13:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CAE184;
        Sat,  4 Nov 2023 12:13:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699125207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MJCihwPTy5OwZN2NTsf1hJfW4cndlqjv9l25lruXqKw=;
        b=YOlzPi1OQjXip78U4kukgs9z7VijKGU20xncuBg/RxHlSz675Gm3CggyE9xTDjoUkVlbRE
        N/1PzhG3/AwCNqL7uZh3R14Jz62geTGgkq/cpS6gXbl5wZO9ZtPGOeNbmjUYI9jDKMLOQ4
        x0sq/u45XmGuvm8/pvmllH5ugMcpHxyHsYDsYL/SwgzQwZ6K0p4LLUnRUp5AaTOl1gbvUX
        hyfPzR0/tpy3g+i+vP5NZZ4oIBgzxtbfKJyb7Loym5OUu2kZB/4+F9U/i2umGJt++mDlB4
        4NLWmJerDVryX5Ht4q9WtTgb0jsvwRq/vei9dUly3wN17ObPuySSTtzyf5Tp5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699125207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MJCihwPTy5OwZN2NTsf1hJfW4cndlqjv9l25lruXqKw=;
        b=9kWiki06mJPN5/FQqpV/mkXRpWL5jFTRyvL5i9qYAv72d2P2E1/NweXPn92zQ+H0y6Yf3l
        kfp3Tiq1hdn2N1Cw==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 1/3] x86/apic: Drop apic::delivery_mode
In-Reply-To: <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
 <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
Date:   Sat, 04 Nov 2023 20:13:26 +0100
Message-ID: <8734xljprd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2023 at 12:26, Andrew Cooper wrote:
> This field is set to APIC_DELIVERY_MODE_FIXED in all cases, and is read
> exactly once.  Fold the constant in uv_program_mmr() and drop the field.
>
> Searching for the origin of the stale HyperV comment reveals commit
> a31e58e129f7 ("x86/apic: Switch all APICs to Fixed delivery mode") which
> notes:
>
>   As a consequence of this change, the apic::irq_delivery_mode field is
>   now pointless, but this needs to be cleaned up in a separate patch.
>
> 6 years is long enough for this technical debt to have survived.

Guilty as charged. :)

Thanks for spotting this and cleaning it up!

       tglx


