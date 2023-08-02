Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DB76C26C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjHBBoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBBoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:44:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCE594
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:44:09 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230802013850epoutp019165b5b6f68126d68ae7844e143e3bbe~3bUWKTV5n1768117681epoutp01W
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230802013850epoutp019165b5b6f68126d68ae7844e143e3bbe~3bUWKTV5n1768117681epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690940330;
        bh=UTp2spf180fapim/QCGBMuGvcRmlmKbbwTJawClBTJo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EObybahhQI8texORO+HgKCWJv5iD5LnVbf2n8RLMa+uP85dvmLBkdu4fdh6PXzZ3e
         5bPp9Kr/MRa3/CcVWLDE8SfMwiXylfiSrhO2RPO8aKsK9jG0Ti5jFmjFueogaq1bWc
         2LlpVFhUSeRFBGA5ys23Jda7cQzic7dAUOE1PTIA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230802013849epcas2p3aaaebb3a4d25c93d5371c95dc33d85c9~3bUVmAKFM2061320613epcas2p3C;
        Wed,  2 Aug 2023 01:38:49 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RFvlF2dyPz4x9Q1; Wed,  2 Aug
        2023 01:38:49 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.96.29526.9A3B9C46; Wed,  2 Aug 2023 10:38:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230802013848epcas2p3a896970d5bdc8e3f3e422c84c282a151~3bUUpvjeP2063320633epcas2p32;
        Wed,  2 Aug 2023 01:38:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230802013848epsmtrp2156a6eee4530405a398e9e029373e1cd~3bUUo8KB81331913319epsmtrp2F;
        Wed,  2 Aug 2023 01:38:48 +0000 (GMT)
X-AuditID: b6c32a4d-853ff70000047356-f8-64c9b3a95461
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.0A.34491.8A3B9C46; Wed,  2 Aug 2023 10:38:48 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230802013848epsmtip2d41050ecba6841c4e4af8d5dec783f92~3bUUaRQAa0101401014epsmtip21;
        Wed,  2 Aug 2023 01:38:48 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RESEND PATCH v3 0/2] change UIC command handling
Date:   Wed,  2 Aug 2023 10:28:31 +0900
Message-Id: <cover.1690939662.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSf0wbZRjed3deDxRzFsa+1QzhyDJBCy3jxw1hYlzMTUSRJi6aTbjQC5CW
        tvbHxhaTYVRaQBmwjbGyOgabk2IkaVmlCG4tM0DCgAEGSoCURKZllk1L0Elglh7T/573fZ/n
        fZ7vB4EK63ARUabSc1oVq6TwcMwxkJAu7rAPyyXzt0l6+Jdvcdr7lQOnfY9+xmnXYjVGNz18
        hNKd7V6MbptxIHTvxqcIfWPGidGe7p8werL3Ek7XTvfg9PXBTYSumZ8B9LVNP0bbJ9awHJKZ
        nMpl2vt8CFPfdgswf3WZcOaPpVmMqeu2AiZgi2GMt2qRfOIDRVYpx8o5bSynKlbLy1Ql2VSu
        rPD1wrR0iVQsPUBnULEqtpzLpg69lS9+o0wZPAEVe5xVGoKtfFano5IPZmnVBj0XW6rW6bMp
        TiNXajI0STq2XGdQlSSpOH2mVCJJSQsSixSlPwx4cU0TWjHYNf1UJXAjNSCMgGQqrF6pQmtA
        OCEk+wDcWOzD+OJPAEeaHyB8sQZg27IRfyIZNj0W8IN+AOdWh7YlfwPo6QgItlg4mQCXPOdD
        8ijyIQIfX3eArQFK7oO99UMh90gyEw74GkJrMXIvHDXxFhEkDX/90Sng7WKgZ7Q6lBCSnxCw
        u2NsO/oheN5jRHkcCZcHu7cFIhhY6Q8uIoJYAfuuRPPtCtje5Md4vB+a7xnBFgUNBu3qTebZ
        8fD2LManfBaaBjYEfDsCmqqEvDAe/tN4FvB4N7zomdv2ZGCjuTHUF5LHYI19AqkHe8z/728F
        wApEnEZXXsIVp2ikYhV34r+HKlaX20DoYybm9YD7XRtJboAQwA0ggVJREc+vD8qFEXL25ClO
        qy7UGpSczg3SgjfWgIp2FquDP1ulL5SmHpCkpqdLM1LSJBnUroiFzy1yIVnC6jkFx2k47RMd
        QoSJKpG3vceX8IVXrbJde498179+ZQipvdS6pNn3wqk7X4QXNEe25FQqQQWafPdMHe10tS4f
        xk/76zNN4phXrq7tOJozpG2Z9a8sCe76j102r/oK5k44rl52ydqcVUrFZNr7izvy9jxDNX9z
        Ibqnc8Sfl7tgP9dYdOejndMzMqktcIEb6/VOjSQXt790L8GXqLQi/dcs+szxJINr7ObuM1Ob
        pPtwE2OJW2t+bvVjW9RFn6zUWf1145EHZa9ZFrHTIlvdu+O/2z98Z71juWX0+9/2B94La1g2
        UqhpdP1o1JednU/fxIzkjXlXXM/L8ZVv4i8mZrlObkZZwdki80RcQfT98YOfWShMV8pKE1Gt
        jv0XgV1cYyEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvO6KzSdTDHr/G1mcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4ueUoi8XlXXPYLLqv72Cz
        WH78H5NF190bjBZL/71lsdh86RuLg4DH5SveHov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR
        4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBm7Dz9gK5jGXHF8/XXWBsZDTF2MnBwSAiYSJzv+
        s3cxcnEICexmlOiespodIiEpcWLnc0YIW1jifssRVoiib4wS/1vOgxWxCWhKPL05lQkkISLQ
        xCxxafZ0FpAEs4C6xK4JJ8BWCAtYSRx+OZENxGYRUJU419EOZvMKWEg837cTapucxM1zncwT
        GHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDl8tzR2M21d90DvEyMTBeIhR
        goNZSYRX+vfxFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTByc
        Ug1MrR3ax/+ccmUpObqxaEthVNaL+oosRf2yiEwLQ6G5J7Y3nYpZyHm5tzeQp+9VSbHf67nl
        oZ8DJYz9vA8cOi/jwPMzrzFBmH+a6JX46GrNp10M4vkXj5d8qf/76sDiyGOzIjQvzQlmLfqd
        pP+pM8ksRu5fb0j3g+XH5I7zbjxw72NmxvojMz0bpBJ9ubSVFJ8+embYOys7Qe5j5DWOw6fT
        lf0v7ErJvLL7DUdS9jQfMc/bQtMrtmf3sfaZLelKZWLc9/+g6Kow5p3bw/YH6u05eJmp8EWD
        40u5LTdL54SfP5+YfEj3i1F0t6BXZ3THCjf++U52E3yi9e7URv5l9X37272eN7PRso77enzY
        LSWW4oxEQy3mouJEAJGqH6fOAgAA
X-CMS-MailID: 20230802013848epcas2p3a896970d5bdc8e3f3e422c84c282a151
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230802013848epcas2p3a896970d5bdc8e3f3e422c84c282a151
References: <CGME20230802013848epcas2p3a896970d5bdc8e3f3e422c84c282a151@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

