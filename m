Return-Path: <linux-kernel+bounces-1938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE17481561E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A711285ED6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA515BB;
	Sat, 16 Dec 2023 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CLyV8jq0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267691365;
	Sat, 16 Dec 2023 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702691772; x=1703296572; i=w_armin@gmx.de;
	bh=XAyO0T7Lw8SciW7DMIbTLRQ9EUno3/ZKTyiy8CBdVO8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=CLyV8jq07QOd25neNjzA2zJ0+GdxFM4TU2IvdZgF0oKRo2cfJAA5r/vc0rvCl1sQ
	 qeMkXjvAvqKy+wwNz9ZE7Q4pEtrl1erNIWRs/0ap3yHimuFu5JDEq1ntg8HVifL7J
	 aPTb7tq8Jd0oSbkosS5VX3xShLwUvDtc0WVr4+H+mLSirTHDeaApjfFNrTUz11iB2
	 7Zz2BU7CbZY000xh04yz88AaVCdBJ5fBBemVxOnTcuFKU1PGUwqeT0RzpUd3ZJ/e3
	 KhqhuiVqqoIEjA3gSYlJ1PIn9uEpni6I1ye1Y/EamCQLpEdTyJhtu26nTsquL2Agv
	 VC0ZAmK1qCDCShbXtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N2mBQ-1rK4Zz3n9I-0138lv; Sat, 16 Dec 2023 02:56:11 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] platform/x86: wmi: ACPI improvements
Date: Sat, 16 Dec 2023 02:55:55 +0100
Message-Id: <20231216015601.395118-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Acv3WgCtcW+bWFyTlAbt7blGYzzEQ2MBOtnhTxKfeM2RMNvJ5g
 wQ0w4oQik2oCgG3AYKsX4ReWeYFNwknSI4t8ZUTmb3q1FJuw9cFN9G1YFJW6DuBCp4paC4u
 XFeOo1crD1mILAW6YGkL+NkmjOTGb0Uf4nyPH7v1npvtAEGOaNWUB3yFNs6H/mC571dJiOe
 5E2ljLQH+rqLrhevdB0Bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8wIU+Wd1RkI=;QcRKX5WB5wOxz+cwJpgc8ZqJzNz
 pFi7deAA2Y1ORme0eQyRy2I5HX3TrFc0sI9C7jkfPbs8BDwutL0sAdmLl20TGGbCOVeY3mLgp
 mh1jn2k+gEPp6A3knB7hRv7Wth/77IjpY1PwgOc6EJeHPpjkesxsaC2JAXRuSTlQWFRKaQbpk
 sp6dJiW9cVQmWSoQN47+E3qelSpBowV6TkMMDHdJ8FfT59zRGokUOwggbqMpkxLFWAICtDmfI
 fxpQzL63wYjvjCCxPA7JzC5r7kWuLbswH7Un66ELumLPHbUTwolTqKOcmNlnrryYl/fWfkL3I
 ueuf+7ZG7AgyNmWgohmyLEpqFgk/nZB/dc2od2Z5k0tfmI+zzRYtp//zEBvJxQqZaz0r8gZ0a
 si9dKfSSmMRTNvhCI0Ot2YaaUlEyV0fWj3p0cFcIY93tPlcMI6F+zpW/HbY3Hj3UCug9aTKGd
 AyfTJt2VlkyU7R6CXoDDX7LkdpasRNAbTm8azcO4pbDWMGwz10MEPPRz/GrXi3iORVsH5LQCT
 4j8LZRIA356lx1vPJ/mIag1BXEDJObeFTskX6KiWTSYdRCsbgpHBOWrCyP/oiUIWaLIsf1C4P
 nYpeY/Fs28l9D7DQ+RIHqcY/YBQdm+8caAH2bEtCOV5uybMl991aWTqZ9O5U0sJvEDq95D5/4
 n575U0R49o7ZZZ2s7Fy0L0OfTpfJvY6Zc/dTuw0285HTse8rzwHGy1RJnkFnKC2zmIORlp4gl
 Gh0GAxqa3v6n6fkp9rud6dFM4IpC7KN2GAdLsbUWjAgIGx3OBxuL3Li4pGFWNlfFc3pwTl3cW
 iSpGMCOQ4kqg2twZbE+1M31YZighQbwyhG/dfiIrvvHeWymIhvZB4iVZnc7citq6hn9HvjdCh
 7paNLWgOvxsOR54CEEwwvgOuFAAtdwp6bOHtuf6yN7MtlgHiPB5Wwl46D66XJbGy3XY/O6Noq
 E8VUwIp4GnFwAkXd13E5TNKQ4IQ=

This patch series improves the ACPI handling inside the ACPI WMI driver.
The first patch removes an unused variable, while the second patch
changes the order in which the ACPI handlers are removed on shutdown.
The third patch simplifies the error handling during probe by using
devres to manage devie resources, while the next two patches decouple
the ACPI notify handler from the wmi_block_list. The last patch
simplifies yet another ACPI-related function.

All patches have been tested on a Dell Inspiron 3505 and appear to work.

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


