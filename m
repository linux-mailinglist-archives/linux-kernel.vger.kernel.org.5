Return-Path: <linux-kernel+bounces-120497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2A88D866
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395321F2A044
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE952D05B;
	Wed, 27 Mar 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/gTX9gB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F422C842;
	Wed, 27 Mar 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526919; cv=none; b=nyBEye+H8zL88jg2c6vR7OHbpPNsT05/QQisEhuTMjz7gLzoyZCXtnYRqN7O7Ics1qM7eKWPQMyWqPdIGbW08sjXkUojZumKhFz7z9lw3yetwBpfZ12xvgeP4TIb6dpoVbWzEVf/EvtfK4xFX6rLNcz5AbcG0K+b3NSbJxVNClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526919; c=relaxed/simple;
	bh=wl9NzEEEzFaq/cZRe1HNQXpS1Pwff+DEAEStKmncbBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TcRSssXaIZw0Rn5f1nNOZ1ejbhYCsntHluNUhFafnud6QZMwqzszMAfjEs7ViTtJvLWKMCX++FWVAb61rQ4G1sLKrK3yzP/WDeoaKQz+Hzs9/eCLXKPXgB2RALP16NY9cuqxJjf3YzbrugfBgTPTwqAsZBU7X7wivLjDtTU+ft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/gTX9gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49E1C433C7;
	Wed, 27 Mar 2024 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711526919;
	bh=wl9NzEEEzFaq/cZRe1HNQXpS1Pwff+DEAEStKmncbBI=;
	h=From:To:Cc:Subject:Date:From;
	b=P/gTX9gBC/8VmXxu3KSqfX+PhHpB049Q/pZeE9wP16jlxZ26tXioaHQX1RsZHjHKK
	 stLEoiZjNrv16LirzgwlMwfmct3y6GE62YA1uf0vTZ7wyrPT8/AVLA/dA8Pl1wg4kc
	 JndCQg6zKdU8SCKBVebptWiQTSmCzuiShVVr35sM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: naveenkrishna.chatradhi@amd.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3] platform/x86/amd/hsmp: switch to use device_add_groups()
Date: Wed, 27 Mar 2024 09:08:33 +0100
Message-ID: <2024032732-thigh-smite-f5dd@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 36
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=wl9NzEEEzFaq/cZRe1HNQXpS1Pwff+DEAEStKmncbBI=; b=owGbwMvMwCRo6H6F97bub03G02pJDGnMVxheXavkNfE4cJ9fX9rPdeaSqzap4ROC9zyQn5S6T uity9fUjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiI2U6GBf3eL3b69bs/Wfh4 Rr322/rtj9mfbGJY0GGmUvzz4dujtVq5RUdFH92+y3BTFAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

devm_device_add_groups() is being removed from the kernel, so move the
hsmp driver to use device_add_groups() instead.  The logic is identical,
when the device is removed the driver core will properly clean up and
remove the groups, and the memory used by the attribute groups will be
freed because it was created with dev_* calls, so this is functionally
identical overall.

Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3: change the changelog text to reflect that this change is identical
    to the current code.  Rebase against 6.9-rc1
v2: rebased against platform/for-next

 drivers/platform/x86/amd/hsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 1927be901108..d84ea66eecc6 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -693,7 +693,7 @@ static int hsmp_create_non_acpi_sysfs_if(struct device *dev)
 		hsmp_create_attr_list(attr_grp, dev, i);
 	}
 
-	return devm_device_add_groups(dev, hsmp_attr_grps);
+	return device_add_groups(dev, hsmp_attr_grps);
 }
 
 static int hsmp_create_acpi_sysfs_if(struct device *dev)
-- 
2.44.0


