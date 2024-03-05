Return-Path: <linux-kernel+bounces-92457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45389872069
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDD92861F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3E85C70;
	Tue,  5 Mar 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQYD7b/y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1D84A48
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645940; cv=none; b=ZIEYqU1pDccTUtgK+U3WWvjT2G9+V7sT8FlvZulmc93E+n+L7FgvWNL1FY4BBOdA4sZlbSjIa2KS/kHasdFu21H4VFtzZyL0R0Y5zliRE2fgi+uU3UYkU44+cestTE/daIpGK04jp12LhM6xVH2AzLvEwppvlzBeQK6GqoiRERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645940; c=relaxed/simple;
	bh=czHC4aaMIIxMKEnyQHGaUV95AewxoxYJJ10LZ/UYu0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKDtCDV6/dYVdMkOdtUdIq79HdsSQttwrYbnRHCNKvFWA1DspE5WTnTt1ARzpg2j/bSymfTx0vnhB06XBMCvQewUm7VTsxC9bFbnB/pDfWl79Axkgt0Vk8rDXzmil0+/XuNbze8CXSM+HetaHU35Ty2yrKtJLTvOIe87O/stpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQYD7b/y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709645937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZmDbi0/7NtmfurlLAzP54jPejCnlehzU2sr97TUoiA=;
	b=RQYD7b/ygQag5mMNyEmRcSKV5XwXfNa/H7j3S34dbim1y3WFp6kS9bu1EP2Wky+tiBb1gk
	tcX9Z479nSQD2AyKYdRm5x7/pnNq27sPgvHpi42hwcdNTw/mZh8KcrnW0nWcyobhZ+K5Wf
	MSDYo2m8SXE0/Q5l8W0OHBXFIl7Rc8o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185--FQ_U7qCNbKJQFfHXTrY0g-1; Tue, 05 Mar 2024 08:38:56 -0500
X-MC-Unique: -FQ_U7qCNbKJQFfHXTrY0g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a442979dc04so52129566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645935; x=1710250735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZmDbi0/7NtmfurlLAzP54jPejCnlehzU2sr97TUoiA=;
        b=Ya76kB2SO/jPWNBDdFkTaWZHhmp5Hy/RfFHzI1Z69wF1GeKIK2J4I8TqgYFaybsdej
         gL3p6ckjg/Ayh2r9kkvH4uWpeFnKfY5MALLsFXYgmEcXoj8lTDwyvvvt0zHpWLA+yYnb
         bie8ELGmB4iIbzYGnjGh7xz4zbRbMxAfy3ROaC8Vu4AUCghj0Z0MyNP15O4+LIDEmgx5
         NkOdGH6ZJicFz7O98lHJ3JINBOJJdWrvDfhkCAPwTiIrctKfmw1D3gqhPeAZ/WfdRz8T
         AMIzDwzLOtA+lxmnIDz36AfmA1ofrpkAp1KsIVmhsdI2tW+rZL9zmkUZ4Vwk5POwUm3r
         S5hA==
X-Gm-Message-State: AOJu0YxOaGJflM6sBMFJNwFUzURLVNAA7NcwkMYrbtCDHHEkHPLtdkQP
	PmgqhKuRbGYqTzNBTHuemBiVDg494Xm6swXJH5FN3hd2Wyqjfy+w93wJEcHt3hDiUGiqdnjzdHM
	D5nY3de8i/p8NWnYT9vCnQ9+5PWWL1PYKxd5p7HgNLTzxd4cI3DC+ulmN8koIlrgonKyM1Lvnvx
	q8uKD+B7rZm4Z2cOhbP4O4kkJ0+IJLSOlCoPw7z18sz7zq
X-Received: by 2002:a17:907:8e99:b0:a45:ac3d:c7b with SMTP id tx25-20020a1709078e9900b00a45ac3d0c7bmr392291ejc.0.1709645934852;
        Tue, 05 Mar 2024 05:38:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoA5EnVACQYWqtrKszYM26SCh3o7LzluQPz/dl1CKgBblrnDtnRwmrcAiwSzosvNxTTtA1Fg==
X-Received: by 2002:a17:907:8e99:b0:a45:ac3d:c7b with SMTP id tx25-20020a1709078e9900b00a45ac3d0c7bmr392262ejc.0.1709645934470;
        Tue, 05 Mar 2024 05:38:54 -0800 (PST)
Received: from kherbst.pingu ([77.20.15.65])
        by smtp.gmail.com with ESMTPSA id wk16-20020a170907055000b00a4532d289edsm2641326ejb.116.2024.03.05.05.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:38:54 -0800 (PST)
From: Karol Herbst <kherbst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Karol Herbst <kherbst@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pushbuf
Date: Tue,  5 Mar 2024 14:38:52 +0100
Message-ID: <20240305133853.2214268-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If VM_BIND is enabled on the client the legacy submission ioctl can't be
used, however if a client tries to do so regardless it will return an
error. In this case the clients mutex remained unlocked leading to a
deadlock inside nouveau_drm_postclose or any other nouveau ioctl call.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240304183157.1587152-1-kherbst@redhat.com
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 49c2bcbef1299..5a887d67dc0e8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -764,7 +764,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 		return -ENOMEM;
 
 	if (unlikely(nouveau_cli_uvmm(cli)))
-		return -ENOSYS;
+		return nouveau_abi16_put(abi16, -ENOSYS);
 
 	list_for_each_entry(temp, &abi16->channels, head) {
 		if (temp->chan->chid == req->channel) {
-- 
2.44.0


