Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AAA7FB5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbjK1Jaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjK1Jau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:30:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2927CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:30:55 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B15091F7AB;
        Tue, 28 Nov 2023 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701163851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C3hPIaPy+NVkWatkJYJY56mWODl1OrV2QEbB7uNHPUE=;
        b=l/aXLDlHu6ZhPoW5GB8Gz1GLjMqqJxA+SDs5zIPIk64Ae8Gk/9sgauU5VE0tA8qODBdjHn
        hindH5fpGLCGGPocaedxzKmqUuNjKDJsoB3ynoopIjj3dvb7GVHDzAVqvHLSrppx2rY4DU
        hp+gXW6aS7c3PdaowAlNC4xhxNB1nLw=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1708A2C166;
        Tue, 28 Nov 2023 09:30:50 +0000 (UTC)
Date:   Tue, 28 Nov 2023 10:30:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Christie <michael.christie@oracle.com>,
        Zqiang <qiang1.zhang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kthread: kthread_should_stop() checks if we're a kthread
Message-ID: <ZWWzSZeyRuPDwBHZ@alley>
References: <20231120221503.3378095-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120221503.3378095-1-kent.overstreet@linux.dev>
X-Spamd-Bar: +++++++++++++++++++++++++
X-Spam-Score: 25.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: B15091F7AB
X-Spamd-Result: default: False [25.00 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         RCPT_COUNT_FIVE(0.00)[6];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,oracle.com,intel.com,linux-foundation.org];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Andrew into Cc. He usually takes changes in kernel/kthread.c.

On Mon 2023-11-20 17:15:03, Kent Overstreet wrote:
> bcachefs has a fair amount of code that may or may not be running from a
> kthread (it may instead be called by a userspace ioctl); having
> kthread_should_stop() check if we're a kthread enables a fair bit of
> cleanup and makes it safer to use.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  kernel/kthread.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 1eea53050bab..fe6090ddf414 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -155,7 +155,8 @@ void free_kthread_struct(struct task_struct *k)
>   */
>  bool kthread_should_stop(void)
>  {
> -	return test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
> +	return (current->flags & PF_KTHREAD) &&
> +		test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
>  }
>  EXPORT_SYMBOL(kthread_should_stop);

I agree that it makes the API more safe because &to_kthread(current)
is NULL when the process is not a kthread.

Well, I do not like the idea of quietly ignoring a misuse of
the kthread_*() API. I would personally prefer to do:

// define this in include/linux/kthread.h
static inline bool in_kthread(void)
{
	return current->flags & PF_KTHREAD
}

// add WARN() into kthread_should_stop()
bool kthread_should_stop(void)
{
	if (WARN_ON_ONCE(!in_kthread))
		return false;

	return test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
}
EXPORT_SYMBOL(kthread_should_stop);


And use the following in bcachefs() code:

	if (in_kthread() && kthread_should_stop())
		goto exit;


Is see several advantages:

    + It will warn when the API is misused.

    + It will be more clear that the bcachefs code might be
      used in both kthread and userspace code.

    + in_kthread() might be used around other code which is
      needed only when the process is a kthread.

    + Similar check and WARN() might be used also in the other
      kthread() API.


Best Regards,
Petr
