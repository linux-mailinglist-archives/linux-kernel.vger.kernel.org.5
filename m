Return-Path: <linux-kernel+bounces-17601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0E825004
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1258DB218ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE6A24B52;
	Fri,  5 Jan 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD+vhHPI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE721A14;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BC9BC433C7;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704443225;
	bh=J9zv5oHyamS5PRZOF0tXtJ/G7Rms0rZ2TZXyj5Hx/qE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oD+vhHPIbjP4Sa/kR7JKxNwNQhKwb2UFwmxFl+fFiIkk3e3oYQkv9M4cH5gEgjpCt
	 rhwK3FCVUTelq7NY7Q9qG2VAbf9VVfvNKmOtRJuQjZVSeb4XKk1dns5FEKCKU5afAV
	 8RDx7skUc5KEYp7R8GIKxXLfQK2ttP/lAGQMZDEGLS9UaJg8zFFOjQsj5On1h/tUta
	 Eh1w/Os1XI1udn/y2X6ObQmhQ3LE01nBLQWSRKu4zOSaQNQ2/lGXYl/o0160ITnVos
	 dHoP+hVaUb950FrEjyDvB7oDEf9lJACL/i+myBEvtAOC+dacFBacvjf+Y4YIPH01pr
	 xYhhRxniqgviw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE4C47079;
	Fri,  5 Jan 2024 08:27:05 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] w1: add UART w1 bus driver
Date: Fri, 05 Jan 2024 09:26:41 +0100
Message-Id: <20240105-w1-uart-v3-0-8687093b2e76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEG9l2UC/zXMwQqDMBAE0F+RPXdlo4lIT/2P0kOwG93WGFltL
 Yj/3lDoYQ4PZmaHhVV4gXOxg/JbFklTRn0qoBv81DPKPRsqqiwZsrgZfHldkbltWueN844gt2f
 lIJ/f0/WWHTRFXAdl/9/XpsohstSW1pJr0GD3KDeZnuOQAuulj17GsksRjuML1wHc95oAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704443222; l=4768;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=J9zv5oHyamS5PRZOF0tXtJ/G7Rms0rZ2TZXyj5Hx/qE=;
 b=oJYrb7YMqdI2yRcQld2Z45q1j8586OsLVG+BXbM26rhykV4fUMLxosVq7IokqvcjqsXcuHS86
 CVS8+U07jxRAG2ripWJ0TPXClw2P21/7f4Mr2RHk/tutkWjmzjI5IuT
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

Changes in v3:

- improve baud-rate configuration: use specific limits for 1-Wire
  reset, touch-0 and touch-1 operation, compute in nanoseconds.
- remove unused header atomic.h
- use function instead of macro to compute bit-time from baud-rate
- switch to b4 util to publish patch: missing recipients

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
 Documentation/devicetree/bindings/w1/w1-uart.yaml  |  44 +++
 Documentation/w1/masters/index.rst                 |   1 +
 Documentation/w1/masters/w1-uart.rst               |  54 ++++
 drivers/w1/masters/Kconfig                         |  10 +
 drivers/w1/masters/Makefile                        |   1 +
 drivers/w1/masters/w1-uart.c                       | 350 +++++++++++++++++++++
 7 files changed, 461 insertions(+), 1 deletion(-)
---
base-commit: efc19c44aa442197ddcbb157c6ca54a56eba8c4e
change-id: 20240104-w1-uart-ee8685a15a50

Best regards,
-- 
Christoph Winklhofer <cj.winklhofer@gmail.com>


