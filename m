Return-Path: <linux-kernel+bounces-62217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E48851D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AAC28275E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502A50249;
	Mon, 12 Feb 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VifBjncT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92F4F88E;
	Mon, 12 Feb 2024 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763361; cv=none; b=BTLrYxiIeLSM36mLRI9VjB9oho4w3LdDj1hRtMRTbY2y15N10wKieFjKbRUEeIteS+Rz6m9YDiRb6eYIqnOB3kzuqi/o7+0VsnHxrq3UiQwFZKFbAvU+xM52t7nN9aSGgUYI5xtUv3DzrdqwBQiICZwDZrTdX4FwkINsZE/D0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763361; c=relaxed/simple;
	bh=irer2YtQLNsknzcYh5DTwio375EH3XNe3jCuZA+5ASY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mde/8//aL8awIYOkL23HE1xZj4gnHMzExR3wW6mnWuo8PuBs2EPEwbEAhzDfSE39UUBMIV2dGoq72ks2w3Q22oxpL6/rZY5IVmNpK0NSD7/+TaLU+py0VaXGnCz79EYoKvg3CQCftH5d9X7ZAR7zzfbaQtNADWWG9zdkBXj5srg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VifBjncT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79C1C433F1;
	Mon, 12 Feb 2024 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707763360;
	bh=irer2YtQLNsknzcYh5DTwio375EH3XNe3jCuZA+5ASY=;
	h=From:Date:Subject:To:Cc:From;
	b=VifBjncTzm/SLmDloF6KudUAhLMU3zwB/Rc/bEv4ZXXj85D3XaKXQlcAmd2r00kYd
	 KXUi+QdWYSAaviDRAozXc3iojVFFFp39oDduA3NFimDwlpR/7wlWrPcYJChs54IpT0
	 wK8NqEi8K8sag4Q4lBdvc28ywS+asdkcH3h3jSHf/Ulk6PecgeSp3gmc9toWXOAYP0
	 w6ocisprHyqF3EC/r3+Rb5CsYlWhq+iiaZrIRn6EDb4iGk9zX9yHsC1OzKbSHcqno+
	 Wkds3mofpO1WWgj4y5ULuH1D1r5X+zqFWn9h0EQOLfT0T13ntlmUumtHHY7mb55rbl
	 syMMRZaiJyM+g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 12 Feb 2024 18:42:13 +0000
Subject: [PATCH] usb: typec: tpcm: Fix issues with power being removed
 during reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-usb-fix-renegade-v1-1-22c43c88d635@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIRmymUC/x2MQQqAMAzAviI9W5idovgV8TC3qr1M6VAE2d8dH
 kNIXkiswgnG6gXlW5IcsUBTV+B3FzdGCYWBDLWGGsIrLbjKg8qRNxcYB9sH2/nVG09QslO5+H8
 5zTl/muZROmIAAAA=
To: Guenter Roeck <linux@roeck-us.net>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 =?utf-8?q?G=C3=A1bor_Stefanik?= <netrolller.3d@gmail.com>
Cc: rdbabiera@google.com, amitsd@google.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=broonie@kernel.org;
 h=from:subject:message-id; bh=irer2YtQLNsknzcYh5DTwio375EH3XNe3jCuZA+5ASY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlymadxjfOunvW5iuuvs6fLTNKMZiykKsoChOlBpq+
 W2B7YsiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcpmnQAKCRAk1otyXVSH0PXGB/
 sGjzS7y8rugetcpFH7Oub8vjhofM6VhXi+yLi4bybuapgOYCHidxWUP8CNGOVpiX+2iYIt7HuXYhGV
 RvwALySl2kR987R1PDdF/AkVhYq5KotLAkSny1djJZMywDhiy+AtFy0+ZVy1kH5kPBvON5sAsZO3qk
 rv+5UL/RhKjd23IVZghZ7GB/gDinEZphaO14t1mA9cwaPllVQKry6Jk1L9vFfSjdzhtX3Ebun1uWZn
 j+iuBsDkM5I2dYtL+w5P2maUsfCkZ5+lyzF5Umzy52Bx6RfMONkcCWo5TN7dPBC4sVc8xdOMHNcChT
 ZTDDlGjE4uW2YtMVQ/I2AouFN3+03k
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since the merge of b717dfbf73e8 ("Revert "usb: typec: tcpm: fix
cc role at port reset"") into mainline the LibreTech Renegade
Elite/Firefly has died during boot, the main symptom observed in testing
is a sudden stop in console output.  Gábor Stefanik identified in review
that the patch would cause power to be removed from devices without
batteries (like this board), observing that while the patch is correct
according to the spec this appears to be an oversight in the spec.

Given that the change makes previously working systems unusable let's
revert it, there was some discussion of identifying systems that have
alternative power and implementing the standards conforming behaviour in
only that case.

Fixes: b717dfbf73e8 ("Revert "usb: typec: tcpm: fix cc role at port reset"")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f7d7daa60c8d..a0978ed1a257 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4876,7 +4876,8 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
-		tcpm_set_cc(port, TYPEC_CC_OPEN);
+		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
+			    TYPEC_CC_RD : tcpm_rp_cc(port));
 		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
 			       PD_T_ERROR_RECOVERY);
 		break;

---
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
change-id: 20240212-usb-fix-renegade-837d35cfc0c2

Best regards,
-- 
Mark Brown <broonie@kernel.org>


