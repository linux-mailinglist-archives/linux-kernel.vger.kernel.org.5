Return-Path: <linux-kernel+bounces-18636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC0C826057
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0B3B22B61
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B873C14E;
	Sat,  6 Jan 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU8g1GHx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17FB8475;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 331B1C433C7;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704556947;
	bh=CyU2HWnIK49IXRUVfIRsjtKjJMAK+3OujvoA9cvQ0X0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PU8g1GHxFTVl/Cns8oQEYxFY75s8den6NATRH6ym1Cp0giYTmjbhXelyV+5d+wr53
	 8AIPBtjXC5K38rVYekTEJwwJAwbd4i5qojM6C5Zz4tskqa22Z27hO91FLrZ5O+jrL2
	 QTGy0Pn0Y9TYBHFv47+pKKuy3ZUWdvFr1wgDRgrtHUMqfOtVsW0DFutGCblhUEdsj8
	 BEazUoNoLFvky7v8Cmlv28WzKfyKfk6o965ZHLdWdTjvwxMT0ftU0EGyjwHJanDd3I
	 HvwlFtNUp59TSCb0xezTN56jNdmpQBdNO5jkGGuK1dAhyREW8nHXgCdEGBDwv6+cPr
	 6BdnR2Z0eSXKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11257C46CD2;
	Sat,  6 Jan 2024 16:02:27 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Subject: [PATCH v4 0/3] w1: add UART w1 bus driver
Date: Sat, 06 Jan 2024 17:02:23 +0100
Message-Id: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI95mWUC/02OQQ6CMBBFr0K6dsiUtoCuvIdhUXGgVaCmIGgId
 7eQYFzM4iXzX97MevKWenaKZuZptL11XQB5iFhpdFcT2FtglmAikaOEicNL+wGI8jRXmiutkIX
 vp6fKvjfTpQhcedfCYDzpfS94Eg5RYh5LiSoFDuU9nmz3aIyryJ/rVtsmLl27Co3tB+c/W9koV
 u0eoX4RowCE0JHhUVwTytI/RbEsyxcXaU7A3wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704556945; l=5244;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=CyU2HWnIK49IXRUVfIRsjtKjJMAK+3OujvoA9cvQ0X0=;
 b=No9PAQgILfnalERUJguZqJLrU+U8keYvsT4A5lqggEkxW0ywVnZ5uppBvbrzQt1rTqzQS8p/J
 JESQngfn4lDAjlA/GueYT0o4V9V4zbyU4ojZ0COZrtlhX6DEgMqf1yi
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

Christoph Winklhofer (3):
  dt-bindings: w1: UART 1-Wire bus
  dt-bindings: serial: allow onewire as child node
  w1: add UART w1 bus driver

 .../devicetree/bindings/serial/serial.yaml    |   2 +-
 .../devicetree/bindings/w1/w1-uart.yaml       |  44 +++
 Documentation/w1/masters/index.rst            |   1 +
 Documentation/w1/masters/w1-uart.rst          |  53 +++
 drivers/w1/masters/Kconfig                    |  10 +
 drivers/w1/masters/Makefile                   |   1 +
 drivers/w1/masters/w1-uart.c                  | 307 ++++++++++++++++++
 7 files changed, 417 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml
 create mode 100644 Documentation/w1/masters/w1-uart.rst
 create mode 100644 drivers/w1/masters/w1-uart.c

--
2.43.0

base-commit: efc19c44aa442197ddcbb157c6ca54a56eba8c4e
---
Christoph Winklhofer (3):
      dt-bindings: w1: UART 1-Wire bus
      dt-bindings: serial: allow onewire as child node
      w1: add UART w1 bus driver

 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 Documentation/devicetree/bindings/w1/w1-uart.yaml  |  62 ++++
 Documentation/w1/masters/index.rst                 |   1 +
 Documentation/w1/masters/w1-uart.rst               |  54 +++
 drivers/w1/masters/Kconfig                         |  10 +
 drivers/w1/masters/Makefile                        |   1 +
 drivers/w1/masters/w1-uart.c                       | 398 +++++++++++++++++++++
 7 files changed, 527 insertions(+), 1 deletion(-)
---
base-commit: efc19c44aa442197ddcbb157c6ca54a56eba8c4e
change-id: 20240104-w1-uart-ee8685a15a50

Best regards,
-- 
Christoph Winklhofer <cj.winklhofer@gmail.com>


