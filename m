Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587C17FCD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjK2DkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjK2DkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:40:02 -0500
X-Greylist: delayed 2121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 19:40:07 PST
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6431AD;
        Tue, 28 Nov 2023 19:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.master; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description;
        bh=sfSRZz+tS/jgANowDisFfaKV4+KVzpwYgUqmEwwZxuw=; b=v5TF0+LNwHfL76OBlQ5vagPgWg
        PfJeZ9p1jv3lRHH7rB02doABPNJL0L3CC59HvJoScpjfo6cEs8h46ewWikRk5VFySq6Ju6nMhkkbu
        EUvmAWKkU3WAxJb/rDu40uFJygcWPq62wNRrWkkzyabAmyYKN8iRXpAXcQ/LLHHWgcOFcZ+nCi61L
        AybG5gg4dYJwhZAm+luDzm58GlGaEwuBsbQXAajw87jwJ00ltEDSYr3xgsx6lFKsFcfUh5TIunpOk
        VxKFhpQFHv2dIHXzX0kPJBdBABabZ/1mZJIJOxJHdCpvxii1llzBAMYu6TH761wxPMpW4xze5/bn1
        r0VeHpdg==;
Received: from guillem by master.debian.org with local (Exim 4.94.2)
        (envelope-from <guillem@master.debian.org>)
        id 1r8AsN-00GS5r-I6; Wed, 29 Nov 2023 03:04:35 +0000
Date:   Wed, 29 Nov 2023 04:04:33 +0100
From:   Guillem Jover <guillem@debian.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kbuild: deb-pkg: remove the fakeroot builds support
Message-ID: <ZWaqQeR8Rcx-0b4Y@thunder.hadrons.org>
Mail-Followup-To: Guillem Jover <guillem@debian.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
References: <20231128235356.527642-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128235356.527642-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, 2023-11-29 at 08:53:56 +0900, Masahiro Yamada wrote:
> In 2017, the dpkg suite introduced the rootless builds support with the
> following commits:
> 
>   - 2436807c87b0 ("dpkg-deb: Add support for rootless builds")
>   - fca1bfe84068 ("dpkg-buildpackage: Add support for rootless builds")
> 
> This feature is available in the default dpkg on Debian 10 and Ubuntu
> 20.04.
> 
> Remove the old method.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v3:
>   - Remove DEB_RULES_REQUIRES_ROOT=no again
>     (resent in order to clarify which one should be applied)

Thanks, as this variable is supposed to be defined by the build driver
(such as dpkg-buildpackage) that calls debian/rules, as covered in the
rootless-builds.txt spec.

> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 0c3adc48dfe8..a81dfb1f5181 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -109,8 +109,6 @@ debian-orig: linux.tar$(debian-orig-suffix) debian
>  		cp $< ../$(orig-name); \
>  	fi
>  
> -KBUILD_PKG_ROOTCMD ?= 'fakeroot -u'
> -
>  PHONY += deb-pkg srcdeb-pkg bindeb-pkg
>  
>  deb-pkg:    private build-type := source,binary
> @@ -125,7 +123,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
>  	$(if $(findstring source, $(build-type)), \
>  		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
>  	$(if $(findstring binary, $(build-type)), \
> -		-R'$(MAKE) -f debian/rules' -j1 -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
> +		-R'$(MAKE) -f debian/rules' -j1 -a$$(cat debian/arch), \

Since dpkg 1.14.7, dpkg-buildpackage uses fakeroot if available, so
regardless of anything else this removal seems safe.

>  		--no-check-builddeps) \
>  	$(DPKG_FLAGS))
>  
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index d7dd0d04c70c..2fe51e6919da 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -36,19 +36,13 @@ create_package() {
>  	sh -c "cd '$pdir'; find . -type f ! -path './DEBIAN/*' -printf '%P\0' \
>  		| xargs -r0 md5sum > DEBIAN/md5sums"
>  
> -	# Fix ownership and permissions
> -	if [ "$DEB_RULES_REQUIRES_ROOT" = "no" ]; then
> -		dpkg_deb_opts="--root-owner-group"
> -	else
> -		chown -R root:root "$pdir"
> -	fi
>  	# a+rX in case we are in a restrictive umask environment like 0077
>  	# ug-s in case we build in a setuid/setgid directory
>  	chmod -R go-w,a+rX,ug-s "$pdir"
>  
>  	# Create the package
>  	dpkg-gencontrol -p$pname -P"$pdir"
> -	dpkg-deb $dpkg_deb_opts ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --build "$pdir" ..
> +	dpkg-deb --root-owner-group ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --build "$pdir" ..

If you want to make sure dpkg-deb supports that option, perhaps add
«dpkg (>= 1.19.0)» to the package Build-Depends? If that version seems
old enough to be assumed to be present, then unconditionally using it
seems fine.

>  }
>  
>  install_linux_image () {

Otherwise, the change LGTM.

Thanks,
Guillem
