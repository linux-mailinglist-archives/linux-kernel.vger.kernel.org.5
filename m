Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D0C79136B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352525AbjIDI2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbjIDI2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:28:39 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41ADD8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:28:33 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230904082831epoutp048fac7ecf122ea0e96b8cfd24f0727f98~BpMddtd_Z1079810798epoutp04y
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:28:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230904082831epoutp048fac7ecf122ea0e96b8cfd24f0727f98~BpMddtd_Z1079810798epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693816111;
        bh=pqZMEtXF8khk+aqi2sWEdZGk9hIFpnSAUPxL2kkqvUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZC9vx+E8n8uvOg1WlVm+ADfq3vuuNtTjvwSJbnh9L2JsXWhCwqT30VuSlm2wlVadT
         mLPxg24MAUGjqEkbcKETIRBjfeymj9Y3pHmhtEw6s+Y3+SEFSI1LV17fP76hUbXydG
         qYQijvPidCwnIpVWZhRN8WPsHqFc9WlAx6wiG2Lo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230904082830epcas1p293318144f09e703757133fd0cbb334d6~BpMcxjfNA2571925719epcas1p2j;
        Mon,  4 Sep 2023 08:28:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.243]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RfMGk1PzTz4x9QD; Mon,  4 Sep
        2023 08:28:30 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.E9.09646.E2595F46; Mon,  4 Sep 2023 17:28:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230904082829epcas1p23ee3e36b0ef77a1f6112897afcacd93e~BpMcMgGG72571825718epcas1p2k;
        Mon,  4 Sep 2023 08:28:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230904082829epsmtrp11052edc93668d685fced4125df5fbcd1~BpMcK6E9o0877608776epsmtrp19;
        Mon,  4 Sep 2023 08:28:29 +0000 (GMT)
X-AuditID: b6c32a37-b23ff700000025ae-36-64f5952eb413
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.BE.08788.D2595F46; Mon,  4 Sep 2023 17:28:29 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230904082829epsmtip17447f8ae9152b8c4262ad5e3170c8100~BpMb6wu5E3126031260epsmtip11;
        Mon,  4 Sep 2023 08:28:29 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     kwmad.kim@samsung.com
Cc:     adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, bvanassche@acm.org,
        hy50.seo@samsung.com, jejb@linux.ibm.com, junwoo80.lee@samsung.com,
        kwangwon.min@samsung.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        sc.suh@samsung.com, sh425.lee@samsung.com, wkon.kim@samsung.com,
        Chanwoo Lee <cw9316.lee@samsung.com>
Subject: Re: [RESEND PATCH v3 1/2] ufs: make __ufshcd_send_uic_cmd not
 wrapped by host_lock
