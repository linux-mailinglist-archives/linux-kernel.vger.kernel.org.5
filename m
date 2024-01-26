Return-Path: <linux-kernel+bounces-40290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1B83DDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39007288D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718B1DA59;
	Fri, 26 Jan 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAJq1/H2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217D1D522;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283759; cv=none; b=R5xuXxO/5bTh0I0sRaBUgGwf9BRSzJL8gMxC4SXx+L3v8NceJXYhULoA0XgcgS5hCk82SmpC/qMmU+L0Y+8fsA+un4F8Noh0egGswQ0EkllPfQkRo+8C4hcs2DTKli5sZRV2CQd0CKz3L6Fbgb8xtCBv/yqAh8LLwe3l74adRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283759; c=relaxed/simple;
	bh=Y3Z8LYJk8ojW2lKAiG+yhwYm9jBbV1csLki0ZOFKhMU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UM6OYIxjoSNOYEO6HVgIy3m5XAuEN0jDlTIyDkwXlaKCveA4lAgL3uYoIdhfAdtRLQgRkNtvRa9PbKsnrR/TtbkWoAqtt9qxz9/qeBAFLJruSjhRKOk2Fnq7f5U1Fl8DJxz28mX/zW2JyIx8kxiKYX1QU6yPauiCAq6moa/PqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAJq1/H2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA51BC433A6;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706283758;
	bh=Y3Z8LYJk8ojW2lKAiG+yhwYm9jBbV1csLki0ZOFKhMU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dAJq1/H2LfglyYCA895mP0pspSKJfqBVqPTM4GDwFZ8lW8euWLEuCc2/hX/jRTuiV
	 3f/FkRZKJMdvbAhB9rNhN9sH152hxZKGQCFIf9T3/v1iCgCBTclwEXnkDL9CnUV/Cv
	 vVXKvYuZLmaoyvwI84OPn8tjrTDIcQwaJuha8qPDer5lOafCjlHGb2h3GW++6Nwr2H
	 XukhS077gS7ztTG4Jd8BbprS1hcOLQDmvu8CPjBVTrx85qxt2ubCJtQOyccAEeKV6K
	 gA6K7jWJN82Dg1gi+TfMVRYYE0EaHDP+CWYTy+gtz8sTgZp+bvHPery5G9FZVSGPSr
	 WG/k81l3tdSwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D52C47DDF;
	Fri, 26 Jan 2024 15:42:38 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Subject: [PATCH v5 0/3] w1: add UART w1 bus driver
Date: Fri, 26 Jan 2024 16:42:02 +0100
Message-Id: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrSs2UC/02OzQ6CMBAGX8X07JLtH1RPvofxUHCRqlBTEDSEd
 7eQqBz28CU7kxlZS8FRy/abkQXqXet8E4feblhR2eZC4M5xM4FCIUcFA4enDR0QmdRoy7XVyOL
 3I1DpXovpeIq7DL6Grgpkv7zkIh6iQpMohToFDsU1GVxzu1e+pHC41Nbdk8LXs7BybefDeynr5
 az9RuhfRC8BIXZkuJO5oCxdKeaIXq259M+pyGUlcZkZa3JJa26apg/1cHhQFwEAAA==
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706283756; l=4786;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=Y3Z8LYJk8ojW2lKAiG+yhwYm9jBbV1csLki0ZOFKhMU=;
 b=R7jPweL5XSb8Z6yp5Suh+YaLtVSrdR/qZScd1ek+b7zMEqmM4CViPNz9//ExzoN4cS/V1iWGN
 p22SMvhB6kFBdh3lKRlb1aK20ei243q+aWJr1N5gDMfxQrWPaE+ys/d
X-Developer-Key: i=cj.winklhofer@gmail.com; a=ed25519;
 pk=lgjGjOt7hFKJT9UXhgUyrdthxvZ7DJ5F1U/7d9qdAsk=
X-Endpoint-Received:
 by B4 Relay for cj.winklhofer@gmail.com/20240104 with auth_id=111
X-Original-From: Christoph Winklhofer <cj.winklhofer@gmail.com>
Reply-To: <cj.winklhofer@gmail.com>

Hello!

This patch contains a driver for a 1-Wire bus over UART. The driver
utilizes the UART interface via the Serial Device Bus to create the
1-Wire timing patterns.

