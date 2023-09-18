Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D37A50B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjIRRNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjIRRM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:12:58 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08140B6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:12:49 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB85640E00F4;
        Mon, 18 Sep 2023 17:12:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S_UsqsTXJ-MG; Mon, 18 Sep 2023 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695057165; bh=YI3I1QxOIrQjiyjqRgir31veHbJdJ0FWupmJqtauMmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0LE1gqORf/+0ZhdGOFNWLEf79QlZWiyTyBzyNZn2zVHfBgflX0ZLiiSyRPnjvq6e
         WGYzdXMDN1FJYecevJEaqttwCdVMiA5zy7lNK/jeK9W1e6bumvKnsUFPbRhZ2mFlDe
         L2XeGG2RiapiCEPHMlqatxocIopAhV2tBAiXMkm8gBoRqXq+8IYJzhb4d+Z7nGF+Lx
         MZZT11R/85n5ogmiGQE6vSzFqJLxb5R21vocJT/acxV9hxwuOfXiBntsJ2DC0GoCBU
         opURzWFiN9q9lvE86zUSHNywLhGnQyl+1JIg1uQMdTKnLdS1s+5sMqjUxAaWVj9Rsw
         M6tJp+bT0X1U8c7WK5em0qnO9/tatFcRbAWwegkRfQo/nbphgyKxy1s1jXU+EUtTLB
         5TZEoST8XtpkDcYdPNPzZ2IZ/ttf34aVG1tpyeJClVdikGET5y+DZoBt5R/Q1oDeYM
         zARuG98s5JYAHHjslFXTf19Evcbr6r4veqc7rbwjD6bU9Aa3p/E49l16m8q98vXkH8
         YzgQkfs85xlXzraC6R5x+fnYRfJc51uKm/MZQPPpUMe0NjCXlEmscirUjtoXWofJUB
         GPzxV7T+KPOEeBFZEaqmAHlUr76UeZGQl82g9GphZW2vfc36v8yvybIuS3JOHU+tcV
         ny84ftHSDrQiHiB3q49BnefE=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD62C40E01A3;
        Mon, 18 Sep 2023 17:12:39 +0000 (UTC)
Date:   Mon, 18 Sep 2023 19:12:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 02/30] x86/boot/32: Disable stackprotector and tracing
 for mk_early_pgtbl_32()
Message-ID: <20230918171238.GAZQiFBkcW5W6odCCg@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065500.886599632@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065500.886599632@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:57:46AM +0200, Thomas Gleixner wrote:
> Remove function tracing from the whole source file as there is no way to
> trace this at all, but in case of CONFIG_DYNAMIC_FTRACE=n
> mk_early_pgtbl_32() would access global function tracer variables in
> physcial address mode which again might work by chance.

Unknown word [physcial] in commit message.
Suggestions: ['physical'

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
