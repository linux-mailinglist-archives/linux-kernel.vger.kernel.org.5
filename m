Return-Path: <linux-kernel+bounces-31423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA84832E22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81086B2133D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE955E63;
	Fri, 19 Jan 2024 17:27:56 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC671F60B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685276; cv=none; b=eVKnBD2m1XqHWa6e6PX9zPcVBad3H3mb7bRZwnPzV1hFyr6xmwQzQgdapM7A+QUY4dAEeAmd2qRr5ZO6ZBJyqOOoWbuU67KqihEDlJOSgsNBRp1hBgVMR/FQYd77GaUpnghtOqTLuK9Xx2ABBbqM3s+mTi11AUHGTwUxCRYTCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685276; c=relaxed/simple;
	bh=WccHZtevh36Q68nlIwCeL4aylMukbYDvF4RnTnFhx+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IKGhVd4ceEovRuERc5fPtg6USiTk4nNJfco7aOI4iA5elguUWn4CDnFy/SJf6O5msgNEt7mVYQCokgJWTqsDi8PKeLo9UsGIRaeuoDVlSrL6AurZQLhTTQM3LrVXmF1+274OL0OtA3Nq6uRC1R8ArBHNYKVaqkk+5Ja0fK3EVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=none smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=shelob.surriel.com
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1rQsTL-000000005Ma-3Z7s;
	Fri, 19 Jan 2024 12:16:03 -0500
Message-ID: <d8a413037b0f6db6a3834f596bba3d038c2a62b6.camel@surriel.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
From: Rik van Riel <riel@surriel.com>
To: Yang Shi <shy828301@gmail.com>, jirislaby@kernel.org, surenb@google.com,
  willy@infradead.org, cl@linux.com, akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2024 12:16:03 -0500
In-Reply-To: <20240118133504.2910955-1-shy828301@gmail.com>
References: <20240118133504.2910955-1-shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-01-18 at 05:35 -0800, Yang Shi wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
>=20
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") caused two issues [1] [2] reported on 32 bit system or
> compat
> userspace.
>=20
> It doesn't make too much sense to force huge page alignment on 32 bit
> system due to the constrained virtual address space.
>=20

> +++ b/mm/huge_memory.c
>=20
> @@ -811,6 +812,14 @@ static unsigned long
> __thp_get_unmapped_area(struct file *filp,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0loff_t off_align =3D roun=
d_up(off, size);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long len_pad, re=
t;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It doesn't make too much se=
nse to froce huge page
> alignment on
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 32 bit system or compat use=
rspace due to the contrained
> virtual
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * address space and address e=
ntropy.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ENABLED(CONFIG_32BIT) |=
| in_compat_syscall())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return 0;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (off_end <=3D off_alig=
n || (off_end - off_align) < size)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

