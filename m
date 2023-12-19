Return-Path: <linux-kernel+bounces-5137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72908186EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CB1286F17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ABE17988;
	Tue, 19 Dec 2023 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="opRfUd5M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414C171AB;
	Tue, 19 Dec 2023 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qnVFcIvF1gJlcIQoJO6+eF3Hs5GGqy+0hcHu9D8VlGw=;
	t=1702987396; x=1704196996; b=opRfUd5MJoE6PH3QdKYhZMHFOHHN5TVegTfb87enuOrdN6M
	yEwyRTKYdB6pM96Kfat6yNk9+u5/Nr4VCc9i6wBsUF1j6bqYZ/dUuHJkN4cUryeQJXJQrtfppHFY1
	MdEyOX1gqpum0jJUmroxSFuBi2tV81MlOpcXzz+2/KwiRwF49Jh9ycXH1zXNGxQK2xLOgdXowIfbh
	vx2zcU144bpQrAlZvTohs3i8xYKRfqIodrhf6h9oTxysmb7A/4cAbDKLTFwqKKT51nzqcdoWh3Mou
	S819DAXGpPywl7VR8WjKy09Kp9a0WguDO2NJyif3POOLDJKc1fuA29FB+6YUKGkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rFYob-0000000014Q-33V0;
	Tue, 19 Dec 2023 13:03:13 +0100
Message-ID: <798e32d457e3ea029fecd423fdb2b1317016e02f.camel@sipsolutions.net>
Subject: Re: [Regression] debugfs warnings when resuming from suspend on
 6.7-rc5
From: Johannes Berg <johannes@sipsolutions.net>
To: Mateusz =?UTF-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>, 
	linux-wireless@vger.kernel.org, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Tue, 19 Dec 2023 13:03:12 +0100
In-Reply-To: <d8aef271-418c-4644-a3fd-72ee5f1959b7@o2.pl>
References: <da91e776-b192-4e2b-9157-e83a5a2659b1@o2.pl>
	 <d8aef271-418c-4644-a3fd-72ee5f1959b7@o2.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-12-14 at 22:49 +0100, Mateusz Jo=C5=84czyk wrote:
> W dniu 14.12.2023 o=C2=A022:45, Mateusz Jo=C5=84czyk pisze:
> > Hello,
> >=20
> > Since upgrading to 6.7-rc kernels, I have been getting the following er=
ror
> > message in dmesg
> > while resuming from suspend:
> >=20
> > [=C2=A0=C2=A0 83.302944] debugfs: Directory 'iwlmvm' with parent 'netde=
v:wlp2s0' already
> > present!
> > [=C2=A0=C2=A0 83.302963] iwlwifi 0000:02:00.0: Failed to create debugfs=
 directory under
> > netdev:wlp2s0
> >=20
> OK, now I see
>=20
> https://patchwork.kernel.org/project/linux-wireless/patch/20231211085121.=
88a950f43e16.Id71181780994649219685887c0fcad33d387cc78@changeid/
>=20
> ("wifi: mac80211: don't re-add debugfs during reconfig")
>=20
> Will see if this fixes the issue.
>=20

Did that work? I think we need

https://patchwork.kernel.org/project/linux-wireless/patch/20231220043149.dd=
d48c66ec6b.Ia81080d92129ceecf462eceb4966bab80df12060@changeid/

in addition ...

johannes

