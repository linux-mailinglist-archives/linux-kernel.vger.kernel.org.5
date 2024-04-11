Return-Path: <linux-kernel+bounces-140045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD68A0AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18E01F217A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1213FD6D;
	Thu, 11 Apr 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvQcY68I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB22EAE5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822294; cv=none; b=WowwNIfxvQi2edenrgqWnXX3NAn5H+JG8V5kOvlJf9DooCPXIy+4A2ok6h1iuPVVY30oxKmiiPOtzudrLWTbTfmEHDKfhwlApwXyr2dgeSVjDnbGYyyXH7IWlCQ8uOWG9kCimSDINS+Up5zbF2tES28naDuQ4d3XfF3i0fSdnPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822294; c=relaxed/simple;
	bh=joMzTyz23qmG+b+PQc5HQqQmeMqXg/U9MthFl8kkmFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kilpPtidaXWnj40scNfNSlHpw6FHW3n74h6jIlxX+tnuHL2yotg8O6+st+7PbTdxY3ul7FdwLXxYimBSL5O/zRhpp/88yMHIGXPLEbcvHlbQt+bRws8SHpoCPAU87o6+cNTCisGbwZNQDMbeMaunElKBF8E3N1fTdw/92U1v4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvQcY68I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712822291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SqVTw0UTFVtH3IwS7qkCBECw2fl92QBlfhYoyR8m1lo=;
	b=MvQcY68IYBDznjnctv9HNaoyuCH4P2v812lVkNdgiziid6342X+qOcHt4fPnhtlE/5OyqD
	FiEAUVvAqltTXOs113GUh4Llk/0Pfg3WbsU84MWQh6vsAS2mvJJ9tu6MgGgc/5WUD6/3n/
	syK2TbEtLREk+KNBbdL0Y3VPS3oK/tI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-EeGGg_l6MSWhNfXM4OyXcg-1; Thu, 11 Apr 2024 03:58:10 -0400
X-MC-Unique: EeGGg_l6MSWhNfXM4OyXcg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78e13eddaf3so124028085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712822289; x=1713427089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqVTw0UTFVtH3IwS7qkCBECw2fl92QBlfhYoyR8m1lo=;
        b=YxmzdsiNcLiSHq+EhrbjcxV1r8j2TS/LCAGpVxNxt8V1W2o8tjIrdqjEaStLERHz0/
         Q8C/PrXU9TrZvVEfGNyMRh4yjV3vso3y3KSIM2WWLggS7sV+uo1GwnGsbVTA5O+3LsGH
         pG88p+6rJ6rvghxw4zTk02X6uWUd7l0nVGFdZIDPANUhZJwS9cyIaKTtFF/W6lqlJd4K
         G+bfCIXBsb6LEviBPndMKn42nC3EEpQi+EJZ7wFkS3fWPgx3XV9K00xusNDU7bkWnP3h
         Y+QKiTMQaYbe0XsI/7HMrnEmTC9+SIV3abie7QZHgN+bY+Rc7B9dcOW3nyDIt4MqgbT4
         ruMw==
X-Forwarded-Encrypted: i=1; AJvYcCWoCT7vkkM52eo0DV1bVvJt1Wa9OF6OXYbJWoYXWVqbMPFW+tE0zPpfH/CYWafH2XWFF7Inxu+ZmEstuYE4dvwqbBIKxKEVuSRpxCKj
X-Gm-Message-State: AOJu0YyLLIi4inW+DkLIn3Nj3AKX2F6NhuENuXJst31vj+jLsabIgP3f
	OiMQpb1s8KnVG636WqusP/0Ml0IIkmmY1IgtnhG7sbeW9jGM7f1a2LpwAsKiU7YPSL0cLh6Xqtm
	fNgsgs2yiz6EcUyJl8PM2wykCuavao57HdE7IRDKdrit50xl/8J9O7Kbs/+RHwQ==
X-Received: by 2002:a05:620a:3d0:b0:78e:ba91:a4a9 with SMTP id r16-20020a05620a03d000b0078eba91a4a9mr2901286qkm.33.1712822289633;
        Thu, 11 Apr 2024 00:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvSh9y4I/IGdCNvTciq7eFbqCOuLJohMuODkTcOR2jUHxmkOOxyBUfrylL1fqN6UUVEDDAUg==
X-Received: by 2002:a05:620a:3d0:b0:78e:ba91:a4a9 with SMTP id r16-20020a05620a03d000b0078eba91a4a9mr2901266qkm.33.1712822289235;
        Thu, 11 Apr 2024 00:58:09 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id bj38-20020a05620a192600b0078d679f6efesm691961qkb.16.2024.04.11.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:58:08 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
Date: Thu, 11 Apr 2024 09:58:03 +0200
Message-ID: <20240411075803.53657-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8167bd1c8a45 ("ASoC: dt-bindings: ti,pcm1681: Convert to dtschema")
converts ti,pcm1681.txt to ti,pcm1681.yaml, but misses to adjust the file
entry in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file entry in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS after
this conversion.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5431f06ab55..d39e0f2556f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21976,7 +21976,7 @@ F:	Documentation/devicetree/bindings/sound/tas2552.txt
 F:	Documentation/devicetree/bindings/sound/tas2562.yaml
 F:	Documentation/devicetree/bindings/sound/tas2770.yaml
 F:	Documentation/devicetree/bindings/sound/tas27xx.yaml
-F:	Documentation/devicetree/bindings/sound/ti,pcm1681.txt
+F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
 F:	Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
-- 
2.44.0


