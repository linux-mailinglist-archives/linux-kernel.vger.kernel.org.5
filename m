Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1DC7CC1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjJQLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:18:38 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC7BA2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:18:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C05FD40E0196;
        Tue, 17 Oct 2023 11:18:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6IN4eX55QrNn; Tue, 17 Oct 2023 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697541513; bh=rAgqEtaipV0w6VNIClWPporD9UN1OctlQ9N+Z9rL6Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4I5H/bL8bf1jlgUgTct9CxUisqNn7vkQrXxxVauK0EEPxOwVEiKEVAu1Cc6A9BK8
         kzS2189Y4HLwvn+RG88m/CY1AOd5UV5OFLf2R+jaq4zOvy1TUFf1FRv2AS5MoM65PE
         TKvHMY9rPY/pjsFQY4NuSofRRYqVKNkOknCbMr+FV7RUztmLVqepFYI69uq0NGRKAT
         byz+zcfMYa37guKPZzsQQdYkMMP3G+TYSBOSmrP9VcDlPCWBl6xSZr3yq3B8WMyvAj
         z0ALp+2o8drXNtmZ1Titd87ca8uRqVe+9/J+gs3eG8RR8DIaqsYbtCudvOwBnCqDg4
         TJ+0qVKOj9v8K/vZnnrrtGtpRPPaReaoZa9K+T+omvugwveedqw7nUSPuoiSM5HRVM
         rP9RKtmSn9Jq915DmzzCW3OCQeneCFBfiixSEKMxtqPLSUvBcEg/5odtAT646gkYFk
         a6MU7XfzpmlyPmPIY88NxnccfFD2xCuRj97N0hdXAc/Z1Q76HPKgz2LyOx0UmzrzoP
         Tt6KsY8DKpAiA+fqkXRBwMe1SUFM1dhn0eplZJ5EP08Nc6bXvza96VrSaq/1buJGdb
         dLsjFxN6vQqBiYt+1kfK1YlqUWxpUM57ySjwEa0DNlhmo/8rZSsPZQDwWpzxgsjT14
         rs2npfRFcNXVCPl4BEbMWin4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB13540E01AA;
        Tue, 17 Oct 2023 11:18:24 +0000 (UTC)
Date:   Tue, 17 Oct 2023 13:18:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Message-ID: <20231017111817.GAZS5teT4rFkXVD2KA@fat_crate.local>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
 <20231016091143.GCZSz+T1xFf5tCFi2w@fat_crate.local>
 <759ccb97-cf5a-4787-b699-27551d5d2865@intel.com>
 <SJ1PR11MB60834039F485FEBC8031398AFCD6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60834039F485FEBC8031398AFCD6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 01:24:53AM +0000, Luck, Tony wrote:
> How about:
>
> When there is a fatal machine check Linux calls mce_panic()
> without checking to see if bad data at some memory address
> was reported in the machine check banks.

... for the simple reason that the kernel cannot allow itself to do any
unnecessary work but panic immediately so that it can stop the
propagation of bad data.

Now, it's a whole different story whether that's the right thing to do
and whether the data has already propagated so that the panic is moot.

The whole point I'm trying to make is that the machine panics because
the error severity dictates it to do so. And there's no opportunity to
queue recovery work because it simply cannot in that case. So the commit
message should simply state that we're marking the page as poison for
the kexec'ed kernel's sake and not because of anything else.

> If kexec is enabled, check for memory errors and mark the
> page as poisoned so that the kexec'd kernel can avoid accessing
> the page.

Yap, yours makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
