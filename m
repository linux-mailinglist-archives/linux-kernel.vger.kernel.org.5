Return-Path: <linux-kernel+bounces-159794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D108B3423
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55F3B2306D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDD13F446;
	Fri, 26 Apr 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHQIXMFT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711413F436
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124036; cv=none; b=WeR5U9jn7+OTlnIhi5o/2g5qavn1Nb+LZoVFBRKZoOdFSMORHUoP3937ztPg4dduGd8nnaCb0AA+9Ux+0TrqkOlGZZ/RTOMPpV9e2Q/WJ5d79wJXQ2aUie4DlXt6TKtb4isuKu6UEa8TzJnCy17oV4//DOUgqvCCNM+nm/kQQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124036; c=relaxed/simple;
	bh=/pMH4enciC7L9Alrpd3tuEENkzHhRgIR4fDOAN+IbQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpTDmEoBVZfBZmIH8wvZhMl07qh0coQYRbjuOiOWykqcWLbPKqyAwHQTURAejHZX2GjT1YExVbh8+niAmlKAEM3BYBkNz0s3ZVVYvMiJbYBHTcC3YlojO10K2S9Yn7iV3G4dYiZN6v5BG8YEiWkmwWi+6CDQg32VUAZTrBGAAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHQIXMFT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572229f196bso2358357a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714124033; x=1714728833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPuH+vBjv5eyQAgbcQ7abdv/zl57lH4J1QFyOBw4iiY=;
        b=LHQIXMFTykhyOU7VZ1d2A7PPuEYRBLAUcT894E6Ixp+18A/jqro5yt62y4EWxT1KZN
         IobWW77dKwlSDwPnUPuZ4u0qh2tVj4xpUxHpgj7ou8RhAuq0BYpXYpLEloZynEE/edVQ
         IfvK2bPthJz7jPLhxqYECA7rB6p+R8ryp02hXGlNRWqRfY3T1yGL64uHjX3pGCrUzLYw
         TuK9uvDOgGiWCIEQCFDcr6ASWCThxgNTocOQgNOJqnpcfkfhlZN+sI1+r2SKr55KXoR7
         0sY6WggSREywVnqEygN9P5OQrK+XZuzLLy7QNgzsUmHu0Xf/1rgN161Xx9JJ8nL4o8ra
         /VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124033; x=1714728833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPuH+vBjv5eyQAgbcQ7abdv/zl57lH4J1QFyOBw4iiY=;
        b=YWN702T/QlnWrpwJPNXAL8jfRb2mHIiX6p3W/jtQxqnVGbRZiYAgFaMBoR5ZRwA8AJ
         xBOD6C1aFLIPVH+Yx7Vf/QSgVZSv5OcKYr1dDrcL1blnsM6fj8Xb1j64kdexoCrjxnrR
         BKqBwyG5o7Sj203LljZ5MSk25u++E/l0dCRWS2J50OxlDfJWD5zK58LLV6o7rQUlpGmZ
         CkU3yWJPMxdqkt3FlGIfSUqp0tIoSrd1qdKRT5CF6U1ZbJHGPu3tzbotPtV4HjiWkE3z
         d2AkOl72HDcbNxy0a/Aof3LB8H76v/3z8alMY5OGr6MqeqqqH69poP03CGYFRmyQneFJ
         jXYA==
X-Forwarded-Encrypted: i=1; AJvYcCVLlAmAXCU0Q382M3RS9hToYuTKyv+7wH/I4Ee08vdd+f28Kxu+b0j3HWvezM9TxwI8wCgx1VX3AKCWRl/SIykIyYoCi+kanA0z6v/3
X-Gm-Message-State: AOJu0YzFx+e9Hbmd+SebWprctc5L9cDnZv8xHTsLxk+Ngoe6gQ57+ZZk
	ZT4buQtsiqbocmUrf4ro1w+J4/wbubZBXWoH+hNsPeYvEuWJNkvYqCLYfU3vRuX8MgEvS33NUNC
	vOktcvFYe3blBspRtxwHkWHQOc1oPItEz
X-Google-Smtp-Source: AGHT+IHPezjE+CJztDyYGDoPWkYAoc0JFZBredYxiGUqz91b4Ostfrb6qpSw9Sq9J+ppKcnAjnV98p/aXleUwfeXIEM=
X-Received: by 2002:a50:950c:0:b0:56d:f47c:5308 with SMTP id
 u12-20020a50950c000000b0056df47c5308mr1351685eda.34.1714124032931; Fri, 26
 Apr 2024 02:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425211136.486184-1-zi.yan@sent.com> <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
 <7c233278-1006-4449-81b2-d473b18a66ca@redhat.com>
In-Reply-To: <7c233278-1006-4449-81b2-d473b18a66ca@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 26 Apr 2024 17:33:41 +0800
Message-ID: <CAK1f24=k0mq_PKKWG9KF4vbfk1xN9MrRoa5=DW-eT1YD-S5Vtg@mail.gmail.com>
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:26=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
>
> > @@ -1553,9 +1557,9 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
> >                    * page of the folio is unmapped and at least one pag=
e
> >                    * is still mapped.
> >                    */
> > -               if (folio_test_large(folio) && folio_test_anon(folio))
> > -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdm=
apped)
> > -                               deferred_split_folio(folio);
> > +               if (folio_test_large(folio) && folio_test_anon(folio) &=
&
> > +                   list_empty(&folio->_deferred_list) && partially_map=
ped)
> > +                       deferred_split_folio(folio);
>
> And now I realize that we can then even drop the folio_test_large(folio)
> check here!

+1

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

