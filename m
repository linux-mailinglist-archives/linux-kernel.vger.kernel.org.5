Return-Path: <linux-kernel+bounces-24760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E682C1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9651F25209
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF36DD09;
	Fri, 12 Jan 2024 14:36:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757A56B9F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIeB-0006a0-GR; Fri, 12 Jan 2024 15:36:35 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIeA-002Ak0-U7; Fri, 12 Jan 2024 15:36:34 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rOIeA-00CzmU-2g;
	Fri, 12 Jan 2024 15:36:34 +0100
Date: Fri, 12 Jan 2024 15:36:34 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, mkl@pengutronix.de,
	netdev@vger.kernel.org, robin@protonic.nl, socketcan@hartkopp.net
Subject: [ANNOUNCEMENT] Open ISOBUS File Server (FS) and Client Implementation
Message-ID: <ZaFOckVIRwmkwkoK@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello everyone,

I'm pleased to announce the initial release of the Open ISOBUS File
Server (FS) and Client Implementation. This project partially implements
the ISO 11783-13 standard and uniquely utilizes the CAN_J1939 kernel
socket for its operations. While it's not yet fully compliant with the
standard, it supports essential functionalities for basic tasks.

You can find the code and contribute to its development here:
https://github.com/linux-can/can-utils/pull/487).

For those interested in experimenting with this implementation, here's a
quick guide to get you started:

ip link add type vcan
ip l s dev vcan0 up
j1939acd -r 64-95 -c /tmp/1122334455667788.jacd 1122334455667788 vcan0 &
j1939acd -r 96-127 -c /tmp/1122334455667789.jacd 1122334455667789 vcan0 &
sleep 1
isobusfs-srv -i vcan0 -n 1122334455667788 -v vol1:/path/to/export/
isobusfs-cli -i vcan0 -n 0x1122334455667789 -m 0x1122334455667788 -I

The current implementation allows you to:
- Connect to the server
- Change and list directories
- Download files

Interactive mode supports these commands:
- `exit` / `quit`: Exit interactive mode
- `help`: Show help message
- `dmesg`: Show log buffer
- `selftest`: Run selftest
- `ls`: List directory
- `ll`: List directory with long listing format
- `cd`: Change directory
- `pwd`: Print name of current/working directory
- `get`: Get file

We welcome everyone to test this new interface and share your feedback.

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

