Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7479D138
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjILMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjILMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:37:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6310D5;
        Tue, 12 Sep 2023 05:37:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313e742a787so3508642f8f.1;
        Tue, 12 Sep 2023 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694522270; x=1695127070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49e+l1Yidi/qhSW+/Oluai/nUug0SULS4Us9G5sFvjU=;
        b=FLQZlfM159anfLTemEMPJnC59yNZNoIRVg6n4xlQB2R+fzEU1mdmOKczXSuINLagUV
         70b4XPP6kSnBJEeo5G8Qkw7ye805tqeHUqwSPAknHp7BFpfFCa6d76K41meBqGahJQ+f
         9BWqmvEGkZDCYM8tS0KKOKqcUgp/XVWzPT1w2vBZOfimiRls3NHytLkLMdEdSjMon4Gl
         06eyzrY7YVG96srJofl2pfvLlvmUSE6+QvnEnlWxkwzEHl3npwxkbKRGs4KAYTZApxBS
         ZPDHibw+FMRMnXWdZ1anj+z9ZsAc9ZXZ2EpjQOPIEyTV5krtsXCAhxAuY/OEKC8XASoh
         fD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522270; x=1695127070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49e+l1Yidi/qhSW+/Oluai/nUug0SULS4Us9G5sFvjU=;
        b=QNWac7/vcYEBhvjkQO/3jMW7TqyU810ws9m/CyirFSfOkarzrSQcuLeEpnhYmdRuTt
         /gOSB7FoFsbem+UboeHNx1bjToFav0oN1rWZbfZkAruK6hSlyWw8PaUI0LEkTzudkycc
         jqOG8YHo5uKKZGamWKtrRbMuNk1od+NqC8WqjElbMqSxSC06TxqDZRo3e18fmEtpLWpq
         Ds+1Sn0OqpuJCzNgBSTXDPNV126gsgM2zaajc9xDcWSgVMTg746GZ2oK6t6fqa7hMxgW
         VTTBn/QZRis6viRyd6YsOeqJcfYwPS/C4P6lbl+aQyKYsazj5rGFLlmXMSWU4jibO0Av
         WDgw==
X-Gm-Message-State: AOJu0YzUytbqWDuIrUyss/5FafnsqsYuepzJRSp5lGbAvaLH7RraHWz+
        XGhBUeBUdnleFyZ7gislqAY=
X-Google-Smtp-Source: AGHT+IGYEebIYgKMreGO33DsSvXOiEZOsQqChsZdmr7EgKjYmVw9IGu/0wfCT9WxOBuJNK2xhec+7Q==
X-Received: by 2002:a5d:594f:0:b0:31a:dbd8:95dd with SMTP id e15-20020a5d594f000000b0031adbd895ddmr1647946wri.29.1694522270650;
        Tue, 12 Sep 2023 05:37:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b0031f5f0d0be0sm12660276wrr.31.2023.09.12.05.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:37:50 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5][next] bcachefs: remove duplicated assignment to variable offset_into_extent
Date:   Tue, 12 Sep 2023 13:37:43 +0100
Message-Id: <20230912123744.3929609-5-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912123744.3929609-1-colin.i.king@gmail.com>
References: <20230912123744.3929609-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable offset_into_extent is being assigned to zero and a few
statements later it is being re-assigned again to the save value.
The second assignment is redundant and can be removed. Cleans up
clang-scan build warning:

fs/bcachefs/io.c:2722:3: warning: Value stored to 'offset_into_extent'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/bcachefs/io.c b/fs/bcachefs/io.c
index 3c614c864b6e..3b827c8dbf12 100644
--- a/fs/bcachefs/io.c
+++ b/fs/bcachefs/io.c
@@ -2724,7 +2724,6 @@ int __bch2_read_extent(struct btree_trans *trans, struct bch_read_bio *orig,
 		pick.crc.uncompressed_size	= bvec_iter_sectors(iter);
 		pick.crc.offset			= 0;
 		pick.crc.live_size		= bvec_iter_sectors(iter);
-		offset_into_extent		= 0;
 	}
 get_bio:
 	if (rbio) {
-- 
2.39.2

