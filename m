Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1665E753C84
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjGNOF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbjGNOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:05:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC91989;
        Fri, 14 Jul 2023 07:05:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 08314220DA;
        Fri, 14 Jul 2023 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689343553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=on/azD0IDlTgoCRWpUxAHxN1A8r6V3mGNyszvfAq2XM=;
        b=QqujmIyUmcwLCx1w91PVT77vLkB9BZkbmvtw4g2T2Rqu+UJOZ/Vm0E/riRq8hTtUp59xbX
        ymMKPZAJjtfhzVzSV4MXdOiSra7JX5e0Gc2LrqF2AMuCeSvtkPizx2AeMfcfZAZpNwZoRN
        pdor5MeOnt9HQvUILjpvtlJXI2MJbkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689343553;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=on/azD0IDlTgoCRWpUxAHxN1A8r6V3mGNyszvfAq2XM=;
        b=WS5esd4G5G0U/62lxAWt52V/41MhPMsdJN7JLdxRsX1ahdYQliEle959ILT0M+boS1J5Sb
        Sb6TNH/gp6eRZaBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5E4962C142;
        Fri, 14 Jul 2023 14:05:52 +0000 (UTC)
Date:   Fri, 14 Jul 2023 16:05:51 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jan Engelhardt <jengelh@inai.de>, linux-modules@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <20230714140551.GK9196@kitsune.suse.cz>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
 <20230714122111.7528-1-msuchanek@suse.de>
 <s4sr75q4-5120-5sp5-7751-noqs9q67904q@vanv.qr>
 <mg5c43nynzgrp6mn47shxjobquqjs3klxwwheesjmsotvlalbx@axhwgiehelfx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mg5c43nynzgrp6mn47shxjobquqjs3klxwwheesjmsotvlalbx@axhwgiehelfx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 14, 2023 at 03:59:17PM +0200, Michal Koutný wrote:
> On Fri, Jul 14, 2023 at 03:38:18PM +0200, Jan Engelhardt <jengelh@inai.de> wrote:
> > Ok, so if the problem statement is that hardcoded paths are bad, then why
> > continue to hardcode the "/lib/modules" fragment? Just make it so that
> > KERNEL_MODULE_PREFIX can be set to the exact string "/usr/lib/modules" and not
> > just "/usr".
> 
> That sounds cleaner but I'm worried it would be a BC break in setups
> that expect the existing layout under INSTALL_MOD_PATH, wouldn't it?

It's a break either way, the expected directory righ now is exactly
/lib/modules. /usr/lib/modules works to some extent for some use cases
only when the compatibility symlink lib -> usr/lib is present.

Thanks

Michal
