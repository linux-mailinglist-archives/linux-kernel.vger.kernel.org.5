Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168EE78742E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbjHXP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbjHXP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:28:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C8CEA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:28:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692890918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rW1Ud/mUS090ecR/OYxaHQ+CSWTkHEboFUgxXo5F4+8=;
        b=osHug8OyGLbmyzacCVLkZwtUQqpzLLxt2X2BXhkarvvoJ2HRlwtJ/4X9+PYG8+Qb5rTVcY
        +QIUvGZIGhqIxEAUk8maLHUOouIt1AAiBEWvbfXIbyOaOZmNEncAu+9Pfii2BamfC31Git
        PE9R2M2KZ2T3TdPsyg7B+3JEXE+ShbTm4jYhB5k+ns3phbkC9DD11qwEhl1Tk0WxvmOi6g
        JCn6zQYzUdHXxd4aim7xYtknjhsYuI8c+J/KLa4OiCCUwduunYmft1VVaSQY81PExcAKdv
        WWtaWNJIJRi4tAL2KjnSnQAX0S4jAADAYp84+LGmQZpfSiFxVoVNktdAxR1dsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692890918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rW1Ud/mUS090ecR/OYxaHQ+CSWTkHEboFUgxXo5F4+8=;
        b=G/NTb6Jpbhmf7YrsM6OeUYcC23VtSluNymGxCyXH66wE5t072Z8dbaKDXkzQ9n4nNtFojB
        p3pO5x3xa4G03bCg==
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org
Cc:     ssengar@linux.microsoft.com
Subject: Re: [PATCH] x86/numa: Add Devicetree support
In-Reply-To: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
References: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
Date:   Thu, 24 Aug 2023 17:28:37 +0200
Message-ID: <87edjscvdm.ffs@tglx>
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

On Tue, Jun 27 2023 at 00:28, Saurabh Sengar wrote:
> Hyper-V has usecases where it need to fetch NUMA information from
> Devicetree. Currently, it is not possible to extract the NUMA
> information from Devicetree for x86 arch.
>
> Add support for Devicetree in the x86_numa_init function, allowing
> the retrieval of NUMA node information from the Devicetree.
>
> Additionally, relocate the x86_dtb_init function before initmem_init
> to ensure the Devicetree initialization prior to its utilization in
> x86_numa_init.

Moving dtb_init() is not really a good idea. The APIC/IO-APIC
enumeration is post initmem_init() on purpose and the ongoing rework of
the topology evaluation relies on that.

What you really want is to split dtb_init() into two parts:

   1) x86_flattree_get_config() which can be invoked before initmem init
      like ACPI has an early init part so SRAT parsing can be done in
      the numa initialization.

   2) The APIC/IOAPIC registration part, which stays where it is.

This split wants to be a seperate change.

Thanks,

        tglx



   
