Return-Path: <linux-kernel+bounces-64792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813598542EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61701C20D52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F4125AF;
	Wed, 14 Feb 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV7XWZGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6310A36;
	Wed, 14 Feb 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892584; cv=none; b=WUULtdto2OwOC90rTzjjcflFdP7nQAVZq0iGPCnt+vDfRQXTnU+7JFR8OlpntXevD62aaronM25Dno/KqfJbHBfNPAPHUm3foDHHdgIz7dhsNGWhkBIyCzV5Mnl/3jWLzZepUA2fk+Ma8fXLq9qV4Zl1C5eTXqN2sEvHX1FgdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892584; c=relaxed/simple;
	bh=WpkvpKeOfNBGl3s6SIPd42Jru7SBxmJQ0eeopGKSBh0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=su+PzvbOm9M+m2TwYB6K95K7+zcYnHDiWj7oS/HAEv2Bwmll/R0KiHGYumHMoSVnWewPxQSJQX65GYsOS3CVx+M3fpsnY9gfwNcvSQ9WDLLWTRfwCkyEYJVskfVcNykN1+U5uh6XkhFYS339TDrwPVcYkxo42CLDvnUh5jQ6AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV7XWZGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF834C433F1;
	Wed, 14 Feb 2024 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707892583;
	bh=WpkvpKeOfNBGl3s6SIPd42Jru7SBxmJQ0eeopGKSBh0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eV7XWZGgcsCBWCzbwnWFvwhtnkFdx9lheIXn+t6XALWjWJ/cuAq8dcWZcnBsvWx7r
	 +9sO0OoBQL3KVHuEM6pckQjRbkrdKjj6ofZ3t7FNO2bqZn1aZR+XMsl19E0HALUvuN
	 ZNECPLVkUvzxAFRKl68feMOv94jvnRf+tveOLBEhgOBKGTOBzxTPt9QXntvBMTALaU
	 A5LHbv9HFPrl/8cNhn2VwlXvNT7ObWCjVk81qHPfw1rykH9RUcX3kIWqOcsGfYN+5u
	 fHey70CLrw0ZZwiRngcaKTMxOBcjtwbxKTjypmxjZAfhVrl0ZM5T/VM/Wty7UL8QMi
	 qHEgAMykJ/P/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E91C4829A;
	Wed, 14 Feb 2024 06:36:23 +0000 (UTC)
From: Christoph Winklhofer via B4 Relay
 <devnull+cj.winklhofer.gmail.com@kernel.org>
Subject: [PATCH v7 0/3] w1: add UART w1 bus driver
Date: Wed, 14 Feb 2024 07:36:12 +0100
Message-Id: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1fzGUC/13OTW6DMBCG4atEXtdo/G+66j2qLIwZB7cBV4aQV
 hF3r4mUQrPwYiQ/n94bGTFHHMnr4UYyznGMaSiHeTkQ37nhhDS25SYcuAQGkl4Zvbg8UUSrrXJ
 MOQWk/P7KGOL3fen9WO6QU0+nLqN7eMF4eQASbCUlKE0Z9R/VNQ6f5y4FzG+n3sVz5VO/DnZxn
 FL+uZfNYp19RKi/iFlQoKXDQC0ajkbvJtaIWe6d3pwszgRkwlhnG4HPTu0c3zlVHGstb0LrucP
 62enNcag3p4sTaJTwTNas/te5LMsvFCMkVIcBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707892581; l=5348;
 i=cj.winklhofer@gmail.com; s=20240104; h=from:subject:message-id;
 bh=WpkvpKeOfNBGl3s6SIPd42Jru7SBxmJQ0eeopGKSBh0=;
 b=/uU0jMlHsz8KXluEL7g+eEFniKD6PeJMvlDOYz0JZZVc1Om2voISol0iky4T3FOmNFvn6HalV
 VQFyi3MZIGDANmui+wyhL1sWAAH685itWvlVFU3U2fMWRLS6hN9Unh8
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

Changes in v7:
- rename mutex to rx_mutex and comment its usage
- fix comments and use kerneldoc for internal structs
- Link to v6: https://lore.kernel.org/r/20240209-w1-uart-v6-0-3e753c149196@gmail.com
Thanks Krzysztof for the review.

Changes in v6:
- change order of patches for dt-binding
- remove unnecessary lock in remove
- delay for 1-Wire cycle without mutex lock 
- fix comment style and add some more comments
- Link to v5: https://lore.kernel.org/r/20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com
Thanks Krzysztof and Rob for the review.

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
      dt-bindings: serial: allow onewire as child node
      dt-bindings: w1: UART 1-Wire bus
      w1: add UART w1 bus driver

 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 Documentation/devicetree/bindings/w1/w1-uart.yaml  |  60 +++
 Documentation/w1/masters/index.rst                 |   1 +
 Documentation/w1/masters/w1-uart.rst               |  54 +++
 drivers/w1/masters/Kconfig                         |  10 +
 drivers/w1/masters/Makefile                        |   1 +
 drivers/w1/masters/w1-uart.c                       | 415 +++++++++++++++++++++
 7 files changed, 542 insertions(+), 1 deletion(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240104-w1-uart-ee8685a15a50

Best regards,
-- 
Christoph Winklhofer <cj.winklhofer@gmail.com>


