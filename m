Return-Path: <linux-kernel+bounces-15909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFE82358E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9868D1C23AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9151CF90;
	Wed,  3 Jan 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NCi7oiuX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E571CAA1;
	Wed,  3 Jan 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704310044; x=1704914844; i=w_armin@gmx.de;
	bh=yWQ7XN1J5vZr985YRVzHaSSRXWFlznRBidVHnXk3W9g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=NCi7oiuX8m9HO5zNYLOhnGUntnD+cDznVkBp+9zqeVWHogDkwOGAn9J6e4bOjQZi
	 EVb3oiiJXWYfCWOBW+c22n/VQc/pkDPGL+tTobMNRirZQx+ROoKv3xWZlEO+NPsB7
	 gXx4ahQ0IvC263uuTXpJc0B0fzI3EHrHlRZsnQbX9bCwjRPXMNGi5gdleE4LXLTxe
	 cwx89M/kWZ/Sp8+DmnaywyLWKK411ciQZWgmjYanX8s7GvmmI4WvQg1Rf9aVUXz/B
	 ef5cEZ2iBatyrNxARudZGFP3KEwvIy4WNhOq1o0MeiLF6tlJaksI+YhRcwLx4XheX
	 wwn9okYRAsA8/534gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MoO2E-1qsKeq0Vc8-00oqzh; Wed, 03 Jan 2024 20:27:24 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] platform/x86: wmi: Event handling fixes
Date: Wed,  3 Jan 2024 20:27:03 +0100
Message-Id: <20240103192707.115512-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ExSkNmB2XLBVT0zbD7/ej9cbtogIZbianXTtpDxY4fOmtJE0vKv
 bB/Ey2dY561zgHgoV8BJoWM3XO81NP5Zi8KCS4mbC+qWGgqTpJVoAMJE7VxSYe5M2OOCZQV
 gB+8kQXddMHcNdBzYLfupU8YJWvU4zmz0nhvedr0seaEI4X7muqCMHtyu7y39moMXJmAjJD
 VmO3VMnqlGMHCxdj4PDqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8maeRSqu2ns=;kqNKUrPIL14F7ooBFSA5Qtmy80l
 RUVZaG6lMPIpE8ukBWzqrGh1wZH5mK3geulUxAAW9PcO22V8V/Zso4h/7lKrF2E2BV2UXIRRW
 IlqCrL4xgMU3OrXE3VkT2dtR0MAq0+G/6Puc1BXZVk87IXnlixRl0jlLo60ylzz9P16F3hFDU
 Fr+Dotg1ckKGbwXxsv1FwDQGUFPkaMikv8mKnni6w/Wsw4ePsuShBycQ2Z8yuKJFDiiqIQ2X6
 ThpSIpt5iOnlkEL7bLuhXUOCX++WoUL3ZGmsOQAMjf9M38bFEM2K+WSReHdKI1W1Ss9ysVr8q
 vFDMTvLfhD6dHSspl8Ni20qK0gF4D0oyUJ4L1u+Vg359lcsR3QR66vOt2P5/3+0mjW/WQnMRb
 y/7EQzExsuTDlUJ210v3L53NshI/JiB0IUx59kCJosKEGFyCzSdSJQ3jbcx13UX5qQtldtz0k
 XJ8a3brsCkKZHgJNFcXoZ3nfzJvu2bgn1PebxeJJsfFFtuu1z/5ubPSILSHNNUPrExfXjGRqe
 AqYQieSFcLH+MuLFEUMpGC56uqCOjsI3TPf2qoyKfxaPE4jgbxwhx7a30BnwCnkD3MOW0EWOy
 ylA3i+JjgzK/krUJS8mtL4JdMEYjH7UxUttu/MpoOOD4Nee+RUgVVxtHzk+iH5V/QUDmCpced
 DaB+101jENUWn3cyce/6Tk0vnJjk7GbNKKV+4ylt3MtJx/2Eeh3TZLtiZWYCY51edvNPuym8Q
 FAp6NhAJ8Q6qE3Qytp4mezTbO1U4IJp0IRqAj3Nx3q11pJdPiesIa46m9ydR/O1lOc+BIRJto
 N9oTICAx8O5eFYNpN17RwJ+HEahzmlDI5OShHvrUbsFMBtaEV4xjQy2928uWC5Nm5pa+OLpw+
 hUmUyEFmaBES8JSYtpPxCtmXtumyQs6Y4PNHw/mv1NdWn7K0ltBPFdHwrEzJSmrX0HAcRIINW
 CjxA7dfGfw9XP9jjORHEaHg/wz8=

This patch series contains various fixes for the handling of
WMI events. The first patch fixes an issue where the WMI core
would return an error even when a legacy WMI notify handler
was installed successfully.

The second patch cleans up the last remains of
commit 58f6425eb92f ("WMI: Cater for multiple events with same GUID"),
which is useless now that legacy WMI handlers cannot see duplicated
GUIDS. This however might highlight a potential problem:

In the email thread concerning aforementioned commit, a (now legacy)
WMI driver was mentioned which depended on this functionality.
I believe this driver is the dell-wmi-aio driver, so this driver is
likely already broken for some time and should be converted to the
new bus-based interface.

The next patch decouples the legacy WMI notify handlers from the
wmi_block_list, while the last patch fixes a race condition when a
notify callback is called by the WMI core.

All patches have been tested on a Dell Inspiron 3505 and a
Acer Aspire E1-731.

Armin Wolf (4):
  platform/x86: wmi: Fix error handling in legacy WMI notify handler
    functions
  platform/x86: wmi: Return immediately if an suitable WMI event is
    found
  platform/x86: wmi: Decouple legacy WMI notify handlers from
    wmi_block_list
  platform/x86: wmi: Fix notify callback locking

 drivers/platform/x86/wmi.c | 179 +++++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 68 deletions(-)

=2D-
2.39.2


