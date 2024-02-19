Return-Path: <linux-kernel+bounces-71262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6985A2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95A01F22564
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0072D611;
	Mon, 19 Feb 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XpaeoWD0"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC392C848;
	Mon, 19 Feb 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343978; cv=none; b=LU99K9NaRmU8LAdrfAba9rRFp1c5f/2pxnFfU1qKoBZaz4EVSN09kspLR9CbZaMxIByloUxB2LBmSjixe/ovMAeNzBKTYPc+y+s8fMxZrp88dARBA8Gl+TcNoJezC9WJSvCb0CgxCbXDWe08PeYhZpTZodiBH6mbxbgjwC189fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343978; c=relaxed/simple;
	bh=DARuHR30dnAqAr1NDeLu/YfYZj02SN8k2C8kOfQs7Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CdVg/cSXJIXClaoOqSBEDH7LDqregBrQarNQPRS6SNKdSquhZO+lI87ldCPBnD4LUYyyqHP7EaABrcD3KUz55Db6CMvMJas9gvCeU5aHZ6WaCM/gbhlfCGGYMhpRrjAjpWB9X0Vb+1Ax4giTfPgdlGA6eKQ6+Q3vna9dIzXJt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XpaeoWD0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708343962; x=1708948762; i=w_armin@gmx.de;
	bh=DARuHR30dnAqAr1NDeLu/YfYZj02SN8k2C8kOfQs7Jg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=XpaeoWD0+dKs9vTq+cvmN2nn154rdGgam28fF1n5pUrdbvfzxjSxIB2N2HldffEL
	 7nyKDC2hUKQclBkiowuvK+/ZVUCaN2WEPueRNX+ITDduLGpvXhBAMFxARpu/fXiEA
	 RjmwsUKNuSbKc2pOPNlcf/qD6NksSO0H1QWZ2IcwN99R5xNxbEbWT9RwcFzlaMG3e
	 MVcdQGuAULdiR7vHWUWXKXGAalVY5jRdnaDZB7cEl4NJGRDZfuLexIRuXDY++zkrL
	 0vkMBJxWW9DC/jiJD6yNXt4O69lSzLdDH/QKyApoXtHkmOlimw5Ix6hcfseIapyTS
	 P3cH6OqjiWrv1ASPAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MSc1L-1rV8ZX1V85-00SwsG; Mon, 19 Feb 2024 12:59:22 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] platform/x86: wmi: Fixes for event data handling
Date: Mon, 19 Feb 2024 12:59:14 +0100
Message-Id: <20240219115919.16526-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7dEMHjd/3RyOyA2GLAf5fKIWuEmtu692sKRqSosRzMvXUovT4U7
 JTLjIkTedoIx8vHzj6RdtzBXyiew7DSI1azCam+QAUul2n+4WuaweK18+fvObI1tteDANoW
 CuDjayHB2Ull1pqSIxwlRTa811YocmAmJLgnvkTyoosahJR65C8khdaHMElNLcwV6q9/+Zv
 BXQtIug55zrbNq0Np4i7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CMu4Py6JY/E=;ouDpr4nVK4OfHvZD7q7ixZr/TuU
 BcyFI7O5yXNIyixdpIiP9Zr5/NdSBqqdcEsgaTmhk2eKWn63orY+OEMcxZUnflSaaFDoj9PPj
 uHpZWr85+ofseoLlPjwwBYZ1sM/4u92Eo9kfX8K+R4jvnRj7cMpXNrQGFuwUlcF1rehie6z2r
 vM5v3Rva4WA5O+uN4rbrFv/Q1CFruEtoUUV/+oHEBa9rsGYJ1kGHh2GKE47ggv9YB3KVlndFC
 vwdoVyG6DqBCrREuL8mFMLjxs255O961/ifMMxHNI1CrmCqWcRO3K0VFMEQHqYz0UK3+FIb/O
 HUZT9EzlDeAWWdh7GYiuYnVXdlBCjZ6keDiAyomaKdFaj5U3cP3hQ6PfIlc1Aal6WbanMJ2IQ
 0hq3VvNb9LED3+jII3ylNCJBZpPZWI26yzXeUSMnxeONL9AugHD7YZd0K/XaFuKQKVojrBaBF
 7z9zD4Xo0Tw0Inl41Z9M4Ikt1jhRar1qBgco5E6EAesuufo1q/r3Y1B0sTMWRchrJALI391nq
 I56KgD90SdbtbuX3q1CWQqiFqNOaN7rD/tMbY0DuJDLS3U3nwPiI0QtLUP2GNJu+B2tENdO8H
 MaDdCbHiZSfkuxHf0DSZELiFZmcM4xEiOR3T6yl9ZbKh8xDLafUafvNAywsn4wqv1iuKE0FoD
 sSgF7az01MS92qCckYGQDF6e2XF0XHsrUWsb5HqorSMF7xoVt2h8IqA2FDd5JVWftII+Fr7g9
 gTWVls8tefX1ocmRA/6kJ1Jq265iA8dD8+1++8BYjLw3fEeMmE3XHajJ6qnAkggFKDlU6sgum
 Lb+oNfpExBAg3wxFIF8pNcekqmMHh7nCFe3yLr1wECmhM=

This patch series contains fixes for the handling of WMI event data
when receiving WMI events.

The first patch aims to prevent WMI event drivers depending on WMI
event data support from binding to a WMI device which does not
support the retrieval of additional WMI event data.

The second patch makes sure that the WMI core not only checks that
evaluating the ACPI control method used for retrieving additional
event data (_WED) succeeded, but that it also returned any data.

The third patch fixes an compatibility issue with the ACPI firmware
of some ASUS notebooks. This issue was "fixed" inside asus-wmi by
manually retrieving event data items, sidestepping the WMI core.

The last patch reverts this hacky fixup, as the underlying issue is
now handled inside the WMI core itself.

All patches where tested on a Dell Inspiron 3505 and a ASUS Prime
B650-Plus motherboard. However the last patch should be tested on an
actual ASUS notebook which is affected by the workaround.

Changes since v1:
- Drivers are not "he"

Armin Wolf (5):
  platform/x86: wmi: Prevent incompatible event driver from probing
  platform/x86: wmi: Check if event data is not NULL
  platform/x86: wmi: Always evaluate _WED when receiving an event
  platform/x86: wmi: Update documentation regarding _WED
  Revert "platform/x86: asus-wmi: Support WMI event queue"

 Documentation/wmi/acpi-interface.rst |  5 +-
 drivers/platform/x86/asus-wmi.c      | 71 ++------------------------
 drivers/platform/x86/wmi.c           | 74 +++++++++++++++++++++++-----
 include/linux/wmi.h                  |  2 +-
 4 files changed, 71 insertions(+), 81 deletions(-)

=2D-
2.39.2


