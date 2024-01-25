Return-Path: <linux-kernel+bounces-38807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AB83C63A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD71F22FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498863417;
	Thu, 25 Jan 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ApDpCl9W"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AC6EB74
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195604; cv=none; b=ehoi1uW/BqZqAgY2l9DSbsdpK2foFM1isnnbhObw9F10bvFdivl9zf3wA70syKlmlQWIHMw5mfBOonRvFZtyebO0LZyFhvqvhYIpDLnjXm3diV/UZkroR/lUfqehAzJd+9uECkI364nTQstQeNid5nlC7IYaoLh/+s7ch99Y0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195604; c=relaxed/simple;
	bh=1+gWzxHdDlvUYh7j8de4u19xdmEQhVFoU39PTbIkN2E=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=KZCZzV5Sp4GNg6DKMLGkv0M1gtbgYNlYl+KVsCMrA5zrcHH8LWaC6l4FzooXlojLZFGYhoNVQJ01oYeCDs2MzSnGH8NaZvgX2WyWEkv9fCBsRiQ8JjYar6m3Ar4XkrjKOsOvzM3EeJBt6jT0jje3OUCmIK7ZWEQ8NJSNnrxRofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ApDpCl9W; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783b7ec94d4so111818185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706195601; x=1706800401; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8QfX+fXMC//GQOsMmawYMOFIuyxE057vSsZZYnIogE=;
        b=ApDpCl9WKbxlFmKiIncvTlnmk9JM6IOLvC3SIXbIgOfwx49W2FemHoAbiZrMJ+3wJS
         Bni1LaAiamlDI6boEdKLBxFNPLT2DIP4RwNcyhIIIEKihFMH5KLdLffNUJy0jRQ3dnQF
         43KzNq8kimi002Y1KZHPGn2/jKpmKXahnWre5NSUbtW5EDjJRE/EbAa3ixAYRI0gRhwc
         L55iOFw2X7EDDX0352cD1cDcuCKsLrG2pjmUp03iD1sQIvZ62zeUrtN/yCIqJDAWEQhS
         I5vCP6HXy88p29Y3iXMmN0xovsXj1GP/SsPx0nVE8J2kY8Gy/+cnabtb4ya5BYc/Cixt
         SaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195601; x=1706800401;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8QfX+fXMC//GQOsMmawYMOFIuyxE057vSsZZYnIogE=;
        b=bRzmDUzRgkoINDdBLlR3KaONJ4GQIEaSLOyobj3OuyUdekud4hG1L3fKWDtGkceMr/
         2F7Dzxf3dX5ugTvv8E77gNujVXyMokhlLIJeIpS/os/nKrPsseteCbin5/v09sxg1qJv
         I7+C1tmTBHNWpxQB4TU1K7l9RR6p3a2GjT49ZXXL7j0MHQxQi7kFfjHGKAMunE+gorCi
         V2cgKddGdjPCtvBCT74uHobV7aUQDhP+1zyJ9KulzdqLf9cG/MLO0PgfMU+F0078+wFM
         tA5LJJWPK//mk2x/8vFGCjf9Md6up7NkfTWcZoIGiMt5ZAzc4g1EgO9d1dNp42rB7Ts6
         CI2g==
X-Gm-Message-State: AOJu0YzBeUVoxRi9emHCryzC5Yl42UFyqhaOrq0Keg5qjr+RG8MrLRfz
	J69ccxLfzcb7ACWpDOOXLxcbvAW1BLIS1vkZcwQxvwpbxDUihgQlR+uXcEnSCo6mJKPxYcEJAxM
	=
X-Google-Smtp-Source: AGHT+IH++ju+QnC7zWMmKmf82XR22Nz1qLA0O29ZEqkNG6+qEZ7JpdQbGUJ0jC6kQDzg6KIzJ4GsuA==
X-Received: by 2002:a05:6214:c25:b0:67a:a721:caf3 with SMTP id a5-20020a0562140c2500b0067aa721caf3mr1242821qvd.84.1706195600876;
        Thu, 25 Jan 2024 07:13:20 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j6-20020a0ce006000000b006817a88541dsm5526504qvk.75.2024.01.25.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:13:20 -0800 (PST)
Date: Thu, 25 Jan 2024 10:13:20 -0500
Message-ID: <1d15909e568d1571f08d430213ad77ff@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Kunwu Chan <chentao@kylinos.cn>, eparis@redhat.com
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] audit: Use KMEM_CACHE instead of kmem_cache_create
References: <20240124060224.463335-1-chentao@kylinos.cn>
In-Reply-To: <20240124060224.463335-1-chentao@kylinos.cn>

On Jan 24, 2024 Kunwu Chan <chentao@kylinos.cn> wrote:
> 
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  kernel/audit.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com

