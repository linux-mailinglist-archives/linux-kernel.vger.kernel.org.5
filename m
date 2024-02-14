Return-Path: <linux-kernel+bounces-64819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAE85433B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CE51F291E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DBD1173D;
	Wed, 14 Feb 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="D3neLMNN"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF0111B0;
	Wed, 14 Feb 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894293; cv=none; b=gsAx7nExisVCN8cl+QLLF1NtOD8Fsjc0pH9DN3u/Gq65ZdIGnzlVgAWxRapl+mhsSTZgdiEQyLEpHJg6OFZMkJ238yTcIXRgscYOSsJn/q85FWbjukSvgO3YLWnbBgLsnxPHBnQIdqhxh4lacbaE93FHnXoGCwga3gDM4VVvta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894293; c=relaxed/simple;
	bh=9WF497N0mP5INdxam/s7jjMx5qgKT8n8tqzrHlsYhq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uFvKZOWjS7vkaHkKUHO2LJoLEqRKnJFUKvh9NPQGcBzbl+UlqgNET8fpolV5DOu92PuZ5wkr3pAm9UPl5qNIY4LWXrSDpKWqe6abCMFM6xXKMzECTJYLeGg9/Y3ccd+PTLEUVmoZYIGhv+dQ6re5bVm2ToO2iFtFaDhzBAZUYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=D3neLMNN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707894277; x=1708499077; i=w_armin@gmx.de;
	bh=9WF497N0mP5INdxam/s7jjMx5qgKT8n8tqzrHlsYhq0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=D3neLMNNjJTeXH1Fc63ssXErJ4oxyExeEKPP99SMC0MdHz6vxuZhK6MzYRNnkXEU
	 M6D6M3dFACptbZgRD79YiAIjMP/XLsEOCGBUL9n3KPD66Go69IhJm3elZ/+WUhz4/
	 pyKy7NQtKx3MQ8jzrWr4PUYFMC5bWf6l/TwXVEWG6A+fdYAVQxKFvu/Bdh3X0nYmy
	 pMa5IYJaKhQMyse0AWaPrRo8XtH51x+OWFYgVfATuWraoU7BbqDExsyEZtS9bT22P
	 GodeOizafUmCOr1oeHXvdbdv7oysefqxPlkFLahdx0MU+PHK5CJdyu7QtR+QtG/WH
	 I5vz5GRtw2ESwM3I0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MxDp4-1qleEn0EEy-00xbZ6; Wed, 14 Feb 2024 08:04:37 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] platform/x86: wmi: Fixes for event data handling
Date: Wed, 14 Feb 2024 08:04:28 +0100
Message-Id: <20240214070433.2677-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kHHTIzpSa5Q/YMCYAMtpResv8URGHXtnxQMel96xS29hKHkQ2Ly
 3odIg0dyrr3zojRqi4gU2xBsEviCN35cLfD3rL5c8nxQyDzxzGCCcCQQ/ZR9dBHJtM/wgiE
 2/lmpYDlKnzjP7VyJuQxzAhV4a0uMw6e8ppistgTURq5yZM0lkJZ7BRAomFnknnnc/dCRY6
 oCA9O7bgJ2QKZORWR9Z8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:19Gueatd4H0=;F0AOFIW/7F6yBKwWzIYmqqJHyA9
 +H/vlHfkTXzVzwBN7JQJ8qtmKRQfzP6uV67zhUf9SFlbs4alHxcKpqzHCNV9KdaX6YmnGh6BY
 fylye4tVSsTQixEwkdQG1+6YfaVHt6Ipib2+KtyVV7kTCzJifLmpve+EdaPxZ/eKACWW4goY9
 tqzjZ3h1WO5J9bkCMdF3dcDOGi5VwiammBrCEhWGHRmD/3a1XWLpUxQ7zhBEzpd8Y7O+06pf3
 QIaYAzeSI4uOgCu/TbSFmTkh3D3Sra/RP3zStGUR/Zl5jcv7ImJDBVcApq6dNw0tTvNxq3UM2
 m4vSisHzL9h9mUkvZVzYSxc8rg8LrASvWqMh6BbndIsToDfSpwWQC3jOKKi2Kc/jlDOvEMADV
 C28rVLpPIxD+iFe+9W+U0pn0yD9DOhA8QOmAwiAuPjjVFxqkVOj8iumSoE2guIJqdq0f2UrZA
 qgEk7D0gEqjFbMRIXj7WNWQd8SJC7W0hUsBkTuYVZwzUp8lbjPHPrhvarpbjvV4tGOFHjQm30
 7ExcHkaE7s4SzJqeUiRLXlD7n1E3KSVA9k7pb1+yMXgPy2AmatEsSOrmZ6w+UKuK2TtzbdLLl
 Vr2p9OUQNXXZFhXsW436ByWVykQWg4KtaXz/tNU6wrXVLvI+mAx4epzET8gvslhalUvLT+1mb
 iWndfssKYwohpzsa3EHArUtRoKuaZN0QZKbW+qTe2CY1Ux1DFnjVIDPD3NiogLydNpmSzQ/fa
 EahAXeML8MCEIab4yMd+ksAUbqAaQo0GOkLTvOCoN3N9uAPVIGlEeRr0KhS3WXZ3ofoHVw7k/
 z3AWl9AIPo5udeG+r2vXjanlV2fypVJFXAlQcmqpVNH1A=

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


