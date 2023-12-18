Return-Path: <linux-kernel+bounces-4285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C4817AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB84DB22EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084F71462;
	Mon, 18 Dec 2023 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AP1jLQBa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D01DDFC;
	Mon, 18 Dec 2023 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702927470; x=1703532270; i=w_armin@gmx.de;
	bh=c8VmnYc8RAbn6tVJXPaaBXqLrzr52/q6yoK1W5rvXGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=AP1jLQBaEChG2Aanm01gq/5jfdw0jJhTXBIRW7aGytJ8nA7Brahq/OH0rdZFwNJR
	 HRE9ZzG32y7ePrvvvqyFHr4MmhMW7M65l9W9+ghVaCPbax/HpQXNCbXO3xlDyXNNr
	 vbbIzzYxR9rDa3p+ArdZ7QCoVvc6w7O+G8p0VHZGR4pLB1F8+O8sGY+w0dzNbxJXY
	 7q55zJ7Bn3texgwkNorJ48dNRiyHGyPAJkRyrsdIxT1h5cPWdM6TLycaZk9N3IOs2
	 VPtUrUxcPKkCvVmWh2KZV0qM5Rg3XjpOYVNPFIzUQsjIw02ruwwy/eWK33nQDF3+y
	 qmo0uHrtMUEcmAtFcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MLi8m-1rWybN3MbA-00HfpE; Mon, 18 Dec 2023 20:24:29 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] platform/x86: wmi: ACPI improvements
Date: Mon, 18 Dec 2023 20:24:14 +0100
Message-Id: <20231218192420.305411-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z2cy3YLfJ9IXpxVudYEdAMMB69cI6u7vr6YAJpqcPEnggm4Hhvu
 NtjRGinrsDWqNmKKlKtXJD6+lMVJ+qVy/Mir2cVOdpQAMosps3EgQszIpgyNJKeP6y7aNsC
 dp1gQDI1PqczDP+yrYqlVhe1LSNOg8evQvj0d8h6T8ZQLrBQ7wI0e/y3EgxIk3eJ48Df/0c
 8d3bTh19HiQqmXemLowBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3cIKdZLfjI0=;Y8JFBY8/KV7s0IDeQLXJ61ARr9t
 716PvU56z0TgHBsXzJwzPLb0Tl0IndgYXK2R6xquNxkg6qsNXpoQKpXoJV+cAV5zMVayxHXJM
 U3Mf/yXozLrsvVSunfdCBPOX3Tn69zzvv/G1I3F9UK5iPtnYOLyuuUBchu9f7IQWALRqmLZFv
 SLtO2ooS3XkhH8M/E7t0JYbaAY9iBSn+bIbbLGlri9UFDgZpamjOHrh2DQVCFHIorSNh4vApW
 tjfAmyLKUUqX5myIZ7l1tCNgr+PjxsEW00QZZI8P5hhpltpmjwgPwkAaljmhaIy4hKEBwnlzL
 VCrtupdBWM8F0WSrf4XQV1MbR6SSaruQ8bEZkeEefQzCHTZQ+I7NP0r37KBL7eSVZm47n6uOs
 CVhnckKWmYlE0lwBTgd+rek/W42Ruvi1sEoqhp8Jp7bJR/nvtPgoI4qoACEqm45R6YS6KbxfR
 5/zO0sZirKDsAUx2ohjHD9zFjdsBYbDcqAZL+N2KwYNCUfg2d+21L9E49qspAVT1iiNBgANKk
 FZv59PKL/vjBRYklNCNPUXf1IkaPC56t4pzAmTxZyJKQYUimysiIfeMNzTOA3pWPZvztcjZ92
 ABR4rFnQ64zaS8Y1yBvWiYsvpLHS+pDbN2sGa9uWywTUNu4keTs4EoLCsRx95Us9bn4LHJYMP
 MiHoSuHOKvIe00jcpSoU85BglJxD20Uely3X0O9DVgIX2NvaSUao+11n8S1g9fJ/WCjAgeFMP
 i/yW7i3O4WF+/VFHssqTgjRJMxr5P7i6IEwDFpQdsNW5lZyhD9RLxuWoRl4KENUl2aQNgJGbJ
 3z6GmgqMY/xI3kt/Q6FqqEYPxpKx8K0c8aPRrAXsSzoeE2Tv2l6FzsQvXKei+mctxV6cXKn29
 Ia7x9Hoi++9wOsqrg+oD8q0JkUTQyipH36Yd3d/2ojtXqAhHbxSShqTMkzO/wgO3vPO1TZ7/j
 0CkHf/toSSP0SV6i6nsbtihp36M=

This patch series improves the ACPI handling inside the ACPI WMI driver.
The first patch removes an unused variable, while the second patch
changes the order in which the ACPI handlers are removed on shutdown.
The third patch simplifies the error handling during probe by using
devres to manage devie resources, while the next two patches decouple
the ACPI notify handler from the wmi_block_list. The last patch
simplifies yet another ACPI-related function.

All patches have been tested on a Dell Inspiron 3505 and appear to work.

Changes since v1:
- fix ACPI handler devres order

Armin Wolf (6):
  platform/x86: wmi: Remove unused variable in address space handler
  platform/x86: wmi: Remove ACPI handlers after WMI devices
  platform/x86: wmi: Use devres for resource handling
  platform/x86: wmi: Create WMI bus device first
  platform/x86: wmi: Decouple ACPI notify handler from wmi_block_list
  platform/x86: wmi: Simplify get_subobj_info()

 drivers/platform/x86/wmi.c | 143 ++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 72 deletions(-)

=2D-
2.39.2


