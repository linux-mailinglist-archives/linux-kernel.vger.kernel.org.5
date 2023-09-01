Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA45B78F8B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347410AbjIAGtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIAGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:49:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A54E7E;
        Thu, 31 Aug 2023 23:49:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61CF72185A;
        Fri,  1 Sep 2023 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693550951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4bHvhu9iGZmVaIXxTBt13MUr6lzgxbnZNtI2eX+22I=;
        b=BBrxsb8fTTKJjVhBGQztumrcVStpBkpM5F5MM5lRLyrtln7qEPAjsPXYYTHKTYnN2h+pkv
        6HS7NKsM3dgynjwdhdI6lntMW6J61rpIVcw6lLOyFGS7or008yN++BQxnOTR4bZzR1QFRp
        4hIejXeuU3m0L7vgIyu7N9usOHpATHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693550951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4bHvhu9iGZmVaIXxTBt13MUr6lzgxbnZNtI2eX+22I=;
        b=goKKXVSwspArMDEGZJVPt0r1sqH8paISM00q446hiAaHXhgTRqg5t/9CVb9jDrra/0u+Tw
        N4oe+/tDiuxnbRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21EA913582;
        Fri,  1 Sep 2023 06:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id beDxBGaJ8WR4awAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 01 Sep 2023 06:49:10 +0000
Date:   Fri, 1 Sep 2023 08:50:28 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20230901065028.GG8103@alberich>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:24:18PM -0700, Ricardo Neri wrote:
> Hi,

Hi Ricardo,

> This is v3 of a patchset to set the number of cache leaves independently
> for each CPU. v1 and v2 can be found here [1] and here [2].

I am on CC of your patch set and glanced through it.
Long ago I've touched related code but now I am not really up-to-date
to do a qualified review in this area. First, I would have to look
into documentation to refresh my memory etc. pp.

I've not seen (or it escaped me) information that this was tested on a
variety of machines that might be affected by this change. And there
are no Tested-by-tags.

Even if changes look simple and reasonable they can cause issues.

Thus from my POV it would be good to have some information what tests
were done. I am not asking to test on all possible systems but just
knowing which system(s) was (were) used for functional testing is of
value.

> Changes since v2:
>   * This version uncovered a NULL-pointer dereference in recent changes to
>     cacheinfo[3]. This dereference is observed when the system does not
>     configure cacheinfo early during boot nor makes corrections later
>     during CPU hotplug; as is the case in x86. Patch 1 fixes this issue.
> 
> Changes since v1:
>   * Dave Hansen suggested to use the existing per-CPU ci_cpu_cacheinfo
>     variable. Now the global variable num_cache_leaves became useless.
>   * While here, I noticed that init_cache_level() also became useless:
>     x86 does not need ci_cpu_cacheinfo::num_levels.
> 
> [1]. https://lore.kernel.org/lkml/20230314231658.30169-1-ricardo.neri-calderon@linux.intel.com/
> [2]. https://lore.kernel.org/all/20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com/
> [3]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/
> 
> Ricardo Neri (3):
>   cacheinfo: Allocate memory for memory if not done from the primary CPU
>   x86/cacheinfo: Delete global num_cache_leaves
>   x86/cacheinfo: Clean out init_cache_level()
> 
>  arch/x86/kernel/cpu/cacheinfo.c | 50 ++++++++++++++++-----------------
>  drivers/base/cacheinfo.c        |  6 +++-
>  2 files changed, 30 insertions(+), 26 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)
