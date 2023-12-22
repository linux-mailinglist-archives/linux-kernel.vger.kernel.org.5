Return-Path: <linux-kernel+bounces-10109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2281D058
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F3FB24347
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB435EE3;
	Fri, 22 Dec 2023 23:16:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212335F08
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 25AC91C18F6;
	Fri, 22 Dec 2023 23:15:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 1B2202F;
	Fri, 22 Dec 2023 23:15:52 +0000 (UTC)
Message-ID: <2b294dc33ea64d1d605cf146741d92677b13006a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: ignore deleted lines for comment context
From: Joe Perches <joe@perches.com>
To: Andreas Dilger <adilger@whamcloud.com>, Andy Whitcroft
 <apw@canonical.com>
Cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Date: Fri, 22 Dec 2023 15:15:52 -0800
In-Reply-To: <20231222230551.95425-1-adilger@whamcloud.com>
References: <20231222230551.95425-1-adilger@whamcloud.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1B2202F
X-Stat-Signature: 5yyep1gtej9546mqjphbfijenq453ew5
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18+H6BsdhjeerElRaYNGOIFSDXjpfyiOjg=
X-HE-Tag: 1703286952-821529
X-HE-Meta: U2FsdGVkX18dC6vbJYTiWeNzbzEaTsD/YvjoDuhszMpjmaknWpG43WBy0u1en70s2QJyT+nXawavE4dTXsTBsr+1Dwg8C2bYDfG0usEW5T8YVBTFp3HK1S9K49Zg4NrG1c2yqiMe7DWMd4gCASoGQPHY3JAkt49lXkZAkzkRyljcohT7qYnyUlhI+LVw53oH9R8xn6LmK4NmlSvAs3kwySTL/StH5TSG9Ruws7RXo9bAOTp+eaLpkPNBdXyvP88Ry2+tyfp7hJ+zBXHbKqjz2WeYsthQNeT5yyB0W9tivSTvZ/DbhmuNguJnrHGwnhU16PJdWghGbx38W2y5Rvuk631YC3y1n38PLYmNR0e6GS8aWaTu+3OzUPcLbv7w+i6D

On Fri, 2023-12-22 at 16:05 -0700, Andreas Dilger wrote:
> From: Andreas Dilger <adilger@dilger.ca>
>=20
> Don't consider lines being removed by a patch as part of a comment.
> Otherwise, false "WARNING: memory barrier without comment" and similar
> issues can be reported when a comment does exist on the previous line.
>=20
> For example, a change like below was previously incorrectly flagged:
>=20
> 	/* matched by smp_store_release() in some_function() */
>  -	if (smp_load_acquire(&list->tail) =3D=3D head))
>  +	if (smp_load_acquire(&list->tail) =3D=3D head) && flags =3D=3D 0)
>=20
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

OK, but:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -1972,7 +1972,8 @@ sub ctx_locate_comment {
>  	$current_comment =3D '';
>  	for (my $linenr =3D $first_line; $linenr < $end_line; $linenr++) {
>  		my $line =3D $rawlines[$linenr - 1];
> -		#warn "           $line\n";
> +		#warn "LINE($linenr): $line\n";

This is a superfluous change

> +		next if ($line =3D~ /^-/); # ignore lines removed by patch
>  		if ($linenr =3D=3D $first_line and $line =3D~ m@^.\s*\*@) {
>  			$in_comment =3D 1;
>  		}


