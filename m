Return-Path: <linux-kernel+bounces-91101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCA8709A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCEC1C2035A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0D78697;
	Mon,  4 Mar 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml0T9nOZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911F78698
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577152; cv=none; b=p2Xr5uPxeKOwOZ9S7f6g2IVMKgZNdmIKa2Am7/s4c5fytVd0M2k7z1TNruT/iS6A4wLECUZUzFi2MMKfRZNmZnokqjKrn1RLJaVKhR7ta+lVWQ3uuLI+dwSUd/bpJu9PooKGN6HSQ2oSCTg6ITJHsUCfxTib0YGIzKW9wKj8ikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577152; c=relaxed/simple;
	bh=RSfRBROODAREyjTxFM0bUdxGWsN6Z7kxsq68XS2kao8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUd90r5SNkSZdWDKWC0yrEFNcSsNpHZ2WmEXFVs3uAwGF8T+8B5CN9vLHJIzk0L6LUbHbQ4ble9Y2WGgNYfGI6caIdA6U8Tf19X2dN734/Qj6KpOO9AofowQSVQ+SmUUJS4Fs3P3rCmmTE8rH2OA7Tr7GjN78M7ES3o5YiodphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ml0T9nOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709577149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F9gPWxAqIxccC8AlqeFUtelqmyaQBlXMXZSupr7dlUM=;
	b=Ml0T9nOZaVdbXmn+68Woig4jyAoKcau/m7nWlVZW3WJJBxP/C5elKFEnGKAVe1SbJ4CSdq
	kfrN4afQuGddI/OxA3pRS91j/4uakQHXkp0K6K7QIzz7YGVsnPJB4pJ7d4yG4BlExlMkx3
	lv84NuToodfWnxwW547LCBdep12/PG8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-62Ff1_eUOaOtl_cqk-CcJQ-1; Mon, 04 Mar 2024 13:32:28 -0500
X-MC-Unique: 62Ff1_eUOaOtl_cqk-CcJQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a453e6b3021so18438666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577146; x=1710181946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9gPWxAqIxccC8AlqeFUtelqmyaQBlXMXZSupr7dlUM=;
        b=Eh0d3GrT7AQAAqYyS0pFuCSQjDaMjKWgJaxkXPQHsvlX6bbsHIN8DbRtuYhVfZJ4AM
         NflSIqVnrY6Zn7i/+Q/RsVYjpGgmFlz+OYdJykL9fpxwgvITsZ/XWLGIIKKW3gLhYl52
         DwCJZoKRfeWxoUGe1vBIdJwFkE9eM8hm35x///YASnoB/YA7PIrexop3qUpl0+6nB12E
         //kzZuXDsX3kwD0a5Z7ShdxWnSeGCwFySs++KaEDD+7jIiarRsNHEFdlfp3y7oHWz/MH
         6Le8G7ZFO0DRoje7OfRtCoVvwBY5Aag8fccFtuLV/lsDGnDhDt2PrSZVyjX5iOHkPTaL
         q7Fw==
X-Gm-Message-State: AOJu0Yzc7dmhj5sQWZTSvbM50BgtbpgDQjPiYFyMx8Ly1BQtTT5ww00u
	BgIE/c/b/y6JYUunKygRIF/IibwMmwYm2JESMHYS/rgNUnWf7E3Z/Lrsg4JDYFWgEFPnYjHn0x/
	Ao5fbwo/AJGC6GRbVb3mNOkv3PKY2oVzMicf1OyboCXBZPannn5k1j8oxurvoGZ9CmPSlrkadFY
	JVj0aHE0yWvLfUIoP0KOfm7PoIEJUj4t1qDuuWKNp5/7y6
X-Received: by 2002:a17:907:c787:b0:a3e:ac92:b952 with SMTP id tz7-20020a170907c78700b00a3eac92b952mr9568237ejc.5.1709577146254;
        Mon, 04 Mar 2024 10:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsGCx4zG6do4zNtrBRrVyEOICLWH37Q9tXC93/H5tH8Kv6remnyfRjukUyyIlLyM94N97akA==
X-Received: by 2002:a17:907:c787:b0:a3e:ac92:b952 with SMTP id tz7-20020a170907c78700b00a3eac92b952mr9568214ejc.5.1709577145825;
        Mon, 04 Mar 2024 10:32:25 -0800 (PST)
Received: from kherbst.pingu ([77.20.15.65])
        by smtp.gmail.com with ESMTPSA id me25-20020a170906aed900b00a44efa48c24sm2705672ejb.117.2024.03.04.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:32:25 -0800 (PST)
From: Karol Herbst <kherbst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 1/2] drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pushbuf
Date: Mon,  4 Mar 2024 19:31:56 +0100
Message-ID: <20240304183157.1587152-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.43.2
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
Signed-off-by: Karol Herbst <kherbst@redhat.com>
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
2.43.2


