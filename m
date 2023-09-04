Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3F790FAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 03:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350465AbjIDBmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 21:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350377AbjIDBmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 21:42:05 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB1B106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 18:41:54 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230904014149epoutp02ca585873b16d26fd4e0eca1a4902d77d~BjpX4pFvt0530905309epoutp02W
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:41:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230904014149epoutp02ca585873b16d26fd4e0eca1a4902d77d~BjpX4pFvt0530905309epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693791709;
        bh=UTp2spf180fapim/QCGBMuGvcRmlmKbbwTJawClBTJo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EkU2cTu3rrHWN876t+KkFF2ZDBC3woBGRCb79RphC5+DWatNgoVKS00p/VaFd8MO9
         sQyFpJyQQnx6WxhtdJetN3akwXQ0bbus0SMBbhYtjOBLR8AKrrtYqbxTY4GTQg6J5U
         opt8IdqZHDXqbi/pOHDEJtUUokQKJdTl5wl8GkK0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230904014148epcas2p3df99419c636d78ea9e6bf22857a2452d~BjpWwNIsb2851428514epcas2p3O;
        Mon,  4 Sep 2023 01:41:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RfBFR5wLfz4x9QM; Mon,  4 Sep
        2023 01:41:47 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.48.09649.BD535F46; Mon,  4 Sep 2023 10:41:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3~BjpVSCK-91655016550epcas2p38;
        Mon,  4 Sep 2023 01:41:46 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230904014146epsmtrp188e98d322e15dd493b14d2b4326e84ef~BjpVRMHU40625906259epsmtrp1E;
        Mon,  4 Sep 2023 01:41:46 +0000 (GMT)
X-AuditID: b6c32a46-943ff700000025b1-e9-64f535db9d19
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.E0.18916.AD535F46; Mon,  4 Sep 2023 10:41:46 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230904014146epsmtip106f24fa5813680b7a66f39407aa2fc9d~BjpU-NdfJ1118011180epsmtip1R;
        Mon,  4 Sep 2023 01:41:46 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RESEND PATCH v3 0/2] change UIC command handling
Date:   Mon,  4 Sep 2023 10:30:43 +0900
Message-Id: <cover.1693790060.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVPe26dcUg08ftSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZuw8/YCuYxlxxfP111gbGQ0xdjJwcEgImEnN/HWDsYuTiEBLYwSjx5OBO
        dgjnE6PEseYNTHDOhz2n2WBaXq/YzgpiCwnsZJT4tLwUougHo8TGllWMIAk2AU2JpzengnWL
        CHxgkvi/fBtYgllAXWLXhBNgy4UFrCQOv5wINpVFQFXi3KaT7CA2r4CFRM+MJSwQ2+Qkbp7r
        ZAYZJCHQyCGx4v1jRoiEi8TxX8+gThKWeHV8CzuELSXxsr8NyOYAsrMl9iwUgwhXSCye9hZq
        prHErGftjCAlzECHrt+lD1GtLHHkFgvElXwSHYf/Qg3hlehoE4JoVJb4NWky1H5JiZk370CV
        eEi8320GCZFYiSdbTrNMYJSdhTB+ASPjKkax1ILi3PTUYqMCI3gUJefnbmIEJ0kttx2MU95+
        0DvEyMTBeIhRgoNZSYRXTvtTihBvSmJlVWpRfnxRaU5q8SFGU2BgTWSWEk3OB6bpvJJ4QxNL
        AxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUamDId+LdOeKYbt2bfty6ntYHX
        Otg3OCVFf2v8kquSx3FrgvctjwmKr5ebtyzzEnjfwW70IVme7W6y299AOZYNTuzi9+/ezBL9
        V7jjeLnR2p7LOUWF8SZv+po5tFcZN3d9/mx+pf+1rchEt4LNz5JWxLrPzGhYKhruGx5aJXZR
        xitoltspl2li5jdiu2Nmnm16zKCwJs1yod0kZeuLXhF5Ou7fpF0vNvMs0rJ+/7V1xsGpvxc7
        RNcLP2Ov2XV1Yu6KVxGbi7yUQqSWbzrGt/bz87Nnf+fIRC+My/q+R/1J6HubS76tElZaDuqP
        JzxvbLhRVs+7WfPYhox5KSum3V0mzvdlwjrjlaIH1Vf92JatoMRSnJFoqMVcVJwIAGu4vvgb
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnO4t068pBjvvaFmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4ueUoi8XlXXPYLLqv72Cz
        WH78H5NF190bjBZL/71lsdh86RuLg4DH5SveHov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR
        4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBm7Dz9gK5jGXHF8/XXWBsZDTF2MnBwSAiYSr1ds
        Z+1i5OIQEtjOKPFo0zRGiISkxImdz6FsYYn7LUegir4xStz8v5AFJMEmoCnx9OZUJpCEiEAT
        s8Sl2dPBEswC6hK7JpwAWyEsYCVx+OVENhCbRUBV4tymk+wgNq+AhUTPjCUsEBvkJG6e62Se
        wMizgJFhFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZw2GoF7WBctv6v3iFGJg7GQ4wSHMxK
        Irxy2p9ShHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpga
        9m3inVL75ubD2Yd+nSr1MpiiO3P/ctnfW/gfzLxzUT6zbqPUtrk9RS/lD8vGijV8F+MTPSsZ
        JuU9M87x+D+53b8j+c+u6qw7eLOxheOgRL7czl77OeaZx47dM38xOV+jNI1TbY7toYL5Mw4E
        7uNkEQnzTXh7pZjRgZvntItutk+x9um0F4f8tz328o7KD5VqmNd6b7FaleG7awIHEkwuWfzY
        2nJsyTfbp49zNui+48ormKG8/8/656KPFtz/mh8Vzus/LfcQs5zG5WcTHxw00vfgF7x3855G
        dHP4lkOPti1bG6PYKNh1UqF1xWwG5qfpvLw+5xerPsueIR8n2S0aZ8cYKDWpX+LJ1C1e9xOV
        WIozEg21mIuKEwE31Nq2ygIAAA==
X-CMS-MailID: 20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3
References: <CGME20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3: rule out the change of polling w/ pmc from this thread.
(I'll post the change later)
v1 -> v2: remove an unused variable in __ufshcd_send_uic_cmd

Kiwoong Kim (2):
  ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
  ufs: poll HCS.UCRDY before issuing a UIC command

 drivers/ufs/core/ufshcd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.7.4

