Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6F79137B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350283AbjIDIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjIDIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:33:01 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D393
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:32:58 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230904083256epoutp0458051e481c8529241644d68d16784729~BpQUnk7EQ1506415064epoutp04b
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:32:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230904083256epoutp0458051e481c8529241644d68d16784729~BpQUnk7EQ1506415064epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693816376;
        bh=Q1yqxXmwlHA4EQx5felIcWYStF2OEXaRHYhXVJP76E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ja7GwogaM3P4T1twM7/fj0C/So6YqVnMpygu4JIAXtmrE1Ik2Bv6NaOF+w6wyNjJj
         gEzQAdCqyXBuOYJPwvw3nQeflzTo8suWPSzAwYhUPVNXgDTNf9R2/q9A0QVc39Ape2
         V/wmh0FJ3QvkbCaWVpy0ZPOIR+RFbyYKSC6AbeDI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230904083255epcas1p13117cf2fe0b6ecb723403a6299b92ad6~BpQUCyhVm1023110231epcas1p1P;
        Mon,  4 Sep 2023 08:32:55 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RfMMq31yxz4x9Q5; Mon,  4 Sep
        2023 08:32:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.3D.10163.73695F46; Mon,  4 Sep 2023 17:32:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230904083254epcas1p43e2cde7ddcf301970561041c582bc4b0~BpQTREYlX0378203782epcas1p4v;
        Mon,  4 Sep 2023 08:32:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230904083254epsmtrp24fee961f46218f055172614f72e03b46~BpQTP3U0u1249612496epsmtrp2A;
        Mon,  4 Sep 2023 08:32:54 +0000 (GMT)
X-AuditID: b6c32a38-28bff700000027b3-51-64f59637a096
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.FE.18916.63695F46; Mon,  4 Sep 2023 17:32:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230904083254epsmtip2c987be467209b3a15961cb1047c4e418~BpQS-saIB1973819738epsmtip2j;
        Mon,  4 Sep 2023 08:32:54 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     kwmad.kim@samsung.com
Cc:     adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, bvanassche@acm.org,
        hy50.seo@samsung.com, jejb@linux.ibm.com, junwoo80.lee@samsung.com,
        kwangwon.min@samsung.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        sc.suh@samsung.com, sh425.lee@samsung.com, wkon.kim@samsung.com,
        Chanwoo Lee <cw9316.lee@samsung.com>
Subject: Re: [RESEND,v3,2/2] ufs: poll HCS.UCRDY before issuing a UIC
 command
