Return-Path: <linux-kernel+bounces-93331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7CE872E19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8492862B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D58175B7;
	Wed,  6 Mar 2024 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D9amF4YW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD079E4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709700481; cv=none; b=eeZQUyapK0xJ47ymv97AiFQF0DhyI+EQzzekTekcXakcWNO5L+rGKztzasuDwVRTMXTuxKLmrwkDXgD9rcR4JEnFvrnVeVLpfydFjDQQYMJqEByQNuxE/26BRyk/35oKzygy1LFudl1hFhP5H6kEhIfKE8csit/nVuojGdzBK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709700481; c=relaxed/simple;
	bh=tSAjs9eK7HDF/sYHpxTRhAOh0V/U4g9EmR+uAcjvDXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0psD+L8Cb7QA5ewoXXSjRE5pfIuHf50N4NnNb6O6GpkYBYfX/H2kX89vnDh4+4waaDd3SJtBGI+oesyTBlgBghz9rCJzkEaUVIKHYuOpcVYmOcJ+qBlg5TWLMk6/FVk0xehuQDj01J17GMfY2DYPRbd69tp2pZFQpqvb5jSaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D9amF4YW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45c006ab82so1751666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709700478; x=1710305278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4CIdjZYesrl7XFeEbdapJDS4EOgCD8lVZBp8CLgu4c=;
        b=D9amF4YWHZFS2/ELgoymaZRjTs3eUYH5djUdi6vOkbDw3bvbsYfVSbWXNxd2yD8IqL
         dl7tpytPjThiSlNssArfxPxYFyy9ZKsJxIUnYX0ekiD9k2N7tb+pwHj/Hn1WD1WmrlTu
         sxDRjAklCQWMrQhgp4VtP49dpXfJw9wAjsCuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709700478; x=1710305278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4CIdjZYesrl7XFeEbdapJDS4EOgCD8lVZBp8CLgu4c=;
        b=XoEKRhj1a/GXtBmaCLG6xUSP6thug4HA2vzVw/fpKYkBf//jJze5Jc6rWJ7sxb5nXc
         AICJX6An85TJtf9UosgQzmy1HS+KiBS9pLrBT9QtPW2x8IaNhI8qlJaqIl3uFIh8dxTP
         HoP/hDU2+5/QSpfgz5T56/LT12Rg+DEyw5TyVSkUAeTOGAHVGV6ffzBJBYv/CfSakJPI
         6Ri5A8hNhn5Xu2P065sznfF5Bk0l69iPzSSFg37GT6Rspk2sOvlRAS8dTbSEkzpSDr0j
         uJ5bBYMXj2I8V3lgYdcskKDHld2LRH040eyX2fTdtYAkFl8lNkQxibno4bLG5eGNJjYF
         k4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBfy5Mc+aRlK65x44Ahq7gCCAU8viKfUYx+wIWA5RU2WV0sWE/9AfhMFTwJhkIqFq2/86dDsNlKNcSmXQBSOs/FraJ8NPWgUP7/xzt
X-Gm-Message-State: AOJu0YyNo3XDMzjGZUk69TQSZ3qdSSQTylk8unMtjrFW4mbW7O4nmvzB
	9TDrMNDLJktS95J1EzrGnQWeVkwHJvO7iAwbW/S3V0aRXzUtrjIEWpcCYOHeB+fjnFd11YOrTlr
	JSLVGHA==
X-Google-Smtp-Source: AGHT+IGzHVx0HyPMxMVeIyKvX29jIAHuiG9t7iHYDp6qFa6V88DqSn5VbkmEqi2lGy15Oi7+87P5ww==
X-Received: by 2002:a17:906:fb8c:b0:a45:a7e5:fb98 with SMTP id lr12-20020a170906fb8c00b00a45a7e5fb98mr2801095ejb.27.1709700478187;
        Tue, 05 Mar 2024 20:47:58 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a4452ed413asm6534584ejc.16.2024.03.05.20.47.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 20:47:57 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so19923366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:47:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiFcWhHAkYaZs9VRC/IIt8YwprGxYLPaQv48V8J7JzD0Rx95l0YbhOC6elLefqEd6FwXyq5Paq+cRnkECfuvArQrCrBuXmsBkt9ivX
X-Received: by 2002:a17:907:367:b0:a44:47e3:839b with SMTP id
 rs7-20020a170907036700b00a4447e3839bmr10781091ejb.10.1709700476605; Tue, 05
 Mar 2024 20:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306105150.06a456da@canb.auug.org.au> <CAHk-=whdTCEDaUPTMHUQXPQHuM8dhBi8yWbNAL11yE_ODqR_uA@mail.gmail.com>
 <20240306153703.499661d2@canb.auug.org.au>
In-Reply-To: <20240306153703.499661d2@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Mar 2024 20:47:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJLeR6tPcEmiRndhVtrPex0WavrFZ0UZHGjABVc=Tq1w@mail.gmail.com>
Message-ID: <CAHk-=wiJLeR6tPcEmiRndhVtrPex0WavrFZ0UZHGjABVc=Tq1w@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, Tong Tiangen <tongtiangen@huawei.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 20:37, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> +static struct page *dump_page_copy(struct page *src, struct page *dst)
> +{
> +        return NULL;
> +}

No, it needs to be "return src;" not NULL.

That

  #define dump_page_copy(src, dst) ((dst), (src))

was supposed to be a "use 'dst', return 'src'" macro, and is correct
as that. The problem - as you noticed - is that it causes that "left
side of comma expression has no effect" warning.

(Technically it *does* have an effect - exactly the "argument is used"
one - but the compiler warning does make sense).

Actually, the simplest thing to do is probably just

  #define dump_page_free(x) ((void)(x))
  #define dump_page_copy(src, dst) (src)

where the "use" of the 'dump_page' argument is that dump_page_free()
void cast, and dump_page_copy() simply doesn't need to use it at all.

Christian?

            Linus

