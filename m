Return-Path: <linux-kernel+bounces-108324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B888092E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253A51C20899
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD714291;
	Wed, 20 Mar 2024 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b="k1F/4DvN"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF113AE8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898934; cv=none; b=Nh5SXl3+kXPluM3WvGdkLI/Nl1HfVhe6xAsJ8H7crTQKfKp5LRlBHBLdUlynp1g42ni/9IBxLxRcE5UxRA711K1SEce7de+DFejGkweS7qarCj6QrnsNkvVB3oAsu8HHw+Qtzu6nIvNdskV6Oqo4px79vUNrWBdd6XBu5N0ViTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898934; c=relaxed/simple;
	bh=JJp5BjVgwceJSsUFmj642CkDTMAZWthXZgqfDWfpTHI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dQXvJDqAKHthP66seh5nAKtD8SvA2eWGa6yv3AMt2HFAFRwHogbSGgaMCJOYgGZsBSnWVctifOGY/wxnWzq/v1NEEeGWboQPv6n3dWmsgimB+ohFGIyXTe+FUXaCvwP7kkeEKEp7pQ2dzUv0NiqPIb/zLUTWWZSZH/onANuPmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com; spf=pass smtp.mailfrom=turingpi.com; dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b=k1F/4DvN; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turingpi.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c8ccffacbcso102472139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=turingpi.com; s=google; t=1710898932; x=1711503732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJzgiStFUlr1nxSqxAj64/hVS0Fow/+7dcCq3KkYmS0=;
        b=k1F/4DvNTb72BXfwjGLhVPkv/9DOklOCCJY7H+/PN9eq98k0dkzZJuiaWu3Z2cq10u
         L8euZ0KTFwY4jqRsgdWkOBYQ246oIF9IFxLReYXCBbIrqW/Mn3MCym6DGOlC9tBiAkgH
         W6oJtFGuOTYELD5hU+jJbAw9mNhMrGc+PWiAz5qKDSMq52bmJWfpbYBZLqKYklcEk3Ug
         ww+0BNXs4JvToGPK6XLuQlq8sEXoMkfU/M0q3QPuh2T8cTwB4C3FtEM7noqDTpSraF+1
         xhvkFUXbkkRSC+HAC43/udqmIihFNt9HW83yAm4/4HdNapApDcigzeKMTOSMcoLJ9dLt
         8n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710898932; x=1711503732;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJzgiStFUlr1nxSqxAj64/hVS0Fow/+7dcCq3KkYmS0=;
        b=U56FE5pyXpjO2WJNBAAAF28jY7PsPCcM59GvjobM/QosmVab+ke18kbT66kNadYpWh
         KQqDgIEIzG40Tr9qbkZz4HbVA4i5QG2OsXuxEUM+mQuzxoKzfmLWMPPwJzYGNezUYzVr
         +Szilwry6G3WAu3zvMsvBPKYD22KtBEijxKYCmKm0LxT2zlwc0J2UfCAuqjAlE8NA6HT
         ZPo9XDkCUDn5knQDUqYhREwUsW2BU5DhnW772Zt1jFWuKjtpJIxVMSduMfQBtfPuZsHS
         IRaw55TwaPPME/YscdUmsUdAU9GipoaXIKMZUJH0C9eBun4SgPh5J5WRyiPu4L1E9Nqs
         o0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQXm/z8GTGIk+HkbYujIKEWFC8GsscNCfTgh3TSJvJ4vHSiM4cmhlDz1hWfw73gtBOqzkRShtUsQVvL4T5AEyDKcFKMvMcnRqjje7H
X-Gm-Message-State: AOJu0YyC/Pld8eNpdnLnQQbNXXVlO8iwX6+tUUmpLFh+lunn1eapCFGK
	VugUYCTRIyw92JEb76lya1yrxe78u5ri6oXmtsSSRkpntnbuF50g4dFeKp1xYUk=
X-Google-Smtp-Source: AGHT+IHZ0Akvv10k6gATwoQFeaRxwKlPggp2ClvESjcX3me4odqczTr69IWhpdbBDKqUg1TmNabmWg==
X-Received: by 2002:a5d:8491:0:b0:7c8:b7ac:23b with SMTP id t17-20020a5d8491000000b007c8b7ac023bmr19469582iom.4.1710898932311;
        Tue, 19 Mar 2024 18:42:12 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:9af9:b18f:3f69:51be? ([2001:470:42c4:101:9af9:b18f:3f69:51be])
        by smtp.gmail.com with ESMTPSA id y19-20020a6bc813000000b007cc028ce258sm2632845iof.36.2024.03.19.18.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 18:42:12 -0700 (PDT)
Message-ID: <26aa2bec-8d60-4b01-a6a3-013a50d70330@turingpi.com>
Date: Tue, 19 Mar 2024 19:42:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sam Edwards <sam@turingpi.com>
Subject: [RFC PATCH 4/5] i2c: mv64xxx: Allow continuing after read
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The current FSM does not check the `send_stop` flag when completing a
read message; it just assumes any read message is always the end of the
transfer. This means subsequent messages go unprocessed, with no error
code to indicate otherwise.

