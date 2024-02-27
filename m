Return-Path: <linux-kernel+bounces-82910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E3868BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56ED288C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B713698E;
	Tue, 27 Feb 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOUWJKmx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012F130E27
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024810; cv=none; b=MZfOpZYx9+AW2u/nOB7ID5RJaWmiTbXNA0T90kp/1HPAAOJ1JyNygZdtx59ynjaXXdiXCJustZ9DqrFfFSuR7Vv1krab13WL7kH7UETvtXxNSONik9X0RhVnrYezEWKtqfwPqfMeO9THLrpWNc++lPmx+No0Bk+C1qhIstoEWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024810; c=relaxed/simple;
	bh=nWDZ2zj8RhLA+e/LR6ZW41Ft+IJodiJtEXLpMcaC7rM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auYadoqYUMNYumMRXwFGT7R1Cc4epeE+/tkFbJy52X2PHRfmB+Yg76jbZepsHcHGB6HQ25f50RnRMRHXJcyr4xM+w9P1gVvNCV57IL172ekGwRD4lc7bAlOd8PtQRBuOyaDmuYGPCK45jDZTLR3fgZ99FM5PBfaWr3tWpR2VT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOUWJKmx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709024806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nWDZ2zj8RhLA+e/LR6ZW41Ft+IJodiJtEXLpMcaC7rM=;
	b=SOUWJKmxtkEj0BjH3MU9Lo2+Ti9wam+HtF7gxOG0COyco51Fg+KnxufmSxDtatw/MEfxH7
	Uk0p8NJfmUgRuHDHaD8476gsqWObg/wzT6PtVtVt1gBpkqx2VYduDXwxF9F5hPzyWqv1Zq
	NKrvwVYZijhwEs5+Q1YBtyKm/m8ut1s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626--md08Yf5ObmEQyIU4Pv4xw-1; Tue, 27 Feb 2024 04:06:44 -0500
X-MC-Unique: -md08Yf5ObmEQyIU4Pv4xw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41296f8d1e6so6211125e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024804; x=1709629604;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWDZ2zj8RhLA+e/LR6ZW41Ft+IJodiJtEXLpMcaC7rM=;
        b=RoAbBkElPz2EIEVnJF2lg/k8Ck/XJSTKZj8ICnsu0GaW7EfceWnnf9yjXcVf3B+YZT
         VwbWbZJla/y7nrRZODZX1C0qIxT6IJmPwU3EJwRh1FUYd2kC47oiWuWsp2Cs+rSNSbfB
         ZHmEeLft5WwizYjop+5zA4J2VOjVWcNq5fK+husRs9VXQVpxtcL3WDWyGSCQST78xHFd
         8mKkF/IQSUXgFiq3e+BgxmDHRosmngqGwAoEgRmpyttKvmxIcuUihFGpK7doO9OnmJrY
         h4YB0D5wKdlj5+J9tuAiEQzFkagSx194uQu59GHMPq1j09qOy0zMJoEimeT47daj2fJJ
         kiGQ==
X-Gm-Message-State: AOJu0YxdXSDSyODcmfdmW4R4iHZzRQZ+IA8CeFVWyhk0Rjkf45oWuVSv
	ENsaWurl6dgSbEY52FpDxkubklwLlycxbTJLY1VofcTKs7eFdUydIZSJaBWJnpkmldlhHpHMPIf
	+16AHxe1Rs5PWB2Kfg6C2guTjt4objw80UXlOZox/gzDQ6vzSr68G/yrsebVaRg==
X-Received: by 2002:a05:600c:358c:b0:412:abf5:cbf3 with SMTP id p12-20020a05600c358c00b00412abf5cbf3mr904754wmq.0.1709024803817;
        Tue, 27 Feb 2024 01:06:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoXMfjmhwggIZxieJMwcs+RNL0SfQa1Py2WMPLW1H146ut3MmM/ee0UCUiiLw8hHx6iG1STQ==
X-Received: by 2002:a05:600c:358c:b0:412:abf5:cbf3 with SMTP id p12-20020a05600c358c00b00412abf5cbf3mr904738wmq.0.1709024803484;
        Tue, 27 Feb 2024 01:06:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b00412a466f0c3sm6273243wmo.15.2024.02.27.01.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:06:43 -0800 (PST)
Message-ID: <f0eeaab76d6386e22b88d9526ec7a53ae7e98ef5.camel@redhat.com>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
From: Paolo Abeni <pabeni@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Charlie Jenkins
 <charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, Erhard Furtner
 <erhard_f@mailbox.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Date: Tue, 27 Feb 2024 10:06:41 +0100
In-Reply-To: <c434b94a-2072-4b74-a222-0906579a351e@csgroup.eu>
References: 
	<73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
	 <c434b94a-2072-4b74-a222-0906579a351e@csgroup.eu>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-24 at 07:44 +0000, Christophe Leroy wrote:
> Hi,
>=20
> Le 23/02/2024 =C3=A0 11:41, Christophe Leroy a =C3=A9crit=C2=A0:
> > Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
> > fixed endianness issues with kunit checksum tests, but then
> > commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
> > ip_fast_csum") introduced new issues on big endian CPUs. Those issues
> > are once again reflected by the warnings reported by sparse.
> >=20
> > So, fix them with the same approach, perform proper conversion in
> > order to support both little and big endian CPUs. Once the conversions
> > are properly done and the right types used, the sparse warnings are
> > cleared as well.
> >=20
> > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> > Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_=
csum")
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>=20
> netdev checkpatch complains about "1 blamed authors not CCed:=20
> palmer@rivosinc.com; 1 maintainers not CCed: palmer@rivosinc.com "
>=20
> Palmer was copied but as Palmer Dabbelt <palmer@dabbelt.com>. Hope it is=
=20
> not a show stopper.

No, it's not.

Acked-by: Paolo Abeni <pabeni@redhat.com>

I *think* this, despite the subject prefix, should go via Andrew's tree
to avoid conflicts.

@Andrew does the above fits you?

Cheers,

Paolo


