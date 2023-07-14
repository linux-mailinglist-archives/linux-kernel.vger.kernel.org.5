Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C953C753967
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjGNLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjGNLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:19:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE042D78;
        Fri, 14 Jul 2023 04:19:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5322211E;
        Fri, 14 Jul 2023 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689333559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNe+Gf3I5enTnyuL0ajOVSEMvthYdstQw6XyBnmILFY=;
        b=O41kwjgRAMaULzdkdj+t8Kn7PFn4h+EElN6WrgqfDgNFlAGcnZVM6UNjlcbe/9OmxdaXNJ
        sEMHVL1Wz4GkD+m8raS7dc/OJNIpDsz5IT6NmjqqtpFoU8hZqZHHLDTtDp6+X+NI99BuNN
        gf9hRNRIQFZyGGIFCz3h3dKlszOsg0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689333559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNe+Gf3I5enTnyuL0ajOVSEMvthYdstQw6XyBnmILFY=;
        b=nKvtNnfDq3yztDN/UtUFpaunYtesuG/jPByktklTQY+bW+GEut3Xpz3Vann0xzLvBq8GI3
        sxxnUrKXWHgN4+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 467CA138F8;
        Fri, 14 Jul 2023 11:19:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WCPlDzcvsWThLgAAMHmgww
        (envelope-from <trenn@suse.de>); Fri, 14 Jul 2023 11:19:19 +0000
From:   Thomas Renninger <trenn@suse.de>
To:     trenn@suse.com, shuah@kernel.org, Wyes Karny <wyes.karny@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com,
        Mario.Limonciello@amd.com, Ray.Huang@amd.com, Perry.Yuan@amd.com,
        Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH v3 0/5] cpupower: Add various feature control support for
 amd_pstate
Date:   Fri, 14 Jul 2023 13:19:18 +0200
Message-ID: <1896655.g5d078U9FE@p200300d2573c9800520d172709106850.dip0.t-ipconnect.de>
In-Reply-To: <20230619190503.4061-1-wyes.karny@amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the late answer, I wanted to give this a test, but could not
make it (yet).

My 2 cents on this one:

what Ray already mentioned is greatly appreciated: Find common APIs, not only 
AMD vs Intel, but general ones, outside of the driver specific sysfs dir, e.g.:
/sys/devices/system/cpu/cpufreq/...

But not at all costs and if the epp part is (AMD) specific and varies to others 
in meaning or in values, it has to be a specific file/API.

(Another Example/Request at the end)

And...: It would be nice to see some documentation in form of manpage 
enhancements. At least for the newly introduced arguments.
If not yet, there should be: possible value range, which machines (CPU flags, 
Zen 4, ...), if more complex technology, some kind of introduction or 
reference where to find things would be really great.

I wonder whether it could be possible to connect this with:
Documentation/admin-guide/pm/intel_pstate.rst
Documentation/admin-guide/pm/amd-pstate.rst

I guess there is a static web site address people could rely on where above
kernel docs are hosted forever?
Then it would make sense to link the cpupower manpage with it and keep the 
description short and avoid duplication?

             Thomas


Another Example/Request at the end:

One example I recently got asked for, the bug is private:
"cpupower is not returning max turbo active cores information on latest Intel 
processors."

Here are examples of 2 newer cpus that don't return the active core 
information like this: 
    3600 MHz max turbo 4 active cores
    3600 MHz max turbo 3 active cores
    3700 MHz max turbo 2 active cores
    3800 MHz max turbo 1 active cores

Not sure whether there finally is some kind of consolidation on turbo/boost/
dynamic/hw/bios interfaces in respect to turbo/boosting technology. But if 
anyhow possible and it makes sense, it would be really great to see one sysfs 
file exposed to userspace to read/enable/disable.

Possible cpufreqs (including or only) boost freqs, maybe with active cores if 
this is a general technique optionally added if avail?

Nothing which has to be implemented at all costs and right now, just an idea 
on how things could be consolidated at some point of time which might be wise 
to think about now already...



