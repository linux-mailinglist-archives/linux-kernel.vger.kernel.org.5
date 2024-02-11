Return-Path: <linux-kernel+bounces-60718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88278508DD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E911F2371D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A235A787;
	Sun, 11 Feb 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="lk/Skea2";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="xCkYaHVc"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058159178;
	Sun, 11 Feb 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650961; cv=pass; b=vA6rFr7f8A6/5ishpturveudw0b/IJEU4WfkhwlU9I/NLsNeFDhhmf6+ghkWxm83aOybLIS/tS1YXI9fK1JtQrbR1QPP29zmzVXaLB+2AHjwUYRvBAKAzS+eywyJgka17ZGuPe7xSqoS1bmyB0Bb5g7I2wfzywCt5uNVA6RIQVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650961; c=relaxed/simple;
	bh=a46TbE/hynpL7eBBgQ6hVp16oGlGrY98nmFueVCtp5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DiHgpUB5Hldh+R/F6p9ZeeB1xFVw+tV1li2ZUNM+uwQ1ByNKbOofviftcqfqLKbzt4djDJpHg6R7UI9I3iVv14axoJYwfWLkJ7W9/382UAIex1ojxnFXbAOQS2uwzMJ8FEUy7orlVzbByQ2NwHFqFP87Tvh/LVdy9CElaX0QNnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=lk/Skea2; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=xCkYaHVc; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1707650776; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CMVOGEIk50drHDsacifP9+ilY09W6SVtoclY+psFfsXC9VmRMZU5alq0xUAw4TYQrJ
    eRlX1SMmlsVB0zOY/EECH7MjZB+9JL3GR0hqcZMJ8aeYqpC4NlsD75CssoGutFGWnz+r
    MznWHUwIoVwBk3sNh9gVBOFWn4GygTdKA7wLF3OfC1F3QIM8n8vFpeGX+o6ufNof1N0f
    RVtovWLuUiFhWwpY8YwM96GZV8R+6g2W08n31iEya+xHk9iHGDtgxw3t6bVZyrRas1ya
    uFQSmHJ/3Eryhj9PEji97aIlNitJpulaH4R//CiUj0n1hhw5iVGoeESKoLfs+Ab10ZgU
    HIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707650776;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=YYORJiZMbtCUrplYD7CEsHGckfDhLB55zmu0nOiwreE=;
    b=AHvShyhzNKbR5pJ73kp+o8YuY100VBfCq2/TGlVUnMrnN6CEbFItzmkw958FsYpuwD
    k2ftLWCHQuqJvDdWsgCpQSUBJOAaXRe/ES4jb8bfhPv44XsYuZ+0DS1vcCEj0Ti681yo
    owrUh1Itc8mnUbC2GQ8kslkOk4nBssWJ4Ht8n+i5rgLZaYrOy6eFzu1jvyPODHRxhw86
    yiK99VcQWnkl5IPEiYGBQV54u1G7rMboBe5EssBFvwM5Xan03Dp/ro57hTSRatbksnYq
    Qgu9SQBLoeA3zTUQitvP/65INuScgDlSE+QHhkPQge3NoHwoyLuuvpX15PPjbv17FLay
    h9PA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707650776;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=YYORJiZMbtCUrplYD7CEsHGckfDhLB55zmu0nOiwreE=;
    b=lk/Skea2Fe88PpmmBQZ6jvEae16Juof0984NA0WgzPBbYXxhxzqYM4EJwJISixx+cl
    GNp0VKQ49PwKjAFClIj9HYTJvfkHpwLVnzf/Eq8DAPERE+35U5+7uzRwKCJ2/LFfgawm
    0ve/nf3vGSnbpvWbiAhxJWUDXLb4tM21SJXl+Ca9HOa1XdqTQhRB81tFXKtaYH8TC6ZI
    D9yQD/1mHejOUapahC/IyelU43wHort70EJ6EnJPKWXORcYOYvNfa7edQIjTyM23h/Ne
    03NIj6b73XF8C1EU+G86ugdFwTiKFywVFxnauR5izCv1BZMfx2KjVPbgBPUgIyZ0ABbH
    roqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707650776;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=YYORJiZMbtCUrplYD7CEsHGckfDhLB55zmu0nOiwreE=;
    b=xCkYaHVc0ji4XJK8kqEv6SnD4NG0rP7ri4JiohgM07RvVV8JHuSMJzay3BYSRQWRW1
    hT/hCBDiSyxrOi0QCdCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p3mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
    with ESMTPSA id ze34f101BBQFwzs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 11 Feb 2024 12:26:15 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH RESEND v3 0/2] Input: add Himax HX852x(ES) touchscreen
 driver
Date: Sun, 11 Feb 2024 12:25:49 +0100
Message-Id: <20240211-hx852x-v3-0-f682e2fcf11d@gerhold.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2uyGUC/2XPPQvCMBCA4b9SMhvJ3fUjcXLQ1UFHcejHtQ1IK
 6mUSul/NwQsiuPl8rxwsxjYWR7ELpqF49EOtu/8QJtIlG3eNSxt5WeBCklpSGU76QQnSbFRFWY
 ZEaLwnx+OazuF0FWcj5fj6SBu/r21w7N3r9AfIWxDygB9UiNIJU0JXNR1QikX+4Zd29+rbcfPE
 BnxC5JaIXpYJhrBxFmBmPxDWiEojFdIHuag/QmUa2DzC5dleQM7Zn8nGAEAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Add DT schema and driver for the Himax HX852x(ES) touch panel 
controller, with support for multi-touch and capacitive touch keys.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Unchanged resend of v3 from Tue, 24 Oct 2023:
https://lore.kernel.org/r/20231024-hx852x-v3-0-a1890d3a81e9@gerhold.net

Changes in v3:
- Fix device_property_count_u32() error handling (Jeff)
- Properly handle errors in hx852x_suspend (Jeff)
- Simplify error handling in hx852x_read_config() (Jeff)
- Close i2c_msg array with trailing comma (Jeff)
- Clean up error handling in hx852x_power_off()
- Link to v2: https://lore.kernel.org/r/20230930-hx852x-v2-0-c5821947b225@gerhold.net

Changes in v2:
- dt-bindings: Swap required:/additionalProperties: (Krzysztof)
- Use dev_err_ratelimited() for error in IRQ thread (Christophe)
- Use dev_err_probe() consistently (Christophe)
- Improve error handling of hx852x_power_off()/hx852x_stop() (Jeff)
- Add linux/of.h and linux/mod_devicetable.h include (Jeff)
- Fix %d -> %u in some format strings (Jeff)
- Fix other small comments from Jeff
- Link to v1: https://lore.kernel.org/r/20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net

---
Jonathan Albrieux (1):
      Input: add Himax HX852x(ES) touchscreen driver

Stephan Gerhold (1):
      dt-bindings: input: touchscreen: document Himax HX852x(ES)

 .../bindings/input/touchscreen/himax,hx852es.yaml  |  81 ++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/himax_hx852x.c           | 500 +++++++++++++++++++++
 5 files changed, 599 insertions(+)
---
base-commit: d03f030115fe930de1222fef294730ba21b93045
change-id: 20230816-hx852x-3490d2773322

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>


