Return-Path: <linux-kernel+bounces-4332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4DF817BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608EF1C23109
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5B772069;
	Mon, 18 Dec 2023 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="t9D//caF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF714239A;
	Mon, 18 Dec 2023 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702930743; x=1703535543; i=w_armin@gmx.de;
	bh=q9wL0sOP60Ja7H4IQatHbqL5WFADfzE9WTyOrzpo5n4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=t9D//caF0Yy3sAnH6zA4ICqi0afZWMWlc/IrLDM46nuVhKQOfqYUNJkQyJ+Yx3qU
	 F3pASgnk6HOb0ajNSPoqaBFn5pDBziwZFI9rxdo3VnogPdudCS8cwpuKp++JhxRa0
	 T4q5ymddC+NuZqg6ocEPcZLOvVL6xTh0Nd33zLhqVoPWKB9H+U/aBQzkQ5uI+Qb+3
	 WA4v2BPQEj+GBnO+HntWrmbF/FEOXtKGpWhi9MXo0KH+TM4V18mNg6u2+JxFMaC86
	 EnYoXfocPLjTCIS24nDZuef5uJ8xlIejzRhp9Dplh7PG7qDbprG2WHMBjEKkrzsM7
	 mRRw0tiSgKnZLr9P6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6Daq-1rLvmZ2vgO-006ehp; Mon, 18 Dec 2023 21:19:03 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/6] platform/x86: wmi: ACPI improvements
Date: Mon, 18 Dec 2023 21:18:39 +0100
Message-Id: <20231218201844.2860-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1HKcbLmgC/4UC4x94Q3rYinHRyvyZBup2IskAZUhduSzecLUxX5
 OWBQO9gg3fDL95xfd8ve+gOCWeEg/DaISOnINt28MIfxwPZWzWe8mS5jgIsEMfxcqy2U6j5
 xBF9R7cPKAKZYjM2Og1Q0X1DCbm1rN31ikuEl+NZmkEYwCNIyPOxcC3EgtBIhjK/zqDFmGC
 +KIC6stijwNk/embzgRTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cGTfvJ2G2JE=;Cn7C5n3bmHcGeVxB6LnsoT5IkGm
 nY5kJ66wrSR4Y6m44ZLbVRx4CaIromJaMkUjRI3hovkuRXB+T9/1TxIDB0i3w04n7C2bacZEJ
 /fkUlurU6j5JD5R2GskxcUOEGm164w3naDUwoy7j9so8OIM51CBd4NinAqEp7xc3x/lZeCBcn
 lIg6sRMZcDaHSWGuEm/gcIUhvZY0jfq33g/7mnU/JNqGD3FNWXWgx492/Ougv16pnNbqmYub5
 RXag4iAy+mDVgkEBeqLKlmo8boUGoGZjDat6aR30UNMXLlz30dpTSm6oHjhs8MMlPrF7McFp3
 668hF8mwOCoLwaD149qeH3CdGHyzjmJKPZeD1aZCwcHe2la6yQj/KSCZNSqcfaOF/qlTTEy6l
 T0YsA8wVYh6ODQVCoegh9DPxS1fb8imXBydNnHjTG6LAflRIve2Jhp4YcIsAB0VhCBQK/u2eT
 //sjGODVPLhuNfsNxIdcomLyEgbeRCK67oXP1juGcGQ/wr4HwtWEV+e9CTm5AkhrMc9I90QGS
 WgCYUhmKNnKe5HthRhUW75gzEdi/UGwfI3CDFSp50iM+gP/LByytlE1ArFwcqxVLCN2d2eRFG
 8asUgR7qsohStSt89O8Cy8WaOEDtddVJAGroK4Z9bztM5jLfmEh9QZVxPFIO5b9FjoHW6NvxN
 cj36ni2DnYwJhUFY2si7ya4pvMAYD8Vu7X7h073SGcw1t+OKW7XYeec+8gs7K+O1cHqxJd2gr
 ifyl4mk0xldt4R+LDzazrL58kBZYhzpXmv0D5uxu/osLAf7kiz1ODR2T42dd5w6ShW0E2rCuV
 tAj9Na8XIr7VEGeDJeDjnfFTnq7yM43QRAKkUJs7ix/jeN4eapUkgyRKhZ9n1/qLiwQVkMMpk
 7XwJ0zmpalXc3TLKd3vi4gJkWzghdMEyg/jbBfQ99fnkmvck+WuvRMCWKeWZgEaezbO/VP2Ko
 77DuKtYUCGPv9sghlutJ+xCVJiE=

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