Fixing this requires that the FSM check the `send_stop` flag and issue
the `SEND_RESTART` action instead of stop, but there are only two RCV_*
variants, one for receive-and-continue and one for receive-and-stop. We
could add another variant, however, the new FSM from the previous patch
makes it pretty clear that the RCV_* variants aren't really full actions
in their own respect, since they both implement the same observable
functionality as another action, just with an added read from the data
register first.

Therefore, convert the receive actions to a flag that can be set,
allowing any action to have an "...and also read" variant. The FSM can
then just use the plain SEND_RESTART action, but OR-in the flag, to
represent "read a byte, finish this message, go to the next message."

Signed-off-by: Sam Edwards <sam@turingpi.com>
---
  drivers/i2c/busses/i2c-mv64xxx.c | 47 +++++++++++---------------------
  1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c 
b/drivers/i2c/busses/i2c-mv64xxx.c
index 3ae74160001d..6a205cca603a 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -116,9 +116,9 @@ enum mv64xxx_i2c_action {
  	MV64XXX_I2C_ACTION_SEND_ADDR_1,
  	MV64XXX_I2C_ACTION_SEND_ADDR_2,
  	MV64XXX_I2C_ACTION_SEND_DATA,
-	MV64XXX_I2C_ACTION_RCV_DATA,
-	MV64XXX_I2C_ACTION_RCV_DATA_STOP,
  	MV64XXX_I2C_ACTION_SEND_STOP,
+
+	MV64XXX_I2C_ACTION_RECEIVE = 0x80,
  };
   struct mv64xxx_i2c_regs {
@@ -395,16 +395,15 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, 
u32 status)
   	case MV64XXX_I2C_STATE_READ:
  		if (drv_data->bytes_left == 0) {
-			if (prev_state == MV64XXX_I2C_STATE_READ)
-				drv_data->action = MV64XXX_I2C_ACTION_RCV_DATA_STOP;
-			else
+			if (drv_data->send_stop || drv_data->aborting) {
  				drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
-			drv_data->state = MV64XXX_I2C_STATE_IDLE;
+				drv_data->state = MV64XXX_I2C_STATE_IDLE;
+			} else {
+				drv_data->action = MV64XXX_I2C_ACTION_SEND_RESTART;
+				drv_data->state = MV64XXX_I2C_STATE_RESTART;
+			}
  		} else {
-			if (prev_state == MV64XXX_I2C_STATE_READ)
-				drv_data->action = MV64XXX_I2C_ACTION_RCV_DATA;
-			else
-				drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
+			drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
   			/*
  			 * bytes_left counts the remaining read actions to send
@@ -419,6 +418,8 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, 
u32 status)
  			if (drv_data->bytes_left == 0)
  				drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_ACK;
  		}
+		if (prev_state == MV64XXX_I2C_STATE_READ)
+			drv_data->action |= MV64XXX_I2C_ACTION_RECEIVE;
  		break;
   	case MV64XXX_I2C_STATE_WRITE:
@@ -457,6 +458,11 @@ static void mv64xxx_i2c_send_start(struct 
mv64xxx_i2c_data *drv_data)
  static void
  mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
  {
+	if (drv_data->action & MV64XXX_I2C_ACTION_RECEIVE)
+		drv_data->msg->buf[drv_data->byte_posn++] =
+			readl(drv_data->reg_base + drv_data->reg_offsets.data);
+	drv_data->action &= ~MV64XXX_I2C_ACTION_RECEIVE;
+
  	switch(drv_data->action) {
  	case MV64XXX_I2C_ACTION_SEND_RESTART:
  		/* We should only get here if we have further messages */
@@ -503,27 +509,6 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data 
*drv_data)
  			drv_data->reg_base + drv_data->reg_offsets.control);
  		break;
  -	case MV64XXX_I2C_ACTION_RCV_DATA:
-		drv_data->msg->buf[drv_data->byte_posn++] =
-			readl(drv_data->reg_base + drv_data->reg_offsets.data);
-		writel(drv_data->cntl_bits,
-			drv_data->reg_base + drv_data->reg_offsets.control);
-		break;
-
-	case MV64XXX_I2C_ACTION_RCV_DATA_STOP:
-		drv_data->msg->buf[drv_data->byte_posn++] =
-			readl(drv_data->reg_base + drv_data->reg_offsets.data);
-		if (!drv_data->atomic)
-			drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
-		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
-			drv_data->reg_base + drv_data->reg_offsets.control);
-		drv_data->block = 0;
-		if (drv_data->errata_delay)
-			udelay(5);
-
-		wake_up(&drv_data->waitq);
-		break;
-
  	case MV64XXX_I2C_ACTION_INVALID:
  	default:
  		dev_err(&drv_data->adapter.dev,
-- 
2.43.2

