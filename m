Return-Path: <linux-kernel+bounces-40223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F183DCB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7428300B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713591CA90;
	Fri, 26 Jan 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ/CrNAP"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505B1C68F;
	Fri, 26 Jan 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280381; cv=none; b=TrRmmSAOD25mdlB4f2zrHMzXGAvMTMFiJVBY2gLmZaOTQypM7Sduwe6rjrGKVV3cs/1Kv4RtYkG/z/1cPePEX/BtITe2INOyOv1oz/gOppxfIU+W34YGX/esRmEIEuPWHQrhLBmbqj1uDDZ0QsLEX+9pqkA9dcFgmD8mlytlhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280381; c=relaxed/simple;
	bh=oaR+Rs+o1ovCFQgcjvwFQtMJjDy9R3/Hi0ALcXjhD+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEWFIsJj6SxMWxZiGC5GXoZSMoy2+Y6lUwNS03d+9ycfpb9XyBjNnINzV7uPIAjOmw8lL3QvGrzL9ZKrCsMX87qLQTrg2xHSo/Io2A3opWHy4jTx86tgNRm3BbPxtF5WOz7w+7yYEvJLVmmbVWj3bBOUEAoQJ8IrUlcgqOCQyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ/CrNAP; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-20536d5c5c7so287339fac.2;
        Fri, 26 Jan 2024 06:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706280379; x=1706885179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onb58WbK7XX3zmn2vav9TfD/9KJKtooABn9lOzetSkA=;
        b=UJ/CrNAPySnj10klWyYzcD4jebFkC0SXyvvoQqfqc7Y9JcfgV/hJj+DJuUNBrxDwgO
         cViH1DO0/aKKfu7FfaXVsxGQiI2Rs+BkO7J8b5csrxo7twcI/wXp/QWd564H8nOMmL57
         kF6zLtDhAX6qfdFe4tnLVZCnPXM8K8HhO8WOMy0lKyv9gzZkryU42u8IUdw7RKRznsyM
         n+rgV7usxs8yhSMY3RTaKir9zuBJCNr5/ieP1D7uXuWhw4dZ3KnUOKcQOP33pR8I0q3Q
         yFYhAYOpPBoeM1Xlfn5RXH9jz//G4wf9A1n5INLwFevg2785MwJ7P2Kmf4F9Fj/krTOG
         Kc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280379; x=1706885179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onb58WbK7XX3zmn2vav9TfD/9KJKtooABn9lOzetSkA=;
        b=VMRkwYhkgNZldtR6ouK7acknNSE5MKl34GxdtATyR4pqgNSIAr9GoWQDQzhUpzQ36g
         suT1BM9FhLZQqdPhNhb2xCoX8OquiYFcvet+gHxsq/2wmfJAdYR4jdobz9tkYrbaFaef
         utbufZ/a5fSugAqGXqwLs7FweURxD22+ziEZ4tx7RlSIdrnINp7Ii59/91ze/4Y1BQdP
         yBkBCH0J9VA8KGv9f351kzKqiVP88JI5Qj5qRYfFeli7pNyARfmHQdpJhHM+ZJt/zb1l
         s63BuZGl9nsJ6LFTDoiZnzkNQu+A4TZM7N36wcW7JN1ZYoQWVnqX6KPfsg0slA9DTBjB
         +2Lg==
X-Gm-Message-State: AOJu0Yzqfc3az61Owj7Nts9SSj8m1mUQxx57KnnQIYPPIdsp5rX4YjEP
	MmF6ZQfkCqF3jaqWmGuSmEqm6f9SiBIA7xnZMPgKyLlqhvEKjnGnUGoC3JsAj0VCOt+4jnJJxFx
	Bqf1f1FSoh+dKXpK0C31k6mLXMmk=
X-Google-Smtp-Source: AGHT+IHbFDM80qEM+b9WtcEXhSnneDa5QtW5uT7RRJDrIz0L/IFbADa3zja96a5BV5BviU//qtNfm7VHRJ+ajwGSNf4=
X-Received: by 2002:a05:6870:f78f:b0:214:8451:7da2 with SMTP id
 fs15-20020a056870f78f00b0021484517da2mr1019956oab.2.1706280379414; Fri, 26
 Jan 2024 06:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125235723.39507-1-vinicius.gomes@intel.com> <20240125235723.39507-2-vinicius.gomes@intel.com>
In-Reply-To: <20240125235723.39507-2-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 16:46:08 +0200
Message-ID: <CAOQ4uxgjgQbYy+cHKYM5ZqJm7hKT6oGTty6fvh1_zEX3krptJQ@mail.gmail.com>
Subject: Re: [RFC v2 1/4] cleanup: Fix discarded const warning when defining guards
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> When defining guards for const types the void* return implicitly
> discards the const modifier. Be explicit about it.
>
> Compiler warning (gcc 13.2.1):
>
> ./include/linux/cleanup.h:154:18: warning: return discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
>   154 |         { return *_T; }
>       |                  ^~~
> ./include/linux/cred.h:193:1: note: in expansion of macro =E2=80=98DEFINE=
_GUARD=E2=80=99
>   193 | DEFINE_GUARD(cred, const struct cred *, _T =3D override_creds_lig=
ht(_T),
>       | ^~~~~~~~~~~~
>

I did not look closely, but can't you use DEFINE_LOCK_GUARD_1()?

Thanks,
Amir.

