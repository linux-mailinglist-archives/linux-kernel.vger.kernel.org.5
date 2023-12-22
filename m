Return-Path: <linux-kernel+bounces-9779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774581CB4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3440F283E60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E811CFAE;
	Fri, 22 Dec 2023 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="w3EbMALc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EA1CF98;
	Fri, 22 Dec 2023 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 22 Dec 2023 15:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1703255200; bh=pq/YwoAnfz7EccKlETbBjyFhOlRdIcMYxuqlAMmwibM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w3EbMALcrWqNWshtXZfk/YcvQH/JUvMX0NWBb3CwA8mw4YfIXncs/jFBX/GsOXUMS
	 CVM9oHnUH1OMh6nzYdhHVD5uGdH/mPGkywDfH4PYq3LXmJ95voz1c9qReFoBD+mOkU
	 7wG2FglzsZbZLzOh3WC++yLpqXv/hLNUJSwm42PI=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 04E958041D;
	Fri, 22 Dec 2023 15:26:40 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id EB216180C9F; Fri, 22 Dec 2023 15:26:39 +0100 (CET)
Date: Fri, 22 Dec 2023 15:26:39 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kbuild: deb-pkg: hard-code Build-Depends
Message-ID: <ZYWcn3QUrndoiHN9@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231219181957.1449958-1-masahiroy@kernel.org>
 <20231219181957.1449958-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219181957.1449958-2-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703255200-A0EEC5FF-AB418A54/0/0
X-purgate-type: clean
X-purgate-size: 1117
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Wed, Dec 20, 2023 at 03:19:56AM +0900, Masahiro Yamada wrote:
> The condition to require libelf-dev:native is stale because objtool is
> now enabled by CONFIG_OBJTOOL instead of CONFIG_UNWINDER_ORC. Not only
> objtool but also resolve_btfids requires libelf-dev:native; therefore,
> CONFIG_DEBUG_INFO_BTF should be checked as well.
> 
> Similarly, CONFIG_SYSTEM_TRUSTED_KEYRING is not the only case that
> requires libssl-dev:native.
> 
> Perhaps, the following code would provide better coverage, but it is
> hard to maintain (and may still be imperfect).
> 
>   if is_enabled CONFIG_OBJTOOL || is_enabled CONFIG_DEBUG_INFO_BTF; then
>           build_depends="${build_depends}, libelf-dev:native"
>   fi
> 
>   if is_enabled CONFIG_SYSTEM_TRUSTED_KEYRING ||
>      is_enabled CONFIG_SYSTEM_REVOCATION_LIST ||
>      is_enabled CONFIG_MODULE_SIG_FORMAT; then
>           build_depends="${build_depends}, libssl-dev:native"
>   fi
> 
> Let's hard-code the build dependency.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

