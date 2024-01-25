Return-Path: <linux-kernel+bounces-39063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F3C83CA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBEB1C248AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E913343E;
	Thu, 25 Jan 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aeeurj5v"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FE6EB67
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205621; cv=none; b=A1ReOiV/psEo1zIeImh2aj40sCnHtvR3hOc83IZIZkc9QzjkHAqBr+GnVkCoOo2/dE8/X3CQiDZlrPL3cqt6ML6FcCOHeCD9npe1knM+OOM43evajw/lhhUBpoleN9H0XU6crVkHNzhBfUoboIGi9TA/ADzeZ12Fz2czbq8ZN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205621; c=relaxed/simple;
	bh=mT3YLkbrBaeTvDcmwOHl1CS/WsjvlqLYlUMs+sUIjqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJXpWnDM/vKBhmJ+fEPyt8GC/anxaPP/blzN7RBnCxIAYohmpb6iIMEsxFmZHLPCySW6EO956Yt/QUMiW+hx+S+Ka+J3W9mwIoQ+4aKe7it/HDsWXVjTqdeK7gKXQXq6+paPBxuhYmOlgfHJUqGh5H7uso1TGkgR1iY8wVovW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aeeurj5v; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso347886839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706205618; x=1706810418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASf7ytaMtxVk0xSdSw9HpPo51B0EyC7CmU5TJyjG/94=;
        b=aeeurj5vUhzBjQCv2FWqw7xbsQXbYPNAe8V6krXVa2WoocWpvlAs/wNMb+qQeFKCv8
         MzdG1rxN5fRQ/nSIAsoZ0QXGCtkF4zMAMw79Dv+OmKp5dVtqWQUtdkiR8HKxTRQSqBJR
         Wdk7/Ygo4OO3jG9IMkZdmLUd5falLLTdrQpCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205618; x=1706810418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASf7ytaMtxVk0xSdSw9HpPo51B0EyC7CmU5TJyjG/94=;
        b=j8yTm/eAQsg7O2Ee8WcpXLqChpIVCXxGiBLzVJRrz94rXPxRX+4Nq9NYX3UeTz531U
         rSK/mBsdGpqA652Y0JMIQFIbwPugRQXtL2akIzKuVCkhr7g/+Nh+hvSFjqiu3U2/OrHQ
         KunddChs6M2CvdQ+tTAgNa/uZkADPZwGi+4tCUn2DQTvhA7+ium47iikNY1sKi2OyhtK
         SNMXdZwMLILP/nJhZQi+CZseBw4fgNg3DMafkpkGa8u/zMB1vOk0SKxd/slJAhFqeQST
         qlgQ74FhBdrAQHW7vSXOuHSxFYWU5G9e2v6PpjoYvTTFUH0rIEWFNUQGcD6U9kfI6v9K
         f4Uw==
X-Gm-Message-State: AOJu0YzuNBlpFk1ZImKg7OpX/8eJjQYTwtcSLqmRAO2nAbSJPJIdZ03R
	xLnyNFz5cgk2mroT6K5BIT1z0U5ZJpg9uj45lwc+9V7S0QR07G3lQnB2wS81+Q==
X-Google-Smtp-Source: AGHT+IGPddlDJxd6qVGArdVFf9Nrta2FGnNCUo/WGULBp9ke0+atvbxuIdfHfuqucOPAMPk2QtvD5Q==
X-Received: by 2002:a05:6e02:1a6e:b0:35f:ef30:d665 with SMTP id w14-20020a056e021a6e00b0035fef30d665mr115219ilv.41.1706205617791;
        Thu, 25 Jan 2024 10:00:17 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 73-20020a63004c000000b005cd835182c5sm13721878pga.79.2024.01.25.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:00:17 -0800 (PST)
Date: Thu, 25 Jan 2024 10:00:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Steve French <sfrench@samba.org>, Nathan Chancellor <nathan@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, llvm@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] smb: Work around Clang __bdos() type confusion
Message-ID: <202401250958.11B29BE48@keescook>
References: <20240123234731.work.358-kees@kernel.org>
 <CAMj1kXGcKBPnHOm6PtsrxePdv5a6AokB=qvMrwvGmPh_Uk6vsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGcKBPnHOm6PtsrxePdv5a6AokB=qvMrwvGmPh_Uk6vsA@mail.gmail.com>

On Thu, Jan 25, 2024 at 01:19:19PM +0100, Ard Biesheuvel wrote:
> On Wed, 24 Jan 2024 at 00:47, Kees Cook <keescook@chromium.org> wrote:
> >
> > Recent versions of Clang gets confused about the possible size of the
> > "user" allocation, and CONFIG_FORTIFY_SOURCE ends up emitting a
> > warning[1]:
> >
> > repro.c:126:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> >   126 |                         __write_overflow_field(p_size_field, size);
> >       |                         ^
> >
> > for this memset():
> >
> >         int len;
> >         __le16 *user;
> >         ...
> >         len = ses->user_name ? strlen(ses->user_name) : 0;
> >         user = kmalloc(2 + (len * 2), GFP_KERNEL);
> >         ...
> >         if (len) {
> >                 ...
> >         } else {
> >                 memset(user, '\0', 2);
> >         }
> >
> > While Clang works on this bug[2], switch to using a direct assignment,
> > which avoids memset() entirely which both simplifies the code and silences
> > the false positive warning. (Making "len" size_t also silences the
> > warning, but the direct assignment seems better.)
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1966 [1]
> > Link: https://github.com/llvm/llvm-project/issues/77813 [2]
> > Cc: Steve French <sfrench@samba.org>
> > Cc: Paulo Alcantara <pc@manguebit.com>
> > Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> > Cc: Shyam Prasad N <sprasad@microsoft.com>
> > Cc: Tom Talpey <tom@talpey.com>
> > Cc: linux-cifs@vger.kernel.org
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/smb/client/cifsencrypt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
> > index ef4c2e3c9fa6..6322f0f68a17 100644
> > --- a/fs/smb/client/cifsencrypt.c
> > +++ b/fs/smb/client/cifsencrypt.c
> > @@ -572,7 +572,7 @@ static int calc_ntlmv2_hash(struct cifs_ses *ses, char *ntlmv2_hash,
> >                 len = cifs_strtoUTF16(user, ses->user_name, len, nls_cp);
> >                 UniStrupr(user);
> >         } else {
> > -               memset(user, '\0', 2);
> > +               *(u16 *)user = 0;
> 
> Is 'user' guaranteed to be 16-bit aligned?

It's the first two bytes of a kmalloced address range, which I'm nearly
certain will be sanely aligned, as those allocs are commonly used for
holding structs, etc.

-Kees

-- 
Kees Cook

