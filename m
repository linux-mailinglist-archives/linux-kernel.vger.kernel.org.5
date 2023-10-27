Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637B07D8D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjJ0DDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0DDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:03:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653F129;
        Thu, 26 Oct 2023 20:03:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cac20789e8so3053345ad.1;
        Thu, 26 Oct 2023 20:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698375799; x=1698980599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EOx1Hx1IAPQ1YOKRVGNCkYTk+hHI63wiG6ySEOWqsw=;
        b=OdDYMYgKyBVpQnrS24hArShy7Z1Tdd/bRseMd7hFzVqMBeA/sCMpA/gckgYsEFDYii
         s+MvtgRbrdfQAvkHhWDTFkFhCZ2xmQRtav0ZPvYvpFBkjbrx++Bp/TV/tJ78ZpYS88q7
         mEwrak+CHMylQlNQwMRE1UvzZ4X+7SdmjBFNtCToI4LdNpTv/dcK+Izo5BYI19U+DgvW
         3F+rOSJsX9r/Rbk/AraogAWi36gonPTHsUZzxL4dwrbe3TpuV2cYwJqNOSHv8kf/CyOg
         ck9sTDxEMS6OF//+TZWi4/IBfUMNjeMs24iKst/FnQxLfuzCRttevFeMavdFDZ6cMDU2
         NhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698375799; x=1698980599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EOx1Hx1IAPQ1YOKRVGNCkYTk+hHI63wiG6ySEOWqsw=;
        b=ev+AhFppn353sy+hqiVW3Ay60eB8vhnbY988TEiTVgw3BFd4cYaXb8eWZctqrtxR5B
         VlTFlmNUmQ7hDnlGomsREmMFzREO0M2U8xdLr7zVAXcf+hLCaTp2WpEoc3VDBnYOj/ee
         JxROpE6OBo2nQqzmfwFghH/l0aYEFIYPbuj4IUaar7KzSc0Zud3upRHaUzlk9WXnAeQa
         zAEupiyH2UJBL1zGdb/2VtBCxXhMAUmS+Ij8hhtS9ON/L69ex1s88bFMRn47jXGn4OFq
         fiueyFVuJZwvMJ8z0rGXgMcg30oRgLtAkxvNDgSjW9LjbDW1XpX/39zebNS5E+HN1Ifv
         q8Rw==
X-Gm-Message-State: AOJu0YzzVpA70jJGEoq4pOwOeSwdY5eOmqc3zOvaNFISN/rp/yv8DRVs
        edrRuxhx7V0ijGFTahbDm18=
X-Google-Smtp-Source: AGHT+IG9yKdbB5f6crmqx99aYXu0CfVPTX0c780HCd5N35eViHlFac5rHuZEhQhsRoxb4hn+gVW6SA==
X-Received: by 2002:a17:902:f213:b0:1c4:1cd3:8062 with SMTP id m19-20020a170902f21300b001c41cd38062mr1465649plc.2.1698375798663;
        Thu, 26 Oct 2023 20:03:18 -0700 (PDT)
Received: from hbh25y.mshome.net (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001bde65894c8sm407508plb.268.2023.10.26.20.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 20:03:18 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     v9fs@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] net: 9p: fix possible memory leak in p9_check_errors()
Date:   Fri, 27 Oct 2023 11:03:02 +0800
Message-Id: <20231027030302.11927-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
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

When p9pdu_readf() is called with "s?d" attribute, it allocates a pointer
that will store a string. But when p9pdu_readf() fails while handling "d"
then this pointer will not be freed in p9_check_errors().

Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
	
	v2: change the Fixes tag and remove "ename != NULL"

 net/9p/client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc1..b0e7cb7e1a54 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -540,12 +540,14 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
 
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
-- 
2.34.1

