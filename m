Return-Path: <linux-kernel+bounces-20916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85106828752
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5491C24058
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D338FAE;
	Tue,  9 Jan 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg9AJHqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7013985B;
	Tue,  9 Jan 2024 13:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132C6C43394;
	Tue,  9 Jan 2024 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704807992;
	bh=Y8dClzL0DyXiUZvR04jQRjbWXwHaw+NvJXiLsKNHI0E=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Tg9AJHqaaNGCUPJOhuQly0/lqpwkZduL5Chm7HR6b5sHUK9gXPwdHDfrmTDScU10x
	 n4zUtN7ovF8UzQSTicWKQS5V+h4gY0FL0mI4lfggZyzTfCkKZmm9ic+he0sF34vOzX
	 XzyJ322Hp/wTFYvYHoQwme1gQWhXvFZC0foDecxfyVoWdOHC3d6w9QgkHMC1oY/Xa/
	 nhcwAXhP5hs62hyXkNzoX5LPdJr07pJ686vEDFSpj/sTKApUXmuSyfPRn/rAdkJk+8
	 2VhcKo/G1JePexcX2Qfj1MXXNbCNAWAkGaiGekZGUaW0fX9zALAY5QSofOmtPfusTN
	 c+H05Yy8vZR2Q==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5968b4a073fso1626306eaf.1;
        Tue, 09 Jan 2024 05:46:32 -0800 (PST)
X-Gm-Message-State: AOJu0YzZm3YnwAcztIZu8WngMFLrIWi7x+mn9W8AyMNqyv36RzZTftgF
	szs1WVWigIeXAsceKhmNKKOaOrFyMEryNKSAv3k=
X-Google-Smtp-Source: AGHT+IHAeeTKTgVU0YbKbQdeEd8efx0On4S6jRiAZYJUqbROhxLVLmCCVlogLtraW7XlVYtWpLuYOSY+FtiX+gcdMDE=
X-Received: by 2002:a05:6820:820:b0:594:51d7:681b with SMTP id
 bg32-20020a056820082000b0059451d7681bmr3622145oob.2.1704807991365; Tue, 09
 Jan 2024 05:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:c13:0:b0:511:f2c1:11ee with HTTP; Tue, 9 Jan 2024
 05:46:30 -0800 (PST)
In-Reply-To: <20240109133429.31752-1-pchelkin@ispras.ru>
References: <20240109133429.31752-1-pchelkin@ispras.ru>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 9 Jan 2024 22:46:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ULRwKdDLs2XPwf6n9_HTHUJv1+aLmbWN5SqjUxw_xNQ@mail.gmail.com>
Message-ID: <CAKYAXd-ULRwKdDLs2XPwf6n9_HTHUJv1+aLmbWN5SqjUxw_xNQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: free ppace array on error in parse_dacl
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

2024-01-09 22:34 GMT+09:00, Fedor Pchelkin <pchelkin@ispras.ru>:
> Free the ppace array if one of the init_acl_state() calls inside
> parse_dacl() fails. At the moment the function may fail only due to the
> memory allocation errors so it's highly unlikely in this case but
> nevertheless a fix is needed.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  fs/smb/server/smbacl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
> index 1164365533f0..e6d0537cab49 100644
> --- a/fs/smb/server/smbacl.c
> +++ b/fs/smb/server/smbacl.c
> @@ -406,11 +406,14 @@ static void parse_dacl(struct mnt_idmap *idmap,
>  		return;
>
>  	ret = init_acl_state(&acl_state, num_aces);
> -	if (ret)
> +	if (ret) {
> +		kfree(ppace);
>  		return;
> +	}
>  	ret = init_acl_state(&default_acl_state, num_aces);
>  	if (ret) {
>  		free_acl_state(&acl_state);
> +		kfree(ppace);
>  		return;
>  	}
Looks good to me.
But rather than this, How about moving ppace allocation here ?

Thanks for your patch.
>
> --
> 2.43.0
>
>

