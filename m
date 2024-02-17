Return-Path: <linux-kernel+bounces-70035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04685921D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFCB1C215D1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9B7E589;
	Sat, 17 Feb 2024 19:40:18 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CD7E577;
	Sat, 17 Feb 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198818; cv=none; b=s/KUxOp1J7wsyWRXvc3NhW3kVEvBTLzm90Is+LsovVZhOCv6f0xyBW3tMsrPIiNc8zmHI6pPMF+sH7MLGi+oE6/V2X6xuYc71r7NVnRtyZ5tfXMiJIJ0nO8jshh0buAqBJ//50B+7p+/nk0ODPs2/mJfWY6ychI3rZjsIl5Dhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198818; c=relaxed/simple;
	bh=J2ytfZaYSAZQyO8x+e3VhJmlyC3h1laCCKwfpuUERQc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=gh1D/w/jpx6GgKtKnA5RmSJfo5m4zWLXr33U0tLxcAgVhZ3wfWczfOHIXk79p3F51XV1Xg8HZl510eGcDtWufxua7EWCcuFC/5G+6X21aTIIept/7xFDCrHkHdtQKqaeHWi2z5N6to1E2c6NB2csLcNw78ZQuhcDlDGPV17cEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id BB95980326;
	Sat, 17 Feb 2024 19:40:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 6F6B01A;
	Sat, 17 Feb 2024 19:40:07 +0000 (UTC)
Message-ID: <7658242ceef838cc553cb3bbb63ede20d1bf9cb5.camel@perches.com>
Subject: broadcom: brcmfmac, alloc without null test
From: Joe Perches <joe@perches.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, LKML
	 <linux-kernel@vger.kernel.org>
Date: Sat, 17 Feb 2024 11:40:06 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: otkpsbwgsgz9cbsycrxaiy1huqbpt47z
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 6F6B01A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/0TOWJG50euXH/Y2/XmM/8hmtHbmXurDY=
X-HE-Tag: 1708198807-741751
X-HE-Meta: U2FsdGVkX1/XB7jer+wcyMGzLnQLgoWpYpVv5i9TuUVNqk4/ULH990HmWOgvHIw0rMyC68L0cVRGmiRbaYixVYJXY7ffNEfIrC8nX5bIcULM5qFE60Fbo+tDGD5VqkoZpOqNnrfSloZ3EP77X4xngZzOLasDZBSijvOphot0ffQuWSOWc2pautGfNknY6ncNejCdUb0hngLYygflM1AmPWGA12fpcSsYIkvk+CJ+kuP6s25rV0GZzrGZuZR+XE2FY6mooee56bWaD5LcoL3/WaO8X6IOscS/YPGOpSZoDSfMmVrw4u5OelvZlD2FLHsx

There's a missing NULL alloc test here:

It doesn't appear obvious what a proper fix is.

diff -u -p ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c /t=
mp/nothing/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
--- ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ /tmp/nothing/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.=
c
@@ -4308,7 +4308,6 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp,
 	int ret;
=20
 	pmk_op =3D kzalloc(sizeof(*pmk_op), GFP_KERNEL);
-	pmk_op->version =3D cpu_to_le16(BRCMF_PMKSA_VER_3);
=20
 	if (!pmksa) {
 		/* Flush operation, operate on entire list */


