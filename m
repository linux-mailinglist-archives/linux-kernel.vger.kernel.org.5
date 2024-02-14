Return-Path: <linux-kernel+bounces-65879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A46F855332
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5641C2514B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164E13DB86;
	Wed, 14 Feb 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="SCw6gFnF"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74913B7A6;
	Wed, 14 Feb 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938881; cv=none; b=Dy8mBjQQZ5NAIS1WDJHi0gus4/sSuw11J41e7k76DUJMhiO28BK6nbdRYUTCfFFsmebCfHvvDdXO4hL/PUycsTmk+dMbi0TgaxRxuDxNZaTJ5FV3MwS6KNrJ20x9iBBIU8RD75We/rBHqqNYKJwK+4aF5y5ep79dOfw+LieKeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938881; c=relaxed/simple;
	bh=Xx9qKGdssRAp5mo/Ka75lHZUssh4sDREhVlfbYK5MNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+2pi/8VVvFUmpXh/L3Sv51YsXbcnwbATDHxVJjcQgVzqTc7IW3cEWb/xQHp/li8oezLT3Ve2pkniGD3tZHBr7y8d9510XX1Rvs+iECIsGgjyRicd0vm7MSipLTDlMonDJxdSKa2OIwR3nf0Id8yBkvXktpF9+pYrqB9D0zPo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=SCw6gFnF; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bba50cd318so118895b6e.0;
        Wed, 14 Feb 2024 11:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938879; x=1708543679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf14ZoO/nmlBr52xH16f4QtzbmUF7I3TiNIRIuzv/38=;
        b=rNG7Qpf12jx04P55Gmafl5wEYdLgQl7rALulAOsTUdy8eKoERrmQJZ1f23ye/zpm+G
         BIzCCnepF11LSdrNtrBY1KusCJuSHxUYqntmLNqsg8Q0DJOh/wmlPkzy+Sbf/BO6wa0+
         YyB1KH+mffWImqqXNmI12w52bTKJnAePvxMWfxkj1sV2rt3aiayTy6R9SRHXIYVUkZTR
         8j2pkU5HT7+dYrDH+DZFTlPdus1q5LJfXLFtfhe/YVLTFKBhQsVWcq+maSDR+09QdOam
         iIFWiTa7gfkfbq1KGXY9v2Sl4ku85Wiw0LOuJuzGmuu+HsOGNV9ZYT4T5ej7sbkoTacp
         lCnA==
X-Forwarded-Encrypted: i=1; AJvYcCWzDSgkyrp3Bc6Oeh4ocJ4zzO+io8gcr6ThEsk/Juf+EdoMj9PPUm4V4GaZETFd1XH4xL4eQnVZ6xK0HAypWVy+i7c3ORnEHpVC+Ztq6LEyKOkWz2AbCtwetvx9iYB9JFgTt3o5NmVx8pk=
X-Gm-Message-State: AOJu0YxIgXCfCbKPhtI0l1MTMsTBId8GFZCUPcIHeGyyxhRPZAOoHtLB
	0RrnxYh27ij3HrhnSpE1uObN5Vjhtr3a9xKZ8zY4JicfrmJ37J6T
