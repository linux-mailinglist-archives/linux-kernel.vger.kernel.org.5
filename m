Return-Path: <linux-kernel+bounces-21574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFC829161
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26995288FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE86803;
	Wed, 10 Jan 2024 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5VcNG+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E90389;
	Wed, 10 Jan 2024 00:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B615CC43394;
	Wed, 10 Jan 2024 00:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704846497;
	bh=9WkGAQtgB05uUdmYyfkP3v6E2CugYXvS+PZbpjodQaw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=U5VcNG+Z0qVlRy24Oq6lB0Wgl6INOPZ5Z920J/v1W9PF8ZwmiddonaBJg+kQ1jT5r
	 xb3oJBOv0VpzBlf6hZr24PgBb3HiD1akbOFFpINacyFlzEw4dnbEpWA5xOv+TdS61c
	 JFQcfFAw2/Dx6sY6Mkm9q8gR1yF5xBBUjxtcfw9pztHpYpmvX0pjvk+bdHD15G1fiA
	 VXn5JSTer1pmpSwK6uztv0e/7pJ4VZiUgs56A0e1sgTuYD3tgAUv4aEXhSpOus/6TH
	 jPUCwtYtqN3EgkFGMbCOrOc6KMRTg+v5cNfaLT3FVM5WA06IMmKFqbDBVSYFPg03oI
	 KjgHW55a7Ti0w==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59502aa878aso1926059eaf.1;
        Tue, 09 Jan 2024 16:28:17 -0800 (PST)
X-Gm-Message-State: AOJu0YwelHCuHreN1ET0ksvIKjFtaxj3EvBhdaLurfNFO915UyYPSRf3
	lBRta6f2t1xJEHnTSVNkwjOnqLF96PXaVghabjI=
X-Google-Smtp-Source: AGHT+IFAIGn0a8vQ6sKHqEOZtiRlFmyG4Xc3vza2/LjNavKjlr5yWzi4FR6bJS8xLTbeUTb7wnIc+XqYNTEGsKJZBHA=
X-Received: by 2002:a05:6820:2382:b0:595:87a7:26a5 with SMTP id
 co2-20020a056820238200b0059587a726a5mr261025oob.18.1704846497045; Tue, 09 Jan
 2024 16:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:c13:0:b0:511:f2c1:11ee with HTTP; Tue, 9 Jan 2024
 16:28:16 -0800 (PST)
In-Reply-To: <20240109141445.6808-1-pchelkin@ispras.ru>
References: <CAKYAXd-ULRwKdDLs2XPwf6n9_HTHUJv1+aLmbWN5SqjUxw_xNQ@mail.gmail.com>
 <20240109141445.6808-1-pchelkin@ispras.ru>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 10 Jan 2024 09:28:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8g4k8kF+GyOv-jX5mw+PtKb9HxLrcWy5c4qpFwXFPTAQ@mail.gmail.com>
Message-ID: <CAKYAXd8g4k8kF+GyOv-jX5mw+PtKb9HxLrcWy5c4qpFwXFPTAQ@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: free ppace array on error in parse_dacl
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

2024-01-09 23:14 GMT+09:00, Fedor Pchelkin <pchelkin@ispras.ru>:
> The ppace array is not freed if one of the init_acl_state() calls inside
> parse_dacl() fails. At the moment the function may fail only due to the
> memory allocation errors so it's highly unlikely in this case but
> nevertheless a fix is needed.
>
> Move ppace allocation after the init_acl_state() calls with proper error
> handling.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ksmbd-for-next-next.

Thanks for your patch!

