Return-Path: <linux-kernel+bounces-74951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196985E063
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D796D1F22B03
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562F7FBD4;
	Wed, 21 Feb 2024 14:59:11 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AD79DD7;
	Wed, 21 Feb 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527550; cv=none; b=CKqLMzSVUKcWnwl0Ch1GzbKLD2yrdqlWHRpyAwe89rXOiqPrcGwSd96ialDFZpiMjXAr6Q795mnHU7SbZyCGTJmNyTZGekUPkHrg5rxnXdQlLCWOWfpNPC7KLWh5GJ5DprnQBOzAmf/LNWJ3tYZjX0KGFYNXXl07683sqnQJKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527550; c=relaxed/simple;
	bh=N+0G2ZdTsC9Iod1o884oqVOm5Ko8o0yA3zGwFZP/CtQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZPyOVaKv69qJxVAQZvxCNvgvL0jsGhN6VJ5Crx8FhFDgRxSJM6MN+/jRPWTxR3CF/bC5LI7Q/kMRMLBFCXEvcgkzN+gMeJ+gADxy0/+YcAjlsmmmPdOWiNDIro5Qt0P7V5BlpfUwOayKrhi9E3/8XRbFGQxbhuIy2B8EI9tp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15 0/1] Bluetooth: Fix deadlock in vhci_send_frame
Date: Wed, 21 Feb 2024 17:57:43 +0300
Message-ID: <20240221145744.27895-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

Syzkaller reports a potential circular dependency leading to deadlock
in 5.10 and 5.15 stable releases since the commit
92d4abd66f70 ("Bluetooth: vhci: Fix race when opening vhci device")
that caused this crash was backported to these branches.
The problem has been fixed by the following upstream patch that was
adapted to 5.10 and 5.15. All of the changes made to the patch
in order to adapt it are described at the end of commit message.

This patch has already been backported to the following stable branches:
v6.6 - https://lore.kernel.org/stable/20231230115814.038261305@linuxfoundation.org/
v6.1 - https://lore.kernel.org/stable/20231230115807.749489379@linuxfoundation.org/

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

