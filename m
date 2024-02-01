Return-Path: <linux-kernel+bounces-48041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFCE84568F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4311C27ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3B15D5BB;
	Thu,  1 Feb 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9R0iZ0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DE15B995;
	Thu,  1 Feb 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788404; cv=none; b=mmsI9yMVH2yKrwdwP3W+46iUZS8SBt1/rnLmUAWEIp5VUtXvcylyMhLt4WS8g0gQM7e+fb8oCPP62XWsyy+4tHhIFO3uIDyhS56hO5zh6J8mYDSHLWnko1uhdJWe4UZzYBjtt9mxpENoe69i9L+WvjSUIerkEib73JvU2dTDxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788404; c=relaxed/simple;
	bh=lItx3fkUY4BWsDEsLhdSZpmfRs+Sv8dfzuA4Ayj4ctI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/q9mx0EuC9vUNPuMJjDvmFla5JgXRp3JhMRT+p3wCXE1XMiyIbTTYy1pwWTk9dj8htgEmsd2uFJUJw60UCDvtph1wptjyJFgxBbpwUMFcYQ/QiBv5kA06P9HMc0TiCujqUyYkkV2fqFTZJl7J+q9GNuCzdqf4NIhDtUWULOLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9R0iZ0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DEFC433C7;
	Thu,  1 Feb 2024 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788404;
	bh=lItx3fkUY4BWsDEsLhdSZpmfRs+Sv8dfzuA4Ayj4ctI=;
	h=From:To:Cc:Subject:Date:From;
	b=I9R0iZ0P9v2PJQqViWFvvI7RiJpHVYw+qes4Vr8AbbAZT4Qv1KnEdnolVKoxfDeUN
	 +cvRpKBCvvBeNt/cLaACvKqUsnSZbdgxi12bslX/P22elU03USKO1TL/oHNfGOzgrn
	 flKuk9vzvXIqkUiG5ohDcIvgyn9S31StPdMek8UhBP1TKVMdh9E9G9ltKTAHQk5u3+
	 DjxlV8t5r/r5ZmUzo7axix3WQ+5W7EHg1XyKCB2o3VMhkTcUk/S5yuGTyUI1LjrZ1W
	 MF81wDSxKAHOuClFqnO/HlLYd+48zTXrUvoEbMAr8S1DXXfGDvwScKSjiTlDWdciZx
	 ps3csnL0mxfsw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/7] HID: unused struct members cleanup
Date: Thu,  1 Feb 2024 12:53:13 +0100
Message-ID: <20240201115320.684-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

the patches deal with unused members of structures as found by
clang-struct.

Sometimes even whole structures are removed.

Jiri Slaby (SUSE) (7):
  HID: apple: remove unused members from struct apple_sc_backlight
  HID: wacom: remove unused hid_data::pressure
  HID: protect hid_device::bpf by CONFIG_HID_BPF
  HID: hid-lg3ff: remove unused struct lg3ff_device
  HID: hid-multitouch: remove unused mt_application::dev_time
  HID: hid-prodikeys: remove unused struct pcmidi_snd members
  HID: hid-prodikeys: remove struct pk_device

 drivers/hid/hid-apple.c      |   1 -
 drivers/hid/hid-lg3ff.c      |   4 --
 drivers/hid/hid-multitouch.c |   1 -
 drivers/hid/hid-prodikeys.c  | 115 ++++++++++++-----------------------
 drivers/hid/wacom_wac.h      |   1 -
 include/linux/hid.h          |   4 +-
 6 files changed, 42 insertions(+), 84 deletions(-)

-- 
2.43.0


