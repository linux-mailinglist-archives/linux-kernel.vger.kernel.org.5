Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A77BE21A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376914AbjJIOHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376856AbjJIOHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:07:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8EC8E;
        Mon,  9 Oct 2023 07:07:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 74A1F1F390;
        Mon,  9 Oct 2023 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696860455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brarWfHZNCZ/eUpQXOhCyTl2NDxbkajiRmJcDbpuHgs=;
        b=RGKzRlOXXdF7EKqqP/+xuk+g25i4EXFcaoMbDvzg6BeFrjuYE8c6esJrX/5TvdAzobu2qn
        7QvS5032wNfNueNtdEZyXeZOzw/QYrSa/lpozcpJ18+GXQ9cnM9ZDgN+WULLd4kdIkJsPT
        /C8lIyEndmOPKFekJuTI/DYv90GiPaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696860455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brarWfHZNCZ/eUpQXOhCyTl2NDxbkajiRmJcDbpuHgs=;
        b=Gve28qXk8V1AtyFuItekX82mN33W4bquggzI4baM2iWx2XNt1eXjJf/q4al9h8r0WL2LCe
        svZpALoXkr2vfaBQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E17502C142;
        Mon,  9 Oct 2023 14:07:34 +0000 (UTC)
Date:   Mon, 9 Oct 2023 16:07:33 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default
 MODLIB
Message-ID: <20231009140733.GV6241@kitsune.suse.cz>
References: <20231005150728.3429-1-msuchanek@suse.de>
 <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
 <20231009085208.GT6241@kitsune.suse.cz>
 <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASeMEKVi5c0PEow5KSdN7rsm7UYEf2smWOSkYOhr_5fVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:34:10PM +0900, Masahiro Yamada wrote:
> On Mon, Oct 9, 2023 at 5:52 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > Hello,
> >
> > On Mon, Oct 09, 2023 at 05:31:02PM +0900, Masahiro Yamada wrote:
> > > On Fri, Oct 6, 2023 at 12:49 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > > >
> > > > The default MODLIB value is composed of two variables and the hardcoded
> > > > string '/lib/modules/'.
> > > >
> > > > MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > >
> > > > Defining this middle part as a variable was rejected on the basis that
> > > > users can pass the whole MODLIB to make, such as
> > >
> > >
> > > In other words, do you want to say
> > >
> > > "If defining this middle part as a variable had been accepted,
> > > this patch would have been unneeded." ?
> >
> > If it were accepted I would not have to guess what the middle part is,
> > and could use the variable that unambiguosly defines it instead.
> 
> 
> How?
> 
> scripts/package/kernel.spec hardcodes 'lib/modules'
> in a couple of places.
> 
> I am asking how to derive the module path.

Not sure what you are asking here. The path is hardcoded, everywhere.

The current Makefile has

MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)

and there is no reliable way to learn what the middle part was after the
fact - $(INSTALL_MOD_PATH) can be non-empty.

The rejected patch was changing this to a variable, and also default to
adjusting the content to what kmod exports in pkgconfig after applying a
proposed patch to make this hardcoded part configurable:

export KERNEL_MODULE_DIRECTORY := $(shell pkg-config --print-variables kmod 2>/dev/null | grep '^module_directory$$' >/dev/null && pkg-config --variable=module_directory kmod || echo /lib/modules)

MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE)

It would be completely posible to only define the middle part as a
variable that could then be used in rpm-pkg:

export KERNEL_MODULE_DIRECTORY := /lib/modules

MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_DIRECTORY)/$(KERNELRELEASE)

Thanks

Michal


