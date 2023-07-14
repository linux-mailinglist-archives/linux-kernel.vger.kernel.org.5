Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBF753C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjGNN5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjGNN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:57:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B02B26B5;
        Fri, 14 Jul 2023 06:57:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 110AA220E3;
        Fri, 14 Jul 2023 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689343029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsHcxIMf2mArNErpDripO+Zo0yyfVXNRaCZe3moXKDc=;
        b=hNo9xdg+cL8aAxhgs69udnW0dajB4lkoV7HsCSp+xiMH8hxDeLNYEeAywBBNNZXzNHocmN
        FHWe5mJq/JwXObqD5m33US4dUjHXZerYAfzLW21k+LZ/MUE5wQ/DfY47xHyQZijRiRqVvd
        hDo88VKPAqjUSNK92gczh+kjsTDE38w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689343029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsHcxIMf2mArNErpDripO+Zo0yyfVXNRaCZe3moXKDc=;
        b=FvayFZ7oGoadJjLOrTNL/eMEyahi0UAu3h+CDRjwNO2mdTEh0yRjLewRvG3B6y5qyOkLmJ
        QSstG1VjFjbyhoDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA1462C142;
        Fri, 14 Jul 2023 13:57:08 +0000 (UTC)
Date:   Fri, 14 Jul 2023 15:57:07 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <20230714135707.GI9196@kitsune.suse.cz>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
 <20230714122111.7528-1-msuchanek@suse.de>
 <s4sr75q4-5120-5sp5-7751-noqs9q67904q@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s4sr75q4-5120-5sp5-7751-noqs9q67904q@vanv.qr>
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

On Fri, Jul 14, 2023 at 03:38:18PM +0200, Jan Engelhardt wrote:
> 
> On Friday 2023-07-14 14:21, Michal Suchanek wrote:
> 
> >Some distributions aim at not shipping any files in / outside of usr.
> >
> >The path under which kernel modules are installed is hardcoded to /lib
> >which conflicts with this goal.
> >
> >+MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)
> 
> Ok, so if the problem statement is that hardcoded paths are bad, then why
> continue to hardcode the "/lib/modules" fragment? Just make it so that
> KERNEL_MODULE_PREFIX can be set to the exact string "/usr/lib/modules" and not
> just "/usr".

That's certainly an option.

The feature is modelled after the installation prefix option that can
move the whole filesystem hierarchy of installed files under /usr/local,
/opt, or any other directory of choice. However, in that case the
subdirectories in the hierarchy can be configured as well while in this
case /lib/modules remains hardcoded.

Making it possible to set the whole path is generally more flexible
although there is no need to set the later part for this particular use
case.

Thanks

Michal
