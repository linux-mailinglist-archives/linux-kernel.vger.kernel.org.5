Return-Path: <linux-kernel+bounces-49315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC2846898
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A841C231DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6821772F;
	Fri,  2 Feb 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g08hhqq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155617567;
	Fri,  2 Feb 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856972; cv=none; b=XHBwgRe/Lrrm87zIpiZ58WNfHc1d5/FT39MQsZxvQgYmDqmXwboyfWPJ7hsWuiv+Gqb7SoZJ7thlEgbRnh0qSvWRuuDNAwYPIfOnMPFQ8sNhnBJKdcWmfhaJdM0kl8EZefZZYHGyuSabA2HqOx3Q6pWTDk35/Hm0k7QR5RVpU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856972; c=relaxed/simple;
	bh=Tb+Xie0eU0KycmdJdnMo1LjLbaYJ6rW5HUuzFiLn2OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myUxtT+pcsBd8rqwixudlUVO/bShWJ9hYJT9z3waqzzu85BUdzmMBoDRajFbx7vXvC7uM5Ev7EEdyuomLAAXKDdSiJ0gjphk4ExHamrstXKQh6uqgQx2Qs6gsgy8KIpjdhCvR6Gjm1g3crkMp3JhTxgiEYAejeGTbfT85T1Q/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g08hhqq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4954C433F1;
	Fri,  2 Feb 2024 06:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856972;
	bh=Tb+Xie0eU0KycmdJdnMo1LjLbaYJ6rW5HUuzFiLn2OI=;
	h=From:To:Cc:Subject:Date:From;
	b=g08hhqq6f2FrBtz4ISWyaneEHHAoNRuc4zvRWe6oKq1sK+E5Uv7ejYEPhDdNu0KxW
	 06EdzH4guN1+IyjkjCelYQGA44a9N+9w4r0Tvwz5W5U2azbPx37NCClA4lRUOOOM2E
	 Uj7nMsl0673VFr2+K0IOxvQPejNYDnUoar2PlOcAM18J2wXNlCYUR4sMUbyVhQ8QKn
	 MfA6mEscHlQ05r2ig3Zu9lJNxWFYk2v3S5G5cPDPWQ5ZAJpvlZeU4R67nCkmL30Bnw
	 1E4Ph8Ciw7Nn0/e6OtBBLhKK5T/LO03Y9G7SHxE58c6znYD2dvAyYLC//VvjnZ+qdD
	 K34HjSx0NajhQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/22] tty: vt: cleanup ESC sequences handling
Date: Fri,  2 Feb 2024 07:55:46 +0100
Message-ID: <20240202065608.14019-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a promised followup of "tty: vt: cleanup and documentation" [1].

The escape sequences parser is cleaned up, so that it is easier to
follow.

Most of the patches are easier to review with '-w -b' passed to git diff
(as the code is moved to separate functions with a different level of
indentation only).

[1] https://lore.kernel.org/all/20240122110401.7289-28-jirislaby@kernel.org/T/

Jiri Slaby (SUSE) (22):
  tty: vt: make rgb_from_256() slighly more comprehensible
  tty: vt: define enums for CSI+h/l codes
  tty: vt: rename set_mode() to csi_hl()
  tty: vt: split DEC CSI+h/l handling into csi_DEC_hl()
  tty: vt: remove unneeded assignment of EPecma to vc_priv
  tty: vt: move CSI+n handling along to other ECMA CSIs
  tty: vt: define an enum for CSI+] codes
  tty: vt: rename setterm_command() to csi_RSB()
  tty: vt: put cases on separate lines
  tty: vt: accept u8 in do_con_trol() and vc_setGx()
  tty: vt: extract ascii handling to handle_ascii()
  tty: vt: separate ESesc state handling into handle_esc()
  tty: vt: move CSI DEC handling to a separate function
  tty: vt: move CSI ECMA handling to a separate function
  tty: vt: name, reflow and document enum vc_ctl_state
  tty: vt: simplify ansi_control_string()
  tty: vt: handle CSI+[ inside preexisting switch-case
  tty: vt: add new helper for reseting vc parameters
  tty: vt: use switch+case in the ESnonstd case
  tty: vt: use switch+case in the ESgetpars case
  tty: vt: use ASCII enum constants in vt_console_print()
  tty: vt: decrypt magic constants in vc_is_control()

 drivers/tty/vt/vt.c | 876 ++++++++++++++++++++++++++------------------
 1 file changed, 514 insertions(+), 362 deletions(-)

-- 
2.43.0


