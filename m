Return-Path: <linux-kernel+bounces-141308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA18A1CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31256B28F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354C194C67;
	Thu, 11 Apr 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RGdAa4ln"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53A2C184
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852507; cv=none; b=H/D3AxagLCjZQX7QLgcddMJ6gnBVrp0au2TWsXZvkrLuDjGU8akwP995w8USZNib0/mhRIc+M9mXN0jlED7cNNskhHeovBRSSelmXZwDJia/0n1N8tdkB8YYnbvoS01WZypOiAxUvymc808ww/mZ7XHrqgTQndMImnADhGfuvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852507; c=relaxed/simple;
	bh=j8D/Z53nu49+HJajrMHYyo77QiNAWVcuqSGJ2wCUdn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlM9myrmxfWR3DBR6Wunr2ZTQ/zt6CjXe1zkGV0P6YNzpdQmL9858eMJiDax59w8TyIQSvBhkdVbbAaFutXHepIAAPKBvI3rf4M95GbyskYYC7fvPg/ErvD3P1MGOmmSuwrzzHVxD+UGyBBoEXMxLYoxe3EFEhNTcNSmBkKRUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RGdAa4ln; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a522c00ce55so53829066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712852504; x=1713457304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nb6qBOubwpr++hT5NYcUKi/PePjm+psMH2yQSPywASo=;
        b=RGdAa4lnvTgkAW7khWtzRtNQ5fF5aDOSejl6QAt7HDZ+OBSKNoyoEdibGaUQXMPbY5
         FqvAPKiezRml+b/Xdl7FoF8stv//d4sZwFYv13ZkbJ0b04kPCMSRJcxKAqtYap64kQSK
         FmOBG8NRxmsElismgqtfL/500PAfYtHEpIk+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852504; x=1713457304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nb6qBOubwpr++hT5NYcUKi/PePjm+psMH2yQSPywASo=;
        b=wjWGl6Dkscoj+7ryxbmtUBtGCs0qUKKCknm3HG8F9znVhy4+63n9yJeWXoLCw+O8TN
         btBBAH5yIqM2iOT+o+OqrUGaC9epdEfmUlDP3ta3CVFu1DH/Cg1ToEOAcBgsn7aElYnU
         9ySgx484rFZ/LPJObMBzp5GI/Dvzmo4g0bnA9JnyXqskSyaiHDZvi5BrcLNa1sMvkPO1
         GdCEisk38cIcw/a0Owx8tgTRqBIyhI4YpyMkzYxFeNXvkN1KmY42k+vvrfBNzcu57ocS
         jGvDvtiTcKKA2UyhojWXXCkMNcTiFHsqcAJgnAKoMes1p0riZBpwtCfV9HL464b7NkoA
         Aq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH3MbEnD5pRfcL90/rAcPdSTxElXDe3YEscDa0MR5SkKfH/Oq4S+cdPMjZyG7qUKnSAjNeI6+k3lyRAGZWjeO2oklPbhj8n8HCjwhi
X-Gm-Message-State: AOJu0Yyb7zECZnZmcRBkpCOyLVnJGhnoPQWQpPKKiaR32fN1Mh4m7bnd
	J9N0sUPEqk5Ws8Xxc84+bAzdJ39Cq/FZuoLTT6xc1ZyAac+F+IMOCu0xN9YsSaLluvblhO1hrz7
	wAvKLgw==
X-Google-Smtp-Source: AGHT+IFKBbM+db/ETaRPkWr2SAYUPiD0LxUyMqmwOxE4thXN4Ks24dGj4ipbxNB7i2NavoKOFd4faw==
X-Received: by 2002:a17:906:f74b:b0:a52:1a82:7d3b with SMTP id jp11-20020a170906f74b00b00a521a827d3bmr182003ejb.0.1712852504385;
        Thu, 11 Apr 2024 09:21:44 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id du2-20020a17090772c200b00a52299d8eecsm441849ejc.135.2024.04.11.09.21.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:21:43 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a522c00ce55so53826666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:21:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVMaADW48YPmOqlr4Y4yKxwbkWa70uKc8Ikv1IyfWH0BO9zyHVsijV4cQfwacPWAHWNS9OCHhyvaNWj3IFK51H0yZ+ewAbeuHrgSLC
X-Received: by 2002:a17:907:7e8c:b0:a51:abb0:a8a2 with SMTP id
 qb12-20020a1709077e8c00b00a51abb0a8a2mr167343ejc.42.1712852503153; Thu, 11
 Apr 2024 09:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <20240411-adressieren-preschen-9ed276614069@brauner>
In-Reply-To: <20240411-adressieren-preschen-9ed276614069@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 09:21:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+8Cq82exnjf1HMsDODHwtnTOmfnGPMUf12ck9F-pyLA@mail.gmail.com>
Message-ID: <CAHk-=wj+8Cq82exnjf1HMsDODHwtnTOmfnGPMUf12ck9F-pyLA@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 05:25, Christian Brauner <brauner@kernel.org> wrote:
>
> Btw, I think we should try to avoid putting this into path_init() and
> confine this to linkat() itself imho. The way I tried to do it was by
> presetting a root for filename_lookup(); means we also don't need a
> LOOKUP_* flag for this as this is mostly a linkat thing.

So I had the exact reverse reaction to your patch - I felt that using
that 'root' thing was the hacky case.

The lookup flag may be limited to linkat(), but it makes the code
smaller and clearer, and avoids having multiple places where we check
dfd.

And that 'root' argument really is the special hacky case, and is not
actually used by any normal system call path, and is meant for
internal kernel use rather than any generic case.

           Linus

