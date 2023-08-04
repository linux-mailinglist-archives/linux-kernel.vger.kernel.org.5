Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5612B76FB63
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjHDHvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjHDHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:51:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A34234
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:51:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 461081F749;
        Fri,  4 Aug 2023 07:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691135460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjm5wLyvz4cY9tLarxXb4REzVGSm0jQGJmCuVtpqVdo=;
        b=fLkVdr8WXOyDzySmPvkVnK1GAmb5vqHMQHl8cyod1jYgQmhu/eshedwFHp05bvZ1LB1kRF
        dNEHhlHk620xBke/GpFs5J5gT3Q+QJkC6Bz1EM6uQiV/fWhnMG628zBaGm1YjfoJFTTiYX
        KbUkxTDTnLudRfJMVggZl0e77iDqq9w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26AB913904;
        Fri,  4 Aug 2023 07:51:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JWX2BuStzGRtZQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 04 Aug 2023 07:51:00 +0000
Date:   Fri, 4 Aug 2023 09:50:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] watchdog/hardlockup: Avoid large stack frames in
 watchdog_hardlockup_check()
Message-ID: <ZMyt47ptEp2z4BIT@dhcp22.suse.cz>
References: <20230803160649.v3.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
 <20230803160649.v3.2.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803160649.v3.2.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-08-23 16:07:58, Douglas Anderson wrote:
> After commit 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to
> watchdog_hardlockup_check()") we started storing a `struct cpumask` on
> the stack in watchdog_hardlockup_check(). On systems with
> CONFIG_NR_CPUS set to 8192 this takes up 1K on the stack. That
> triggers warnings with `CONFIG_FRAME_WARN` set to 1024.
> 
> We'll use the new trigger_allbutcpu_cpu_backtrace() to avoid needing
> to use a CPU mask at all.
> 
> Fixes: 77c12fc95980 ("watchdog/hardlockup: add a "cpu" param to watchdog_hardlockup_check()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202307310955.pLZDhpnl-lkp@intel.com
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
