Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585DB7AF058
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjIZQLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjIZQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:11:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C111D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:11:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695744689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/4oGwVhJJnS6YiS74XdOiw9OQ5nHz4MC1dAGWOI1f0=;
        b=GxQhBWHtaMLcgPONHZC928y7TDF3cOY1p/hMWfj26O0H0Vpa2G4UTkX1PlytFL5fejVIUO
        c33RUkIlXv3sl/GE6w+pgAhkcq8cAvqEOxN12ER/1412BWoiJo86n9zYRSsCSgLmgeULfp
        5tSY8aCxQwGPwO2+f65CvX7KeEbjuu/EzMiIPEywp84XhQHSTltYjq4I8f1DfETF5BrT3I
        f8BshNZMaljmCVDDMGpqTmD0rt3ZxVhOP6Jov85ObPKKs+796KsxOO+MpYJch0v6QOcbvk
        ng8TKXN2b1PxHBDII45pcQsHZeCFdUw9fYsIF6L9Gs7/iUm2sZgPBPxXDLf+0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695744689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/4oGwVhJJnS6YiS74XdOiw9OQ5nHz4MC1dAGWOI1f0=;
        b=oWLLBFgsRrRWtQ4IdWFYp96sLwSKU2NmK3BPhC5cshGGJZHrvmW22wKjE+53j1k9+BmLoP
        mGBR/O8AAJz7CxDg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 23/30] x86/microcode: Provide new control functions
In-Reply-To: <20230924065824.GNZQ/eEKAO8IaCcUJU@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.202675936@linutronix.de>
 <20230924065824.GNZQ/eEKAO8IaCcUJU@fat_crate.local>
Date:   Tue, 26 Sep 2023 11:42:20 +0200
Message-ID: <87pm25feyr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24 2023 at 08:58, Borislav Petkov wrote:
> On Tue, Sep 12, 2023 at 09:58:20AM +0200, Thomas Gleixner wrote:
>> +
>> +	ret = microcode_ops->apply_microcode(cpu);
>> +	this_cpu_write(ucode_ctrl.result, ret);
>> +	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
>
> Do that update...
>
>> +
>> +	/*
>> +	 * If the update was successful, let the siblings run the apply()
>> +	 * callback. If not, tell them it's done. This also covers the
>> +	 * case where the CPU has uniform loading at package or system
>> +	 * scope implemented but does not advertise it.
>> +	 */
>> +	if (ret == UCODE_UPDATED || ret == UCODE_OK)
>> +		ctrl = SCTRL_APPLY;
>> +	else
>> +		ctrl = SCTRL_DONE;
>
> ... here, after having checked ret.

No. That's two different things. The write above stores the information
fir the current CPU, while this conditional constructs the command for
the siblings. 
