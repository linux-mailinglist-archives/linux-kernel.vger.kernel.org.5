Return-Path: <linux-kernel+bounces-21800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BF82947C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04F4B255F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8A3C46A;
	Wed, 10 Jan 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RDDlycAb"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA533981;
	Wed, 10 Jan 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704872802; x=1705477602; i=markus.elfring@web.de;
	bh=hhPaJcyeSBxTfwuEoDUTo5lm2LbnDI4Sufrw3CS2k2s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RDDlycAbIBjqIBZhciOaoMzfl8tat1ml5+qzKdoiHfMJreRpIHAbWIXRnPKwlnhr
	 w0vse/ZAZ3cCwQ7mccrHYN9VDuoVlfWNQ8uIZoL8s+3TUf5O7ga+mecRtASez08rI
	 07w8aaKfxzw/exDThF6Fkwkrpnv/ZCpWbCcynR7vWOWhUdijv5Jjt3cQq8mcyTSJI
	 RT4OMizwoUpYzSXNWSPBgXIEHsEDQQyf5YMDWTPeDR7HY/BXT9aPGL5XZp7AaYCwy
	 ZrYY/gILsaXbNsNlUzLE3Ss51DRCGO3dBL1NNgDiVupzBTuhoQdAYuR6EDnClKaee
	 2l1JfThVel14fi8LUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1rTH7H11Th-00CKiQ; Wed, 10
 Jan 2024 08:46:42 +0100
Message-ID: <0d7a06f0-7a0e-47c8-b89e-c3122b46d93e@web.de>
Date: Wed, 10 Jan 2024 08:46:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
To: Justin Stitt <justinstitt@google.com>, virtualization@lists.linux.dev,
 linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, cocci@inria.fr
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Gonglei <arei.gonglei@huawei.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
 <202312260852.0ge5O8IL-lkp@intel.com>
 <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
 <20240109234241.4q3ueqdjz5o54oan@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240109234241.4q3ueqdjz5o54oan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uYjo0zmC9Bv8IGNYZK4OcE5zWAU90y0/cZTEhqTTR+46QfZcrke
 tgvURLyjA9lTvet4ThfCVXnv8xkFz5vm5k/faG0SI34wHLmSeb4+ISwwXtzGVUNyei+sko3
 imEXpQg0tfMnY2jPBNEQpi1Nej6dOCS3XWYf+0+cvT6Tzo9nqafppm62vyx/roH5eUamaVt
 V+cwMMwdBpWwOAkMutt1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S0h3qRtm9JU=;wWqjC0b120yckKxNsgoQLwgkgBW
 TANfswLwhLmaw2f/tPyZEWPKAcRWd062YgXcSl/MJ2qJRU1QKDsfT2ThjEWt9E72pzH0XbipK
 ek+fzGIiWGzIJsPlXIujThtScJKp1023bSnfHXoawQA9pX+pihbfTuFGFlAUTWqVRcAWqrqli
 0nCKkRvwtVBpgQQHcOkSiZz2JlCRwk57Shx+Gvg6y5bk4L3PH3AlWQ8tO6Xp3nleW9MR0s7si
 MSvzw7RCAFeB6LwjIZwmlOEOjjPLPbYUs521VFEI/yO6FjCahBvoh12NcXhyV06gTwrZxYSeE
 b8pBwfLUgR/Esz4UAIkpBHYPrX/bWsRwmcnQHgEEK4xgOgGDjqsiyPzEp2Y2Efcn2/R/EF712
 VQk246045auIbeX9HAJOCho2yLaMsyEH1f6EHNTxHg0+SqFqDWpwoGio4SkvRb3I8VuZ3pxn4
 pKeUq4c1gFEumr07bBhEG4mi/NUQgnLyhdgW6BwDdFk4VwWYt4+ogSIr5ka7LK0XE9enEulDt
 FYzDmGriybFkbMm6TBpDciJx5Sh6BnEUu+Et3jr/Wo5juVLgYVUD68PVkhXYCB9kXCZBCdsVV
 ugIrdZ0ILSXTq7qyQMj80Xqu7K02gBTP9d/ghsEIPcwB8ADu4LuJO6tT7jydAQmru2Q2FVJk1
 ivWlGskt+2ukhVot4diVbYzhRSU40RAEtZ+czNRSy7ThyCDOja3gPdwSQvyCuhQFKR8wgwG9b
 XrqtDCFIWRfjgOes6u/gzPr5TaEA4NNxHUyub1v+1OAf9I203fen86ea5RIg7ATId3YwnrbNF
 CPYepQfCHStuUHXi9ghJSc64B7/bq4g0XeNcJeCEkljhWyB2+P2eOjuzJeW/QqYtSYA6LzvEr
 oZ4SBkMQ7rrO/7shvLlLjbwtqb6JDHUcnuYj1+D6YDz0o8p6Hfvl/T+rJqJzOzUkuEamvmJ98
 B+3jVJr1HhEYCoxIDT4FjRo5reo=

>> The kfree() function was called in up to two cases by the
>> __virtio_crypto_akcipher_do_req() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>
> If the script is short and simple would you mind, in the future,
> including it below the fold -- this may help others do similar work down
> the line -- Or =E2=80=A6

Would you like to take another look at the clarification approach
=E2=80=9CReconsidering kfree() calls for null pointers (with SmPL)=E2=80=
=9D?
https://lore.kernel.org/cocci/6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00096.html

Regards,
Markus

