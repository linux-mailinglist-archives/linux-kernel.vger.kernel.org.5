Return-Path: <linux-kernel+bounces-35452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F8839172
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A67C1C26AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027A650A69;
	Tue, 23 Jan 2024 14:33:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903EF5026F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020430; cv=none; b=gqZy6k0qg7mnXdOPzGEN+F+d792TSA2GX4llIUqsUugZUquZXweDC+XL/0GLET4aem/QKWDRkowUTV+5EKO0Rx61Zr6OquFzPUEIwOu3bqU64vX8Ppyx03fSYT0CQKb7YU0CvPq8FQMINO3t5nHrlNOctF1stxYEBACkIAi32xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020430; c=relaxed/simple;
	bh=OrQaBm/3X4/JptmXUDv2nfceAYZz3BfKaK5EznOjCgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAmrn1NkVCOOIL7xMmB9qpFjaJz4JyHx6W6osytNhVj+Pcw7aIhbDVIOauH9ctbkNM5q7akasw57DoX98+qHGF0c2BlH4X73pCLI/8lLDlxbp50Eq7FTKbIzMe2vaZs4qp2b503ZBjz8y1QmORcPDrYsAk3s5dFwz/2n5+ZfSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45568C433B1;
	Tue, 23 Jan 2024 14:33:49 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:35:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, "Bhardwaj, Rajneesh"
 <rajneesh.bhardwaj@amd.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Felix
 Kuehling <Felix.Kuehling@amd.com>, dri-devel@lists.freedesktop.org, Fedor
 Pchelkin <pchelkin@ispras.ru>
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at
 ttm_device_init+0xb4
Message-ID: <20240123093519.3ed37601@gandalf.local.home>
In-Reply-To: <c45df2c7-695b-42be-b893-a4f520d9e723@amd.com>
References: <20240122180605.28daf23a@gandalf.local.home>
	<20240122181547.16b029d6@gandalf.local.home>
	<20240122181901.05a3b9ab@gandalf.local.home>
	<CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
	<27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com>
	<20240122203552.529eeb20@gandalf.local.home>
	<CAPM=9tyQ22nw4_u366EX=PnROYcWPD7ONRFpPEKxRvTZo0B4zQ@mail.gmail.com>
	<CAPM=9tyCN1ZhvCTjoKn-Yg5BhnrMae4E5Ci4_u7BZ2vv5gDnKw@mail.gmail.com>
	<20240122215200.1ec02a4a@gandalf.local.home>
	<c45df2c7-695b-42be-b893-a4f520d9e723@amd.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 10:43:04 +0100
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> While applying the fix a week ago I was under the impression that QXL=20
> doesn't use a device structure because it doesn't have one and so can't=20
> give anything meaningful for this parameter.
>=20
> If QXL does have a device structure and can provide it I would rather=20
> like to go down this route and make the device and with it the numa node=
=20
> mandatory for drivers to specify.

Then at a minimum my original fix should be applied. Perhaps with a warning
too. That is, I added at the beginning of that function:

	if (!dev)
		return -EINVAL;

Could have that be:

	if (WARN_ON_ONCE(!dev))
		return -EINVAL;

In any case, it should not cause the system to crash.

-- Steve

