Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D0785E95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbjHWRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbjHWRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:31:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37FE7B;
        Wed, 23 Aug 2023 10:31:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1EF8F22151;
        Wed, 23 Aug 2023 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692811882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NinYELGE/FtFe+nmt4Bc2gSohu54SUypYHfwx7pJ9Xs=;
        b=wlFq2RtSK8xAAfU7vLdu1TpHJ6odEO+gKblslyReb/RvrRAmJlxSZgijfGq5Zl/Ou+ij+k
        w8oj8K0aJ6+BO13TJxEDuiMOstivf6nuzvrG9pu/F2SsuPN1J0pxLk95Ij8BK6dw/+BcFP
        buPxe6O407veaFtAxlp3Dbfvqjnm3l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692811882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NinYELGE/FtFe+nmt4Bc2gSohu54SUypYHfwx7pJ9Xs=;
        b=f5xN9z+DcnFkLXQaKahsCU0lJBHxHKsDfJ9vcjJ0+NR6AkFW9AtO6gzPAOIoMc9n02eNhh
        IX/gA3Y2FTEbMLDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 03FB92C142;
        Wed, 23 Aug 2023 17:31:22 +0000 (UTC)
Date:   Wed, 23 Aug 2023 19:31:20 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] depmod: Remove version parsing hack
Message-ID: <20230823173120.GP8826@kitsune.suse.cz>
References: <20230823170632.14377-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823170632.14377-1-mkoutny@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Aug 23, 2023 at 07:06:32PM +0200, Michal Koutný wrote:
> When kbuild on usr-merged distro like:
> 
>         make INSTALL_MOD_PATH="$BUILD_DIR_C/mods" \
>              MODLIB="$BUILD_DIR_C/mods/usr/lib/modules/$release" \
>              modules_install
> 
> (notice the '/usr' insert)
> 
> where
>         release=$(make -s kernelrelease)
> 
> depmod fails:
> 
> >   DEPMOD  /var/tmp/build/mods/usr/lib/modules/6.5.0-rc5-default
> > ln: failed to create symbolic link '/var/tmp/build/mods/lib/modules/99.98.6.5.0-rc5-default': No such file or directory
> > depmod: ERROR: could not open directory /var/tmp/build/mods/usr/lib/modules/99.98.6.5.0-rc5-default: No such file or directory
> > depmod: FATAL: could not search modules: No such file or directory
> 
> I used kmod-30-8.1.x86_64 (openSUSE Tumbleweed with usr-merge).
> 
> The explicit MODLIB doesn't cut it because of another path dependency in
> depmod's hack. That provision was added in commit bfe5424a8b31 ("kbuild:
> Hack for depmod not handling X.Y versions") (2011, v3.0).
> It says the hack is needed for module-init-tools < 3.13, 3.13 is from
> 2011 too. Actually, it seems to be a cautious action between 2.6.xx
> series and an expected 3.0 but it ended up as 3.0.0 and SUBLEVEL=0
> has been since then (so even the busybox's depmod should work without
> the hack).
> 
> Remove the hack to make builds with custom INSTALL_MOD_PATH on
> usr-merged distros possible.

As far as I can tell this is already merged as
4d15c9fa058e6dee09324cfc93f48858d4296019 in
https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git

Thanks

Michal

> 
> Link: https://lore.kernel.org/r/CAK7LNAT6mQ0EpwmKUCBhv9Acaf_qyGq4hu%3DXvSWRuZ-pNAFWVw@mail.gmail.com/
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  scripts/depmod.sh | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 3643b4f896ed..84311255e4bf 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -23,24 +23,6 @@ if [ -z $(command -v $DEPMOD) ]; then
>  	exit 0
>  fi
>  
> -# older versions of depmod require the version string to start with three
> -# numbers, so we cheat with a symlink here
> -depmod_hack_needed=true
> -tmp_dir=$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> -if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> -	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> -		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> -		depmod_hack_needed=false
> -	fi
> -fi
> -rm -rf "$tmp_dir"
> -if $depmod_hack_needed; then
> -	symlink="$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> -	ln -s "$KERNELRELEASE" "$symlink"
> -	KERNELRELEASE=99.98.$KERNELRELEASE
> -fi
> -
>  set -- -ae -F System.map
>  if test -n "$INSTALL_MOD_PATH"; then
>  	set -- "$@" -b "$INSTALL_MOD_PATH"
> -- 
> 2.41.0
> 
