Return-Path: <linux-kernel+bounces-22205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2997829ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1CF289213
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7F4879F;
	Wed, 10 Jan 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HR+QsUTh"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B54878A;
	Wed, 10 Jan 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704891686; x=1705496486; i=markus.elfring@web.de;
	bh=fqSFKY5Zirnw4hSO+f9JSpx6szHta+QQy+nLiPG9ozg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HR+QsUTh3JMkedWITQ3E4tHVdgeuKVdUK1yjOWV+UvLTU+X/yU1G4TQ42tpBCwXu
	 +BOpP86+ZoVzh9vdfwzENzMs8j/Gg1z/V0C+sVE68OrSQFGzjIg96C/3/h9JFAfKx
	 tKTVXdES+YKrs/gCiI/9VDSa24gkZYTZWvUn4bEdBBJV3lV8HAlvKoX4T1BdLc8LG
	 4C7Dv8htTMshKzV/h3Jb2Rw+6B2IYUvvurOtAfpbaXRMt5uM4dLvJf0Wev7Of1BHt
	 wJm5XGWp/c2I6k1sSxSHDBHKOs+2X484+ftVgto6UYd2H984y/cgP66xNT14alSQ/
	 oBo5sKm5dpJwWrRAKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2jaQ-1rBQEc12ey-012zo4; Wed, 10
 Jan 2024 14:01:26 +0100
Message-ID: <d912872a-e70a-4e5d-aabe-26f289507f44@web.de>
Date: Wed, 10 Jan 2024 14:01:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/4] overlayfs: Adjustments for ovl_fill_super()
Content-Language: en-GB
To: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
 <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
 <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h8tCbXXw0Swhpr88lNGFvUEGFYt40i2z0RuHlDmlga9TVUJiPh4
 JaiVj/0ZiSWg6/4bEGeMEgE+DJQpcfcPDxeGclF4igoN8nbuuCZ/KLECvsROT1ZePdxFF1S
 XqNkNsQ02shb2lmFyeNAo1QSKj2BonPY4fkSwWuKK0YuTRmzKy4gTj4oKVqH55tgdsCaBlR
 BzDlGVNtlRDiGW+I/E1Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:du3gPScwpYI=;xWLpWwsJ6b0IwbjzBfQqcOG12Ci
 YtBsjgLTQIqOyffl58KRi4P0CfKo+Ln8fGqncCRADCO45AaIgrrFcfEa2Ss4gpoZnFzFYotzB
 T0oukIDp+Kw4TM3fmfieBqMYRVK4W3ZI85AeI0xlMnhJOR4VbnpXmVKdlIUZoZ1zisVnNfQPn
 E1UT8uA1U14UgyCcAPyVsoV25PunUFKBJkWtDdrGL/WPRVBoHGbQ0nK/nYoSqGA5UeaJjHXC9
 diWQeGf13mSUdLj8tlaj1hWxYSmjUoRJVYaFBTXsVE8RDoBO8EKJ8peM4PCk6URjmvij+UEFn
 jGI9GwrrfXylcy6TpAdSwzuXqW9N+S4bjv8PMt6g3m/1rDv+POs7iBtd8qYRcFZBUdmUArVab
 0Ks4vByapiiCbheNOJzShpWpIkNfpyzUudZAJEwFXpWbVh1JfqAcqKrtp1wdqXAmH3SSulcV7
 TvlY1E4pDsyb88RsStF4M25CpsYcAXAO0O1QaLFyN6mACwrvfmhUOzWQm/pm32mM+F6p5whBa
 n0cgaHziN8ejP70SlZUo2NYAAdOnP3ZeDG10C2vkO0jlpc6eaeFDZpyUkz3N+FfpLvADDBUA7
 spbMoZOqCxVwlH9yykYueh3VOw0h3mqciBDP1r/9bI7hmX8VVGkf5l0vojNecQ7wUoFbXhSzx
 iUUHRoYGnRQ+xekL5WU1+fbCx1QY/8gnHUe8/pOi9tvx2Sow2DhVIbd7PQasEBNOQetZTvady
 eFY6h32Zdae6/F+jeOTeHwvudaclhB3g6czqi63wUZEsI7/ADB3Qzi1VHEPgzXQ6+lwrIAdtT
 fwdVZT5oyd5D95xspSToRZ8ClHEnantDUE00C5DH8OLs7prhWGoajC0iqxlBAIg9Gc1wJJQGQ
 iBRWUkmyrx2S9jKdEIAiq4fkKUyadPjuQIsATi60v0etJwnhPMKfgbg8BliWZ0JwTywFObNaX
 yWl8tA==

>> See also:
>> https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@web.=
de/
>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html
>
> I will queue cleanup patches 1-2,

Thanks for this positive feedback.


>                                   but I do not like patches 3/4 and 4/4.
> I do not think that they make the code better to read or maintain.

I would appreciate if the details for such change reluctance can be clarif=
ied better.

Regards,
Markus

