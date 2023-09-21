Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3672D7AA2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjIUVmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIUVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:41:52 -0400
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3DA4F918
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:19:45 -0700 (PDT)
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
        by mailhost.m5p.com (8.17.1/8.15.2) with ESMTPS id 38LLItlr073396
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Sep 2023 17:19:01 -0400 (EDT)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.17.1/8.15.2/Submit) id 38LLIsqq073395;
        Thu, 21 Sep 2023 14:18:54 -0700 (PDT)
        (envelope-from ehem)
Date:   Thu, 21 Sep 2023 14:18:54 -0700
From:   Elliott Mitchell <ehem+xen@m5p.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        smita.koralahallichannabasappa@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, rric@kernel.org,
        james.morse@arm.com
Subject: Re: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Message-ID: <ZQyzPncxg2HYzlQI@mattapan.m5p.com>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
 <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
 <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
 <ZQM8jRx8uKEbEo00@mattapan.m5p.com>
 <20230915115631.GAZQRGb0vCmEnUcaZI@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915115631.GAZQRGb0vCmEnUcaZI@fat_crate.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:56:31PM +0200, Borislav Petkov wrote:
> On Thu, Sep 14, 2023 at 10:02:05AM -0700, Elliott Mitchell wrote:
> > Indeed.  At what point is the lack of information and response long
> > enough to simply commit a revert due to those lacks?
> 
> At no point.
> 
> > Even with the commit message having been rewritten and the link to:
> > https://lkml.kernel.org/r/20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com
> > added, this still reads as roughly:
> > 
> > "A hypothetical bug on a hypothetivisor"
> 
> If "Hypervisors likely do not expose the SMCA feature to the guest"
> doesn't explain to you what the problem is this commit is fixing, then
> I can't help you.

Problem is you were objecting to 'probable hypothetical "may"
formulations' in what I wrote, yet the original patch message overtly
uses that word.

In order for the first patch to be correct, it is insufficient for the
condition to be unlikely.  Ideally it should be mathematically proven
impossible.

As such I was writing about known counter-examples from the real world.
Mainly at least one hypervisor (Xen) does tend to allow a particular VM
to access sensitive system registers.  Also it is entirely possible some
hypervisor could proxy access to the registers and thus properly simulate
the events.

Not only that, but in fact this very strategy was already actively
deployed:
https://bugs.debian.org/810964

I'm less than 100% certain this successfully retrieves EDAC events on Xen
right now, so I had been taking a look at the situation only to find
767f4b620eda.

Perhaps everyone should consult with large-scale system administrators
when doing things which effect them?


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