X-Google-Smtp-Source: AGHT+IEAYhq6gDI+wfjGNpVE+rgP71R6IJWQwTaB4Pvado9bg6PRnPO8hd9fVaRstKBYiI5d1bhUkw==
X-Received: by 2002:a05:6358:7e94:b0:176:5a5e:4b7c with SMTP id o20-20020a0563587e9400b001765a5e4b7cmr4334094rwn.6.1707938878920;
        Wed, 14 Feb 2024 11:27:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVR9u5eZkHuCGi5ouHd+f0g8NQQ4YHOm8cA1VMP51BbkhHt1JThb7MruHfBbp2jOqzY3XMlD5Np4SblYOAzR1eT/GlxGl27xiJBxkJ3DXV7BdB+CZa9jHyphsomO0b9enJZlVrQB3f0xpjnnXghR2Vfe+GzaoSW4vh6zSdbvGe80sbDUcgvZZKawa5fhWNiYy72gTdl+n7QfMmLZ9pxqjoXacya+Fk3ttY/sEZbWcGPZKtooyKgE0Go0IaZm/nsILUBsA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m20-20020a637d54000000b005dc4b562f6csm4610547pgn.3.2024.02.14.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:27:58 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707938877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jf14ZoO/nmlBr52xH16f4QtzbmUF7I3TiNIRIuzv/38=;
	b=SCw6gFnFMVEuGi9m9kdpWg/G/byrUWhUoaJNVFytbqm08dkL3TNLUCrp5yeU4nk3kH6IKG
	Q2ajsm7fuEGflTqeD6hhPkKqh7otTX5jGTxYS07WwodUuT+emH9TWpwYHF5qqNXYscGk9I
	KFebSrYePXpv5MtXEMJgTv46KBz5NV7GSQpxE4aimnaIwfeCfvA9KAsLL52o9ZwRa2sply
	7FiOY/ZOkr/c2XDxShAFyyXxuEOw51xdbA9jaK3r1H7Eit5zCVM/BBfUi3bsGjsHE0/FPt
	pmidWrok5yRwV2yjYdL2zs+NncOuDqxvjBwlYfRXrkrrsw7lnF82t/zcRv9JCg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Wed, 14 Feb 2024 16:28:28 -0300
Subject: [PATCH 1/2] ALSA: aoa: make soundbus_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-bus_cleanup-alsa-v1-1-8fedbb4afa94@marliere.net>
References: <20240214-bus_cleanup-alsa-v1-0-8fedbb4afa94@marliere.net>
In-Reply-To: <20240214-bus_cleanup-alsa-v1-0-8fedbb4afa94@marliere.net>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Xx9qKGdssRAp5mo/Ka75lHZUssh4sDREhVlfbYK5MNo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlzRRg2+8TMjUIfbvPUXenySoAjgJXgm7QBin3p
 RuofTG2WeqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZc0UYAAKCRDJC4p8Y4ZY
 piFQD/9ZfnDZxcp/IDe9X1ChNa7pjG9eIbYI5mUhOc0Zc6KRmLJ9g7A4IYS+kCOLoFsvVlBkE7t
 6iVQCjTvPi84Kn1tqqV7xnD1SqT3wHWIcLgsTmnYzAZm84HBMeawypWsRFlPgKtosS2aF0TEUz5
 9T+aA3whcNkEru0JDutdtJ9OVwSC0FjnzTbu7xn7UT6yEk52bo9wXKP8P9jpHfABQMwpjHHxr7e
 5bePOHNZ60MbjJZjbLYWANuprwfb77QuFkz+707XTvT00f2dj/WU9/kio0JCXwHge5ByskhQnuy
 NubuAsnmWCzutX4VZFIQoik2lTr5uGIjGFKIfS5NDmgFh7bN1hnyHqUoyo6yoDW/NwkB04lu7p2
 BIB1/EVZSLaj7YXXEoJ+UGEsjahRsI9s1Pz5AqL4JpHX/9JxVQkjUMDlp40MecUDkQA8iG/8oHc
 C/LXnxkomcncgrlQ67GVWTpjOG7v2V2QbYQIA+sz/RriOA6Gn65JZ2CXGLRM36xkK2co36/vZ1Y
 i2lzXIiLtC17GZPcaVd7pxBPwNI4jeNKcRdZ5oReR49HGo/Urq/HI1hHn5mUojaQTnYlrO5NKQA
 0EyWfXjPdN5BVaHaHip4HeiZoP+6CyDDy1L2AGTH4qS+cFaVVh7DS1Cnfv2u4FOYCpXW0W8EXn+
 0h2JDPc+V71skoQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the soundbus_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 sound/aoa/soundbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index 8f24a3eea16b..2a295f610594 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -127,7 +127,7 @@ static void soundbus_device_shutdown(struct device *dev)
 
 /* soundbus_dev_attrs is declared in sysfs.c */
 ATTRIBUTE_GROUPS(soundbus_dev);
-static struct bus_type soundbus_bus_type = {
+static const struct bus_type soundbus_bus_type = {
 	.name		= "aoa-soundbus",
 	.probe		= soundbus_probe,
 	.uevent		= soundbus_uevent,

-- 
2.43.0


