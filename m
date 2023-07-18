Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA875877E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGRVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGRVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:51:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBF5198C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:51:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689717095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9pKuYAJnQI1hbwUroVnwIojvttVffbZ4lo9CxGjqX4=;
        b=3dzsziTi/LGQGjrwWeplP+FOR6Qw23ez+R0Srj8QSR+mlAajeQj1cTWuXtOn+SSCmdnb1M
        fXcLMoaQZ1JsSFqITd02zoqD5+654hmd51NEb0098CSNqdeV8X5TEFzYiuoPxFgRUC5Ub4
        L2BnliOMvu5JVYok4hlh1CrpJhQKgJszmChvGCb4S+oQHkQ3x+5ZqCb9bkEJ//1/jUrLV+
        reaG49HTfECkF9ZBnQVFaoL10WqpUUY6eM241q7byfqs7lFf3KecVZD+iQRIya4UkKim5S
        pkWz9bOj4rerYkolwI8R3TKzNPl6ezYo/H9nA/voiQ6E6ZOHoGsuuhi2CZWP4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689717095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9pKuYAJnQI1hbwUroVnwIojvttVffbZ4lo9CxGjqX4=;
        b=fsid/AHyNDWDEQDjZ5elWBxQC091z9jKMNTaEzZnGTFhNHn13ndoRGhEBncyve037y65Yg
        0j0ssjyYXQ+0ZKAw==
To:     Peter Keresztes Schmidt <peter@keresztesschmidt.de>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 50/58] x86/apic: Provide common init infrastructure
In-Reply-To: <ffc889de-3181-791e-f985-ce461b992bfc@keresztesschmidt.de>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.058365439@linutronix.de>
 <ffc889de-3181-791e-f985-ce461b992bfc@keresztesschmidt.de>
Date:   Tue, 18 Jul 2023 23:51:34 +0200
Message-ID: <87zg3sx509.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18 2023 at 23:29, Peter Keresztes Schmidt wrote:

> Hi Thomas!
>
> On 18.07.23 01:15, Thomas Gleixner wrote:
>> --- a/arch/x86/kernel/apic/bigsmp_32.c
>> +++ b/arch/x86/kernel/apic/bigsmp_32.c
>> @@ -119,10 +119,8 @@ bool __init apic_bigsmp_possible(bool cm
>>  
>>  void __init apic_bigsmp_force(void)
>>  {
>> -	if (apic != &apic_bigsmp) {
>> -		apic = &apic_bigsmp;
>> -		pr_info("Overriding APIC driver with bigsmp\n");
>> -	}
>> +	if (apic != &apic_bigsmp)
>> +		apic_install_driver(&apic_noop);
>
> Could apic_noop be a typo? Shouldn't it be apic_bigsmp?

Indeed. Good catch!

Thanks,

        tglx
