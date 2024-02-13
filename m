Return-Path: <linux-kernel+bounces-63693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE42853356
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65851F2212E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD96C4E1D2;
	Tue, 13 Feb 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="FbKgLYhf"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AA1E529
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835201; cv=none; b=YrTKDXHE+t7HZ7cMA9uIYNNRZLLK7YJDCQc/pUt0u6UFA6zvAgX7CaYSioA0lhfh0PB5XBCXT2PNinCs4ngV9q12HYuIgpEbk3gRc1Yaggs+imPbGj+Tt/GIQAH24CTj4cPqp25jtxnti6XRg7O+voLm6UlHz6oCWsf5g9Zl/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835201; c=relaxed/simple;
	bh=By8R5Yo81SvmGRAazgxdA8dka+BIIwO8Hj3OoAVL7iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EUwonFur5bgVC4ubeXGgOD3TFiNBT+DYu46fHcxtBG0Nk0WaWPDdm2zzYXPjcceJGu9ioK8pWLyk4L2JLCI4tvJslQCh98i76r8gPaHna0HogIYpXxdEuWZgsRqbhxRAFougT9k/7XarRvSRk+5OgMzvorfVRUVnN65rF3w3hZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=FbKgLYhf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3359967a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835199; x=1708439999;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPFk5u19QOItiNka/L08vE774FgQgmKj4OELxHFSgiU=;
        b=a5SFZR7zVgLG95FkSEYFiTZjnrF/2LezYNoV5Dd2ipS8jWitpPqFkcYVX804nb6lTp
         l2xYBXMJoaRmagPAmWq11OR+FimvMfjUrR6AJUMdCFPWhUxiKiP7CNHjx/+Xp9MJCw3Z
         PDuipr+WVj3rJIM6oSTdfq7SCWYXSlWUKlwL5GbXTWASb88kaiahi6bKiMrRncC3U4vB
         uCmhgBxGJ2W1OLnwYXfOMyXEiynU0knz8sgiQXEtsWViSjuHGDN659I0szSwSruSlLsu
         L0SYlGU0GRM2GR8yu9G6gIHeuXh3lOzvMMPUTpCDYx8oEespBGVCmv/qG7wvAlBQzuUa
         eaig==
X-Forwarded-Encrypted: i=1; AJvYcCV/fSDiWaRtQnl1ccVQkPisj85OouthsXkPY+Ajlr6JEydMmprfGG9116IOElHxPWskpf0OWfEIkxCS03vN4PCJku7MLIlbgH8XTS6z
X-Gm-Message-State: AOJu0YwT+sARX7iWobP48TKV0Z2Pdb9yDN6cN6+2ys91v4QKMzY6XiZG
	FQycXO5ZfVyOxZInW1vpuvCBGmQURusJVHeg9sMF2ReGlFOIuK2N
X-Google-Smtp-Source: AGHT+IHCRZaoaPugACk7Dl521flHhhqvx3GUaNO5emNBoR6fTcT2LYDmpSyHLLNJ0QNQ8GY++OZFuQ==
X-Received: by 2002:a17:90a:cf13:b0:295:d722:a420 with SMTP id h19-20020a17090acf1300b00295d722a420mr6877720pju.6.1707835198959;
        Tue, 13 Feb 2024 06:39:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2iAkRxkB8aNc6GjeuAEjVOJq/qTB5N7Ck5EVx/L45I9W4vlnhK82zF5kL6Q/HjFEHXBRXO+ToBcLIlSGQMVVMI4k9cQ46TLqxczeLvFaQ/a+Pf9ZqLgYosx2HbmaXiWcTFKj3OM216w==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ok5-20020a17090b1d4500b0029703476e9bsm2607984pjb.44.2024.02.13.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:39:58 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zPFk5u19QOItiNka/L08vE774FgQgmKj4OELxHFSgiU=;
	b=FbKgLYhf68mOpmyvH6kn6WKa6aVFFpIBTSP97GS3nGCLBqnKu72smK2I8YxR6ClfT//4rS
	1RjuuyUZlHFXHCDoOo5YJN6fXfl6DcD8f0i8iFkwKgE8QXHSdEZsm9jpyHr8u5G+fF0iaI
	z9kbuLuOc14ZEIOg93zOiictBCC/5abxowF2nTDN6YNhjVY+Pge6LxpRXCFMTEFthEEvAI
	CvcKCZWqXlZBhR2/6Y9A7BpC8QeezSFp+PF+JF5s6/NlKcI9VxRvkz07fifQg5y8eJozNU
	GXm/rSpZuex4J16AkQuyY8HdRxfTPAoz/06D9ho9cbNb4p0FE5xqvxosqEyzCA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:40:35 -0300
