Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090FA7C73B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379555AbjJLRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344085AbjJLRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:05:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386BFB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:05:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF44C433C8;
        Thu, 12 Oct 2023 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697130350;
        bh=qoB/kNnsksIOBWuSeqG2ewxVesEUJ5BMIGU22oh6agA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6u+XazX43tSdnEm8nhbDaCxcFioSoyj8ZzXQ9rVMX3nLFbAFcFf/q2uTtuTJ0gMT
         ODMxVo2cGyJ/aUKQwSCbjN/aRRT3/BGfp3EmwXhLSv0QZmgv/aOnTUopmO7ONnY8GB
         h3tqpP09ySx5dUtApAr0vDj3QKMHFYPlSh2ULw4YoUNBS/dmVPhmF14fnOjS4dany5
         Yflp7OB87Aa5hFpR9WxPiMnX9wI8Ebqj15n65UW47RrtAs5FWixf25smfpHbLWn8jw
         0CCaj/8n15jWg+WH6yynDnhLRXgM0gZo8K3BFo3FUJ4kLv7kclB5FDSdWxxKQChpbk
         EmjvCBVtvgm0Q==
Date:   Thu, 12 Oct 2023 10:05:48 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231012170548.o5vi4kgpvpjyld7s@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
 <ZSfucR6docdnLznb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSfucR6docdnLznb@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 06:02:41AM -0700, Breno Leitao wrote:
> > Yeah, so this #ifdeffery is unnecessarily ugly - we can actually assign 
> > integer values in the Kconfig language and use that for initialization.
> > 
> > Is there a reason why we wouldn't want to do something like:
> > 
> > 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED;
> > 
> > ... or so?
> 
> Yes. There are two reasons rigth now:
> 
> 1) How to avoid the "undefined" behaviour when
> CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED is not defined ? Something as:
> 
>  error: ‘CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED’ undeclared (first use in this function)
> 
> 2) Right now, these _cmd values are all different by default. Here are a few
> examples when the kernel is compiled with the mitigations:
> 
>  retbleed_cmd = RETBLEED_CMD_AUTO (1)
>  spectre_v2_mitigation_cmd = SPECTRE_V2_CMD_AUTO (1)
>  ssb_mitigation_cmd = SPEC_STORE_BYPASS_CMD_AUTO (1)
>  l1tf_mitigation = L1TF_MITIGATION_FLUSH(2)
>  mds_mitigation =  MDS_MITIGATION_FULL(1)
>  taa_mitigation = TAA_MITIGATION_VERW (2)
>  mmio_mitigation = MMIO_MITIGATION_VERW (2)
>  gds_mitigation =  GDS_MITIGATION_FULL (3)
> 
> If there is a solution for 1, then I _think_ we can probably reorder the
> enums, so, the "AUTO" value is always 1?!

I'd rather avoid hard-coding enums as that adds fragility into the mix.

Another way to avoid ifdeffery:

static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;

> > 3)
> > 
> > And yes, now that the rush of CPU vulnerabilities seems to be ebbing, we 
> > should probably consider unifying the existing hodgepodge of mitigation 
> > Kconfig options as well, to not build up even more technical debt.
> 
> What do you mean by unifying the existing hodgepodge of mitigation
> Kconfigs? If you are implying to just have fewer config options, I think
> that is the opposite of what Linus has suggested previously:
> 
> https://lore.kernel.org/all/CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com/

I read that as Ingo agreeing with me that we should rename all the
existing options for consistency.

> > 4)
> > 
> > Fourth, I think we should inform users (in the boot log) when a kernel 
> > .config changes a mitigation default value compared from what the upstream 
> > kernel thinks is a suitable default.
> > 
> > Sometimes it can be a simple configuration mistake, or a user might have 
> > different opinion about the importance of a particular mitigation. Nothing 
> > heavy-handed, just a simple pr_info() table of changes?
> 
> That could be done, but, right now messages are printed in regard to the
> mitigations. Aren't these enough?
> 
> Here are some examples:
> 
>   pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
>   pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
>   pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
>   pr_info("MMIO Stale Data: Unknown: No mitigations\n");
>   pr_info("%s\n", srbds_strings[srbds_mitigation]);
>   pr_info("%s\n", gds_strings[gds_mitigation]);
>   pr_info("%s\n", spectre_v1_strings[spectre_v1_mitigation]);
>   pr_info("%s\n", spectre_v2_user_strings[mode]);
>   pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
>   pr_info("%s\n", ssb_strings[ssb_mode]);

But notice many/most of those functions exit early if the mitigation is
turned off, thereby skipping the pr_info().  It might be a matter of
just tweaking the print behavior and making it consistent across all the
mitigations.

-- 
Josh
