Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0366C757BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGRM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGRM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:27:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BB410EB;
        Tue, 18 Jul 2023 05:27:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 420EC2196E;
        Tue, 18 Jul 2023 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689683253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeyzR/SrDd1qPg3qCYLC+1TijcjDHhKUMI9NWi8uv0o=;
        b=PBtCyB8FdLBg7FDaajTikA7ipliqLHB6d5dOPp5U9Ix1tqNararEpCWBjR8HiezfMGiL29
        RDXdP8jPDQi0Gr9iXYqYlJd/TUmxd3Y1x0IjleiCbn4tcRqgs8pyEqI+DaCjGPTVywBEJ5
        i6nOi51boH/Q6yolmDV15QO6TackCNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689683253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeyzR/SrDd1qPg3qCYLC+1TijcjDHhKUMI9NWi8uv0o=;
        b=KJOyrbY+2/ksRKAxhtXeEviQEUf7gN7zPyi1RazlPH+n1p2fDGSuP+Fdh20lwUir/NHEoH
        DOLJd2ZfgXiwLyAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E04172C142;
        Tue, 18 Jul 2023 12:27:32 +0000 (UTC)
Date:   Tue, 18 Jul 2023 14:27:31 +0200
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
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
Message-ID: <20230718122731.GX9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <cover.1689589902.git.msuchanek@suse.de>
 <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de>
 <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr>
 <20230718084300.GU9196@kitsune.suse.cz>
 <81n281ns-s8on-rsrn-pp61-q28pn42ns531@vanv.qr>
 <20230718102958.GW9196@kitsune.suse.cz>
 <pq42o77-73np-66r-rrn9-ns24o907n59@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pq42o77-73np-66r-rrn9-ns24o907n59@vanv.qr>
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

On Tue, Jul 18, 2023 at 02:17:08PM +0200, Jan Engelhardt wrote:
> 
> On Tuesday 2023-07-18 12:29, Michal Suchánek wrote:
> >> -static const char *dirname_default_prefix = MODULE_DIRECTORY;
> >> +const char *dirname_default_prefix = MODULE_DIRECTORY;
> >>  
> >> @@ -2943,6 +2944,9 @@ static int do_depmod(int argc, char *argv[])
> >>  				free(out_root);
> >>  			out_root = path_make_absolute_cwd(optarg);
> >>  			break;
> >> +		case 'M':
> >> +			dirname_default_prefix = optarg;
> >> +			break;
> >>  		case 'C': {
> >>  			size_t bytes = sizeof(char *) * (n_config_paths + 2);
> >>  			void *tmp = realloc(config_paths, bytes);
> >
> >That breaks kmod for the usrmerged distributions, though.
> 
> Does it though?
> The *distro* has /lib -> /usr/lib,
> the *staging area* for installation does not.

Yes, currently the fully installed distribution has the symlink, at
least openSUSE does.

However, there is a goal to remove it eventually, and even now it is not
present at all times.

Thanks

Michal
