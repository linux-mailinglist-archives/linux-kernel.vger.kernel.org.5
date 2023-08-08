Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26977483B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjHHT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjHHT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:28:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53A62D07
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:55:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691520915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jk/7O+KQ8PabwPvLbA1rFu4Gg/yku8mgTP5GC7VSBN4=;
        b=kioYb7IrEe6W/xySAiJPXqnt7NcAsAc4sBQocV6Impf4P5wYMx7Mhde2rhJqiqS3DUP41U
        fO2o+Z2cHmpmAqKnwg3d4QqqAjw+3/+IF3qHIXE86qlgFb5pZTne4LhQipFsCjQX7WKkNU
        45b+mkGuraxLZYNvIvxOr4PS2M5vKHdZanm7rjYNzlahBoeKF90Qpjj8N+ne6o+da2ctd+
        y/3pjGNbH0mF1BNU4m5QoR0DLMfqtKKvJT1F2Ke1Awkq29uqppvSGdCHBbnk68x8KXl0vM
        hBZusVXniqSjWxYdxVufgqdluCUXDAJ5cYTx35u1QEa/9aeyXZioD0evPXzOOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691520915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jk/7O+KQ8PabwPvLbA1rFu4Gg/yku8mgTP5GC7VSBN4=;
        b=TnxQGSKzznGVYxYQU3UZ7DbZW7P1aGh51eWqQg1hgFlv9wqIwRjQksD49eQ2B+VAIFt0rr
        m6N2MwoCjwgpbNCA==
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     andrew.cooper3@citrix.com, arjan@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        pbonzini@redhat.com, peter@keresztesschmidt.de,
        peterz@infradead.org, thomas.lendacky@amd.com, wei.liu@kernel.org,
        x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch V3 45/60] x86/apic: Sanitize APID ID range validation
In-Reply-To: <20230808133407.10901-1-qiuxu.zhuo@intel.com>
References: <20230801103817.624346203@linutronix.de>
 <20230808133407.10901-1-qiuxu.zhuo@intel.com>
Date:   Tue, 08 Aug 2023 20:55:15 +0200
Message-ID: <87msz1l5yk.ffs@tglx>
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

On Tue, Aug 08 2023 at 21:34, Qiuxu Zhuo wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> ...
>> Subject: [patch V3 45/60] x86/apic: Sanitize APID ID range validation
>> Now that everything has apic::max_apic_id set and the eventual update for
>> the x2APIC case is in place, switch the apic_id_valid() helper to use
>> apic::max_apic_id and remove the apic::apic_id_valid() callback.
>> 
>
> This patch removes default_apic_id_valid() and all references to it.
> So may also need to remove the useless declaration of
> "extern int default_apic_id_valid(u32 apicid)"
> from arch/x86/include/asm/apic.h?

Yes. Seems I missed that.
