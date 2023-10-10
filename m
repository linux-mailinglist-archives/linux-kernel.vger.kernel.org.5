Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3894F7BF59B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442730AbjJJIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379435AbjJJIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:23:30 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41109A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:23:27 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231010082323epoutp02b5c5f34ae9c362a86b369de8ffc35cef~MsWQzvz0z3038530385epoutp02h
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231010082323epoutp02b5c5f34ae9c362a86b369de8ffc35cef~MsWQzvz0z3038530385epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696926203;
        bh=OFz9NhvaP5OGEDphP+4ZxQ731zjfj5HHE8gaUxkfqFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Es32xA4ZmGMLkjfINOrvREfjvbxFJ7vLSq4vuQ0/I7Jy3JjvOvIutkGzD9eLT0TkV
         /HcRRKXIUbeZTZ4S4SLLJ1GG9cUow9y1eNd7yc2zP3slJtcCf7Pf30E4zBeeEvOzZ1
         J+zxi4ALGOdM1h5h8yPRqhS4b02+Hp56OSiCZW6g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231010082322epcas2p175d41c2ad8ea2d48e177289a14808124~MsWQLalfx2109721097epcas2p1E;
        Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S4TSB2RY4z4x9Pw; Tue, 10 Oct
        2023 08:23:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.DD.09649.AF905256; Tue, 10 Oct 2023 17:23:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epcas2p253634722bcbe0dc9189fcdb67d3a2e29~MsWPGM6O61612416124epcas2p2B;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231010082321epsmtrp162030943ad754ee9d9590d258ce62d28~MsWPEFSjK1187111871epsmtrp1g;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
X-AuditID: b6c32a46-943ff700000025b1-bb-652509fa8963
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.F1.18916.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epsmtip25e984b78d1c2a9b6c4710f8585f57ddc~MsWOzhr1j0722107221epsmtip2E;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 5/6] cxl: Fix block comment style
Date:   Tue, 10 Oct 2023 17:26:07 +0900
Message-Id: <20231010082608.859137-6-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010082608.859137-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmhe4vTtVUg31NAhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCdsfd2P2tBI1vF2o52tgbGPyxdjJwcEgImEsdnLwOyuTiE
        BHYwSux/1sAG4XxilJi5+CYjnDP3wzp2mJY1v3axQiR2Mkr8aX/GDOH8YZSYMfMAWBWbgJbE
        9JkNYFUiAg+ZJHa+6mMCcZgFpjBLdM7aygpSJQw0a+3V1WA2i4CqRNfWd2A2r4CVxPQXa6BO
        lJfYf/AsM4jNKWAt8XD+WzaIGkGJkzOfgNUwA9U0b50NdoaEwBEOiQcbLzJDNLtI7G9dDnW4
        sMSr41ugbCmJl/1t7BANzYwSr59fYYFwWhgl1t3eAVVlLPHu5nOgkziAVmhKrN+lD2JKCChL
        HLkFtZhPouPwX3aIMK9ER5sQRKOSxLyl86BOkJC4NHcLlO0hce73H2ig9jFK3F/7g3kCo8Is
        JP/MQvLPLITFCxiZVzGKpRYU56anFhsVGMFjOTk/dxMjOHlrue1gnPL2g94hRiYOxkOMEhzM
        SiK8jzJVUoV4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjB/5JXEG5pYGpiYmRmaG5kamCuJ
        895rnZsiJJCeWJKanZpakFoE08fEwSnVwNQlFK4oPOfj9OTShVX3/jfb297ePyv6w5mTjZPl
        btXnrf8j7vnDdJ1qtfmErRHeZ2cbB759cbBHtDT1/ET346z6Rh9fzZ64z9/PfM6c9f9SD/rE
        vtdumBdQqpf9WsWwc7dl7QdBtk2ZZacOHdCO1Vd6zvfmnfC19jLl2qyl2/itilkrtiS5Vpz3
        Kvh/Lf2c5J/iKL7LbPvKpf3ieQuLnVcGLzl84tXFQ7rvpSexfw97k97wN1lR6MmGX/WHBRe5
        Td56sDXTpOD6HZubEf3xP7cmfFjANOPUgtucJ3nVgh85fjLorcrLPixpqP34djpD94e9D6qd
        eXbK3FtZoeX/frly9cJa4wTmZwy+8UrnE5RYijMSDbWYi4oTAbjGGqxnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTcRSA+917d3c3XVzn1KuCwlLQkZoi8suiAsFGYIQgQfZwuOsU35uG
        BpKPxZxgCj6W81GxNN0jU3Iu8/0In7SIFRZqaqYzNdFCfBTpNPC/7/B9cA4cAuUqMTciISWD
        lqaIkvg4GzMO8D39tlne9JneBT6cmjfjsKBMA6Cqwgzg8GQeDnWTegDzdVMMWKBpxuH6yl8M
        9v7IZcLxCSsDap9+xOGgwYJAzdAjFA51EvCdehSDHzpqcPi59C0CW2bW8Etc4Wv1FFMoH1xl
        CDWdVkTYqlXiwp5aPVP48JUWCCuq7ws3Wz2uETfY58V0UsJdWhpwIYYd3/WlhJGWh2cZChV4
        LtjDigCLoMhgSr/TwSgCbIJLtgNKtTeOHgqKev5yCTlkR2pGPngU7QCqoE9nEzgpoFRVuTbB
        IxcRamRlFBwMKFmDUgNKK/OgctzfYbDoGAeMkd5UUduajTlkKKVa0h/d4Un19E3YVrPIc9Ts
        41X8gLn7jbFPgR/2DtRI1Tdbj+73BW3VaCkg1ceU+ph6AhAtcKLTZMmS5Ni0QH+ZKFmWmSLx
        j01NbgW2bwkiTaCh+Y9/P0AI0A8oAuXzOHMJXjSXIxZl36OlqXekmUm0rB+4ExjfhXMqSSnm
        khJRBp1I02m09L9FCJZbLsLziXEWuPi2mCI2AiuamYzEK2FD7CBmU/HYTx/9aR0W6Rlf3qWt
        ikK6jdPBPHs5a1k9HCmv8HofNVw+udNZvbCLLKcXXic8nAubXBOvZt5sFndWlrlGjzwbNmjE
        9Q2kvQox+cSllG15jEu889cZqo3liMaW6NrsthJe6O5mlX7mpGU83JJxayJaMeSi9YsLIVvG
        NsbceXapxnDlQLq8QYHOTT0IeGH09cfXHPxC6lgWN5dGt7DuYknhiUrTdPibLCu5FlWLfWLN
        LM5Fmb+avvtevhjmpAgQb/3GpByzX1BrV/t8Vr35rBxs2uVkbpffNmTVaVd/Dc7mjPIxWbwo
        UIBKZaJ/0X2UPxwDAAA=
X-CMS-MailID: 20231010082321epcas2p253634722bcbe0dc9189fcdb67d3a2e29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010082321epcas2p253634722bcbe0dc9189fcdb67d3a2e29
References: <20231010082608.859137-1-jtp.park@samsung.com>
        <CGME20231010082321epcas2p253634722bcbe0dc9189fcdb67d3a2e29@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Block comments should align the * on each line

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/cxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 545381355efb..0bbe0c15bfa9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -334,7 +334,7 @@ enum cxl_decoder_type {
  * @flags: memory type capabilities and locking
  * @commit: device/decoder-type specific callback to commit settings to hw
  * @reset: device/decoder-type specific callback to reset hw settings
-*/
+ */
 struct cxl_decoder {
 	struct device dev;
 	int id;
-- 
2.34.1

