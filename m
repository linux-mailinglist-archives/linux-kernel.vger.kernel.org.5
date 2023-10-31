Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE607DCB82
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjJaLMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjJaLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:12:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF757C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:12:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698750727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uY/e7u3SiLygPlUFD9YVUFybmqC/ruRtouz4/00CRUk=;
        b=EfQ2DMdLWp8IRDsaore3eSAk3FqLxj4ROJPNmsgrd2fd0RQikJE/1xsPvaUirAeaShaQgg
        u6cwaC21uNvTbtus1/5lY0kj476tn1pxkZDzzHj1S9+R9J8cVJMS5zn/MxQb5mAmc1FNrO
        kXqXSCdh8iHybYpv2r2bmLCI6gKwnj7zar5fDN/mm5zIrH99sInEe0wb3V2VSwpjbvJkNw
        W15E4TLWPQCYNYkV9490fvh0WtD6aH6BCzD8E2rMXlPc1XxdD1E6bf4thIT2499a396LUS
        IW5jDodDfLTuI8vwn2WTTIDDkXM8Hs7UXBB+hCZsRUVT1SZ+FGrPdZozKqAyNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698750727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uY/e7u3SiLygPlUFD9YVUFybmqC/ruRtouz4/00CRUk=;
        b=2A3l/JwhTqgIYye8kWGvktXzq/DHPiIfrKsEgHA/VkRzkQCzxOMP0irfh84Gq9NtzghGuI
        cN4dvnGgTwi11dBw==
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 2/2] reboot: flush printk buffers before final shutdown
In-Reply-To: <20231030092432.3434623-2-martin@geanix.com>
References: <20231030092432.3434623-1-martin@geanix.com>
 <20231030092432.3434623-2-martin@geanix.com>
Date:   Tue, 31 Oct 2023 12:18:05 +0106
Message-ID: <87edhbf3lm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30, Martin Hundeb=C3=B8ll <martin@geanix.com> wrote:
> Make sure printed messages are in fact printed before putting the system
> down.
>
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>
> ---
>  kernel/reboot.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3bba88c7ffc6..bab8350d5dae 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -273,6 +273,7 @@ void kernel_restart(char *cmd)
>  	else
>  		pr_emerg("Restarting system with command '%s'\n", cmd);
>  	kmsg_dump(KMSG_DUMP_SHUTDOWN);
> +	pr_flush(1000, false);

printk() tries to print directly from the calling context. Are you
experiencing problems where you do not see the restarting message?

John Ogness
