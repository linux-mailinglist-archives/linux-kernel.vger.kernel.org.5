Return-Path: <linux-kernel+bounces-72734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 368B185B825
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9536B28AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F414612E2;
	Tue, 20 Feb 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Dcw7t4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B367A11;
	Tue, 20 Feb 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422389; cv=none; b=r46+PzR4OVNj5JSmOYamGAx4ui/Q/NjAj71N5RTtArb5OosDoMp05D0Vkp0UI/+nNym7CaR6EHVFYiqz9Pao1dyrWXfMl7paWCt1NzrJ14tK36zy+EhQkBklZDkZIgSM998LHcpuu8F5xfCft/ng4j7/1e+g/T3g9S3QILwblmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422389; c=relaxed/simple;
	bh=Ns5oGXdY8TXaX6JZCp10MJ9vOoAFV3yNi3j03gOThGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiAXmYn9UTYc0JNEEeKseGd46P6qYuiPG1tXdhb0RzpIdBfBjIr5FXUrd5wF/EdRHlixM6kcW84wcvbTJ1CMywr1VWHX9lQijbjq74gt+kA8GTQND1FVP9zos8yCCaftgQfw/27uNjy7Eym5VIMcMAxisnrr4b9l7IPtZDpARZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Dcw7t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FA7C433C7;
	Tue, 20 Feb 2024 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422389;
	bh=Ns5oGXdY8TXaX6JZCp10MJ9vOoAFV3yNi3j03gOThGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1Dcw7t4kNIfM5xkQOU1U7UALwSd/pcfK2yGTigKVLaqUsV+Y21+djLFUFiOgCmFy
	 y0Jnmmk4+y+q8DI/8Lz+XV2j8X/MfA4R5f8ZASu1wu5aQbXrd/LQxHs+bIUzbeyUZh
	 JHC+o34NWlCjUZf0+QKWZGZWkEg7+CrmHORFdzCdyeR77NN69TcPYSHZF5AOsm30Kr
	 cwlBFCZIMXus1wch9pE7RsFYW+Mmvid6VLiV8dJK1Nt+2LpQIZ9GQNWZOyet1dF2Uh
	 EbyBq7BoeZPw+snyQljVeM8MFK6YkVw+iEQRBPp0/jNSZq6lV+0GW8vdcsMdNiNRSN
	 PnS0lOPXyXtTQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1rcMhm-000000031Qv-2rQk;
	Tue, 20 Feb 2024 10:46:26 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH 2/2] em28xx-dvb: fix DVB adapter device name
Date: Tue, 20 Feb 2024 10:46:02 +0100
Message-ID: <973f454413c31ba5b6464c289ee24b01465abaff.1708422122.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708422122.git.mchehab@kernel.org>
References: <cover.1708422122.git.mchehab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used for uevent, so it needs to be filled with the
device name, and not with it's parent ID.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/usb/em28xx/em28xx-dvb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-dvb.c b/drivers/media/usb/em28xx/em28xx-dvb.c
index 9fce59979e3b..759c04fbd8cf 100644
--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -980,7 +980,7 @@ static int em28xx_register_dvb(struct em28xx_dvb *dvb, struct module *module,
 
 	/* register adapter */
 	result = dvb_register_adapter(&dvb->adapter,
-				      dev_name(&dev->intf->dev), module,
+				      em28xx_boards[dev->model].name, module,
 				      device, adapter_nr);
 	if (result < 0) {
 		dev_warn(&dev->intf->dev,
-- 
2.43.0


