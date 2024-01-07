Return-Path: <linux-kernel+bounces-18965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0F8265CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D820B21263
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1241118F;
	Sun,  7 Jan 2024 19:30:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from sxb1plwbeout02.prod.sxb1.secureserver.net (sxb1plwbeout02.prod.sxb1.secureserver.net [188.121.53.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5411188
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
X-MW-NODE: 
X-CMAE-Analysis: v=2.4 cv=JNb98eGb c=1 sm=1 tr=0 ts=659af14c
 a=xZsz1WqYln3YGRp0IohaNA==:117 a=xZsz1WqYln3YGRp0IohaNA==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=FP58Ms26AAAA:8 a=VwQbUJbxAAAA:8
 a=OQEHJ-BNlmcVwaK9_LUA:9 a=QEXdDO2ut3YA:10 a=EebzJV9D4rpJJoWO5PQE:22
 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID: MY9KrZPrXz19A
Date: Sun, 7 Jan 2024 18:45:30 +0000 (GMT)
From: Phillip Lougher <phillip@squashfs.org.uk>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <522978349.868758.1704653130312@eu1.myprofessionalmail.com>
In-Reply-To: <49472d26-29e6-443f-b0f5-21967a67dd4a@web.de>
References: <49472d26-29e6-443f-b0f5-21967a67dd4a@web.de>
Subject: Re: [PATCH] squashfs: Improve error handling in
 squashfs_decompressor_create()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.19.35
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfOp6H2w7Gin0kDxhYJ6f54ZB0ExIU0in4Z5vWX/LeMg+nZcHXaBIR+/2mkPHvBQmNjfBWbbKLD0XcFwfpM1/kcigFSOKoONRTeOp/6a6kDiRjsbxuXPT
 GOVeHmhOQRkX7dsmvOB+cBFgXUZlroRfuhAk1Rpbac0Gyd0VPSBJugSMrBhBf+SKBBtPC9znBuvdznfJE8uKHiz03Bc4r7KArLn7IlR7nu5KevHVsbDxmJxu
 i/oTUkoeXh+3TsrbdaLr/PA5zMLQUVdWsqjeonV8cW8awiAB6uoHiwAsv7GjSe2OHMkO82zJSr6LVgkNjfxhPLxKxibwyHOddwvE/Lrmcjs=

> On 30/12/2023 09:55 GMT Markus Elfring <markus.elfring@web.de> wrote:
>=20
> =20
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2023 21:30:26 +0100
>=20
> The kfree() function was called in two cases by
> the squashfs_decompressor_create() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
>=20
> * Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=
=80=9D failed
>   at the beginning.
>=20
> * Use another label.
>=20
> * Move an error code assignment into an if branch.
>=20
> * Delete an initialisation (for the variable =E2=80=9Cdecomp_strm=E2=80=
=9D)
>   which became unnecessary with this refactoring.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

As mentioned in this thread (and many others)

https://lore.kernel.org/all/20240104204032.GN31813@kernel.org/

calling Kfree with a NULL pointer is perfectly valid.

So like most others I'm going to ignore this patch.

Cheers

Phillip

