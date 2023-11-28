Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053FA7FC26A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbjK1OHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbjK1OHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:07:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57396D53;
        Tue, 28 Nov 2023 06:07:50 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0799F2199D;
        Tue, 28 Nov 2023 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701180468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Szd0kfLvWrSYQ3QHqmPI1rgK3WdJ32bLnGKR57G4N6w=;
        b=T6qJw7ISXA7Fi4iKSgAIz3Ci3iO4Hj5dsdiOgi/iNjyE2l49xviNFjkJbyvwWJqBPV0TQj
        ucjBzs5PCwMb0LE/FC9ZrB/jEgLhJLFQ5yjPSkdON+6JAzmGsS2+s+ToTdB34n3Wv8cMKL
        kQb+PuFAw5fQHCwHaszJUvKiMw0Ob1o=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 24C2F2C153;
        Tue, 28 Nov 2023 14:07:43 +0000 (UTC)
Date:   Tue, 28 Nov 2023 15:07:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     j.granados@samsung.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 07/10] printk: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <ZWX0L4lV8TWOgcpv@alley>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-7-e4ce1388dfa0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-7-e4ce1388dfa0@samsung.com>
X-Spamd-Bar: +++++++++++++++++++++++++
X-Spam-Score: 26.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 0799F2199D
X-Spamd-Result: default: False [26.00 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         R_RATELIMIT(0.00)[rip(RLa6h5sh378tcam5q78u)];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         FORGED_RECIPIENTS(2.00)[m:mgorman@suse.de,s:mgorman@imap.suse.de];
         BAYES_HAM(-0.00)[29.52%];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[46];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[kernel.org,infradead.org,joshtriplett.org,chromium.org,xmission.com,google.com,goodmis.org,arm.com,linutronix.de,amacapital.net,redhat.com,linaro.org,suse.de,linux.ibm.com,intel.com,davemloft.net,gmail.com,iogearbox.net,linux.dev,vger.kernel.org,lists.infradead.org];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[];
         SUSPICIOUS_RECIPS(1.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-11-07 14:45:07, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> rm sentinel element from printk_sysctls
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

I am a bit sceptical if the size and time reduction is worth the
effort. I feel that this change makes the access a bit less secure.

Well, almost all arrays are static so that it should just work.
The patch does what it says. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
