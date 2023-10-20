Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00887D0F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377099AbjJTM02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:26:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D911B;
        Fri, 20 Oct 2023 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697804783;
        bh=6eucA1hIcjauTZoFNKAzAXAXKE9v2Ut89sCYmHempMk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QclXltIlXyGGi657p/iDwBH81QR1Iq3hd2y3RECoPS8AqMPR/RErtt2w4IjXNvdFS
         BuxNLODSXwr1SZo6QBze4u8LRO5Tcrv7BrbNKQz75YSps06WZpI+zPZg3snlCCjrwD
         jgJM0T/JxnY6UaA0HoIUdP7y/2ufp274BKAWuRePgsiyyG8g/qX2pmJCSQz20w10kA
         Vapu+fMZNMj0nDmOe4WbCdoPUSKWMeWXwi00he23ZyAekbdflKg71CYYMe/zQA7gfz
         YTX72jW07FtzNr5FUqOTLKtcYjkAL829RoSjltinVy+CJfz/VBKbdLd9JBPDwQrT4X
         TR6mZiWRU048g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBkMy1x9Dz4wd5;
        Fri, 20 Oct 2023 23:26:22 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: Enable generic cpu idle-loop
In-Reply-To: <20230821045928.1350893-1-vaibhav@linux.ibm.com>
References: <20230821045928.1350893-1-vaibhav@linux.ibm.com>
Date:   Fri, 20 Oct 2023 23:26:21 +1100
Message-ID: <871qdp5vki.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaibhav,

Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> This minor patch enables config option GENERIC_IDLE_POLL_SETUP for arch
> powerpc. This should add support for kernel param 'nohlt'.
>
> Powerpc kernel also supports another kernel boot-time param called
> 'powersave' which can also be used to disable all cpu idle-states and
> forces CPU to an idle-loop similar to what cpu_idle_poll() does. Hence this
> patch  also updates the handling of 'powersave=off' kernel param to enable
> generic cpu idle-loop if its enabled.
>
> Signed-off-by: Vaibhav Jain<vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> Since v1:
> https://lore.kernel.org/all/20230818050739.827851-1-vaibhav@linux.ibm.com
> * Updated powersave_off() to enable generic cpu idle-loop if
> 'powersave=off' kernel arg is given. [Mpe]
> * Update patch description

I had already merged the v1 when I saw this, and ...

> diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
> index b1c0418b25c8..7367a0698459 100644
> --- a/arch/powerpc/kernel/idle.c
> +++ b/arch/powerpc/kernel/idle.c
> @@ -35,6 +36,8 @@ EXPORT_SYMBOL(cpuidle_disable);
>  
>  static int __init powersave_off(char *arg)
>  {
> +	/* Use generic idle loop if thats available */
> +	cpu_idle_poll_ctrl(true);
>  	ppc_md.power_save = NULL;
>  	cpuidle_disable = IDLE_POWERSAVE_OFF;
>  	return 1;

The hope here would be that we could remove the need for cpuidle_disable.

cheers
