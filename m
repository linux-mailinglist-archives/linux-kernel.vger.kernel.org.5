Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9532811DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjLMS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjLMS61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:58:27 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A85B0;
        Wed, 13 Dec 2023 10:58:32 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231213185830usoutp01ff139d42e939a50e9312679d91a01232~geTDwxzY-0534805348usoutp01j;
        Wed, 13 Dec 2023 18:58:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231213185830usoutp01ff139d42e939a50e9312679d91a01232~geTDwxzY-0534805348usoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702493910;
        bh=h80joI7oKHnktwgbqFNgoVPBTLOrCLlQDQIfQdxtpkY=;
        h=From:To:Subject:Date:References:From;
        b=ibVOgsYD8Qh7Wl2sgC6IbYWeOKkRJxvzBd6EqmdTn23eR5OsJSYNSBeCeCZmc3ILY
         4tPFZiaRrwHcxrVPuBOk6xY6tHq/lvG2w/kiBRl7da6bKQOPW4NDpJjmjDhrPln4CJ
         qv4LIma0KcRJ9ZEoLSw1ieDFXeHJVOOO/9GYpks0=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231213185830uscas1p26d838293335c7a41156280e078780a29~geTDpZt6P3022330223uscas1p2w;
        Wed, 13 Dec 2023 18:58:30 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 18.FC.09760.6DEF9756; Wed,
        13 Dec 2023 13:58:30 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231213185829uscas1p2fc3ee6a9c92bff3cc9a043a9ff93bd27~geTDPFIsL3023830238uscas1p2i;
        Wed, 13 Dec 2023 18:58:29 +0000 (GMT)
X-AuditID: cbfec36f-7f9ff70000002620-9b-6579fed61b1f
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id E1.E1.09813.5DEF9756; Wed,
        13 Dec 2023 13:58:29 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 13 Dec 2023 10:58:28 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        13 Dec 2023 10:58:28 -0800
From:   Jim Harris <jim.harris@samsung.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] pci/iov: fix kobject_uevent() ordering in sriov_enable()
Thread-Topic: [PATCH] pci/iov: fix kobject_uevent() ordering in
        sriov_enable()
