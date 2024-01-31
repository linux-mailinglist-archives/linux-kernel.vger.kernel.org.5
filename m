Return-Path: <linux-kernel+bounces-46331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43E843E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91221C2A9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9276052;
	Wed, 31 Jan 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iO3RmPxz"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9669DE2;
	Wed, 31 Jan 2024 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699829; cv=none; b=ldXmZa35+vcLqNdWRQpl2P6qsR+wEn+8oytcrkIAexPB4aRz3J4o+TQ27SSS2POuHoslecf8X0tBZLLb1GzwOTsoSuQeJQMROfPYuvG5iLYIkHswvO57evWduvk6NI7MUrCV9AFgRo2jPpG4L8yuNOMnO2NrnpHtR9ieKxVeH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699829; c=relaxed/simple;
	bh=ezyJ3RAWthEoMiSHE2pyK7llcs3x4Wbbh8fvvEw11/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ogR5U0vg0KGlJoSbwR5FGfYd2Jnn0VEwL7Q4CUoJMl2A1wtUmjNwaLoxEmvM0+T3HEVGQMXygfN6+I0wzxXj+jjI8yAT5sRIQ16XcaLSHZpgowN3b2EpkHsH9Yw43WnlAkEgzyRUw/++90vSKc9s0vyUw3UdmvZJhFyGERFRJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iO3RmPxz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706699814; x=1707304614; i=w_armin@gmx.de;
	bh=ezyJ3RAWthEoMiSHE2pyK7llcs3x4Wbbh8fvvEw11/Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=iO3RmPxzHQHJNCGLQNTWXxt8ep0NgqSJGMLExWu7uPc+H6rHPRj0wNTMrXs0Aiy5
	 Iu6eEJxI86HryZxWErADo3WI2FFONPOoSyIw1Q8jDvmgXeIq3EPlAxuIBWQh+OTc7
	 WM+HUXqqQ2LU5tcXJHb+uwStvERHre1N0xvfD0oo1ydXdWx+Qi4CMLJAGeT00cVr/
	 q8XRpdtPmn4423dF7yjyZii0kYCwThCrYW8U6P3KNpGBhuUf/TgZS6XdCmiogXc2e
	 GsXQjgnnKDr7wgvm6mIFwIoqOyiA3kGfXCtWWn6Xvzms8xZrF02RiNSj9D3jtO8S5
	 nyP18Fpd8miN7qSOCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MA7GS-1rJXzg09Os-00BeIZ; Wed, 31 Jan 2024 12:16:54 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: dennisn@dennisn.mooo.com,
	lkml@vorpal.se,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: coproscefalo@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] platform/x86: Add ACPI quickstart button driver
Date: Wed, 31 Jan 2024 12:16:39 +0100
Message-Id: <20240131111641.4418-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jDTwPO5c5zM8j2a+DiDZVYT/c6PVwOnwm+ivKNBWn/eRJQUQC+V
 2Tm20vOECym+JDUKfVAEQfChSfMLtE1KaBvy/YtDihwbqd2WnnShVpLDytHXLWCHlXwtjyJ
 J6LrUPicbauqi12kB8An+7s1MZ0HcctRhiSYj8+M+cT/dkSzcFS2YQwe+IaQd5VyS/twuc0
 VZV5BOLiK/azJFiFoWy9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:51xwPc6pxrQ=;09rD8X1Kl+pTpBqHI54ESR6b7pS
 wxaY5w8MsjK1ZSLJBo86dFj+A1qfH9pYTlH+pveQY/M+UlJCN/fRZU+PMJOUR2jK5IcZZU5Tp
 3bF+ml1uz84OQMWcKCCVNpWo5NPDPYfbH4owAThYTVIJipzmUtoktLuH/7cGB9m0gJqRGEZ4V
 vlvV1axIxh2Jq0Fizxt3fKHtQ/D5BsfKt64UgSQnZCw8H6Dj1WRrTDe8FmcvPhSvXks9144tz
 tTDSGLQeIn8UmA83BkqUdHS0VfVbc/3W7LEPm6rApqtOWDvs2X++vrJQwjmC61oB2TWndgBjJ
 ZH9Y0T5tPPxRtLAC6AW6XjGgYqfonKPqCh1B1NDPI62pX2MH72Ift0WIRga79fP11KZeC+yrJ
 DT6iGW9I8PGhlaOq7YLJz+OnRej7dAeqtPv3IObY9DsO9xf91ZJihEF9jkmHD6AQxIN68MzS3
 mOXrhjsGAOEa50C/mqqaVn8uqcKs/sai10XNvvBAcA6QSR2miEwh8xvj7jsLcY+BmqhxXctdZ
 y7ICFhgxpp+fkOqwmUE1DjzU3/EcSfrr1Y4ZqWjH63GbC8OQltAO1hTnJ2Xz4nkNA+ZxKQf73
 YHQqceK2iYrNdN5RJkP/JBKGsd9VZKh8o+Zpi34k/VT/m2TkkmlzPuQZH25tnuVWQi92ilQwE
 aCrQhiTVHPbTggRibAb1GWzNmbi9rik3sKcW5G6jqGrao4gGZMKIzpeqKpw4VtBxUfJxyYEKi
 aweubdzaFLNa7GqIjF2HN3eY7YggVT5ebD1M1V1pcG/PG9aTv4J80uHs3f1ogpcvuHcGWftuW
 xOdoEi+t85LId3e1ibVlA9eY+poMOF9a1f7Tc7ZVaS31AEzlYQsqGggUAXrvtu9HXiQUNsHF3
 v8zVXdK/m1gDQKrI6jcknshJeCrhuqbibtkfUHT2Ermxz3oPZj4KaVgaq6aLppzDpKzdKPTPI
 yVW2/IeZzUXYVvfk736kol7QcBY=

This patch series adds support for the ACPI PNP0C32 device as
proposed in 2022 by Arvid Norlander. The first patch adds support
for the device itself, while the second patch was taken from the
original series.

Both patches are compile-tested only.

Armin Wolf (1):
  platform/x86: Add ACPI quickstart button (PNP0C32) driver

Arvid Norlander (1):
  platform/x86: toshiba_acpi: Add quirk for buttons on Z830

 MAINTAINERS                         |   6 +
 drivers/platform/x86/Kconfig        |  13 ++
 drivers/platform/x86/Makefile       |   3 +
 drivers/platform/x86/quickstart.c   | 225 ++++++++++++++++++++++++++++
 drivers/platform/x86/toshiba_acpi.c |  36 ++++-
 5 files changed, 280 insertions(+), 3 deletions(-)
 create mode 100644 drivers/platform/x86/quickstart.c

=2D-
2.39.2