Date:   Mon,  4 Sep 2023 17:27:56 +0900
Message-Id: <20230904082756.19693-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <550484ffb66300bdcec63d3e304dfd55cb432f1f.1693790060.git.kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmrq75tK8pBue+ilicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYzTrWxWqxe/IDFYtGNbUwWu/42M1lsvbGTxeLmlqMsFpd3zWGz
        6L6+g81i+fF/TBZdd28wWiz995bFYvOlbywOgh6Xr3h7LN7zksljwqIDjB7f13eweXx8eovF
        o2/LKkaPz5vkPNoPdDMFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl
        5qbaKrn4BOi6ZeYAvaGkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAr0CtOzC0u
        zUvXy0stsTI0MDAyBSpMyM5Y8Tel4A5bxbSPWg2Mh1m7GDk5JARMJKY8ec3excjFISSwg1Hi
        1+YuZgjnE6PEp0u7meCc3f8PM8G07Pg+hwUisZNR4uHyFkYI5wujxI+VzWxdjBwcbAJaEreP
        eYM0iAhISmyePpUNpIZZYBqzxIOHm1hAEsIC/hL/2/rAprIIqEq8bzzPDGLzClhLTHr9mhli
        m7zEn/s9YDanQIzElx39bBA1ghInZz4Bm8MMVNO8dTbY3RICBzgkLrduYoNodpE4eG87lC0s
        8er4FnYIW0ri87u9bBANzYwSC98ch+qewCjx5eNtqA57ieZWiHeYBTQl1u/ShwgrSuz8PZcR
        YjOfxLuvPawgJRICvBIdbUIQJSoSc7rOscHs+njjMTS0PST2X7oJDdP1jBIbpz5imcCoMAvJ
        Q7OQPDQLYfMCRuZVjGKpBcW56anFhgUm8ChOzs/dxAhO11oWOxjnvv2gd4iRiYPxEKMEB7OS
        CK+c9qcUId6UxMqq1KL8+KLSnNTiQ4ymwOCeyCwlmpwPzBh5JfGGJpYGJmZGJhbGlsZmSuK8
        x171pggJpCeWpGanphakFsH0MXFwSjUwBXCpRoZkb16zKcmD5c7tZWYJ7tZGtVlr9bVyf7xy
        u9A8L2rK6zaN548Vq6uPNJ9KOix3ha3tsPHepTe7WqyW/IvaU73GOeFGUOCNtmmTJv+1Xfxn
        yufUjbn1/s3X5txn59jz/KWxSCPvt8gdJjO0Wd3cbHV3WP/XvDAl4ra8bkbfesZ/QTdN3m5w
        DWvIv2uqdsj7w2/1S+rf4p4L7axk7r64Za9mSL7b+cToJVp7BeY2Zne+vjE5Zf+TEuG2c4ss
        K7rNV0027rCdXbRBtklymbl/2NJtNvtfvdpx/lPVO+bt6g4GR47rKx7U4TzhHBdY3uH/f/bq
        J4f7XstyftedPS1e4ZKpV0NQ3TqBKfXblViKMxINtZiLihMBDYg10mAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvK7ZtK8pBu0dJhYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8WMU22sFqsXP2CxWHRjG5PFrr/NTBZbb+xksbi55SiLxeVdc9gs
        uq/vYLNYfvwfk0XX3RuMFkv/vWWx2HzpG4uDoMflK94ei/e8ZPKYsOgAo8f39R1sHh+f3mLx
        6NuyitHj8yY5j/YD3UwBHFFcNimpOZllqUX6dglcGSv+phTcYauY9lGrgfEwaxcjJ4eEgInE
        ju9zWLoYuTiEBLYzSvRMb2GESEhJ7N5/nq2LkQPIFpY4fLgYouYTo8SJx9tYQOJsAloSt495
        g5SLCEhKbJ4+lQ3EZhZYxSzx7pM1iC0s4CuxffEGJhCbRUBV4n3jeWYQm1fAWmLS69fMEKvk
        Jf7c7wGzOQViJL7s6AdbKyQQLXG0XR2iXFDi5MwnLBDj5SWat85mnsAoMAtJahaS1AJGplWM
        oqkFxbnpuckFhnrFibnFpXnpesn5uZsYwVGkFbSDcdn6v3qHGJk4GA8xSnAwK4nwyml/ShHi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgir7HE+75bqr6
        v7fLYpy9zwkbcQr+3PnBPWqe49Gsos5POrkqJns194mJT95RlbJNecLsplWB+RXsnB95Ipum
        H59hmCWf7DL1/udXi20vNcZwZz7fZ58q+eSP6QMvpYvqxfe33HfMLFJ1fafTrTGHj3npTpkI
        4/f91aypSvnyV03n7GhdlC7XfpPRcs2K1KAXa18cXBTJqVG8UOn3JJtZ0wr1ClRznv0MCLKu
        nPfxjP0SdwOvdRLXfwk/Pfw7oijhcsavc41vG5NOZn8qN85eWWTreFK462lNsI5du5OGS2DT
        Ih+vosULQk47iYi5bU4KbGyTnhh+b9VDg8Yl5xe5XJ6SlVcyYXa8eJ/U4lNKLMUZiYZazEXF
        iQDSEw+yEQMAAA==
X-CMS-MailID: 20230904083254epcas1p43e2cde7ddcf301970561041c582bc4b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904083254epcas1p43e2cde7ddcf301970561041c582bc4b0
References: <550484ffb66300bdcec63d3e304dfd55cb432f1f.1693790060.git.kwmad.kim@samsung.com>
        <CGME20230904083254epcas1p43e2cde7ddcf301970561041c582bc4b0@epcas1p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/04/23 5:31 PM, cw9316.lee@samsung.com wrote:
> With auto hibern8 enabled, UIC could be working
> for a while to process a hibern8 operation and HCI
> reports UIC not ready for a short term through HCS.UCRDY.
> And UFS driver can't recognize the operation.
> UFSHCI spec specifies UCRDY like this:
> whether the host controller is ready to process UIC COMMAND
> 
> The 'ready' could be seen as many different meanings. If the meaning
> includes not processing any request from HCI, processing a hibern8
> operation can be 'not ready'. In this situation, the driver needs to
> wait until the operations is completed.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Junwoo Lee <junwoo80.lee@samsung.com>
Reviewed-by: Chanwoo Lee <cw9316.lee@samsung.com>