Thread-Index: AQHaLfZbfzSE7OYN20WpA0TR5aL0dA==
Date:   Wed, 13 Dec 2023 18:58:28 +0000
Message-ID: <170249390826.436889.13896090394795622449.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E0FA9BB41EEBF40A7FBB146649D7BF0@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djXc7rX/lWmGnzZx2Lx7X8Pm8WSpgyL
        K//2MFps2vCExeLyrjlsFmfnHWdzYPNYsKnUo7f5HZvH+31X2Tw+b5ILYInisklJzcksSy3S
        t0vgylg84Q9rwSb2ilkPTBsYZ7B3MXJySAiYSBxb/54JxBYSWMko0bNFpYuRC8huZZJ48mo1
        K0zRzd332SASaxgl1l47zALR8YlR4sHcOIjEMkaJ7y9awEaxCWhK/LqyBswWEZjDJDHjgieI
        LSzgKXHi0zegZg6geIDE85f1ECV6Eu3PP4NdxCKgKnHmXjsjSAmvQLTEjJ1gJYwCYhLfT0FM
        ZBYQl7j1ZD4TxG2CEotm72GGsMUk/u16yAZhK0rc//6SHWQMM9A163fpQ7TaSaza/Y0FwlaU
        mNL9EGwrL9CYkzOfsEC0SkocXHEDyp7LIXHooSyE7SIxf8JVqPHSEn/vLoM6IVti5foOJpBV
        EgIFEg1HgiDC1hIL/6yHuphP4u+vR4wQJbwSHW1CExiVZiH5ZRbCnbOQ3DkLyZ2zkNy5gJF1
        FaN4aXFxbnpqsVFearlecWJucWleul5yfu4mRmDaOf3vcP4Oxuu3PuodYmTiYDzEKMHBrCTC
        e3JHeaoQb0piZVVqUX58UWlOavEhRmkOFiVxXkPbk8lCAumJJanZqakFqUUwWSYOTqkGJl61
        iYX7F8dtPcvQz7FyyXWlZo+t5uvnX19zbvsjw8LTHjFiB47OnnF/pXz4PxnuPtMACykRmRt8
        jbK8TVNbJpmrP5rEva35XdD13h2rdkvcLLedzNpVsmvPXvkf2zKOZQeeOKx2grk70Ozuxy9M
        t09JTRNYYHLx8bqN+YWc5ccr3f6cNDlx7dW/ohdrP8/InPF0+5MAi7qrBc9XCX+3tNUruXz4
        yLkL665v/C4g5jdPWC9V2W4qY0f1zxcL5GIuBhS3733L9ufwy82/L26vuqNoeFtmvfS+6NWN
        X90l22PZu3rW9/4L/2aY8zJr07d181Ql7H09fxg9YGu9vi54xdEJPov7J9ue9eaIVtS9NGGj
        EktxRqKhFnNRcSIAJbZTp6oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWS2cDspHv1X2WqwdvjShbf/vewWSxpyrC4
        8m8Po8WmDU9YLC7vmsNmcXbecTYHNo8Fm0o9epvfsXm833eVzePzJrkAligum5TUnMyy1CJ9
        uwSujMUT/rAWbGKvmPXAtIFxBnsXIyeHhICJxM3d99m6GLk4hARWMUqs/b8ZyvnEKPHn4AUm
        CGcZo8TPxa1sIC1sApoSv66sYQKxRQTmMEnMuOAJYgsLeEqc+PSNBSLuJ3H6zhU2CFtPov35
        Z7B1LAKqEmfutTN2MXJw8ApES8zYWQ8SZhQQk/h+CmIks4C4xK0n85kgrhOQWLLnPDOELSrx
        8vE/VghbUeL+95fsIGOYgc5Zv0sfotVOYtVuiAuYgUqmdD8E28orIChxcuYTFohWSYmDK26w
        TGAUnYVk2yyESbOQTJqFZNIsJJMWMLKuYhQvLS7OTa8oNspLLdcrTswtLs1L10vOz93ECIy6
        0/8OR+9gvH3ro94hRiYOxkOMEhzMSiK8J3eUpwrxpiRWVqUW5ccXleakFh9ilOZgURLnvftA
        I1VIID2xJDU7NbUgtQgmy8TBKdXApMb0X0D/c9jRxb4Vc/r0PdPyliu2cV+cq3fq3dsSWeao
        11/Y+OIDpvye3lV3aGX2inN8z+8We7G57PyrECTo7b/ddUf2K8lllR15Au5Jkdz5fBHrxMMO
        3jr3JfborutmQdnb47XN5+d0/jG0Z93dfF3lnUoBo2fR3o6kzc3zT5cXL3n0cV/gJKWcKA7p
        rtNrTC5WTDIKcSrU6z4/9UHNvFcfv1mdYmHexl12iiteWGi/PdMv8d7OtW+yJsZsdrSw+Tbt
        58yZU8NK+vf23vbNXd7WcVp5pmnCrFslPxn5XHb3PMo8fKKuMyZ5blpcmX3FukXNb3XVtsw4
        4hEopsB+y1fTa7PF/wO/z/z0NT2lxFKckWioxVxUnAgAYpTLaCkDAAA=
X-CMS-MailID: 20231213185829uscas1p2fc3ee6a9c92bff3cc9a043a9ff93bd27
CMS-TYPE: 301P
X-CMS-RootMailID: 20231213185829uscas1p2fc3ee6a9c92bff3cc9a043a9ff93bd27
References: <CGME20231213185829uscas1p2fc3ee6a9c92bff3cc9a043a9ff93bd27@uscas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2FpdCB0byBjYWxsIGtvYmplY3RfdWV2ZW50KCkgdW50aWwgYWxsIG9mIHRoZSBhc3NvY2lhdGVk
IGNoYW5nZXMgYXJlIGRvbmUsCmluY2x1ZGluZyB1cGRhdGluZyB0aGUgbnVtX1ZGcyB2YWx1ZS4K
ClN1Z2dlc3RlZCBieTogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4KU2lnbmVk
LW9mZi1ieTogSmltIEhhcnJpcyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJz
L3BjaS9pb3YuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2lvdi5jIGIvZHJpdmVycy9wY2kv
aW92LmMKaW5kZXggMjVkYmU4NWM0MjE3Li4zYjc2OGUyMGM3YWIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcGNpL2lvdi5jCisrKyBiL2RyaXZlcnMvcGNpL2lvdi5jCkBAIC02ODMsOCArNjgzLDggQEAg
c3RhdGljIGludCBzcmlvdl9lbmFibGUoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IG5yX3ZpcnRm
bikKIAlpZiAocmMpCiAJCWdvdG8gZXJyX3BjaWJpb3M7CiAKLQlrb2JqZWN0X3VldmVudCgmZGV2
LT5kZXYua29iaiwgS09CSl9DSEFOR0UpOwogCWlvdi0+bnVtX1ZGcyA9IG5yX3ZpcnRmbjsKKwlr
b2JqZWN0X3VldmVudCgmZGV2LT5kZXYua29iaiwgS09CSl9DSEFOR0UpOwogCiAJcmV0dXJuIDA7
CiAKCg==
