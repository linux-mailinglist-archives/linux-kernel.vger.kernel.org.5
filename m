Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE77FA7FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjK0Rc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjK0RcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:32:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6003A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:32:29 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6CCA51FB6E;
        Mon, 27 Nov 2023 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701106346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FeFGo3A/PHQytb3pAGL1mij1tGEA+VptDNWqWw5gmgQ=;
        b=GqSzwVWJC6Sg+x+kK8orLAXycRBKq8w//2PwuwF49CCCOrrMPi0pxk6hjAwQ+TIu50tszh
        jwsxzuXgXs/h/hrUtDX2mSw68t9MueH7jOBkyMtl/+G7MM9goGRkx/pD5uoQkaAT5sYixC
        6i8CBO6UTimB/2m8qbe8OW1t9gS23+s=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B10412C14F;
        Mon, 27 Nov 2023 17:32:24 +0000 (UTC)
Date:   Mon, 27 Nov 2023 18:32:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     lizhe.67@bytedance.com
Cc:     dianders@chromium.org, akpm@linux-foundation.org,
        lecopzer.chen@mediatek.com, kernelfans@gmail.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [PATCH v3] softlockup: serialized softlockup's log
Message-ID: <ZWTSp70g_PLH963C@alley>
References: <20231123084022.10302-1-lizhe.67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123084022.10302-1-lizhe.67@bytedance.com>
X-Spamd-Bar: ++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [18.50 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         TO_DN_NONE(0.00)[];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         R_RATELIMIT(0.00)[rip(RLa6h5sh378tcam5q78u)];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.00)[23.09%];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,bytedance.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[chromium.org,linux-foundation.org,mediatek.com,gmail.com,vger.kernel.org,bytedance.com];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Score: 18.50
X-Rspamd-Queue-Id: 6CCA51FB6E
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-11-23 16:40:22, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
> 
> If multiple CPUs trigger softlockup at the same time with
> 'softlockup_all_cpu_backtrace=0', the softlockup's logs will appear
> staggeredly in dmesg, which will affect the viewing of the logs for
> developer. Since the code path for outputting softlockup logs is not
> a kernel hotspot and the performance requirements for the code are
> not strict, locks are used to serialize the softlockup log output to
> improve the readability of the logs.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>

I do not feel fully comfortable with adding a lock into a code path
which reports system lockups. There might already be a deadlock on
the system and yet another lock would not make things easier.

On the other hand, the added spinlock looks pretty safe:

   + It synchronizes only watchdog_timer_fn() calls against each other.
     watchdog_timer_fn() could not be nested.

   + The locked code seems to be synchronized only by RCU
     and does not wait for other CPUs to finish something.


I haven't found any real deadlock scenario. Feel free
to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
