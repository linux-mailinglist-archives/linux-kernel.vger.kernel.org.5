Return-Path: <linux-kernel+bounces-30322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E8831D16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E281C23065
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B128DD2;
	Thu, 18 Jan 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="K5FVaXDt"
Received: from egress-ip43a.ess.de.barracuda.com (egress-ip43a.ess.de.barracuda.com [18.185.115.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598FD24B40
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593563; cv=none; b=ex3DSwvmKsRJ4v9Nr11Jq3Ud4SWJTZyOFBHSHk6R03/SQ2VsuNhUrAswTkhApbYNaHE9dDZpb5f1AWOcjQy2Vbs98hIGp9comBpdOysn5PVHKLo6IuS1S/PtMgTbmnpNYaftjKpC/B9sZsiI6iylosfhYSahnexUn5z2aPnghpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593563; c=relaxed/simple;
	bh=+y5fUEkd5+zzoxl0HWIsvFG0uwPbNdaHmGmzGann5z0=;
	h=Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 Received:From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=Jlt8c3MAnPz4aizbPyXWVDc+/KdABHAqR9aeVUWzrqiAZsCZ+ipDswzg2LUDt5aIxIiY1Hk2KqLNCU+PBp6cWbsEs1H0iDZ0MHfQqbfkB3KFxhIOd7DJJSGz18d8lFDD7gYB+rgraLLG2eRJD4eQIVIYKC6r3UqT3lJy4PPnM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=K5FVaXDt; arc=none smtp.client-ip=18.185.115.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70]) by mx-outbound40-32.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 18 Jan 2024 15:59:18 +0000
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e0b75639deso633008a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1705593557; x=1706198357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8p6tnemlAQdnLlr6kCUPw8u4bTJQ9vaiCBP/sDK8h8=;
        b=K5FVaXDtepQr6OE5D7Fk6Q0bZTtlMVb0sSU6qZBFpV8J57QnyoMEdDQ31/TSNKuzaP
         ZcDg70FbhKQ74J1Vo1ZzOCdQn2IW9WQekaUBfyXFAYHaULUKg0teFcspvUEqS/Y+9+GV
         vWsb/p9+SdQNtOHapBaOJ4pn5MAKfuckNrTqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593557; x=1706198357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8p6tnemlAQdnLlr6kCUPw8u4bTJQ9vaiCBP/sDK8h8=;
        b=v27dYZxAktP3GkKM9r/wpv5qxrAJ6uzzdpEowfuisqNaA2Mv02I2fdlhU9fOuvv+0g
         g9UHdH9ALh5LmCJygzUDslF9SS1tePi1zEc2IG9gaBeUP4hKuHZo4hqBXxHellxUeNqX
         Gi07yD+QvQVDT0ibudFMiF1oETDDBQh0G4IKh0WmIa4u5+7t/UIy8bEPITpnIToukvEd
         t0v8++MbHyAwC4tuQLFfOHjBTaIejuSzY954jTdVg/+hp26qbVMLjMexBpgHVLugu0v+
         Ux7bGRrL0UTd1HbxwE3HKHFVjf+PzhI0TUzbAetAqeVx5XiRta6koAWXUbx7dRBECDmt
         adzg==
X-Gm-Message-State: AOJu0YyfPs4dtvUaqK3BiktUhozoWIqoEdCNzWvT8FFJcXRz7RH6ylqb
	cEZdrI7071E97JVZznuYD0Ul6jGuTYXL+JaLPrd7YuOfl8VRF64fnTm/HF5zbb77DRM9ucwrby5
	Hqawl2z97/AMsCWa2h3g5LjCRyYlC094bPR9ldsHWPEACALq+dSVkECjImSJ3hIRLe1RWTeNs8b
	mBxlVkncho/Ywn7iZ9+HPK
X-Received: by 2002:a17:903:2289:b0:1d7:ad3:6318 with SMTP id b9-20020a170903228900b001d70ad36318mr1058206plh.23.1705592152666;
        Thu, 18 Jan 2024 07:35:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMhD19NwdQ6O2/f85sTtPnPbTyrLlNxaAEf9pNnH3bnZq+ODPClOncwHC663UDceOhebj/zA==
X-Received: by 2002:a17:903:2289:b0:1d7:ad3:6318 with SMTP id b9-20020a170903228900b001d70ad36318mr1058187plh.23.1705592152360;
        Thu, 18 Jan 2024 07:35:52 -0800 (PST)
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d0ca40158dsm1535207plb.280.2024.01.18.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:35:52 -0800 (PST)
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
Subject: [PATCH 0/2] Add CAN and OSPI support for AM69-SK platform
Date: Thu, 18 Jan 2024 21:05:22 +0530
Message-Id: <20240118153524.4135901-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1705593558-310272-12403-7663-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.210.70
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMTMEMjKAYsZGRobJJkbJlk
	DSwsLCPCU1NTUtzSA11SzJwMzCxEKpNhYA43mfqkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253601 [from 
	cloudscan10-163.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, NO_REAL_NAME
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

Hi All,

This series adds support for the below interfaces on AM69-SK platform:
-  CAN support on both MCU and MAIN domains
-  OSPI NOR flash support

Dasnavis Sabiya (2):
  arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
  arm64: dts: ti: k3-am69-sk: Add support for OSPI flash

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 166 ++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

-- 
2.34.1