Subject: [PATCH] slimbus: core: make slimbus_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-slimbus-v1-1-34f06d82de6e@marliere.net>
X-B4-Tracking: v=1; b=H4sIAGJ/y2UC/x3MSwqAMAwA0atI1hZqFKVeRUT8RA3UKg0VoXh3i
 8u3mIkg5JkE2iyCp5uFT5dQ5BnM++g2UrwkA2qsNBalmoIMs6XRhUuJ5SNZEZaTIdPU64KQysv
 Tys9/7fr3/QBI14F+ZQAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=By8R5Yo81SvmGRAazgxdA8dka+BIIwO8Hj3OoAVL7iI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly39kVYKVfpnOCQ/hAmX0x+ePSNPlhKNmnr2OE
 Od9rtMT0BSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZct/ZAAKCRDJC4p8Y4ZY
 pv65D/4295SRRNKk58I65nHpvAHJryb0Po4ksZxilmB8ksI5/V9eWW67BXeSms0+TddcICx/Epk
 SXidM6Oz8XXWFSOMkiVH6Z9M56hvAc4tfWa3h7Rb5sfb4SCMjpVywm3kWQgdyb4Sg/gP6MzSuhg
 8tbWowR+wVWhFufmzmwosGxOMJ0VRkg+b2SpZXNmg0fm6H4G+WbSt/9IInrvAuGb37slg1M1pRo
 FebGVkfEddhYVKeX2bVNryECxWKfzMVHrmcSEiPdZsbqG+TQuiG0US1QQVXZbdj4W7mdYSaqObO
 jmf4tkM2LM2+slgT08gYlXD1YOzkXy8UVS6SMcd9uyk/bVctcvYMiUEVVtE192Fja3Pe6OjrEdF
 /ZCAbYbpahaiia177NnxTNgcKyx0kRssnpZItO9qdtC4/ToaZ/cOZU0S/k8lXRKaH+JoibG1vSO
 AcZOx1muU0QEOaEhYmTwUauvUg8kAwRqu71nSaHtHg6LicilIWt5nusvdHpwqP0IFDOzV67Mv01
 rVQajKjAgZrbT8kIfMyfNzqnuQXuGEiqaQyNOwj4NxFS0WZ9l7etxGZbm+PGLEzoTSsrSOvGPHE
 9QxDkx2VAI60pM+OAvzVP64rJxFrf74JVKJIFOZtRwtgIs8IBtLuhWgMQ5Tgq4DN+dFLmyMAqHw
 aagAuCC2hLz88Xg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the slimbus_bus variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
This patch is based on
https://git.kernel.org/pub/scm/linux/kernel/git/srini/slimbus.git/,
should this tree be listed under "SERIAL LOW-POWER INTER-CHIP MEDIA BUS
(SLIMbus)" in the MAINTAINERS file?
---
 drivers/slimbus/core.c  | 2 +-
 include/linux/slimbus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index d43873bb5fe6..375218e02e28 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -100,7 +100,7 @@ static int slim_device_uevent(const struct device *dev, struct kobj_uevent_env *
 	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
 }
 
-struct bus_type slimbus_bus = {
+const struct bus_type slimbus_bus = {
 	.name		= "slimbus",
 	.match		= slim_device_match,
 	.probe		= slim_device_probe,
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index 12c9719b2a55..3042385b7b40 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/mod_devicetable.h>
 
-extern struct bus_type slimbus_bus;
+extern const struct bus_type slimbus_bus;
 
 /**
  * struct slim_eaddr - Enumeration address for a SLIMbus device

---
base-commit: 04b945e4cf81a12365f8207a4d34dbc81ba17413
change-id: 20240213-bus_cleanup-slimbus-e23b9e976fd2

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


