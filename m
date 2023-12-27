Return-Path: <linux-kernel+bounces-11898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC2481ED28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0031F2172D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEC663B6;
	Wed, 27 Dec 2023 08:10:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AE63A8;
	Wed, 27 Dec 2023 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 27 Dec 2023 09:09:48 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id C5F378001F;
	Wed, 27 Dec 2023 09:09:53 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id C181418297D; Wed, 27 Dec 2023 09:09:53 +0100 (CET)
Date: Wed, 27 Dec 2023 09:09:53 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] kbuild: deb-pkg: allow to run debian/rules from
 output directory
Message-ID: <ZYvb0fd-buJuADSh@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231226135243.1393780-1-masahiroy@kernel.org>
 <20231226135243.1393780-4-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231226135243.1393780-4-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703664588-FC32BDFE-E9E5F8BA/0/0
X-purgate-type: clean
X-purgate-size: 1293
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Dec 26, 2023 at 10:52:41PM +0900, Masahiro Yamada wrote:
> 'make O=... deb-pkg' creates the debian directory in the output
> directory. However, currently it is impossible to run debian/rules
> created in the separate output directory.
> 
> This commit delays the $(srctree) expansion by escaping '$' and by
> quating the entire command, making it possible to run debian/rules in

quating -> quoting

> the output directory.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/debian/rules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 8f24a8e84bf2..6b2333e3cf96 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -19,7 +19,7 @@ binary: binary-arch binary-indep
>  binary-indep: build-indep
>  binary-arch: build-arch
>  	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
> -	run-command KBUILD_RUN_COMMAND=+$(srctree)/scripts/package/builddeb
> +	run-command KBUILD_RUN_COMMAND='+$${srctree}/scripts/package/builddeb'

That's a nice trick.

Reviewed-by: Nicolas Schier <n.schier@avm.de>

>  
>  .PHONY: build build-indep build-arch
>  build: build-arch build-indep
> -- 
> 2.40.1
> 

