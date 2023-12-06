Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7E806CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377769AbjLFKsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377846AbjLFKrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:47:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F291FD9;
        Wed,  6 Dec 2023 02:46:50 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C7CB22035;
        Wed,  6 Dec 2023 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701859607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tvr+wZuWLjk8prt1x/6hIZLKUrQpVd6qxv/alDG6+W8=;
        b=unK7AS3Cg4pIF3+wrVJCEBQpXSLpS8lwYo4HyRLgQYo5tfw4JxvANAmdDDXQJXB8SNqbQw
        Ud871XDWRtnqr+JH5efDPaEYlO3pWko0LJWBR4iXWznCTO0cViZtWUeNoeMu1SlB1rlKv6
        +avrHb+G/LxY3TFk1jyRjSfk8F7GzEM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 845E12C153;
        Wed,  6 Dec 2023 10:46:44 +0000 (UTC)
Date:   Wed, 6 Dec 2023 11:46:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] lib/vsprintf: Fix %pfwf when current node
 refcount == 0
Message-ID: <ZXBRE2oR_YIkpsIQ@alley>
References: <20231114152655.409331-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114152655.409331-1-herve.codina@bootlin.com>
X-Spamd-Bar: ++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [18.00 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.10)[65.55%];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,bootlin.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Score: 18.00
X-Rspamd-Queue-Id: 1C7CB22035
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-11-14 16:26:55, Herve Codina wrote:
> A refcount issue can appeared in __fwnode_link_del() due to the
> pr_debug() call:
>   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
>   Call Trace:
>   <TASK>
>   ...
>   of_node_get+0x1e/0x30
>   of_fwnode_get+0x28/0x40
>   fwnode_full_name_string+0x34/0x90
>   fwnode_string+0xdb/0x140
>   ...
>   vsnprintf+0x17b/0x630
>   ...
>   __fwnode_link_del+0x25/0xa0
>   fwnode_links_purge+0x39/0xb0
>   of_node_release+0xd9/0x180
>   ...
> 
> Indeed, an fwnode (of_node) is being destroyed and so, of_node_release()
> is called because the of_node refcount reached 0.
> >From of_node_release() several function calls are done and lead to
> a pr_debug() calls with %pfwf to print the fwnode full name.
> The issue is not present if we change %pfwf to %pfwP.
> 
> To print the full name, %pfwf iterates over the current node and its
> parents and obtain/drop a reference to all nodes involved.
> 
> In order to allow to print the full name (%pfwf) of a node while it is
> being destroyed, do not obtain/drop a reference to this current node.
> 
> Fixes: a92eb7621b9f ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I have pushed the fix into printk/linux.git, branch for-6.8.

Please, let me know if you would prefer to push this into 6.7.

The "Fixes:" tag points to a pretty old commit from v5.5 so
it does not look like a super urgent fix. And I always
prefer when fixes spend some time in linux-next.

Best Regards,
Petr