Date:   Mon,  4 Sep 2023 17:23:29 +0900
Message-Id: <20230904082329.19317-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <782ba5f26f0a96e58d85dff50751787d2d2a6b2b.1693790060.git.kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmvq7e1K8pBhu+sVmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYzTrWxWqxe/IDFYtGNbUwWu/42M1lsvbGTxeLmlqMsFpd3zWGz
        6L6+g81i+fF/TBZdd28wWiz995bFYvOlbywOgh6Xr3h7LN7zksljwqIDjB7f13eweXx8eovF
        o2/LKkaPz5vkPNoPdDMFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl
        5qbaKrn4BOi6ZeYAvaGkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAr0CtOzC0u
        zUvXy0stsTI0MDAyBSpMyM74vnsGY8Fs5orHXevZGhjvMHUxcnJICJhITOmbx9bFyMUhJLCD
        UeL/jVMsEM4nRolDz6ayQzjfGCUuLz8I1MIB0fJfDiK+l1HizuzlUO1fGCV2T2sAK2IT0JK4
        fcwbZIWIgKTE5ulTwWqYBaYxSzx4uIkFJCEsECtxcV83G4jNIqAq8frcUmYQm1fAWuLYyzVs
        EPfJS/y53wMW5xSIkfiy8jRUjaDEyZlPwOYwA9U0b53NDLJAQuAMh8T+5l52iGYXieWt7cwQ
        trDEq+NboOJSEi/729ghGpoZJRa+OQ7VPYFR4svH21Cr7SWaW5vZQN5hFtCUWL9LHyKsKLHz
        91xGiM18Eu++9rBCgoVXoqNNCKJERWJO1zk2mF0fbzxmhbA9JOYse8AECa31jBJde5exTmBU
        mIXkoVlIHpqFsHkBI/MqRrHUguLc9NRiwwJjeBwn5+duYgQnbC3zHYzT3n7QO8TIxMF4iFGC
        g1lJhFdO+1OKEG9KYmVValF+fFFpTmrxIUZTYHBPZJYSTc4H5oy8knhDE0sDEzMjEwtjS2Mz
        JXHeW896U4QE0hNLUrNTUwtSi2D6mDg4pRqYtlYuyua3St8d272isP242RbeKMk+M/tbX+J3
        TQ1sarRolf+Z/fTAhRuT9b+/P7H2UkxRwDk96dqn0iEGl7TVe8NLTd6XzHN13n+AsWN939Jd
        Zjyt8fNW3iiY9WPXq15GvxY3bsENvOeMrtf+Ud4x/YWM3HHD8rS2d/r5h36KHGRne/VwK3vX
        xo8ntZ7+2yJ4pV30oVZdrwNTc1iSsKuL5ZW9h8xlr+z+fzjh/ZeJvmke367uWqAX/W9LaHae
        gfaL02eE7rI+uSQmc/XSdS9vvZaPG56sT5ySs1HiTd7Od3PbpyXp7pkR/pDxwnXBZ73f+958
        N9T+a34l917vXIU5f0zO/m1/mtDFe/b0TZebvUosxRmJhlrMRcWJAHP9SJdhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTld36tcUg3M7lSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZosZp9pYLVYvfsBisejGNiaLXX+bmSy23tjJYnFzy1EWi8u75rBZ
        dF/fwWax/Pg/JouuuzcYLZb+e8tisfnSNxYHQY/LV7w9Fu95yeQxYdEBRo/v6zvYPD4+vcXi
        0bdlFaPH501yHu0HupkCOKK4bFJSczLLUov07RK4Mr7vnsFYMJu54nHXerYGxjtMXYwcHBIC
        JhJT/st1MXJyCAnsZpT48ykVxJYQkJLYvf88G0SJsMThw8VdjFxAJZ8YJZbv/cYIEmcT0JK4
        fcwbpFxEQFJi8/SpbCA2s8AqZol3n6xBbGGBaInbK26yg9gsAqoSr88tZQaxeQWsJY69XMMG
        sUpe4s/9HrA4p0CMxJeVp5khzomWuHx0CRtEvaDEyZlPWCDmy0s0b53NPIFRYBaS1CwkqQWM
        TKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYLjSUtrB+OeVR/0DjEycTAeYpTgYFYS
        4ZXT/pQixJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUA5Pq
        gSNMlleKr5i2Ljb6vGPOB9nl0orXG1IXsb55fX3XIXE9af20f5P/av45LyD41lPiM/87y7fs
        cb+6SoLCd31fdnzy1encp7a/2KH782puYXvWjD8c+zwY76eHmkfn/Xzn9HfD7Wt+JpYBNrLp
        UxLmdJvcW3u0f2Zd4gOxI5pLbdi3nJfyFZy7bbfRV6uHYhP39guLywufq3x15faS585VKdeq
        FjZusJxyUtpu0qENzrGqkzYdMg5WlukIfmaTELQ5VNvLeE4xR7H+rGtP3thUOxn8f/35fLbC
        eof5JZKWJ8x3Wz34vEx27pn7aj73buwIFVDZ8ciAuaNLKe3sHJtfF69fmD8x7ue2iUy958Sr
        lViKMxINtZiLihMBdDESsBYDAAA=
X-CMS-MailID: 20230904082829epcas1p23ee3e36b0ef77a1f6112897afcacd93e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904082829epcas1p23ee3e36b0ef77a1f6112897afcacd93e
References: <782ba5f26f0a96e58d85dff50751787d2d2a6b2b.1693790060.git.kwmad.kim@samsung.com>
        <CGME20230904082829epcas1p23ee3e36b0ef77a1f6112897afcacd93e@epcas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> __ufshcd_send_uic_cmd is wrapped uic_cmd_mutex and
> its related contexts are accessed within the period wrappted
> by uic_cmd_mutex. Thus, wrapping with host_lock is
> redundant.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---

Reviewed-by: Junwoo Lee <junwoo80.lee@samsung.com>
Reviewed-by: Chanwoo Lee <cw9316.lee@samsung.com>

