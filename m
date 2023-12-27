Return-Path: <linux-kernel+bounces-12162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45A81F0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD38B1C223E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06546453;
	Wed, 27 Dec 2023 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MkQgF2Pd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133E46437;
	Wed, 27 Dec 2023 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703697278; x=1704302078; i=markus.elfring@web.de;
	bh=GpcuCyxATDYo+y8qWGQqMQc37tbjB3AlTMTRMIvEPOg=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=MkQgF2PdPeb4ypVZSsKDqrPU+Veze5Oz9N2eXIEi06P49F74OFbSQUiPvNxxG5Z6
	 M4DNRnk5bXE3wz1R+xAzxsZf8VTz9o3M600UjVBzf1cSzCT545vWWnOPmpW4KxAtS
	 2JL5nhaxdESiI5H5j7I9q6/BDMv/4U0M90uoGSijVMlDZ0LHxITHpkfdYob7KstjX
	 1hOiZF0dHzBP4WwnhBLRV6llKriTF215ecvP05ch4rHtlC4Fs1IovYph2BjMkwuA7
	 hzn/jmZP3nmNuI3jsu7GqlJWbSvpO5xTW0CsWlW/3GnsjE0qVlouGpKaoVgQ16Lse
	 KumELOmaXRYljGRQYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1qkIjV0eix-00Zlk7; Wed, 27
 Dec 2023 18:14:38 +0100
Message-ID: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
Date: Wed, 27 Dec 2023 18:14:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] nvmet-fc: Adjustments for nvmet_fc_alloc_ls_iodlist()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywgVd8MaOcVLjM73gdkwz4kyeQQSA41m881FmDgU9ofY/waJv/n
 8Urqhn92jhbNE5EbkJtgbn4AZAi6GECRo2pQxZHemQP3HEB3YxGVOezXjDrV+5429z7S8No
 5JLByAVO5u0wsb9Turp9PiAoAhXxVXPw52Bs1Wc308aHzu1AsFHQZduqlTiyFaXT6dRu9ER
 XwV3lNprphI9zsa/NRLvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qKs6QAQkerE=;ywL5kkQ5xlIBBwIuCPT6iZSDLRV
 JXyjMT8OrugaEsT8jfszvAT2bvLeab3qu/aDXlDppnpK/r7QihoaUdl1mYgE8daxhp94pUmlN
 mWD6ynYeAkLuIBfDgaTMgleW//WAVCpx7wT0eitXa45oCJghIZOqEcFmgdBNddieu0cOV/jl4
 5RejWi8cAyytQGUinX8v7rS35OudqQq52+YSzPAyBq8VtMDJKEFWOEcOrHyTNlv9j5eBAUlUG
 VRlC18bKeht31Y4VDml2Jv4hlRdZ+Tb47BPnJl8locQKlsvALdaKZYQ8SWgmxnoMlRFcRQy9h
 Vf6bxsWaiJI3dj9EQIHUjbGoFQV67alja3EY3RFE5tssdCiGkGOUdKWJDp38qvO1dP8xyEX48
 0mIfUU6JsuL1BsuOfiHI0WV8kOqJjpPyiBqgUf4BhpBe38ztfrqUhEmLHJWyWP0wZU1j4021o
 yYeayGVLqIfSFonfB1Fmt/vwG18cjDLOgacu7s7qUWwOzdZc9SLT5oLSI5ojpmyo2bseO0Pda
 ywevtCS1+DjrQGhezp3ySO/7XeJpEtm/QuEzXgy9XUkgXkCusSUq554Qv6YANhHiQu9iunT5C
 0G23d3Lytb5NGaTevWqUSyObmnhteTh5H1CA1h0vPjVN2zaCjxrbCpX7oGePdlpAc7eYtDjLr
 astcyyaYJgmL3Qa8bb+Bg6GI279qUIaqp5GErrayrpiGQ85OVziiCAJQg1wzUk8AK7QNldRv+
 DUCPi0qJUZCUml55MzPykgOtQXj+79WWNypsJCaHfU5wj4sXMJn+9CBM4D4bfTgvZ0vt7eGFA
 O2SutnbA8wFEYXhxzljSI08p8/ZIw17H4wgTiFUeq7sAR4xTbqr74/2zSOeAtt6SYAAUdAkJm
 9xpo0jDVHdoOMXaq6g5aCDOyJsghUGwAWDwwo+/EzxUghcJqoGDx/9x0gHRzVeJC3sYgckY76
 2fIX66y5PM6GFHj/mZu+sr7gRwA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 18:09:09 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  One function call less after error detection
  Improve a size determination

 drivers/nvme/target/fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

=2D-
2.43.0


