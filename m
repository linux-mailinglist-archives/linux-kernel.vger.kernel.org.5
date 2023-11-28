Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A07FC43C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376316AbjK1TZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345355AbjK1TZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:25:36 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74F7D66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701199540;
        bh=HL/CGZhmPlcfwhxS6h/5muHzHjE+rCyLtoaXJR1cAb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUruDslYbG90Sh/mmWWflfZn689jhEl5CIH8VGmZJLPlfvSAA+dHVXjeOsldRrYSV
         geom4+RamjxS44oPu/L9pHxroNWPpHl/8xTEkGfkrjvuRDsb+0cLxgLDExWYimoPhS
         Jm2ZDG+8KA8k7Zv9mqJlXvef9ONGaaT5gVvJ67R4=
Date:   Tue, 28 Nov 2023 20:25:40 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Update power flags
Message-ID: <15ea49d1-5c6e-4459-8ef1-4bca573b8b93@t-8ch.de>
References: <20231128-powerflags-v1-1-87e8fe020a3d@weissschuh.net>
 <20231128191217.GDZWY7kYC9bE9Qkg25@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128191217.GDZWY7kYC9bE9Qkg25@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-28 20:12:17+0100, Borislav Petkov wrote:
> On Tue, Nov 28, 2023 at 07:54:54PM +0100, Thomas Weißschuh wrote:
> > As described on page 99 of
> > "Processing Programming Reference (PPR) for AMD Family 19h Model 61h, Revision B1 Processor".
> > (AMD Documentation Hub Document 56713)
> > 
> > Tested on an "AMD Ryzen 7 7840U w/ Radeon  780M Graphics".
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  arch/x86/kernel/cpu/powerflags.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/powerflags.c b/arch/x86/kernel/cpu/powerflags.c
> > index fd6ec2aa0303..0c98405aeae2 100644
> > --- a/arch/x86/kernel/cpu/powerflags.c
> > +++ b/arch/x86/kernel/cpu/powerflags.c
> > @@ -21,4 +21,7 @@ const char *const x86_power_flags[32] = {
> >  	"eff_freq_ro", /* Readonly aperf/mperf */
> >  	"proc_feedback", /* processor feedback interface */
> >  	"acc_power", /* accumulated power mechanism */
> > +	"connected_standby", /* connected standby */
> > +	"rapl", /* running average power limit */
> > +	"fast_cppc", /* fast collaborative processor performance control */
> 
> No need.
> 
> The beginning of Documentation/arch/x86/cpuinfo.rst tries to explain
> why.

Isn't this introduction more about the cpuinfo "flags" fields?
These power management flags have their own field "power management".

Without the patch it looks like this on my machine in cpuinfo:

  power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14] [15]

So they are already reported, but only their numeric value.

Anyways, if it's not correct to have them then let's drop the patch.


Thomas