Changes in v5:
- dt-binding: allow child object for onewire and use prefix -bps for
  baud rate configuration.
- use type u8 for a byte, instead of unsigned char
- use constants (NSEC_PER_SEC, BITS_PER_BYTE)
- make delay computation from packet time more coherent
- Link to v4: https://lore.kernel.org/r/20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com
Thanks Jiri, Krzysztof and Rob for the review.

Changes in v4:
- rework baud-rate configuration: also check max bit-time, support higher
  baud-rates by adding a delay to complete 1-Wire cycle.
- dt-binding w1-uart: specify baud-rates for 1-Wire operations
- Link to v3: https://lore.kernel.org/r/20240105-w1-uart-v3-0-8687093b2e76@gmail.com

Changes in v3:
- improve baud-rate configuration: use specific limits for 1-Wire
  reset, touch-0 and touch-1 operation, compute in nanoseconds.
- remove unused header atomic.h
- use function instead of macro to compute bit-time from baud-rate
- switch to b4 util to publish patch: missing recipients
- Link to v2: https://lore.kernel.org/lkml/20231223100408.44056-1-cj.winklhofer@gmail.com

Changes in v2:
- add documentation for dt-binding
- allow onewire as serial child node
- support different baud-rates: The driver requests a baud-rate (9600
  for reset and 115200 for write/read) and tries to adapt the
  transmitted byte according to the actual baud-rate returned from
  serdev.
- fix locking problem for serdev-receive and w1-master reset/touch: The
  received byte is now protected with a mutex - instead of the atomic,
  which was used before due to the concurrent store and load.
- explicit error in serdev-receive: Receiving more than one byte results
  in an error, since the w1-uart driver is the only writer, it writes a
  single-byte and should receive a single byte.
- fix variable names, errno-returns, wrong define CONFIG_OF
- fix log flooding
- fix driver remove (error-path for rxtx-function)
- Link to v1: https://lore.kernel.org/all/20231217122004.42795-1-cj.winklhofer@gmail.com
Krzysztof, thank your very much for your feedback!

It was tested on a "Raspberry Pi 3 Model B+" with a DS18B20 and on a
"Variscite DART-6UL" with a DS18S20 temperature sensor.

Content:
- Patch 1: device tree binding 1-Wire
- Patch 2: allow onewire as serial child node
- Patch 3: driver and documentation

The patch was created against the w1 subsytem tree (branch w1-next):
  Link: https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git/

The checkpatch.pl script reported the following error - which I am not
sure how to fix:
  WARNING: added, moved or deleted file(s), does MAINTAINERS need
  updating?

The technical details for 1-Wire over UART are in the document:
  Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html

  In short, the UART peripheral must support full-duplex and operate in
open-drain mode. The timing patterns are generated by a specific
combination of baud-rate and transmitted byte, which corresponds to a
1-Wire read bit, write bit or reset pulse.

For instance the timing pattern for a 1-Wire reset and presence detect
uses the baud-rate 9600, i.e. 104.2 us per bit. The transmitted byte
0xf0 over UART (least significant bit first, start-bit low) sets the
reset low time for 1-Wire to 521 us. A present 1-Wire device changes the
received byte by pulling the line low, which is used by the driver to
evaluate the result of the 1-Wire operation.

Similar for a 1-Wire read bit or write bit, which uses the baud-rate
115200, i.e. 8.7 us per bit. The transmitted byte 0x00 is used for a
Write-0 operation and the byte 0xff for Read-0, Read-1 and Write-1.

Hope the driver is helpful.

Thanks,
Christoph

---
Christoph Winklhofer (3):
      dt-bindings: w1: UART 1-Wire bus
      dt-bindings: serial: allow onewire as child node
      w1: add UART w1 bus driver

 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 Documentation/devicetree/bindings/w1/w1-uart.yaml  |  60 +++
 Documentation/w1/masters/index.rst                 |   1 +
 Documentation/w1/masters/w1-uart.rst               |  54 +++
 drivers/w1/masters/Kconfig                         |  10 +
 drivers/w1/masters/Makefile                        |   1 +
 drivers/w1/masters/w1-uart.c                       | 402 +++++++++++++++++++++
 7 files changed, 529 insertions(+), 1 deletion(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240104-w1-uart-ee8685a15a50

Best regards,
-- 
Christoph Winklhofer <cj.winklhofer@gmail.com>


