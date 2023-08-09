Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE677621E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjHIOLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjHIOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:11:41 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC8B1FD2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:11:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-585ff234cd1so74849687b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1691590300; x=1692195100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34i6iKDP0xEhvs3ST3hBs6nBUaQZGtmJ6ZJ/h8b6qxc=;
        b=WFRd6SnAL0CN+fvlIQRJMgHjg7eOAgFUJbQkf1aFOyyB8PqaGS8cSqy6iQvPUGu/AC
         VubrA30/pDB/fwFxfd8VpgVLajTenIa5kyb6SyNxxvdwFhTPlzkNCp/7E0BSzqTJGwgJ
         AqRYr7E2atC98ld7b7/dPHHLLA3geGFiOjNaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691590300; x=1692195100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34i6iKDP0xEhvs3ST3hBs6nBUaQZGtmJ6ZJ/h8b6qxc=;
        b=bIUdPm262Jc5pQtsJn8ZDf43fWUrwstmKh87wEsjS6d1X8Int8XStgFjKeWB6BdZzu
         bFsqRD6fTwoklhrDaJb/+IJX2p7EzTr+/+2abij9jhwVntmugBw3V5+3qQkEhCRpNl4L
         FWFRF1G4DgIDNSKLh0jnzApoPw0Pg9p4BA8VbRYpTFfaRd5JBSFogYOuZ/JB9wEpwzIg
         MRwZ8JwFh5rAhFOJIMfSDWlSw+qBSwKhUYLaydYdMiN8zK4SZy/bKAbO600cHAVWt/i7
         TRsMYpoGnVFTYakvIGijWpO8ATQQepX6lwzGJCyBs8KPtiagCgG5HOPA7y5QCvRFucni
         XLmg==
X-Gm-Message-State: AOJu0YywhVBo+GQItiOF4hkeHuNApufqPANXka3D9Ew1DLow4McPU5oZ
        pqAJ0utiHgH9g4pAznrxgxRg/Q==
X-Google-Smtp-Source: AGHT+IHWl09PlCcDhzDmnd3MIv5OYyumiMk8BMzkfwDq8nV+RETz/pPMMQ8qOpnvCs3BuL5EA/bpJQ==
X-Received: by 2002:a0d:e587:0:b0:583:4304:75a4 with SMTP id o129-20020a0de587000000b00583430475a4mr2832236ywe.29.1691590299861;
        Wed, 09 Aug 2023 07:11:39 -0700 (PDT)
Received: from sunraycer.home ([2601:246:5d81:5e3b::100])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b00573898fb12bsm4017726ywg.82.2023.08.09.07.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:11:39 -0700 (PDT)
Received: from puyallup.home (localhost [127.0.0.1])
        by sunraycer.home (Postfix) with ESMTPA id F289A5C3722;
        Wed,  9 Aug 2023 09:11:38 -0500 (CDT)
From:   Steve Magnani <magnani@ieee.org>
To:     Quinn Tran <qutran@marvell.com>
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        linux-scsi@vger.kernel.org, "Steven J. Magnani" <magnani@ieee.org>
Subject: [PATCH] scsi: qla2xxx: Prevent firmware rejection of MBC_GET_RNID_PARAMS
Date:   Wed,  9 Aug 2023 09:10:59 -0500
Message-Id: <20230809141059.10790-1-magnani@ieee.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least some firmware (for example, QLE2692 FW 8.08.231 (d0d5)) returns
MBS_COMMAND_PARAMETER_ERROR when MBC_GET_RNID_PARAMS(RNID_TYPE_PORT_LOGIN)
is issued with a transfer length of 4 (DWords). Correct the overrun fix to
issue a "normal" transfer length and instead limit copy-out of desired
PLOGI data to the space available for it.

Fixes: b68710a8094f ("scsi: qla2xxx: Fix buffer overrun")
Signed-off-by: "Steven J. Magnani" <magnani@ieee.org>
---
--- a/drivers/scsi/qla2xxx/qla_init.c	2023-08-01 03:46:21.727114453 -0500
+++ b/drivers/scsi/qla2xxx/qla_init.c	2023-08-08 23:18:46.475286995 -0500
@@ -5549,7 +5549,8 @@ static void qla_get_login_template(scsi_
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
+	/* At least some firmware requires sz > sizeof(fc_els_csp) */
+	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {
@@ -5560,6 +5561,7 @@ static void qla_get_login_template(scsi_
 	q = (__be32 *)&ha->plogi_els_payld.fl_csp;
 
 	bp = (uint32_t *)ha->init_cb;
+	sz = min_t(u32, sizeof(struct fc_els_csp), sz);
 	cpu_to_be32_array(q, bp, sz / 4);
 	ha->flags.plogi_template_valid = 1;
 }
------------------------------------------------------------------------
 Steven J. Magnani               "I claim this network for MARS!
                                  Earthling, return my space modulator!"
 #include <standard.disclaimer>
