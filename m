Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D767C762B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442021AbjJLSvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbjJLSvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:51:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A783
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:51:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4066241289bso13933845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697136688; x=1697741488; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ahmdd2XFDD/bHfs3mS/qHzV4nCgTn7SsexJm11yVJWM=;
        b=UWxArW7ZLB5GsvYhkDbFlyiKuZCMo3P3uWng3onWA5Ur1AfU3l9qZecSg03s1X/mTZ
         O5GP2ZCMdpyFLUUemzzt6pubjsS60juTOqotccalaU8u2Y635hn4mrkcZ9E/9V1Ezws5
         4K0KYGFHyA0kQIaeIb3ABWMM3Oku4lm7DMQ7g31d3N4aozHIrUxZJRp+caYgmNGOH7VJ
         hEym4Z8xmpTMysOIRAhSlc2vaDXtYaVGCf5ZWkLPJ+M7zxSXngMhDv019YzyLcwRfgGt
         k69r0JGj+ciAQyrSO/QtkaKyy2/O4VE7V2HRSkrKzmLOHZ28wWuAkNXBkhzupr201Q7W
         PkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697136688; x=1697741488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ahmdd2XFDD/bHfs3mS/qHzV4nCgTn7SsexJm11yVJWM=;
        b=q/PJhId2EFPmo7vFuH1YtSq2sBfNQhrjjOKL19hhL+WtvK2hW/5ZBCAaJJ+Cr8psjj
         kAIFxL1JgV8tHR1r9yIZWg6Vm5SF5L+U7sdUD1zzETEBrjt/t9XBJ+DgBuMbSxJE77cA
         SEXSfdFoCWNFmF7NY/3C6hss+QOTtcY6GKOeYPLBWf9jw9HNMhi6veZdHlMjdF6fw9Jc
         QB+180mXvic0A9qYQhMUMZ7FVSQ2cTUQN7Imn7JwAJIjWTt3x7YCkoRtDdKtlArWRo1z
         T01jhtRSMeQjBuOXId9Vv+UNGUzSYcXlm8Fmbx3e2ZFk0dkAtOdHcOaTh2jg+NwIbYik
         KAJA==
X-Gm-Message-State: AOJu0Yx5lP034LOYiylCq8rcieo7SUoAqMrqvbRFPlleWcjKJpTPu40H
        OX2RVolpZeauriTcigSRbMU=
X-Google-Smtp-Source: AGHT+IHEq18okvfZCN33N+PVTyaCiUf/LhOcGwLFnve7qz6ofhBGIU6eWWApWeWY4NkDDb4mV81LLw==
X-Received: by 2002:adf:e187:0:b0:32d:89ca:1761 with SMTP id az7-20020adfe187000000b0032d89ca1761mr4309278wrb.43.1697136687939;
        Thu, 12 Oct 2023 11:51:27 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm4777440wra.37.2023.10.12.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 11:51:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 20:51:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZShALJDaxJ9VJvek@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
 <ZSfucR6docdnLznb@gmail.com>
 <20231012170548.o5vi4kgpvpjyld7s@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012170548.o5vi4kgpvpjyld7s@treble>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Thu, Oct 12, 2023 at 06:02:41AM -0700, Breno Leitao wrote:
> > > Yeah, so this #ifdeffery is unnecessarily ugly - we can actually assign 
> > > integer values in the Kconfig language and use that for initialization.
> > > 
> > > Is there a reason why we wouldn't want to do something like:
> > > 
> > > 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED;
> > > 
> > > ... or so?
> > 
> > Yes. There are two reasons rigth now:
> > 
> > 1) How to avoid the "undefined" behaviour when
> > CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED is not defined ? Something as:
> > 
> >  error: ‘CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED’ undeclared (first use in this function)
> > 
> > 2) Right now, these _cmd values are all different by default. Here are a few
> > examples when the kernel is compiled with the mitigations:
> > 
> >  retbleed_cmd = RETBLEED_CMD_AUTO (1)
> >  spectre_v2_mitigation_cmd = SPECTRE_V2_CMD_AUTO (1)
> >  ssb_mitigation_cmd = SPEC_STORE_BYPASS_CMD_AUTO (1)
> >  l1tf_mitigation = L1TF_MITIGATION_FLUSH(2)
> >  mds_mitigation =  MDS_MITIGATION_FULL(1)
> >  taa_mitigation = TAA_MITIGATION_VERW (2)
> >  mmio_mitigation = MMIO_MITIGATION_VERW (2)
> >  gds_mitigation =  GDS_MITIGATION_FULL (3)
> > 
> > If there is a solution for 1, then I _think_ we can probably reorder the
> > enums, so, the "AUTO" value is always 1?!
> 
> I'd rather avoid hard-coding enums as that adds fragility into the mix.
> 
> Another way to avoid ifdeffery:
> 
> static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> 	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;

I think we could make it a simple:

	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = IS_ENABLED(CONFIG_MITIGATION_RETBLEED);

Because RETBLEED_CMD_AUTO && RETBLEED_CMD_OFF maps naturally to 1 and 0. 
Maybe add a comment to the enum to maintain this property in the future 
too.

> > > 3)
> > > 
> > > And yes, now that the rush of CPU vulnerabilities seems to be ebbing, we 
> > > should probably consider unifying the existing hodgepodge of mitigation 
> > > Kconfig options as well, to not build up even more technical debt.
> > 
> > What do you mean by unifying the existing hodgepodge of mitigation
> > Kconfigs? If you are implying to just have fewer config options, I think
> > that is the opposite of what Linus has suggested previously:
> > 
> > https://lore.kernel.org/all/CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com/
> 
> I read that as Ingo agreeing with me that we should rename all the
> existing options for consistency.

Yeah, and this is doubly important for security features: inconsistency 
invites misunderstandings & bugs ...

> > > Sometimes it can be a simple configuration mistake, or a user might have 
> > > different opinion about the importance of a particular mitigation. Nothing 
> > > heavy-handed, just a simple pr_info() table of changes?
> > 
> > That could be done, but, right now messages are printed in regard to the
> > mitigations. Aren't these enough?
> > 
> > Here are some examples:
> > 
> >   pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
> >   pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
> >   pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
> >   pr_info("MMIO Stale Data: Unknown: No mitigations\n");
> >   pr_info("%s\n", srbds_strings[srbds_mitigation]);
> >   pr_info("%s\n", gds_strings[gds_mitigation]);
> >   pr_info("%s\n", spectre_v1_strings[spectre_v1_mitigation]);
> >   pr_info("%s\n", spectre_v2_user_strings[mode]);
> >   pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
> >   pr_info("%s\n", ssb_strings[ssb_mode]);
> 
> But notice many/most of those functions exit early if the mitigation is
> turned off, thereby skipping the pr_info().  It might be a matter of
> just tweaking the print behavior and making it consistent across all the
> mitigations.

Yeah. A single consistent table would be the most user-friendly outcome, 
with no silence. 'No output' is what kernels without the fixes do too, so 
we should always output the chosen bootup status of relevant mitigations.

This would make it a bit easier for users to report bugs too: for example 
if some uncommon CPU model number is not enumerated by the mitigations code 
and the kernel mistakenly believes that the CPU is safe. While much of this 
information can be recovered from the sysfs files too, they are subject to 
runtime changes and the values are also not reliably logged at bootup.

Thanks,

	Ingo
