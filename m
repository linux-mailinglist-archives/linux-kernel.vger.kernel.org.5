Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A107CFACD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbjJSNVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345849AbjJSNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:21:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B21112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:21:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C5C771F38C;
        Thu, 19 Oct 2023 13:21:25 +0000 (UTC)
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 594E62C556;
        Thu, 19 Oct 2023 13:21:25 +0000 (UTC)
Date:   Thu, 19 Oct 2023 15:21:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] lib/vsprintf: Remove redundant code
Message-ID: <ZTEtVdE-nPGM1iLv@alley>
References: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-0.00)[17.86%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: C5C771F38C
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-10-18 14:48:17, Jiapeng Chong wrote:
> When variable needcolon is assigned a value of false, it must be
> assigned a value of true later on, which is redundant code.
> 
> lib/vsprintf.c:1411:4: warning: Value stored to 'needcolon' is never read.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6909
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  lib/vsprintf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index afb88b24fa74..9a9086885da8 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1406,10 +1406,9 @@ char *ip6_compressed_string(char *p, const char *addr)
>  			i += longest - 1;
>  			continue;
>  		}
> -		if (needcolon) {
> +		if (needcolon)
>  			*p++ = ':';
> -			needcolon = false;
> -		}
> +
>  		/* hex u16 without leading 0s */
>  		word = ntohs(in6.s6_addr16[i]);
>  		hi = word >> 8;

I am against this change. The assignment should be there from the
logical POV. IMHO, it helps people to verify that the code works
as expected. The removal might even cause regression when the logic
gets modified in the future.

Anyway, this is a slow path. The code readability is more important
then the speed. Let compiler do these micro optimizations.

Best Regards,
Petr
