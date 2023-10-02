Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880647B4F3D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjJBJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbjJBJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:42:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE06CDA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:42:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696239747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPnnv8NF4g30xG3tk87h9Q8p6BwaDbVCgaLeYgFz0OI=;
        b=w3EenfYne6H6WoIYMJpkoPAeIbkdKzoKIRmBgb4UUwK5Nbfn3apeTZDcfcgm6GkY0pEius
        fwOv3I2KrywP1dreAU17SdaUPuQZXiMyVG7sO4KsKagQq54uDIjb/XusJo2Jd5i5EIAm3g
        Ipgh8+/uXTW7AyEOuQsT4M2QGdLP+N92EA4pVRDx8LbZnlRufCOghOcDe/4WUluzc+BKHJ
        CIkNJf58xiPpAx25+Y1jxt38PvL+S+eZ9GkJXR66dXPVugFfFPgnsvTNEqYKW5Dv3Nfz/8
        xfi3T/SGwUXgmNJvzW+jCT26erl4Q0ZTOeIQjfwO04dDhMcBQeZzh0Lp3xFC7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696239747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPnnv8NF4g30xG3tk87h9Q8p6BwaDbVCgaLeYgFz0OI=;
        b=1jrxwCQovaTCtKQ82V+MajqVGsfYg40FcHChtV1VTycaGX5ezc0zCuv/KejAO9DlZv5yLm
        iqYqScSqIUo4M8Dw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 29/30] x86/microcode: Prepare for minimal revision check
In-Reply-To: <20230928114733.GAZRVn1R4wvnS6AXIW@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.568284573@linutronix.de>
 <20230928114733.GAZRVn1R4wvnS6AXIW@fat_crate.local>
Date:   Mon, 02 Oct 2023 11:42:27 +0200
Message-ID: <8734yte4xo.ffs@tglx>
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

On Thu, Sep 28 2023 at 13:47, Borislav Petkov wrote:
> On Tue, Sep 12, 2023 at 09:58:30AM +0200, Thomas Gleixner wrote:
>> --- a/arch/x86/kernel/cpu/microcode/core.c
>> +++ b/arch/x86/kernel/cpu/microcode/core.c
>> @@ -46,6 +46,9 @@
>>  static struct microcode_ops	*microcode_ops;
>>  static bool dis_ucode_ldr = true;
>>  
>> +bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
>> +module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
>
> Yeah, it's not a module anymore.

module_param is not restricted to modules. You can utilize it for
builtin code too.

