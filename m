Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08AC77C14C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHNUIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjHNUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38ED10E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C035616EA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED9AC433C7;
        Mon, 14 Aug 2023 20:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692043695;
        bh=my6PHpbJ1Nm3Ey57qu2YRyc6aZBGXa78nxO4Gzl8OMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKYIqOq+17joZ30QrtKHRtRNmtP50JlSZrN9R+Cp7s/MhWH3L2TDBgwx7YJniqCXg
         m+1swyswlITKkNooSAV4jUU2neWbfrFXGm3NwsI4DOO3gdyZFkLKktkWoHcHxsULIo
         eo0UNYaJNHL8NOW3v1CSdkCz8thz1k2DaHB5+Q01yLtxzJ90JmunUWlTofLQWZuiWk
         fuEJzojCBJbtsT8x62hVQTEyQwIlt5kLUxUtMJgRUOaVyVyKBENoelJDWvxo5/dYah
         PIjoE4F9nAenkF38Q5plFHda4xkDxZfG+ZF6KJDcobnANIdarYGzS66Fy8YGxoxKi/
         GiULPrvZmetzQ==
Date:   Mon, 14 Aug 2023 13:08:13 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Disable the mitigation on unaffected
 configurations
Message-ID: <20230814200813.p5czl47zssuej7nv@treble>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:39:11AM +0300, Nikolay Borisov wrote:
> 
> 
> On 13.08.23 г. 13:45 ч., Borislav Petkov wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> > 
> > Skip the srso cmd line parsing which is not needed on Zen1/2 with SMT
> > disabled and with the proper microcode applied (latter should be the
> > case anyway) as those are not affected.
> > 
> > Fixes: 5a15d8348881 ("x86/srso: Tie SBPB bit setting to microcode patch detection")
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > ---
> >   arch/x86/kernel/cpu/bugs.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index d02f73c5339d..8959a1b9fb80 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2418,8 +2418,10 @@ static void __init srso_select_mitigation(void)
> >   		 * IBPB microcode has been applied.
> >   		 */
> >   		if ((boot_cpu_data.x86 < 0x19) &&
> > -		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED)))
> > +		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
> >   			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
> > +			goto pred_cmd;
> 
> Actually can't you simply return, given that zen1/2 never have the SBPB flag
> set? Only zen3/4 with the updated microcode?

Tangentially, the 'cpu_smt_control == CPU_SMT_DISABLED' check is wrong,
as SMT could still get enabled at runtime and SRSO would be exposed.

Also is there a reason to re-use the hardware SRSO_NO bit rather than
clear the bug bit?  That seems cleaner, then you wouldn't need this
hack:

> > +	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
> > +		return sysfs_emit(buf, "Not affected\n");
> > +

-- 
Josh
