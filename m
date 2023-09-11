Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6333479BA05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbjIKWjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjIKJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:37:49 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F2EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:37:43 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon, 11 Sep 2023 11:37:34 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 2F96B800AA;
        Mon, 11 Sep 2023 11:37:35 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 1E614180D2E; Mon, 11 Sep 2023 11:37:35 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:37:35 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karolis M <k4rolis@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: fix kernel-devel RPM package and linux-headers
 Deb package
Message-ID: <ZP7f35Lmt6Lo3Y0X@buildd.core.avm.de>
References: <20230910124413.1479521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910124413.1479521-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1694425054-84FD9D8B-89BDB70F/0/0
X-purgate-type: clean
X-purgate-size: 1583
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 09:44:13PM +0900, Masahiro Yamada wrote:
> Since commit fe66b5d2ae72 ("kbuild: refactor kernel-devel RPM package
> and linux-headers Deb package"), the kernel-devel RPM package and
> linux-headers Deb package are broken.
> 
> I double-quoted the $(find ... -type d), which resulted in newlines
> being included in the argument to the outer find comment.
> 
>   find: 'arch/arm64/include\narch/arm64/kvm/hyp/include': No such file or directory
> 
> The outer find command is unneeded.
> 
> Fixes: fe66b5d2ae72 ("kbuild: refactor kernel-devel RPM package and linux-headers Deb package")
> Reported-by: Karolis M <k4rolis@protonmail.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/install-extmod-build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
> index af7fe9f5b1e4..8a7051fad087 100755
> --- a/scripts/package/install-extmod-build
> +++ b/scripts/package/install-extmod-build
> @@ -20,7 +20,7 @@ mkdir -p "${destdir}"
>  	find "arch/${SRCARCH}" -maxdepth 1 -name 'Makefile*'
>  	find include scripts -type f -o -type l
>  	find "arch/${SRCARCH}" -name Kbuild.platforms -o -name Platform
> -	find "$(find "arch/${SRCARCH}" -name include -o -name scripts -type d)" -type f
> +	find "arch/${SRCARCH}" -name include -o -name scripts -type d
>  ) | tar -c -f - -C "${srctree}" -T - | tar -xf - -C "${destdir}"
>  
>  {
> -- 
> 2.39.2

Reviewed-by: Nicolas Schier <n.schier@avm.de>
