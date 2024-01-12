Return-Path: <linux-kernel+bounces-24982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E182C59A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F271C22203
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35FC156EB;
	Fri, 12 Jan 2024 18:49:11 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB113FFE;
	Fri, 12 Jan 2024 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 779C11201D9;
	Fri, 12 Jan 2024 18:49:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 012A630;
	Fri, 12 Jan 2024 18:48:59 +0000 (UTC)
Message-ID: <3513adb04d17156242c92121a7aec4515c39bcf5.camel@perches.com>
Subject: Re: [PATCH v1] checkpatch: allow build files to reference other
 build files
From: Joe Perches <joe@perches.com>
To: Will McVicker <willmcvicker@google.com>, Andy Whitcroft
 <apw@canonical.com>,  Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kbuild@vger.kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2024 10:48:59 -0800
In-Reply-To: <20240112183420.1777576-1-willmcvicker@google.com>
References: <20240112183420.1777576-1-willmcvicker@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 012A630
X-Stat-Signature: 17cpn1z9nsynxtahe8bd53hk5acu46fw
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/NhfRSfoGQcPU3J0GljDoIYBRUUI5+348=
X-HE-Tag: 1705085339-497474
X-HE-Meta: U2FsdGVkX187bPcpwcUAJDeBsRl4Gr9KR7DMcuAG7TCxkJkddpIC8jQCo/n8mRlVqwdYZHETAka/N05R8RU0OrpaqPp41vobTAtkHyDqCZISuhCONLoDSElhB3DRQQRURBemPl48DqdVsdFc6b0FHtFlFha0CllYY3DhZun3txgmWq6H4mvlzX2ZPvUFS4GzOwmwiJtTqYEx5XDbwyzQ4i3EnAAMZYc/TiLuDIn0mTao6rsBIrSCa3+aeBX74H9kEsPdPJ/JONHPMdIqohUyDo5TD41VI1PRn5YtsuABJvEymmzFGXAAKtGWcSymlyFe

On Fri, 2024-01-12 at 10:34 -0800, Will McVicker wrote:
> Add an exception to the EMBEDDED_FILENAME warning for build files. This
> fixes the below warnings where the Kconfig and Makefile files reference
> other similarly named build files.
>=20
>   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the
>   filename in the file
>   #24: FILE: Kconfig:34:
>   +source "drivers/willmcvicker/Kconfig"
>=20
>   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the
>   filename in the file
>   #36: FILE: Makefile:667:
>   +	} > Makefile

No need to wrap here I think.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3785,7 +3785,9 @@ sub process {
>  		}
> =20
>  # check for embedded filenames
> -		if ($rawline =3D~ /^\+.*\b\Q$realfile\E\b/) {
> +		if ($rawline =3D~ /^\+.*\b\Q$realfile\E\b/ &&
> +			$realfile !~ /Kconfig.*/ &&
> +			$realfile !~ /Makefile.*/) {

Align to open parenthesis please.
It's not useful to have .* before the /

So perhaps better to be

		if ($rawline =3D~ /^\+.*\b\Q$realfile\E\b/ &&
		    $realfile !~ /(?:Kconfig|Makefile)/) {
=09
>  			WARN("EMBEDDED_FILENAME",
>  			     "It's generally not useful to have the filename in the file\n" .=
 $herecurr);
>  		}


