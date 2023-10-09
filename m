Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BED7BD5D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbjJIIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345754AbjJIIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:53:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF410E5;
        Mon,  9 Oct 2023 01:52:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5577721835;
        Mon,  9 Oct 2023 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696841530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+ENGRtc9kO336DfttkT+4HSplaWliy8Mo2bgqKSB/E=;
        b=J7fKzO1nm+oOwsztyCeYtaPIvy797QsY3JttQRQ7ajgueexta+2ZyJfdYXNnvjH7yVd698
        5uB+V94le13H5WBXYyth98m08dh1QCOJzMDgGfCzNMXXV//w7YeaFyhz7wkIMn8LGh84be
        O/ugHH72+rlBSBzsQPCEVF4tPSD4h+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696841530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+ENGRtc9kO336DfttkT+4HSplaWliy8Mo2bgqKSB/E=;
        b=+3GyJk/vSzZ/27KkKuztuGDRCAN7YudyxTcWCnP27cTn3Eg6EQXdY8L31/D6Utk9K2+eiR
        nsWW0/X9H86adAAg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF3BD2C142;
        Mon,  9 Oct 2023 08:52:09 +0000 (UTC)
Date:   Mon, 9 Oct 2023 10:52:08 +0200
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
Message-ID: <20231009085208.GT6241@kitsune.suse.cz>
References: <20231005150728.3429-1-msuchanek@suse.de>
 <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQh7vCQ859RPkL3SDr2d4ptt5OVCr66fkPKGcvxDUHtkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 09, 2023 at 05:31:02PM +0900, Masahiro Yamada wrote:
> On Fri, Oct 6, 2023 at 12:49 AM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > The default MODLIB value is composed of two variables and the hardcoded
> > string '/lib/modules/'.
> >
> > MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> >
> > Defining this middle part as a variable was rejected on the basis that
> > users can pass the whole MODLIB to make, such as
> 
> 
> In other words, do you want to say
> 
> "If defining this middle part as a variable had been accepted,
> this patch would have been unneeded." ?

If it were accepted I would not have to guess what the middle part is,
and could use the variable that unambiguosly defines it instead.

Thanks

Michal

> 
> 
> If your original patch were accepted, how would this patch look like?
> 
> kernel.spec needs to know the module directory somehow.
> 
> 
> Would you add the following in scripts/package/mkspec ?
> 
> %define MODLIB $(pkg-config --print-variables kmod 2>/dev/null | grep
> '^module_directory$' >/dev/null && pkg-config
> --variable=module_directory kmod || echo /lib/modules)
> 
> 
> 
> 
> 
> 
> 
> 
> >
> > make 'MODLIB=$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'
> >
> > However, this middle part of MODLIB is independently hardcoded by
> > rpm-pkg, and when the user alters MODLIB this is not reflected when
> > building the package.
> >
> > Given that $(INSTALL_MOD_PATH) is overridden during the rpm package build
> > it is likely going to be empty. Then MODLIB can be passed to the rpm
> > package, and used in place of the whole
> > /usr/lib/modules/$(KERNELRELEASE) part.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  scripts/package/kernel.spec | 8 ++++----
> >  scripts/package/mkspec      | 1 +
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > index 3eee0143e0c5..15f49c5077db 100644
> > --- a/scripts/package/kernel.spec
> > +++ b/scripts/package/kernel.spec
> > @@ -67,7 +67,7 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
> >  %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> >  cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
> >  cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> > -ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
> > +ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{MODLIB}/build
> >  %if %{with_devel}
> >  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
> >  %endif
> > @@ -98,8 +98,8 @@ fi
> >
> >  %files
> >  %defattr (-, root, root)
> > -/lib/modules/%{KERNELRELEASE}
> > -%exclude /lib/modules/%{KERNELRELEASE}/build
> > +%{MODLIB}
> > +%exclude %{MODLIB}/build
> >  /boot/*
> >
> >  %files headers
> > @@ -110,5 +110,5 @@ fi
> >  %files devel
> >  %defattr (-, root, root)
> >  /usr/src/kernels/%{KERNELRELEASE}
> > -/lib/modules/%{KERNELRELEASE}/build
> > +%{MODLIB}/build
> >  %endif
> > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > index d41608efb747..d41b2e5304ac 100755
> > --- a/scripts/package/mkspec
> > +++ b/scripts/package/mkspec
> > @@ -18,6 +18,7 @@ fi
> >  cat<<EOF
> >  %define ARCH ${ARCH}
> >  %define KERNELRELEASE ${KERNELRELEASE}
> > +%define MODLIB ${MODLIB}
> >  %define pkg_release $("${srctree}/init/build-version")
> >  EOF
> >
> > --
> > 2.42.0
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada
