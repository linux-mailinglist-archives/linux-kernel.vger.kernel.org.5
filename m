Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23117A8C53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjITTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjITTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F7E8;
        Wed, 20 Sep 2023 12:11:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c008042211so2178041fa.2;
        Wed, 20 Sep 2023 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237089; x=1695841889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUQlNWBQLKx5ke9/fjvP01zDeVt7MOvvAIgh8fT+a2g=;
        b=E5P6atyAY2PxZV1y4B8jJZPClW1EaWXyGDolN7Mv5paI5asZJvsMtZ/Yk4QBDYU4yA
         /uDkfiqCZWmQygprWiQYTSiySaYsIB+0tIKsa/qsvhbvdg3En2XL+SMA/LY3oNC6Al3f
         nTm78wpW8AjOKimkXOO2UzTfR6/iwMTpvypzSAzvZ1KBFw6FAJSaPtN5YxGO8/Ze4OEx
         +t96yma3uGrykGKJP6uHagbxNB0JU3+KKBIBAk9mMd9ZoYlJOreEtaYusyE7cdUpdqcS
         jeiwn6SbLyOOoBAoPBVPSllLnsVf2A5RW20juXpnNoVUIMwophVcx+ICcTRxZGoLgmIC
         7LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237089; x=1695841889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUQlNWBQLKx5ke9/fjvP01zDeVt7MOvvAIgh8fT+a2g=;
        b=ql5591myqz3mD92udVID9uuNHzbEYn5e5Ac2dX9FN6xPiqKK7x40WNi5D2N9ABx+Ux
         kvDwrXyB7q7cQApw8cHFK73tGLyWKvPIrEcJqEtSgZAfunRDXfk005VhCOQOhPuGkIlE
         DFsTQlhAh6xEwup7W7w7pehOWI9YdxaWmu/C8I0Pur4QgHq123T9hDOu+xSvpXJ2WbLl
         owFopB4/mx7SwdCC8BKUajg+qGKCT2LMp2yjG3BZBsQe4KDGKD+iF8A/CUoM0XMwdrUn
         K1zR6Nlcb/oTLCcW4wVbnofYzltitUuR5bKM2jY9JyQl3R8M4ZOwkjGP6HV9RFU+YDbb
         OOLg==
X-Gm-Message-State: AOJu0YzyznBgwVHiVMOzJWNfEXfCVe0Vb2+4Ex8M6iSCM7+hBtgV6cGM
        /Mn+Ky8PZdO+l/bSpmXpiL0=
X-Google-Smtp-Source: AGHT+IGjuWCpw3+WqQsoX1kGIpH5V86XQwheI3EqDlTcV/bf3oj9XgFQeK/GNEeHA27ZLJuzhjolVg==
X-Received: by 2002:ac2:5bc7:0:b0:502:a4f4:ced9 with SMTP id u7-20020ac25bc7000000b00502a4f4ced9mr2972681lfn.62.1695237089243;
        Wed, 20 Sep 2023 12:11:29 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id h10-20020ac25d6a000000b004f85d80ca64sm2800653lft.221.2023.09.20.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:28 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v4 04/20] EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
Date:   Wed, 20 Sep 2023 22:10:28 +0300
Message-ID: <20230920191059.28395-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ADDRMAP4.addrmap_col_b10 field gets to be parsed in case of
the LPDDR3 memory and Quarter DQ bus width mode. It's wrong since that
field is marked as unused for that mode in all the available DW uMCTL2
DDRC releases (up to IP-core v3.91a). Most likely the field parsing was
added by mistake as a result of the copy-paste from the Half DQ bus width
mode part of the same function. Even though the field is supposed to be
always set to the UNUSED value (0x1F) drop parsing it anyway so to
simplify the setup_column_address_map() method a tiny bit.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 65790097beb2..308da6f82d3d 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1237,10 +1237,6 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
 				 COL_B9_BASE);
-			priv->col_shift[13] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
 		} else {
 			priv->col_shift[11] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-- 
2.41.0

