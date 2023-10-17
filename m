Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000477CC36A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjJQMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:42:44 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD4EA;
        Tue, 17 Oct 2023 05:42:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuNiO21_1697546556;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VuNiO21_1697546556)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 20:42:38 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net/smc: correct the reason code in smc_listen_find_device when fallback
Date:   Tue, 17 Oct 2023 20:42:32 +0800
Message-Id: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function smc_find_ism_store_rc is not only used for ism, so it is
reasonable to change the function name to smc_find_device_store_rc.

The ini->rc is used to store the last error happened when finding usable
ism or rdma device in smc_listen_find_device, and is set by calling smc_
find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
the value can not be overwritten anymore. So the ini-rc should be set to
the error reason only when an error actually occurs.

When finding ISM/RDMA devices, device not found is not a real error, as
not all machine have ISM/RDMA devices. Failures after device found, when
initializing device or when initializing connection, is real errors, and
should be store in ini->rc.

SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
not require same prefix.

Guangguan Wang (2):
  net/smc: change function name from smc_find_ism_store_rc to
    smc_find_device_store_rc
  net/smc: correct the reason code in smc_listen_find_device when
    fallback

 net/smc/af_smc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.24.3 (Apple Git-128)

