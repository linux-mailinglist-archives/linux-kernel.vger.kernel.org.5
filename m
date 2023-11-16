Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E67ED915
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbjKPB4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPB4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:56:31 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E1182
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:56:25 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231116015620epoutp02b397f8e773ba4b3ce499b99a53fe53c8~X974zDYZ02159021590epoutp021
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:56:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231116015620epoutp02b397f8e773ba4b3ce499b99a53fe53c8~X974zDYZ02159021590epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700099780;
        bh=NjHAXY+npESZSHKM54SAmh+Z2EcBgtlB9s/fZyVIdII=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=paKoW9xyuNUqO97lBxPvDzCOda3pO3geruL3C80IqHX+Y1fwfZLrAcemi/BLzvKSL
         MNhaax0entOPJBWQkBRW8/YMFJrP3FGlb+vftmDJYWGuoIurrtmQFRAo9mFLEmL32e
         cY2GpzasjnGGI4b7WhM9MFrkfZ9yn5qIGuXWxego=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231116015620epcas2p23b7fe74778dfc2a1d0316aa87f235295~X974WDLbn2813728137epcas2p2D;
        Thu, 16 Nov 2023 01:56:20 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SW36W2Zxgz4x9QH; Thu, 16 Nov
        2023 01:56:19 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.D9.10022.3C675556; Thu, 16 Nov 2023 10:56:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231116015618epcas2p2a80374aad80c6bbb7f3328d053fc457e~X973KnIRg3014830148epcas2p2h;
        Thu, 16 Nov 2023 01:56:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231116015618epsmtrp26518cede86e1297626df595b3f9546e0~X973IgGM31715617156epsmtrp2M;
        Thu, 16 Nov 2023 01:56:18 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-f0-655576c38a48
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.BC.07368.2C675556; Thu, 16 Nov 2023 10:56:18 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231116015618epsmtip2b91d84e4bba45f4a987e7cda3c11a4c6~X9727xHuG3047830478epsmtip2W;
        Thu, 16 Nov 2023 01:56:18 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <kwangwon.min@samsung.com>,
        <kwmad.kim@samsung.com>, <sh425.lee@samsung.com>,
        <sc.suh@samsung.com>, <quic_nguyenb@quicinc.com>,
        <cpgs@samsung.com>, <grant.jung@samsung.com>,
        <junwoo80.lee@samsung.com>
In-Reply-To: <e9745815-afc0-46c6-828b-c969a2d352eb@acm.org>
Subject: RE: [PATCH v2] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Date:   Thu, 16 Nov 2023 10:56:18 +0900
Message-ID: <00a901da1830$16ff2e10$44fd8a30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLYbO3h/Z18bVSq8KBPFnY/ewa5qgDl2w4PAbQq5PoB4bZfOgGN9AJOrk8xZ4A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmme7hstBUg1Oz+C0ezNvGZvHy51U2
        i4MPO1kspn34yWzx8pCmxa+/69ktFt3YxmSx628zk8XWGztZLG5uOcpicXnXHDaL7us72CyW
        H//HZDH1xXF2i667Nxgtlv57y+Ig4HH5irfHhEUHGD2+r+9g8/j49BaLx8Q9dR59W1Yxenze
        JOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA
        1y0zB+h+JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomV
        oYGBkSlQYUJ2xrdd31gL7vBU/JlxjbmB8RZXFyMnh4SAicT9zdeZuhi5OIQEdjBKNG04xArh
        fGKUmD13GQuE841RYubyBqAyDrCWqyd9IeJ7GSX6jt1mhnBeMkp8/3uXBWQum4CWRP/bLWwg
        CRGBXcwSG+8tB0twClhLPLs4nQnEFhYIlriz5QwbiM0ioCpxblYPWA2vgKXE3eMXGSFsQYmT
        M5+AxZkFtCWWLXzNDHG4gsTPp8tYQWwRAT+J79MOM0HUiEjM7mwDu0hC4AmHxL3Jx6EaXCTe
        9fxmhbCFJV4d38IOYUtJfH63lw3CzpZo3LMWKl4hMXfzZEYI21hi1rN2RpD3mQU0Jdbv0oeE
        hLLEkVtQp/FJdBz+C9XJK9Gw8Tc7RAmvREebEERYSeLM3NtQYQmJg7NzJjAqzULy4ywkP85C
        8ssshLULGFlWMYqlFhTnpqcWGxUYw+M6OT93EyM4ZWu572Cc8faD3iFGJg7GQ4wSHMxKIrzm
        ciGpQrwpiZVVqUX58UWlOanFhxhNgaE+kVlKNDkfmDXySuINTSwNTMzMDM2NTA3MlcR577XO
        TRESSE8sSc1OTS1ILYLpY+LglGpg0l+Q/+MEm8GO7yukmxgWTeNX7Vs609aIL2nOr2QHZlOf
        QJnKC7Lq2QoXl5XURns4qnXP4GDmD2ZQ3DN1S/ZGlZM9q+aUhBcsCHDkf7jqFJfDyvWBDybE
        nZc3s9/3akb81V1MevfS5DLX8BgZSzVezMuItGrzjgqLZP3GxPVYXG5BGO+vX/xOj5lTd4ne
        OHKYw3+i6xXzfoblJ9SF+mrKQ15OKHm09EP6M94Ni8sfrn/utDNhif9e07cl/HMOt0W6t6oF
        5EcVGx9cW+aVcjVyt82KdRvvVr0+3bbwws/rMa+neq/zf/rcWG5dWdktUVdZZdelSUvnPFid
        WM7G6LbCQWT27A1xOud8eYLbPpopsRRnJBpqMRcVJwIAzSEZjWIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSvO6hstBUgzlX9SwezNvGZvHy51U2
        i4MPO1kspn34yWzx8pCmxa+/69ktFt3YxmSx628zk8XWGztZLG5uOcpicXnXHDaL7us72CyW
        H//HZDH1xXF2i667Nxgtlv57y+Ig4HH5irfHhEUHGD2+r+9g8/j49BaLx8Q9dR59W1Yxenze
        JOfRfqCbKYAjissmJTUnsyy1SN8ugStja+NV9oItPBXLTk9mbGDcxNXFyMEhIWAicfWkbxcj
        F4eQwG5GiSPnN7F3MXICxSUk/i9uYoKwhSXutxxhhSh6zijx7lYDI0iCTUBLov/tFjaQhIjA
        OWaJkxtfsEBUTWeS2HXzETNIFaeAtcSzi9PBRgkLBEqsOTMdrJtFQFXi3KweFhCbV8BS4u7x
        i4wQtqDEyZlPwOLMAtoST28+hbOXLXzNDHGSgsTPp8tYQWwRAT+J79MOM0HUiEjM7mxjnsAo
        NAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCY1VLYwfj
        vfn/9A4xMnEwHmKU4GBWEuE1lwtJFeJNSaysSi3Kjy8qzUktPsQozcGiJM5rOGN2ipBAemJJ
        anZqakFqEUyWiYNTqoGpqDXrnVz53PezTn2VvyCrI9tlKx92SSHwSPmXsOWHG2dcbo3oSlv3
        ouXiccXlE5Z48C5SZFXoaJvrm/3q1+ZNTLq3T/ucvbfG5Fn1p1+zXM7MblkWUaWiaft/7i/5
        Q9wzLlicu7rr2vdcGb3uHOPUI1tZ3Necn1DQW/PDkvl4opt08oy5CzMDD9+wnSC8ROPq4jYX
        2X4P/38nr0Zq72Nyikx6fPTYx8NCGhFnXymnvt9+v+f0scLijutHrnyrf/klpEdsX+1Tn+iQ
        H5MO72OcPPtsp+BLUeF0RWGdS1YLFfW57l25WjvhR+/kVTLxM+s1Wmf8r/nCE/hA6+qaB3xz
        /zK4n340ddsuZWOGCf/OOSuxFGckGmoxFxUnAgBV9k9XRAMAAA==
