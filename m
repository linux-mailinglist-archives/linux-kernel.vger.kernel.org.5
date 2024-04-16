Return-Path: <linux-kernel+bounces-147141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693118A7006
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FF71C2134E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E71311AF;
	Tue, 16 Apr 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSHYndLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76932130491;
	Tue, 16 Apr 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282043; cv=none; b=TOrPcFZpcqcGFvIAyG0V3eLYlh1UFhj9ezWT1kUZVDb6QOPIVKAbxY+DhkXkAQWATcf+2F/I5DKXwJ3MHoT8xqwmeiTTjpmmiE5Zw1HLcVdh+OeTla4mY4BkWFV8Dn39hSCd+jcSkZd/cFxlqmThr6zB4DM9uneReiu6TKr4r54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282043; c=relaxed/simple;
	bh=M8oXFOXC9510L1sS9yrQwCiqB9isOtApcFXKR6Um07A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jg9yqwHJXW7WbN5UeGKVEP/yAp+ZHkKxglcwjyJEqrB45MWdQaUzCNtQoq04Cmwde1QQ/kYxViGKuQismgIlxC7PfwtHvHK6+DihWfSSHN8gouEMK/Nb3LUMnhbXzJ/01bxRRlXC4Rg+lmiFQwaSHKXv1T3uUaHLra32fY7a/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSHYndLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565EFC113CE;
	Tue, 16 Apr 2024 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282043;
	bh=M8oXFOXC9510L1sS9yrQwCiqB9isOtApcFXKR6Um07A=;
	h=Date:From:To:Cc:Subject:From;
	b=gSHYndLgQ56O76u3RNiEF/RQ7gBGKZxI/UgP8M0MOMUZchr73UqFrltTx1Jaky37E
	 2PDm6pZUSLadw3UTIQP6/kmZqgB2xo6Cs59UhIR5pc+Whxv2wKsc5sdxU7LBfRUgkk
	 /de0az0CjUS1nwJTflxergcCYLsZ7ThrkvCkGGEMqmVkyTeOVNsf+LT+zmiCuRi6+/
	 n2UhOXE8XK2MWY+jWNPueo3zeu9IWC6rwmSTjq0OLWCnXVu8Rh/4bLW2DIBKw0r3iW
	 XcDfBGWrT08PV3LlFv0oeQ5c5V2rzeeJ/dhyGwUAwEkfyFaPHA7b8nvCo+I0jlMk2B
	 yeRmPWg/pZ3iA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwkvL-000000005yE-0UE6;
	Tue, 16 Apr 2024 17:40:43 +0200
Date: Tue, 16 Apr 2024 17:40:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: ath11k: WCN6855: possible ring buffer corruption
Message-ID: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kalle and Jeff,

Over the past year I've received occasional reports from users of the
Lenovo ThinkPad X13s (aarch64) that the wifi sometimes stops working.
When this happens the kernel log is filled with errors like:

[ 1164.962227] ath11k_warn: 222 callbacks suppressed
[ 1164.962238] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
[ 1164.962309] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
[ 1164.962994] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1476, expected 1484
[ 1164.963405] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1488
[ 1164.963701] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1480, expected 1484
[ 1164.963852] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1468, expected 1480
[ 1164.964491] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
[ 1164.964733] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
[ 1165.198329] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1488
[ 1165.198470] ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1476
[ 1166.266513] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 2699 at byte 348 (1132 bytes left, 64788 expected)
[ 1166.542803] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 4270 at byte 348 (1128 bytes left, 63772 expected)
[ 1166.768238] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 0 at byte 376 (1112 bytes left, 11730 expected)
[ 1166.900152] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 3 at byte 790 (694 bytes left, 16256 expected)
[ 1168.499073] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 1 at byte 62 (1426 bytes left, 3089 expected)
[ 1168.818086] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 63063 at byte 1466 (10 bytes left, 50467 expected)
[ 1169.032885] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 0 at byte 364 (1120 bytes left, 12483 expected)
[ 1169.308546] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 3092 at byte 348 (1128 bytes left, 64780 expected)
[ 1169.563928] ath11k_pci 0006:01:00.0: wmi tlv parse failure of tag 1 at byte 348 (1124 bytes left, 44062 expected)

which after a quick look at the driver seems to suggest that we may be
hitting some kind of ring buffer corruption.

Rebinding the driver supposedly sometimes make things work again, but
not always.

The issue has been confirmed with the 6.8 kernel and the latest firmware
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37.

I've triggered this issue twice myself with 6.6 and .23 firmware, but
the reports date back to at least 6.2 and likely when using even older
firmware.

An unconfirmed hypothesis is that we may be hitting this more often when
enabling the GIC ITS so that the interrupt processing is spread out over
all cores (unlike when using the DWC controller's internal MSI
implementation). This change is now merged for 6.10.

Do you have any immediate theories about what could be causing this?
Does it look like a firmware or driver issue to you, for example? Is it
something you've seen before?

Note that I've previously reported this here:

	https://bugzilla.kernel.org/show_bug.cgi?id=218623

Johan

