Return-Path: <linux-kernel+bounces-85209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486C86B249
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C4B29AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EABD15B0F3;
	Wed, 28 Feb 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZSP8kgo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D48A12E1DD;
	Wed, 28 Feb 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131694; cv=none; b=sxtVl4djXkP1jp0HkxRsUAmZQGakJe5j0Djb4rl/utTPOQckw2zzGMaftLasOpP0KWFnqpgHk/RLgAPJzyz8Pg5pzIq404/CDDVWsF4qLnKB5WaQSnOKKbQelrvEoW+80RZeBewlfhUtoukqYBB3oIJpO5/e9ZEJJCmCN6aIENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131694; c=relaxed/simple;
	bh=BGdZaD9k7LAInkzJ5BRx71iyoWI+dyq3+fHt8weHUqg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jKn7WdKMuL/tXpYpWaNfepkfT+R2SQdxkpCteR9COZts/UvhuvEofQtpRwOVUP99GFjHQJnBDiGXhTRpasZYchjwdKMlmd6OxpeHoAYSt/38K6OQUBOyh3yw3eWirquUrPBhb4IlQQ3fIChwe8j1V0m+7BQyHyFbqRUwGCERy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZSP8kgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA46C433C7;
	Wed, 28 Feb 2024 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709131694;
	bh=BGdZaD9k7LAInkzJ5BRx71iyoWI+dyq3+fHt8weHUqg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UZSP8kgotAd829ClsURiaX4BS1uPTbjsSun5pBM4h6TGQX3U7mH+n7iX7PU0soBxW
	 BTYn/36b8/JC/h9voKlkftUzlcqmFfL3Bqp/Ve2qUARWRJhhTxjvhZY31ly9CO5dJM
	 5plqLzh5t53sDGVNswF7mhp2We3e/HE+Gvdin96s7rFXQsJvj32qsa5CuFa9Ve04tV
	 cmVKCL5KQJJBUWxDJqcsCsevTOjJA7R2s2y9SmJ4suD6uV8RBQIuJsiVfm/8m5JWzM
	 Q5+7WcmZY4CUlFNyWy+9n6IaF6p6ZnywMD50oXyidXTogyjmboO7ieR8n9WXRI+2wp
	 6eyHOiOC4nv4A==
Date: Wed, 28 Feb 2024 06:48:14 -0800
From: Kees Cook <kees@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
CC: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org, justinstitt@google.com,
 jisoo.jang@yonsei.ac.kr, petr.tesarik.ext@huawei.com,
 quic_alokad@quicinc.com, hdegoede@redhat.com, keescook@chromium.org,
 johannes.berg@intel.com, kvalo@kernel.org, arend.vanspriel@broadcom.com
Subject: Re: [PATCH v2] wifi: brcm80211: handle pmk_op allocation failure
User-Agent: K-9 Mail for Android
In-Reply-To: <20240228063408.7006-1-duoming@zju.edu.cn>
References: <20240228063408.7006-1-duoming@zju.edu.cn>
Message-ID: <8B696743-9487-4A78-B9B4-16DA4F2F8E26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 27, 2024 10:34:08 PM PST, Duoming Zhou <duoming@zju=2Eedu=2Ecn=
> wrote:
>The kzalloc() in brcmf_pmksa_v3_op() will return null if the
>physical memory has run out=2E As a result, if we dereference
>the null value, the null pointer dereference bug will happen=2E
>
>Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
>for pmk_op=2E
>
>Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 =
operations")
>Signed-off-by: Duoming Zhou <duoming@zju=2Eedu=2Ecn>
>---
>Changes in v2:
>  - Drop the new label and just return -ENOMEM=2E
>
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=2Ec | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=2E=
c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=2Ec
>index 28d6a30cc01=2E=2E7af6d6448b9 100644
>--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=2Ec
>+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=2Ec
>@@ -4322,6 +4322,9 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg8=
0211_pmksa *pmksa,
> 	int ret;
>=20
> 	pmk_op =3D kzalloc(sizeof(*pmk_op), GFP_KERNEL);
>+	if (!pmk_op)
>+		ret =3D -ENOMEM;

This doesn't fix anything=2E It doesn't stop the execution path; it'll con=
tinue and immediately dereference the NULL pmk_op in the next line=2E=2E=2E

>+
> 	pmk_op->version =3D cpu_to_le16(BRCMF_PMKSA_VER_3);
>=20
> 	if (!pmksa) {

--=20
Kees Cook

