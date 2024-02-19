Return-Path: <linux-kernel+bounces-71223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD485A227
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED11F1F21D00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999842D60F;
	Mon, 19 Feb 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="ULTQzP3g"
Received: from egress-ip12a.ess.de.barracuda.com (egress-ip12a.ess.de.barracuda.com [18.184.203.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01982D605
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.184.203.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342748; cv=none; b=Uqq5p/gMW3BnPZ3PMZqEr8kfel747d2E7gYFP87tFrrGTthtRww5ZKRMRG3+6hhR0F0GPzuBoB3CSrj6T9HoGDNlQshgGrZF4lAZXdfT1yQglipqiPuAl0cHdUgsXszhypbEepKZ9Qmvg140d6g179j5cEr3uOH7Xia5Tpntuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342748; c=relaxed/simple;
	bh=ipv37Bhc8IqRiG2NGrgwKsYZeUsUB/RRFPRE9WT9QM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Spu3ZkQW5DuhzAJuRlyw1nKRI5Bq8OXb14L8ewT/y+HRU8ADDrcZaCZtSKkHvNLGJLrjfIhRgdYljTF0ouXDat7x4Ef+FhaVT1wszp5USOrIqHFyMF7yLNbUYMb8YindqhO6RYliS7eVRFU15nEtPaqGJnVkqVBIJ8ZS8OrVhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=ULTQzP3g; arc=none smtp.client-ip=18.184.203.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70]) by mx-outbound14-174.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 19 Feb 2024 11:39:04 +0000
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e428756f33so2445359a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1708342743; x=1708947543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxnXFmaJGn/8fcprinCvedGunPUgJSZ24CATlBY3ghE=;
        b=ULTQzP3gQW9CjHsRu5a5EwiI/fkF8aYDyJfIfmrs4vYMPLSQFGt1zXIHXaETb7vhTv
         VN1yRZtUeAzCY2Q933HH7PUgCRkZcD68F8Up+TOciA07pptoqlNcGxTyJqi7Aq+O2RA4
         orIzwlZUiI0BduLT6By8TCo0m+XkQJkZCdetk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342743; x=1708947543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxnXFmaJGn/8fcprinCvedGunPUgJSZ24CATlBY3ghE=;
        b=DoNYJBeLBoHt1XO8MmP4dl9MBRcM5WyDZP+jIXcYOhUm8MIZhnwmJahma3hjy6ifT9
         +72hkMn5D1x4FRC8biiXTxmMmVk7UJcgfpoySQocFKI+n/6CcoJwetyOUp+9yUO9zWvh
         qtNc3X2eSoG7WF98V4BNJUC5rwVwV1uRO0/AxcmUPlUQ/sRE60haOqiQ1N+dLixrw10L
         OkiVjyray5LrfALg0ADQKjdmjLb57GN/Tal1j6MOwwOn7l9guCAAMrGaKBd6GzPCCdko
         jvB56qKwzdS0FFWPx7/z9fepRBPElh3l0ZI2AOP8JQKw644BLJSchQ/IC85770+9d9HJ
         sPdg==
X-Forwarded-Encrypted: i=1; AJvYcCUXYCvDJWSofIhZPS+kgfeo04dfSM1TEYc+QSDKcJb9MZj1XxdT/2s3aw52mFqzFfcym0gVw/fLjrCGvVLIDscXd9cRYnh1iz8NJ4cT
X-Gm-Message-State: AOJu0YzDVDBogfpFnT0trvU9iMEZj9EqDugC4E+xn+fVSniJP7PKR6Y4
	E4SlPqfWR74/caXn7JsmBHGzvcPazkx9tIDD/u2C+cDjuZas2Wf5HXtsGAPlZCLzA4nMvnGQRwD
	dQPc+9iP0/A5BSsSSHbMlQ+6+gcGDTSkuyx/byteJxTxTBrO8HbNY2I2YjPHIRY3La7lCFv/28k
	mqe1dgcvLUxcigiTTVccVv
X-Received: by 2002:a17:90b:4ace:b0:299:3efe:8209 with SMTP id mh14-20020a17090b4ace00b002993efe8209mr4650238pjb.4.1708341279472;
        Mon, 19 Feb 2024 03:14:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGheUrJm7EWhHkQfPOdeAO6ZwmB2OyQFziX8lJMKLRgHHyBawm6Nw8tY/zwOjPYw/zMtcmr+g==
X-Received: by 2002:a17:90b:4ace:b0:299:3efe:8209 with SMTP id mh14-20020a17090b4ace00b002993efe8209mr4650227pjb.4.1708341279157;
        Mon, 19 Feb 2024 03:14:39 -0800 (PST)
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id cq15-20020a17090af98f00b00299947ed2efsm2343878pjb.2.2024.02.19.03.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:14:38 -0800 (PST)
From: sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-kumar1@ti.com,
	sabiya.d@mistralsolutions.com,
	Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [RESEND PATCH V2 0/2] Add CAN and OSPI support for AM69-SK platform
Date: Mon, 19 Feb 2024 16:44:20 +0530
Message-Id: <20240219111422.171315-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1708342743-303758-12432-2350-1
X-BESS-VER: 2019.1_20240214.1700
X-BESS-Apparent-Source-IP: 209.85.210.70
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIytzABMjKAYmYGhpZJZmkGRm
	ZmySmWiSaJlqbGpoZGhuaGyUZJiWZGSrWxABlVRS5AAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254323 [from 
	cloudscan21-72.eu-central-1b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND, NO_REAL_NAME, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

Hi All,

This series adds support for the below interfaces on AM69-SK platform:
-  CAN support on both MCU and MAIN domains
-  OSPI NOR flash support

v2: Changelog:
1) Removed CAN interface aliasing.
2) Updated bootph property on the leaf nodes.

Resending version 2 adding linux-arm-kernel mailing list
Link to v1: https://lore.kernel.org/lkml/20240118153524.4135901-1-sabiya.d@ti.com/
Link to v2: https://lore.kernel.org/all/1d5c0570-fa10-4b87-9833-1710f33db01f@ti.com/

Dasnavis Sabiya (2):
  arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
  arm64: dts: ti: k3-am69-sk: Add support for OSPI flash

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 162 ++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

-- 
2.34.1


