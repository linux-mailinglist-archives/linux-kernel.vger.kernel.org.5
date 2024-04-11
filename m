Return-Path: <linux-kernel+bounces-139659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896B78A060B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A332883F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD213B2A9;
	Thu, 11 Apr 2024 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HlRizrIc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14686256
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803212; cv=none; b=jqp4wyZFI4fB/LGVXgIfcPK/zDcWuJk/SCF8LaurjoUwEA0G6ugSRklN4TQWats1qSF7yeUA3GY6Es1bjFNXUgq9xTncsI04qSq8u8fHLXWeiUC0lBuBQyIP2OdoYYoDiA6iNeb7OBNrDWI/WSyWNz9YqGSV+NcmawRoqdmg8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803212; c=relaxed/simple;
	bh=nAGR3QwbwJHg0yglTUbnjyXfmhwicyQzUNh2YPI0DmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojIGT/yiu2bhBYPSW4jsSdKAgcQVyh7oKudQkE49HqgYzM3WQGVZvDbX7Dkk2uo1W0+CbPuBEuJcaK+nJj4lDa4jrzW3WCvhDc4h/F3Z9H+Z1RK4V6Wzvd2FG0j8Hu1ukdMLcEiDfFA8qcZTlPZ0Pr+JvlMk/twU0Z5yU9nLkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HlRizrIc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so8435363a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712803208; x=1713408008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAti3DeKOVRxV5o0JR8+DzuFObIz3rfvlLJ6eRgxroM=;
        b=HlRizrIcZiOIfOk5s2FvIiqGadh73FKZAAWv7A0W39E8VBsm20/IBL8MGo8grVIA+V
         k9P64q+6gNlEHTIFoPJtsnl5DJX1bPNprAHsmtcG7FOmzS8nO0GZrTkB9fldDAaoFME/
         3WogMhL+jCnctmsKBS0Cy70TM3DFA0leBVCoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712803208; x=1713408008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAti3DeKOVRxV5o0JR8+DzuFObIz3rfvlLJ6eRgxroM=;
        b=k073JZtDRvHyA/nD/KodgYvIoV82Jo6+jtjXl+6V0QUEnpLgESHlS6vowZKsIZKXGj
         vZ6vAuQ6C9VEvZipJmd+Dk+9nC6ANETh908VXmcgYv2l2Gkx6goXe76sqyVHL5skot0F
         DfZ0Sh40sgWYO+ONUvl3E1DtaD3eV98GSIbqY5it7jBofl+xjjxdmyCHq1bSBHUqdUTh
         2SN8Jjjk5TGh0M+IaM1GhWTG5Krcf5nREazDJ9vqffUsRGGkhCCjlM7JQCded2psKKyp
         LXPjJuJJT/E0TdhOYS3HvJs2Bfxf4N+NTctNwvEdwZ9D51ua/EivOaA4Taeh/QwZZTxQ
         NyQg==
X-Forwarded-Encrypted: i=1; AJvYcCX2KvufC/e0kIzE0piXfTKnw7lrGs9VUBWMaE9WYuAoKEHfesJhUJJxVOWg1zf7ZHofHFSOP++Dps5K1v3GXnQ4lx0vveqb1rrQ/Mv7
X-Gm-Message-State: AOJu0Yxhv30qZhBKtEqmWqwEL5qwLuvy6I2dGhpj8BspD8f/s0naPvMT
	NjFV7E5pfEIChrVgSY/d1XaRlA7k+s+/qMm6yQW7HWEo/U9mxGc6EtciELuMpubRYftU+siNvIJ
	XvS/Tww==
X-Google-Smtp-Source: AGHT+IFcKSIHVMDpHf216ysjS6/KjSdmgT8xDtlWLo/ixRdJBezbroHtkwU2EduRr0h6AWw8K5fMng==
X-Received: by 2002:a50:d516:0:b0:56d:fc3a:2039 with SMTP id u22-20020a50d516000000b0056dfc3a2039mr2790011edi.8.1712803208399;
        Wed, 10 Apr 2024 19:40:08 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id i29-20020a0564020f1d00b0056fe8a3d7d3sm112650eda.8.2024.04.10.19.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 19:40:07 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5213f0f85dso133966266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtqisnkoai8BRpJhO9dU5OlMMuXEEExLNbQCAplgwx8w/aSiWWtCyKGBaRdjyh7IpMBNtEXrA66JEzhkGMw/UfVf/ufOtuLzrfaAnO
X-Received: by 2002:a17:906:184a:b0:a52:882:abaa with SMTP id
 w10-20020a170906184a00b00a520882abaamr2382187eje.76.1712803205798; Wed, 10
 Apr 2024 19:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
In-Reply-To: <20240411001012.12513-1-torvalds@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Apr 2024 19:39:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
Message-ID: <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 17:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> +               if (flags & LOOKUP_DFD_MATCH_CREDS) {
> +                       if (f.file->f_cred != current_cred() &&
> +                           !capable(CAP_DAC_READ_SEARCH)) {
> +                               fdput(f);
> +                               return ERR_PTR(-ENOENT);
> +                       }
> +               }

Side note: I suspect that this could possibly be relaxed further, by
making the rule be that if something has been explicitly opened to be
used as a path (ie O_PATH was used at open time), we can link to it
even across different credentials.

IOW, the above could perhaps even be

+               if (flags & LOOKUP_DFD_MATCH_CREDS) {
+                       if (!(f.file->f_mode & FMODE_PATH) &&
+                           f.file->f_cred != current_cred() &&
+                           !capable(CAP_DAC_READ_SEARCH)) {
+                               fdput(f);
+                               return ERR_PTR(-ENOENT);
+                       }
+               }

which would _allow_ people to pass in paths as file descriptors if
they actually wanted to.

After all, the only thing you can do with an O_PATH file descriptor is
to use it as a path - there would be no other reason to use O_PATH in
the first place. So if you now pass it to somebody else, clearly you
are intentionally trying to make it available *as* a path.

So you could imagine doing something like this:

         // Open path as root
         int fd = open('filename", O_PATH);

        // drop privileges
        // setresuid(..) or chmod() or enter new namespace or whatever

        linkat(fd, "", AT_FDCWD, "newname", AT_EMPTY_PATH);

and it would open the path with one set of privileges, but then
intentionally go into a more restricted mode and create a link to the
source within that restricted environment.

Sensible? Who knows. I'm just throwing this out as another "this may
be the solution to our historical flink() issues".

           Linus

