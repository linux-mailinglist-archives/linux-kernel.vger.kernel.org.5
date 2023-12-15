Return-Path: <linux-kernel+bounces-384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA2814054
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74068B21FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507815CF;
	Fri, 15 Dec 2023 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP0zJSAQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCDEC8;
	Fri, 15 Dec 2023 03:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDE1C433C8;
	Fri, 15 Dec 2023 03:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702609254;
	bh=+F+HH1od62WSI2Xzj+oCa5iYNSg0EkSDaFRNOcuhUyE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tP0zJSAQpL6B2DXF01BKoZQHOnAtM1xZi0tWeo9+CPGKnUljK/yq6gqEUS9aqIEer
	 paLW18kLnjoMbqDv/smSZuxiFUzstFHp4t9rjS+iJ2Q7goZLzuMcxee2AbSBONrugU
	 uAL7tbG0UfmeJb0mGpfGVjIjGJMj+Enz8HoAYWco9W48y7KXK1JRzpQLogfcKbswWt
	 yAB0eVrbci1mI9hj2idiZkI1AU3Q+4gOufkKB5lW3iejwLuXrkviVQKGh3ILFzYUS9
	 f9J5qcNJ5UujzvXem0SGHQHsBDNNNMxYvJtj6Z6Kxk31p95vJkARr2UoCFefNzcMVB
	 t2gXVcGyp43/g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Dec 2023 05:00:48 +0200
Message-Id: <CXOKLV16E1FZ.GB1X2HLFVY08@suppilovahvero>
Cc: <davem@davemloft.net>, <dhowells@redhat.com>, <edumazet@google.com>,
 <jmorris@namei.org>, <keyrings@vger.kernel.org>, <kuba@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <paul@paul-moore.com>,
 <serge@hallyn.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH next] keys/dns: datalen must greater than sizeof(*v1)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Edward Adam Davis" <eadavis@qq.com>,
 <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
X-Mailer: aerc 0.15.2
References: <0000000000009b39bc060c73e209@google.com>
 <tencent_B0E34B701B7025C7BAFDBB2833BB9EE41B08@qq.com>
In-Reply-To: <tencent_B0E34B701B7025C7BAFDBB2833BB9EE41B08@qq.com>

On Thu Dec 14, 2023 at 4:33 PM EET, Edward Adam Davis wrote:
> bin will be forcibly converted to "struct dns_server_list_v1_header *", s=
o it=20
> is necessary to compare datalen with sizeof(*v1).
>
> Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaime=
d immediately on expiry")
> Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/dns_resolver/dns_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index 3233f4f25fed..15f19521021c 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *p=
rep)
> =20
>  	if (data[0] =3D=3D 0) {
>  		/* It may be a server list. */
> -		if (datalen <=3D sizeof(*bin))
> +		if (datalen <=3D sizeof(*v1))
>  			return -EINVAL;
> =20
>  		bin =3D (const struct dns_payload_header *)data;

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

