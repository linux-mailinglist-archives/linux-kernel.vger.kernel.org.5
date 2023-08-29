Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02AC78CA42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjH2RI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbjH2RIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:08:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738ACD7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:07:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c1ff5b741cso7573165ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693328873; x=1693933673;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6tNh2jrop/C5GKzOfIBsmoKZX+iK/CaYp9fou2Xs6XE=;
        b=iU2QqkaYRXRLf0tzT8s1le6jWGSQ05Coj+/gbVAZ4J+xgHf5tw1G4dLthNPnU5NaY5
         cxGwYATXPkWmU6PCm9AUa97hnqbRnYJ0RFbq/Dma7+9BmZErPUuG/TVMvEXh7ECVFPc9
         1XcIWXz4ELndL/nIAxCD7rdaj7/TO5XigNAwcrFNIhQvGRI1D98QPAdqjyg8/2pjYnGB
         BH3f4cVQYgktKr15zUc+BP+DTfi3Tjfb2a1xjN5Gd/Q2uR4M4pjIqsuht3IoBMn9/CTs
         kd7M+avgPe7MGmAWlyrBnK7w63jH7EwFnTjBXS6FgPWCAHV41jl9tmymyarRDSZSSEoU
         VBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328873; x=1693933673;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tNh2jrop/C5GKzOfIBsmoKZX+iK/CaYp9fou2Xs6XE=;
        b=Ejv6TRJAmpg6hElUdD47L5R5zi6Ee0KX/Bpt+4vmgFJllUBc9D15GSmBLlg51iGnKW
         uSjZTqJnmvdffGD0BxKEacUEU8F9rxKm0RpdPdy07iinQhshU1PJ8WVDG0/efbiFYG6i
         ZZdrWG1mguZY25D5s2SfNig/s7oPlPKK1+QIAuScNsM6N02xhI1odaLjESsNKc71I63I
         bQGa3TNHHQAzP7rHoAnNRLEbT/gRopozqQnFrgW8P5zMR6iHsCqCySuAc749brT4/LHu
         K5wcYeyxXWbXrorH4DiJGHaZz2iFyHKFedl8yE6+M1mCWo3SbgIbijPQV0iCNLTTg1Hv
         eROw==
X-Gm-Message-State: AOJu0YwHpXt/2b0LdvYJF55Vccmplw1TIJbpBX6iKaulfUPQDI+tBw7s
        HLkd+WqUbhGUeP6imVIZtYQ=
X-Google-Smtp-Source: AGHT+IH9gcboZj3L3HH5W3y5Xnn553TJ1PvT6ETiyDaADG1aspu7MVP0BidaPJIFoHmyFEX8Jhispg==
X-Received: by 2002:a17:902:dacf:b0:1c0:b8fd:9c6 with SMTP id q15-20020a170902dacf00b001c0b8fd09c6mr18456383plx.42.1693328872671;
        Tue, 29 Aug 2023 10:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([103.135.102.121])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001bf11cf2e21sm9579314ply.210.2023.08.29.10.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:07:52 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: [PATCH v1] firmware: arm_scmi: Fix NULL pointer dereference in
 mailbox_clear_channel
Message-Id: <ED5DC8DB-AE81-4380-8AE5-588F370CD4B0@gmail.com>
Date:   Wed, 30 Aug 2023 01:07:47 +0800
To:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between the failure of probe and rx_callback (due to a
delayed response).

scmi_probe
scmi_acquire_protocal
do_xfer
 timeout
mailbox_chan_free
                                                    <--- delay response
                                                           rx_callback
mbox_free_channel
cinfo->transport_info =3D NULL
                                                          =
mailbox_clear_channel
                                                         dereference =
cinfo->transport_info

This patch check for it, and clear the channel at mailbox_chan_free.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/firmware/arm_scmi/mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c =
b/drivers/firmware/arm_scmi/mailbox.c
index 19246ed1f01f..32c5fe0b8c29 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -230,6 +230,7 @@ static int mailbox_chan_free(int id, void *p, void =
*data)
 		smbox->chan =3D NULL;
 		smbox->chan_receiver =3D NULL;
 		smbox->cinfo =3D NULL;
+		shmem_clear_channel(smbox->shmem);
 	}

 	return 0;
@@ -284,7 +285,8 @@ static void mailbox_clear_channel(struct =
scmi_chan_info *cinfo)
 {
 	struct scmi_mailbox *smbox =3D cinfo->transport_info;

-	shmem_clear_channel(smbox->shmem);
+	if (smbox)
+		shmem_clear_channel(smbox->shmem);
 }

 static bool
--
2.30.2=