X-CMS-MailID: 20231116015618epcas2p2a80374aad80c6bbb7f3328d053fc457e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea
References: <CGME20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea@epcas2p4.samsung.com>
        <20231114043704.52525-1-hy50.seo@samsung.com>
        <dca06fd3-d4ad-4e41-a0a3-61d52c85ef9c@acm.org>
        <000001da1784$5c2520f0$146f62d0$@samsung.com>
        <e9745815-afc0-46c6-828b-c969a2d352eb@acm.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bart Van Assche <bvanassche=40acm.org>
> Sent: Thursday, November 16, 2023 3:22 AM
> To: hoyoung seo <hy50.seo=40samsung.com>; linux-scsi=40vger.kernel.org; l=
inux-
> kernel=40vger.kernel.org; alim.akhtar=40samsung.com; avri.altman=40wdc.co=
m;
> jejb=40linux.ibm.com; martin.petersen=40oracle.com; beanhuo=40micron.com;
> kwangwon.min=40samsung.com; kwmad.kim=40samsung.com; sh425.lee=40samsung.=
com;
> sc.suh=40samsung.com; quic_nguyenb=40quicinc.com; cpgs=40samsung.com;
> grant.jung=40samsung.com; junwoo80.lee=40samsung.com
> Subject: Re: =5BPATCH v2=5D scsi: ufs: core: fix racing issue during
> ufshcd_mcq_abort
>=20
> On 11/14/23 21:27, hoyoung seo wrote:
> > The test_bit() function just check SCMD_STATE_COMPLETE bit state.
> > Do not set SCMD_STATE_COMPLETE field.
> > This function is also used in ufshcd_mcq_compl_pending_transfer()
> > to check the status of cmd.
>=20
> Right, I misread your patch. Can you please take a look at the following
> patch and verify whether it perhaps addresses the same issue that you wan=
t
> to address: https://lore.kernel.org/linux-scsi/20231115131024.15829-1-
> peter.wang=40mediatek.com/
>=20
> Thanks,
>=20
> Bart.

Hi, Bart.

It seem that not same issue.
That problem is that the try_to_abort_task() function has already been=20
processed.
So clear_cmd() has been processed.

However, this issue was already completed IO request before executing clear=
_cmd().
So can't get utag to clean up sq.
This patch to prevent access to utag for cmd that has already been complete=
d.

Thanks
Seo.

