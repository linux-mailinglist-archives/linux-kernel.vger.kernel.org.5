Return-Path: <linux-kernel+bounces-96285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F078759BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B920288973
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A213DBBF;
	Thu,  7 Mar 2024 21:45:38 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81864A9F;
	Thu,  7 Mar 2024 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847937; cv=none; b=iRpgt6TlM06wGB4M9dFksydBIyOgeYwQg2uCIOHKYpiMbjNtYmXnimso+ShRJUos+47u6RFA4ZtjvHUm+19hRh+reourGK0nsj1RNB7cuizEiB09hCbmLKmyzVzIwo6OqqydgMk1NXwve/aDNCFEfUpxKnMBZ9bcd5kdeGgsdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847937; c=relaxed/simple;
	bh=XyrV3yZlEAF1mxbGdo1czbAm9N+9F+OQ3GDp0j0njqM=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=oBOrwQy1ywVVlvj6Hqu2CYWRNvcG2FDhO8zu/k8CH+wfyP1Jl+U6lRdYxOXqevj9QhV/jQ1NBx93IleqIXKbwjv9iqxDn4TI8DonbAPIzjTrL7mGn0rf+OpeUATDK3nubsRHQwuFYnlq5I6RKPkmXXoxxXkX8letoQknERmpUIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 86CEE37804B2;
	Thu,  7 Mar 2024 21:45:33 +0000 (UTC)
From: "Daniel Almeida" <daniel.almeida@collabora.com>
In-Reply-To: <c70935815ffc29ae5256b94c0e4880952abad79c.camel@ndufresne.ca>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240227215146.46487-1-daniel.almeida@collabora.com>
	 <20240307190841.10260-1-daniel.almeida@collabora.com>
	 <20240307190841.10260-3-daniel.almeida@collabora.com> <c70935815ffc29ae5256b94c0e4880952abad79c.camel@ndufresne.ca>
Date: Thu, 07 Mar 2024 21:45:33 +0000
Cc: wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, kernel@collabora.com
To: "Nicolas Dufresne" <nicolas@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <144b27-65ea3580-f-61876d80@130641868>
Subject: =?utf-8?q?Re=3A?= [RFC PATCH v2 2/2] =?utf-8?q?media=3A?=
 =?utf-8?q?_rkvdec=3A?= rewrite parts of the driver in Rust
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

> struct reg123 {
>   val1 :3  // bit 31-29
>   val2 :20 // bit 28-9
>   val3 :9  // bit 8-0
> };

What you're describing can be modeled as Ranges in Rust:

```
use core::ops::Range;

struct Foo {
    reg1: Range<u32>,
    reg2: Range<u32>,
    reg3: Range<u32>
}

const FOO=5FREGMAP: Foo =3D Foo {
        reg1: 0..3,
        reg2: 3..24,
        reg3: 24..32
};
```

It becomes more useful when you pair that with a bit writer. For an exa=
mple of previous art, see Faith's work: [0]

This has asserts in the right places so that you do not shoot yourself =
in the foot. IMHO, such a data structure can be shared with the whole R=
ust code in the kernel.

You can then describe your writes using the ranges, e.g.: [1]=20

But as we've established, instead of writing the ranges down directly, =
you can simply refer to them as FOO=5FREGMAP.reg1, FOO=5FREGMAP.reg2 an=
d so on.

I believe this is both more readable and safer.

[0]: https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/nouveau/c=
ompiler/bitview/lib.rs?ref=5Ftype=3Dheads

[1]: https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/nouveau/c=
ompiler/nak/encode=5Fsm70.rs?ref=5Ftype=3Dheads#L228


