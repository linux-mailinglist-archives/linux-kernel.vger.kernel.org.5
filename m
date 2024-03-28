Return-Path: <linux-kernel+bounces-122204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE588F36D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E221F29DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38218EBB;
	Thu, 28 Mar 2024 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="etO8HyR4"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3518D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711584537; cv=none; b=J7+V3ykR5qvuhcTcd1YG1shOstUF34xrvqdMSFwnQgPZkHz6an3tjw2eMDGWA5LDc3mfmZ+8r5f6v58Z8PDh09EgrIsAeR6ceo5P4qT8QKWiItwWmznYTarYviqzCQpxbePs6vz/idmWN/KcQEiF3NSkfqMcI/Hb+jx7RxmGcCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711584537; c=relaxed/simple;
	bh=+hVgvJhRkV9zAky4dYe3lOHAIoU37e/j8bI++LQDzpM=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=cIP1vRgkN/l44cVkEHt2x8sHm0UPwpyA5SpkweVG7mwlCuC9eVJ6Hpb4KQa/tlNgIvdMUlXZcNoVDqVbhptfsUeoopOOqi9Hr6WKGWjO0pQQo30SkKvDcEO1FyXVFlgNJ/2HNLGi9uzHPmEpdS7puAmcxa6xbaml5UEnGsLJnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=etO8HyR4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789f00aba19so25835085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711584535; x=1712189335; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hqu5KZ7ANiufBKIVwu8ItEdmpm8TUn3oazGE5q2jtwQ=;
        b=etO8HyR40NrGl3wB4MpxK+0TU/OOsBLu43JRTLcH4VslHBbYjw8X7N9foIwpJ9Ua8O
         EF9+NzNG7IzQchCIJsFZLG61V7PjxCHoX7opurPv8az1jH8Brvq2PcvBvMsANCD0f6X2
         bk/LhIgtXZlvTG1ot4z0BucPeBZWgKpXAe7T3MRmlMSAVbozzqvihr87n2ud6qN6f5E3
         c3VfbNuyiTKbwhsrG/nzlE87vkyWt4cGfz3nWwH9oNe7BGt235q8i+u53X7BVDZnZ2iN
         FQ6s41+YSvATGuZfUDBNgpor/uLJ5FqFlxmLMyL8WW9rhJzipwty0RuWNWrEynDQfRm2
         tUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711584535; x=1712189335;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqu5KZ7ANiufBKIVwu8ItEdmpm8TUn3oazGE5q2jtwQ=;
        b=DgMeLuiCbVK7MxTY5xGfsXa5PjU7omBEKciAyR0u5V7aQmBVGgQ7qdIzLnJAfDBOgk
         r1ewGKXYf3htXCw46E9WBStY/g4dH7k0/sv49BkOe3FX+TY3u4pLMXHEF1thk3tTeqBU
         fgqe3T1wUw9c91GkG3oLM/jYVFcUbe3V0YwWh6AdiFfM7y6Ozq9LtUdqbCC/YiZRNzbM
         KXEMnzaF4i9CM6TPfmnyDkLItwjazakPRNRaMYa8fpweFFkvGxpno84b+2gYiWM1V6tN
         Qs83uJ+033j+s0Yd8iPXLKpPYFZlyWMBj7UxZEAP38j/+VXp09msWsvXblBODbwYBx0x
         8N/w==
X-Forwarded-Encrypted: i=1; AJvYcCXvXffa60bGm9gH6Y3ME05vINxfKyqVjQbW5xGy1N4Efwx7v8CSBUha7Bsz0JCkxHncIu7Vhre5gzpQr9ZC+3CP+gCdwZ8Hy/KCZ6+3
X-Gm-Message-State: AOJu0YwOI0VhqWzl4Yoh7OFIIzG2wrh/tKT3CWiOojsSlGBxt1oQn84u
	ckYkCCYyzgvRhxAp9UJkoGeq/Dr0ObcLnotz7Eepy4QkYfoRXW4K7QH4KddiRA==
X-Google-Smtp-Source: AGHT+IEuIiA6yL+s6fMX+s9dyz58T/Y6tcHTA6rblF3C6b6P+/XkoqUiOpYvjDoJ26nVCFVeRsH9Lw==
X-Received: by 2002:a05:620a:2016:b0:78b:b5d4:d86e with SMTP id c22-20020a05620a201600b0078bb5d4d86emr760810qka.40.1711584534784;
        Wed, 27 Mar 2024 17:08:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a146f00b00788481cdf4csm111872qkl.111.2024.03.27.17.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 17:08:54 -0700 (PDT)
Date: Wed, 27 Mar 2024 20:08:54 -0400
Message-ID: <54c3ff6d6a7c8e8aed0e5e3facf00271@paul-moore.com>
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
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: use u32 as bit type in ebitmap code
References: <20240315173234.637629-1-cgzones@googlemail.com>
In-Reply-To: <20240315173234.637629-1-cgzones@googlemail.com>

On Mar 15, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The extensible bitmap supports bit positions up to U32_MAX due to the
> type of the member highbit being u32.  Use u32 consistently as the type
> for bit positions to announce to callers what range of values is
> supported.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v4:
>   - apply format style
>   I hope i addressed all comment from [1] in [2].
> v3:
>   - revert type change of unrelated iter variable
>   - use U32_MAX instead of (u32)-1
> v2: avoid declarations in init-clauses of for loops
> 
> [1]: https://lore.kernel.org/selinux/67cee6245e2895e81a0177c4c1ed01ba.paul@paul-moore.com/
> [2]: https://lore.kernel.org/selinux/CAJ2a_DdLR40CB6Ua5cNjYhtexNmGkzQRsVrJn+dhVaZO-aVKsA@mail.gmail.com/
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/ebitmap.c | 31 +++++++++++++++-------------
>  security/selinux/ss/ebitmap.h | 38 ++++++++++++++++-------------------
>  2 files changed, 34 insertions(+), 35 deletions(-)

Merged into selinux/dev, thanks for following up on this.

--
paul-moore.com

