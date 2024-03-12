Return-Path: <linux-kernel+bounces-99723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F3878C40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618D01C210E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB578186A;
	Tue, 12 Mar 2024 01:28:38 +0000 (UTC)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B77E6;
	Tue, 12 Mar 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206918; cv=none; b=XMehRS8yvr2AVlalUTIuKnWTFG+5ZaYThz8omDKJU/fFcIHAbvzNFOs4BnZYfpYMtUrYwPbpwZEEJX8/biO+lGN1Ji/MBhqP/6Zfxv2w4lhZ3+XzdG379Gi4bWnBKdBqydrVFRJxZ3BNcSHfGzLU485+TnZltvymm6PLZeJSqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206918; c=relaxed/simple;
	bh=ZOW09UAyi19w6YXLQJO4RsJctfi8bD03FHleAH9bN6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6ri9oRs015VOv+YORCzGPI296sWMshycJUgXtvq0kLv7MNTxt7G79qkkTs27ae1i9etRivBGNblWhVp/jAopjIwK/d1WpMKKEjxJumbg7NGPRGYz1BAdqKE5yiyLh6xHlr8QsmE9qMISC/F/K37DB9JFR3vgjEFPcAq7cnTaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.257409|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0556319-0.00218893-0.942179;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.WkSydQt_1710205966;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.WkSydQt_1710205966)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 09:12:47 +0800
From: Michael Wu <michael@allwinnertech.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux@roeck-us.net,
	badhri@google.com,
	kyletso@google.com,
	frank.wang@rock-chips.com,
	rdbabiera@google.com,
	xu.yang_2@nxp.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: tcpm: support sink port for debounce
Date: Tue, 12 Mar 2024 09:13:00 +0800
Message-Id: <20240312011300.75081-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both CC1 and CC2 pins are simultaneously pulled up, it often leads
to the double Rp to Vbus cable being stuck in the SNK_ATTACH_WAIT state.
And the state machine fails to transition to the SNK_ATTACHED state.

Therefore, it is recommended to focus on transitioning the sink port to
the SNK_DEBOUNCED state instead. By doing so, the desired outcome can be
achieved more effectively.

[  134.525750] VBUS on
[  134.713240] CC1: 0 -> 3, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[  134.713249] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0965972310275..9228dbd78bf2b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4197,6 +4197,8 @@ static void run_state_machine(struct tcpm_port *port)
 		else if (tcpm_port_is_disconnected(port))
 			tcpm_set_state(port, SNK_UNATTACHED,
 				       PD_T_PD_DEBOUNCE);
+		else if (tcpm_port_is_sink(port))
+			tcpm_set_state(port, SNK_DEBOUNCED, 0);
 		break;
 	case SNK_DEBOUNCED:
 		if (tcpm_port_is_disconnected(port))
-- 
2.29.0


