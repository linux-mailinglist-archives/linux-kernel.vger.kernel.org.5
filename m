Return-Path: <linux-kernel+bounces-55669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBEE84BFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B6F1F238CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B41C2A6;
	Tue,  6 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Qyf+1Aln"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94161BDE2;
	Tue,  6 Feb 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257113; cv=none; b=o+mH/UCHFbKzmCjAkmfJOQLUiDXfWtEPsMFALHfeNfHdBX3fryhrvENHJJAiNQOpiohr/qksTdBnRTzNKmKSxYUaKA3rJD925lmgsFw+/XHHEmMujE9G6ZHO2n8xpH0hVmQ5AcjOahympBuft8/YCzhPGvp0mnBKsZuluMfHKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257113; c=relaxed/simple;
	bh=B23gbhjfbUKpvpzjOifemm6xIDpwsf1gr++jrmLvLaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jd7cpKvw5WhKoFBvkOSTuy8F5BqEZVs9KqV2iv/qjn9oky3uwVp9PSVWomgS8oQLL3DxAONy8Fx48JUHriCVOGP8nxVAhqH2zR41/EUcG/vb0uHJrjVRbkfTGeQzLOyEfdCHGZOw4dGWy7NYM2u0GK5OkuFETmaoaWpk7FN1jsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Qyf+1Aln; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707257104; x=1707861904; i=w_armin@gmx.de;
	bh=B23gbhjfbUKpvpzjOifemm6xIDpwsf1gr++jrmLvLaY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Qyf+1AlnXKU817YWeKjQSW/V4LOVUzwv2B9Yv7g3DQrkFfm40gx2hIyCEvlKBp3y
	 xysKtaCKKLoFcI80GVApyqVx8EirSCqUDiL8YlCsQi4qHbcZlYJfJKg6e9K1imOsT
	 WZ7VN9XZ+6oI8P78xi1eFPOXwhrP8XlkB/4EBWmgNTy0+i1xBMq2D6vpENAqNd7yW
	 NkcEWVq4PUyXAYrV68tCCkBqZ/vS9q2CQRNcLFBeYcd6VcQaaMOlCJ7UgK1POPxWX
	 8KqcD+kSgAPAb6LRHKKSINrB7Ts5BrMxJYfnzOtsZmyD5F1f561BPXT6AvfPsbf35
	 DmxrRpaucAFGnPBL+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTABZ-1rRixj1hz5-00UesZ; Tue, 06 Feb 2024 23:05:04 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: wmi: Remove unnecessary out-of-memory message
Date: Tue,  6 Feb 2024 23:04:46 +0100
Message-Id: <20240206220447.3102-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206220447.3102-1-W_Armin@gmx.de>
References: <20240206220447.3102-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f9SK+HvH8lNvtSB2c5q7kMi7Z6Z3bX/r7F5VCvPB80HyxzoKwhE
 onKmlgkxvI4n0ozaDg9R/MJ4T9Xk5Z1fTZU5NTnz6UG8r9H5zEezC2Rg+rpKDlzS+/TjdQj
 UL81J9W2Q1biMonLk5h/7+QywYKXlorZ1SC6MXxNXOPy/o1kTkIGg9kULDP5oO1teagDQ/1
 K+m7y9KEU6RlpzNp2yrTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sNu2xG2HF8Q=;49cTGIuGzKgX1nRsSbkqEk2AdrY
 WCIiBUJ5rgWmboCJW7p7ImpvPOkpmaM3CqRlOViF1/0CheNQyAkmPtdy0L9QPA1OBm5pGCe0F
 x3nhzQVQqxD76iXxWNnjBO7YcBWMgA5vjjr5Cm3SGf+a3Lw2AzmE7yPMZSIYXVJFjaSsUkVj0
 h3NvCdzWb2QqaJhZEZ/I3oq602hZOYwWAxWEle1RHCy2s1U8fDumEp+9wqCeHHTiPJxGkoYrV
 KN9xZqBHwQaKmRWSOkbClvolMGu0w+8Ve3I5Jkbmyo5/o3NQ9gQl5zj6JaAwIrzMp5VtfuHir
 ilOLZ7+duVrqp2annmlPS0lfaHYhjp/iKb9X6J8rDKJPSNU86VC5zmzyn0NSfklp5Ovs+/Q7N
 uhyzNZZAu6kvDdL42shZAGQ+SQL6RuiqqLDBr6CxVMm8N0HXd+SzvbL1UiTZxXOv0TuaDQpX2
 2ujMh6bOB1JHXgeIGnOIhgzE/mpGHOJSuUN/sC7ToGuBOZhNrFxj71Gi0O6zCtREye1wwXYCZ
 S97gOUhe9dPX19AHpPeLy0AvmzMyLnylJ8sX2c2SAZAtwT8PAJ0V0TtDfy2i+AlrD4cX1lB3F
 xIUQmZo/HCO3DK8oMkfhdg5rIysIkAsfRUT+5DumAxExyGpnnaujkNZVd1cuc5LaDBHH7XLe1
 2oi+4viGwO69wpzFzlGh3DxiPob5mXKSIPbpcLdqswu/jfRBLcJEhCztbvco/JZVX+FCQ1isw
 jRZPxD2Im4GbtbYV6xx4c5I/zpJTEuC0juzEn/fGusZv0cq5n7K6S9eQv4GfoaOGeY+Xna3CD
 CeyQWBMmLmOkl0FDfhn1EtsEv0oGQNZCAD5Wh5yTBpR/I=

If kzalloc() fails, an out-of-memory message is already
printed. Remove the unnecessary second warning message.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 545d6696d7cb..396344523bce 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1127,10 +1127,8 @@ static int parse_wdg(struct device *wmi_bus_dev, st=
ruct platform_device *pdev)
 			continue;

 		wblock =3D kzalloc(sizeof(*wblock), GFP_KERNEL);
-		if (!wblock) {
-			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
+		if (!wblock)
 			continue;
-		}

 		wblock->acpi_device =3D device;
 		wblock->gblock =3D gblock[i];
=2D-
2.39.2


