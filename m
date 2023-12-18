Return-Path: <linux-kernel+bounces-4318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95C817B70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1015E1F232D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E77147E;
	Mon, 18 Dec 2023 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Mk/9gCQ7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF675D740;
	Mon, 18 Dec 2023 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702929333; x=1703534133; i=w_armin@gmx.de;
	bh=q9wL0sOP60Ja7H4IQatHbqL5WFADfzE9WTyOrzpo5n4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Mk/9gCQ7z0PKOy8WjDnZ8pPcrk2TTk4pOV8G/az6USQLcRoIZo7XxZAKfH3HZZdI
	 G6x2vlG0dHIkBrFMcA7/puR0oP4+bsZwLPRtZ3DfGIinH2ZDRsarNiRrvLxlg0MQE
	 vASZKQAt9/3iD33FzXzx5bmOy9J5N9bXCJky5tXsiAWmd04bt2XDx6q4yiBq+rhOj
	 o3g5bzAbH7qfe8r5LfYTYoEmy2kilG33c9QjtUSGiNxf237rp8hlfW1H3VFRrpf5O
	 RBaElDs6ZsRnrIsfmGBMSbfEDmeNXkGUtmHCK53lIKipXfGPcjn+n3FQTaw8C61/8
	 gYqUTl/cNL2riu2dKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9FnZ-1rLexm2A8F-006Pdc; Mon, 18 Dec 2023 20:55:33 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] platform/x86: wmi: ACPI improvements
Date: Mon, 18 Dec 2023 20:55:25 +0100
Message-Id: <20231218195531.311179-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8f2UHcLb8jNJdLncasCfSHguSZsQi94AcT/aUqULAiBBDLl1nCQ
 1Y1IU8J4jSaTp52bnazaOuKn8a+yhcegflIgkkbyzc4kgA7gWNcMh0MS5NdJW/VRr6nVGRZ
 uAFsRTeL2ggQsjs+UAR5M1oNULk5MV+MuYR9nc9/8HE46zJ5JssqrNBEPAPluM+ruSsVATg
 0cSvV+wMRbDM96C7oUaPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aYBdc0JY4rk=;RmZVFPaDteufLbmxknB0SS8WqzO
 x4FK+e9+uD92tfRPpL1pVuocWBLIkiQTePf58Ph5hjZJn2KzESNFhN3eiLMh2EBUPPf9KtP+Q
 8pYBsqaWrMjYbibDuxYJF/UhwJYwTJO/Y0jRQ7c1/baE3diGsb6ORQptCzOioykWYQRKpo79/
 WWh3PaanJ/OEhR2ul5eWJE0B8l1qLJPK5niybEIwSg8207fvrrKpnLVQwPaKkV2u1LHREXuxI
 r+34ix5NLGaaA5G8h7UoccADCxGR+ikZ1f2Kyxr1mNSZtK3zxpcxF7PGDunE5tj4Em95/JZCA
 Bn3F4xeOTUBMEBWV9Z0sO0nWIopo1YZxpbjbhbpdI0CSNA/9BUm7lPexHyhRdqnr4Uaed5EJ6
 XmUucCGoZhQ5jA4MJKSnvBjfhPlRg3lZO1WeqOSoMrJxV2S+dawezkoK5ASqBTWmH3oRTtUQo
 Y0ZTD673dd5NB0iKhW4Tx35YZ5fVm2pu/eiO4gYLi7QhOQbeqwkQT+vYuaeEdt9odmVYOMXjf
 pZzDOoaRlvmILYM/6qUzPRs1Z3xdLt5e6dS24oj7yqXHLnWIuTcP5Mv7j6r5Yzu7oKBAyReZy
 XND707GhWt2KFoiJBwbUArG0L9K4hzpp2yaHthVMC1mFn89kxxC8Ec3I3XoqrlADQAIHRqw8+
 bHKpj9KFyPyPmjSZLo0seo4PzeeFiJ23Qh+02AB9azEXgPSBeEJLJ0cxSUe3Ryz3tyRMJgL6h
 qPCXwH+QiRgDs/ifCqm99BTDzEPu2UpalwWZnb0yHNkE8ZxEoyH5VELIa9bvWTjBJUXpSFrBT
 /B8koXoNVmV00UwK18B3pC3lPMxbV0FhJ2fEqgAvreMqMR6JW3dqRQX8D59H6VH9VrjqYyOsi
 QbmBHiUCe+PE5W7yaWeBybFk86XYha5KVk//sZubMzoSa7L7XjmoShudV2MUIbJId1DNhdXx2
 g2X4z6NeoTcClYpq0D5UpstfKUA=

This patch series improves the ACPI handling inside the ACPI WMI driver.
The first patch removes an unused variable, while the second patch
changes the order in which the ACPI handlers are removed on shutdown.
The third patch simplifies the error handling during probe by using
devres to manage devie resources, while the next two patches decouple
the ACPI notify handler from the wmi_block_list. The last patch
simplifies yet another ACPI-related function.

All patches have been tested on a Dell Inspiron 3505 and appear to work.

Changes since v1:
- fix ACPI handler devres ordering

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


