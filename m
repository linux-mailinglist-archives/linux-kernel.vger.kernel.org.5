Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECF79A49D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjIKHet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjIKHes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:34:48 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D242CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:34:43 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230911073441epoutp0259133d651bf835f1ba594340ced84627~Dx_dV4DdB1311513115epoutp02W
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:34:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230911073441epoutp0259133d651bf835f1ba594340ced84627~Dx_dV4DdB1311513115epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694417681;
        bh=IKpHLoRkEZ25dLla5ObOQQje8kvo8BLHGCCdBwGXhCQ=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=XxjfDhCcXxzOKarTNZ9pAXPpP8Q4gLvv6bir/t7tkAbWvHMOzT0cpN5vdNTZaU7sA
         BOhlva9HDN+apw/ckIVrp16Ep7IjDyxluAXc6zTii3lVvkxEO496qD3gDtHOgKRSI9
         5y4rEbOBSFYtjQGhh3GPP9mC6nhL08+30060ifgg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230911073438epcas2p1ee7b4aba97e141f987e4b4e65d6bc33d~Dx_bK0NqM0846908469epcas2p10;
        Mon, 11 Sep 2023 07:34:38 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RkdlL2RDjz4x9Q6; Mon, 11 Sep
        2023 07:34:38 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.EB.09765.E03CEF46; Mon, 11 Sep 2023 16:34:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911073437epcas2p13fff13f4756dd4949cf88c3716d3011c~Dx_aJN0Kp0659906599epcas2p12;
        Mon, 11 Sep 2023 07:34:37 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230911073437epsmtrp1b3a429076c6b686e3f7813b1dcca8ce6~Dx_aIW3Oq2620326203epsmtrp1R;
        Mon, 11 Sep 2023 07:34:37 +0000 (GMT)
X-AuditID: b6c32a48-40fff70000002625-59-64fec30edf42
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.51.08649.D03CEF46; Mon, 11 Sep 2023 16:34:37 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230911073437epsmtip1bc7841b7be0509ff455477cc2e20a694~Dx_Z3PnS61614516145epsmtip1G;
        Mon, 11 Sep 2023 07:34:37 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <adrian.hunter@intel.com>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <kwangwon.min@samsung.com>, <junwoo80.lee@samsung.com>,
        <wkon.kim@samsung.com>
In-Reply-To: <1694051306-172962-1-git-send-email-kwmad.kim@samsung.com>
Subject: RE: [PATCH v4] ufs: poll pmc until another pa request is completed
Date:   Mon, 11 Sep 2023 16:34:37 +0900
Message-ID: <000801d9e482$6b023b10$4106b130$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHCOs06MSlmgDNb/VB40Dx452KEGwMC5LjvsCx3ivA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmqS7f4X8pBu9+CFicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0z
        B+h4JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGB
        kSlQYUJ2xoH3YgUrGSuObp3G3MDYydjFyMkhIWAi8XDzKnYQW0hgB6PE7x/yEPYnRokbs3m6
        GLmA7G+MEp3HHrLDNEy//ogRIrGXUeJwx0ImCOclo8S0Tf/AxrIJaEtMe7ibFSQhItDHLHFx
        2QIWkASngLvEo32f2boYOTiEBbwlTvRYgoRZBFQlfjz+wg4S5hWwlJj/SAYkzCsgKHFy5hOw
        TmYBeYntb+cwQxyhIPHz6TJWiLiIxOzONmaQVhEBK4lv+9lBtkoI3OGQmP7uDytIXELARWL5
        cS+IVmGJV8e3QP0iJfGyv40doiRbYs9CMYhwhcTiaW9ZIGxjiVnP2hlBSpgFNCXW79KHqFaW
        OHIL6i4+iY7Df6GG8Ep0tAlBNCpL/Jo0GRrIkhIzb96B2ukh0XPrLMsERsVZSD6cheTDWUi+
        moWwdwEjyypGsdSC4tz01GKjAhN4LCfn525iBCdoLY8djLPfftA7xMjEwXiIUYKDWUmEt+TQ
        3xQh3pTEyqrUovz4otKc1OJDjKbAIJ/ILCWanA/MEXkl8YYmlgYmZmaG5kamBuZK4rz3Wuem
        CAmkJ5akZqemFqQWwfQxcXBKNTAlXvHpXxN75bfXwTvplnVd266f1Z9U2hr26FWUidz5v46v
        GQv4LOsqKpaxhIYlyAdkCiUfS5Th11yyvmGXaKFYWL9+0IRtKzc4lO39ZSbdfqE/5eeSaZfC
        JllMZvqk+Idx6uuYkmn9gi3e1mJqf265+3rV6HXUa3Qd+HZaZOJ2/qtGJ9pdmdx3PfgQXhjx
        6nXlvPNSbBxFZ7fqXdzb4Du1S4xb1ezilU+Wz+54z77+as2CM882zJz74onBoVqRufod52o6
        yv3nWiXdtN34Ret+tOz+g832/Ukzz1xa9kTk+ew1yipzXzVNrHDYkrx6C/O5khOaPjevMX24
        XxZ1O1518cQ0mX//bX9MMup7zsijxFKckWioxVxUnAgAy6biiFkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnC7v4X8pBo//aVqcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjissmJTUnsyy1SN8ugSvjwHuxgpWMFUe3TmNuYOxk7GLk5JAQMJGYfv0RmC0ksJtR
        Yt1bDoi4pMSJnc+haoQl7rccYYWoec4o0bFAFsRmE9CWmPZwN1Cci0NEYAGzxLXVS1lAHCGB
        GYwS33s7mECqOAXcJR7t+8zWxcjBISzgLXGixxIkzCKgKvHj8Rd2kDCvgKXE/EcyIGFeAUGJ
        kzOfsIDYzEDzex+2MkLY8hLb385hhrhHQeLn02WsEHERidmdbcwgY0QErCS+7WefwCg0C8mk
        WUgmzUIyaRaS7gWMLKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYJjU0tjB+O9+f/0
        DjEycTAeYpTgYFYS4S059DdFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2amp
        BalFMFkmDk6pBqap//3WezBWSqdOyu721WBgj3rXbh/LVb7v9uPkN/uar7a4n77OGhrt9uiI
        /+JXi3hmz+TrP9LfZsoWdLnDJ8yS6ebaqIuh+dtrFXa6rFrht3TfQ4vfqz/3fnA+VdP3a+K6
        E/8bJp+Wu8Qb16DEdGnxny8cTr9YlzG4qv245SPz4krrj1r1dfuOeP3+dShpyxOTJuPdgRoz
        1d7tfzV9p3980mqrO6y27/PPRZ9TF91+40DO7Ef+ij+7Hl+ZESNo/TE+sklPLiltvkG20s/5
        1Z9bzpx6P73rkmev9slJx3a37he2PZl4+uGio9fP/vzE8rrs2JL1a07MtN98I/CXxuVT547k
        /WzX/jnlhIZx+Yq+tUosxRmJhlrMRcWJAF7f30U8AwAA
X-CMS-MailID: 20230911073437epcas2p13fff13f4756dd4949cf88c3716d3011c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8
References: <CGME20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8@epcas2p3.samsung.com>
        <1694051306-172962-1-git-send-email-kwmad.kim@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thinking again, removing the mutex completely doesn't seem properly
because this could hurting atomicity of UIC command process.
Let me modify and post it again.


