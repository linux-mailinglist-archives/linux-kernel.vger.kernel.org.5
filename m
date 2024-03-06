Return-Path: <linux-kernel+bounces-93251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B8872CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095EB28C477
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8DDDD4;
	Wed,  6 Mar 2024 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XiC+SUB4"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F8D52E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693331; cv=none; b=BuAFo4BwWyWJRU1w+jifPnhM1LDs0aqN3+wqg8tOGuXGqHx9oUOCHcBtNs7et/w6DhH0jwe5LIMUsm++hserg/mRZ8R+9wdhWrUoQGzty/tT5iZGzEVuniTZLxBILeN4A0G40LFp0d2yQKw//jk+FQ9KdcOtafRzTyhQD8GULEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693331; c=relaxed/simple;
	bh=u7eC58xUF/Q9U1FgZ3onEFjqy4ZYgGtENUDsCVzs/c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8gqQtDMcONQpaGmjSwmVFAQlPhj2Pk+TgNhOi1qEwmtBr3HZzTy0Rd3g+zjefa5uF2pDv4V+e4iWl5jgbOo8ScfRMPvQsb/PwS9xC7QxRD+3wI2EyRgJKpH+PvOpPBt00czfTomc949hl7ntAzFu6P8+HlJWE3QcaM+LLoMKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XiC+SUB4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so1812414a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 18:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709693327; x=1710298127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+KUQWhEvCJCpfREgFwyV70EN2GKCk/GEezppyY5IN3M=;
        b=XiC+SUB4XoQpA8SyU5v/1EiUUtvrpjYEMbntdX1Wu3yviupI4zShiZ43OFCSGvXjmW
         l0NgmTisVOIs2QnF8IDbUeBuBvO6EWnt0C5aDFJ8WyFCj68BvunKGjnpdZOQKSdcDYts
         pmSEab9PYI2xiFre+pNJmF2KYedzvKT/aR1qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709693327; x=1710298127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KUQWhEvCJCpfREgFwyV70EN2GKCk/GEezppyY5IN3M=;
        b=nu6vZrm3t8IbHVN+Ho9mrsyjgdsLRfGrLuxNeKegf/Wvdckm2BYOSha6jrG31ScGjE
         l8ECGO9ccQvoXFL5GXOzb1qsauFLfw0zg+ts2w457u/EqJplvIK+GCNw+zs4YHjXe3dP
         wJJz5QwIv7QKMg9FsOPNx9J/F0xn7V0vJtrB7CvlSRYhF1iaiuwzkOb65RVMKqhOUwVY
         wLRWprsiCp4RTFLlcO68yiOYmq6HwODYCq8iibDNkTbBB5KuCuU71fOFiLpdGhLdJ8N9
         fgtFcU3SMi+iE8xgYV9Gg8FHfhcw/HUGRmtQAqz5lsEvuLdRP8id0IYA2fREAcerfcTO
         HOIA==
X-Forwarded-Encrypted: i=1; AJvYcCUnswQPkSn+9e4gIhfkof7NWXkBA4nFvWzt/A7HZPWQaMrcmghzO5pr0pvwlL5qi0MxzOiSVWaSaLMQcW0vdgwCo4pw361f50ACnGNR
X-Gm-Message-State: AOJu0YwoqXJ/tE5mF3Mee5J5licP5fb16rR74AylwaCSyb7XhYzpy9RT
	DYgJtqxXGz27JCqWlakuSXYNbze+Juw1BgSJntOu4Goki10utbaxkylUJ8c98kTUWoV58UvrAKx
	vxHWRxA==
X-Google-Smtp-Source: AGHT+IGax/4ciiUpqvBUKtPepj5cFB1wirGgKqhCWQbOebeZonhKpk1mZF48IEzaGmnaL+7H/RTyEw==
X-Received: by 2002:a50:cb83:0:b0:565:7d4a:1d4a with SMTP id k3-20020a50cb83000000b005657d4a1d4amr8170085edi.8.1709693327582;
        Tue, 05 Mar 2024 18:48:47 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id t11-20020aa7d70b000000b005671a5d06d8sm3948237edq.51.2024.03.05.18.48.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 18:48:46 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a441d7c6125so146423366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 18:48:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXut03Lf9ttt46aSX8Tl9V70jcFoqMfPtLF1G0pgvDVeSODeiTxMjMwJTCG3I4kSWShFG5dTz0NwAGSnCCqxTWEhECkfwpqsWQfsm6f
X-Received: by 2002:a17:906:f10d:b0:a45:3792:fac4 with SMTP id
 gv13-20020a170906f10d00b00a453792fac4mr5217404ejb.69.1709693326381; Tue, 05
 Mar 2024 18:48:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306105150.06a456da@canb.auug.org.au>
In-Reply-To: <20240306105150.06a456da@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Mar 2024 18:48:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdTCEDaUPTMHUQXPQHuM8dhBi8yWbNAL11yE_ODqR_uA@mail.gmail.com>
Message-ID: <CAHk-=whdTCEDaUPTMHUQXPQHuM8dhBi8yWbNAL11yE_ODqR_uA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, Tong Tiangen <tongtiangen@huawei.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 15:51, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> fs/coredump.c: In function 'dump_user_range':
> fs/coredump.c:923:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
>   923 | #define dump_page_copy(src, dst) ((dst), (src))
>       |                                        ^
> fs/coredump.c:948:58: note: in expansion of macro 'dump_page_copy'
>   948 |                         int stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
>       |                                                          ^~~~~~~~~~~~~~
>
> Introduced by commit
>
>   4630f2caafcd ("coredump: get machine check errors early rather than during iov_iter")

Bah. If comes from that

  #define dump_page_copy(src,dst) ((dst),(src))

and I did it that way because I wanted to avoid *another* warning,
namely the "dst not used" thing.

But it would have probably been better to either make it an inline
function, or maybe an explicit cast, eg

  #define dump_page_copy(src,dst) ((void)(dst),(src))

or whatever.

                   Linus

