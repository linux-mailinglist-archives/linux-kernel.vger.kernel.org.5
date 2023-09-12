Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4131D79C1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjILBtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjILBsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:48:50 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AAEFEDB4;
        Mon, 11 Sep 2023 18:22:17 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJX9rQ023869;
        Mon, 11 Sep 2023 17:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=CfEkBgQabMRtBdeslingvI6yV4TdULvLBl+f5HjfCt8=;
 b=Fz/VdEDiaq4eNwOUTNZ2Xn/yCHDV2PkD0uGZv0qamSMHDURzfMS9jCNVsMUhCcBI7wkc
 2c3SRQQaTI6kWNn+UIoRnpHFsCrFFgUOU6Inq7hFGld92Qtoqd1qOzwMxjwWCiuFL1p7
 b5fV89eKhrOk4TUVsveETVVVRT8f9qRCBEL5lU5RqnVBk7eT2S5RH4vcZyoVhf1SpMR3
 rYAxHY80hyRzbWdM/XIIddXF8EjcoCluP6zwurN1mhmdc4fcSoALxQK2uwrUPFWO62sR
 KUS59oh9OtSpK8+LFz3RQ8EtJypEjfTZjZajEGukckl/z+yZMiaeGUuvZ+nqrbYe7ici Cw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3t0qmvknc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 17:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1694477299; bh=CfEkBgQabMRtBdeslingvI6yV4TdULvLBl+f5HjfCt8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Tc03CJzApfOXet5oHQuMivNLBojKr36immpm7NZxOfynkPiswcNaNQoTIrWHQM8ZH
         YidB4XjvCrRiI8DZKGhuTYZsqFR2wauzpPm6rsygbnd6XmlGjr+s0QqCm9qi3FqSZh
         MyuweZK/Kbl7y4RrlmafhuwQUhxfP+yWqn/vO1LH6ADgwS/J9ItaaJ+oa3NEyP6N0r
         MDsqVn7CHyCl4/HlTIAxRpKioAIVpYyIjd/w+omotduSX5eD0+H0jarVXHp6E+1PkY
         jh37SN5/6lBUswX0nsu/rAs9y4Z2p0QqXoExSzovqItYrfaZ3p8U+JOEq+ZPzU2usd
         CLWGYTZM6E34g==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 649DF401C2;
        Tue, 12 Sep 2023 00:08:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1ED96A0071;
        Tue, 12 Sep 2023 00:08:16 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wZ82Ay6Z;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A70BE405DC;
        Tue, 12 Sep 2023 00:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVCUis7Xw2v6p9+DKH6roXlw2Q0bHDbDethYK6HspWMrWM0GH6jClAHFZbbr6kSvHXSuTmlW5dD4OfnBgsZ2zpMSw2JRnImGTS6TE/CeyTzDThOYngPCinhFIkn0vAlNrlZIv+N2YaZQhzF3WZ2V8tlC0HTzEgpOCME3miKLszl6FDae0aZZ3ZWmhPOy7ykXde0uTIQnJeDsLPBVW5S9lK+SN5MPLAvZr/f4f7JI1xol/PdV1Ea5cwrtjzAbjenQyYlACla+/FzNvLxBMa30d0nVRoPTlZKkXzIE/xfJDeswxrvi9C2OSM6JNScRsR6VveNR0xxnQqWNuIM0dyIN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfEkBgQabMRtBdeslingvI6yV4TdULvLBl+f5HjfCt8=;
 b=HzoMEzXTDaTrzWEHjqsO4MLrNEGw2jhsyJ4BY1k9O3nDrRvrOxTadihREUjbW807UVfcsiiii6TTBk3WSs9G2zho+16IbAdA+Hyjd9vc93b1OQnAwc0d4LbQUww/p1xPxxV9zsj8je1kawOJpnv1vqxd3dQVkP9WiWqH1KOAHAfb5A1X+xUybuBhIXdUEy4oakSSyblLoUiGCw3fKYscU6ULtjnaIfdguMvn2BfpEkO7IK5j7r/CBscgc7j1cdG783REaK8CNfi1XBqsTmwht31xRyv7JmeSLoqMbqZ8WCsWoBWcSDDAqWWDIm3+V8tkMdhEZC9l2TyJfUGE2bD0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfEkBgQabMRtBdeslingvI6yV4TdULvLBl+f5HjfCt8=;
 b=wZ82Ay6Z7qpiWLxyMwdP2llcP5eu917ySmFSDXeFFGS9j0swWFHDkJcJxng0Bbzvmf75SV7dLz4NivYNvp6pgM4U/mIvySu0mltgOMG0ZuC1YtLV1bIxPG+50plCP/jzAa2ORzACkVyA3ihY/NQXwo6M2LR6D3Nnkb1kiVyQZ2U=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 00:08:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 00:08:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     William Wu <william.wu@rock-chips.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "jianwei.zheng@rock-chips.com" <jianwei.zheng@rock-chips.com>,
        "yangbin@rock-chips.com" <yangbin@rock-chips.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Avoid resume dwc3 if already
 suspended in pm resume
Thread-Topic: [PATCH v2] usb: dwc3: core: Avoid resume dwc3 if already
 suspended in pm resume
Thread-Index: AQHZ5GBzz8QtSevZ6keCaFk9egZLiLAWUaMA
Date:   Tue, 12 Sep 2023 00:08:09 +0000
Message-ID: <20230912000802.nb5mk4e5toojyqis@synopsys.com>
References: <20230911033112.3321-1-william.wu@rock-chips.com>
In-Reply-To: <20230911033112.3321-1-william.wu@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB7979:EE_
x-ms-office365-filtering-correlation-id: 1df894b0-ca7c-43ab-a069-08dbb324592f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j4/fblLzXvKjEyUyfVBQjpwInSxiCAT5v5IIirV7fMXSdVO8KYIpyO3Ipr7QexVUctvljVSOe87Rxa3dPDEdj6Dl5ySStAfvCPlVkER6SE2M0xrHRivz14TXkSWsUCAFPibwoSQfC7caMmLXcL2156RQY9DY7ukedWUkiCkJDrL7kOcE7/eO9xuqzJf9oe04PbbI9d5qMetEQyRYzA4ERVrapvtpTo0dHE3vUTVfTQtIm4hAvwLClwOyhZp4SSgRblYRKvY4GS2+UlFXLi53OPPJKdk5XdxorvueysBKY9/BMXm2cGLgceeOVSY3GS4KJmQIo342sJBb5GQRPFEQ9ldinJCvwUDDrQXb5z3UGNElzEbjVMfwNqpAG0GVP6wluQFxEs1NaiuDcoNSn8kNLUWBwMQkfstKCcwejl+JcAhveT9D7J9dlmrgI5cr/eK9Ik5VkGkoXobwes4flH3d0yHl0RaKCecR7qDoq2xTovYx+dSfqRbZ0mdGnmG/eCoOKoZhjhjSeY7lBFOcdgz2O02gY1lVvhvHdU8lxKsY1kRZeN6fOt1AHUx5UAizNsuACP8jcSRz9wTilBUZ3J08bM5RP+FqCiNgoit92xTFjSOkHKaXR0IDO+E7dC0qr4j+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(1800799009)(451199024)(186009)(316002)(122000001)(6486002)(6506007)(71200400001)(36756003)(38070700005)(38100700002)(86362001)(26005)(2616005)(1076003)(15650500001)(2906002)(6512007)(83380400001)(478600001)(41300700001)(5660300002)(8676002)(4326008)(8936002)(64756008)(54906003)(66556008)(66476007)(6916009)(76116006)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXNML0VvSzBXK3ZuaFNKbzI0UHY2NndtQVJZZm8rUDI4K0FoV3pwYTN4K012?=
 =?utf-8?B?cmpsdkJiSDY3NmhMWlpwWU85cllZYjBsNG8rTWZEU0tuU3F0dzJmUXArQ2sv?=
 =?utf-8?B?SjJ1dWs2MW8vUGVFaURMdEMvTy9ST3lhSVJBZlZXWW5kcjVqWFFsVjV1TjhP?=
 =?utf-8?B?WjdyZHdicEFYMzBLclpPTUxnZWNOeG83V3VBVDlycWp5MEpJR2huOWFvQzNr?=
 =?utf-8?B?VEtNb0lXdEdOMFh0L2RLMXhKcmp4c2hLUS8yZFZMdzNxN1lTK2FIcjNtMXdy?=
 =?utf-8?B?RkZmZXMrN1pFSlUzZmFKM3Iwb09vQUdKUWhmdWRKU3FDd09iMkFTZ2RNN3Iv?=
 =?utf-8?B?UytQTi9jYjZjS1I2ZHN2dWFsSTBidE5kR0NTYjRtRTRZNU05TnpBWm0zOWg1?=
 =?utf-8?B?T3RnRU9QMWxBZ1pvdnVYTHkyOUJGdk1OSW5hQnM2b3RSY0d1YkxyV0VBclZE?=
 =?utf-8?B?UVpjMGxPeXYwWVJpK2N2K29pLzZhQU15RzZ3Y0VpK2RMdVJXclJiWVArLzlM?=
 =?utf-8?B?Y3djY0gyaFRlaGN1d1E5eDhIVXlhZE16d1VtTC84NXhjNTRpcy9pRWNrblpL?=
 =?utf-8?B?UFowZHRqU2pqTVg2dXp6VXBka0ZlOFBsSG1DV0pOK2hSZm04ZENFbFA0L1Ur?=
 =?utf-8?B?MDg0T1JKbmJLRGVhWG5JQ2NUeUJ1ZlRWYkpGeklYd0YvQjJzWk1MSFRkdlR5?=
 =?utf-8?B?R0NzclZJR0VSVE1RaUlkclc1bHg5L3NkREdFcmNQY04wS1pCYWRJU2dZQUZp?=
 =?utf-8?B?aU1ZbEtPeGRqOGZwdDVRQzE5VGdqYzVkZzBTT3dXYnB4MjhCZ085dW5mbjFC?=
 =?utf-8?B?bGlGNDRPbXlJWHdGUlV6ei9iVjZYeE5uN0ZVdjRNQy9nbi83blBjdWxwRll1?=
 =?utf-8?B?TGdrd2JGQk53SG00K3lTcGJ2K2h2K1RXamQ4QUhPQVdxejhQb1RFVldlcGJB?=
 =?utf-8?B?bTdGL2VQbXE1ZkgwS3JmOEc5TmdsV3FFVlpHc2xSb3UrQ0VQSEk2N09zTlly?=
 =?utf-8?B?UVhNV05QSUlIWHA5L3d5SFVpQ1FSeWoza2NRam1DNkl4ZExhYVVxRHlkMHEz?=
 =?utf-8?B?WE41VjFRai81dFAvbG9ZcXcxdmRVNnQ5aEhzSmE2bUVmRmVzeE9IOVo3bm1W?=
 =?utf-8?B?VkdkWUIyUnc1OXI3RXVhU1dwcGVLRjI1UmVvZ3Vtb3N3OFk2T2thSmowdk5i?=
 =?utf-8?B?YVk5ekVGTnhRSU9QMzRqWFMzcWg5RFU3UStlc2cwdUJYZzJoY3UwRnlCTjdQ?=
 =?utf-8?B?QUxrRlVldDlNeVQyZ0xOM3lrV2gycDZyMkdlMUNqbzNONXZSeXhFTVNNRmQ3?=
 =?utf-8?B?bjNWMm1pejJ1ang3dXVTMDhqNHpKMTFmdnJGT0ExQkVqMjlHNEdiS3VqSm1k?=
 =?utf-8?B?NVRZRmNVYlUzNTd2R1Q5eDY2bUkvT0xHUHBmaTRrQ3I3aGtnQnhVc3drQ3pZ?=
 =?utf-8?B?WHlkWVYwZW5nMUQvOWh0VkpXeEtMRGJ2cjduSHFpaW5sK0FaR0kycjljY0tR?=
 =?utf-8?B?cExXZW0vSFVsUjVaTEJUNWpnRWJDWE1vOGNPcEJDSUZkaTJobzZvRjZzeHYy?=
 =?utf-8?B?eW5IRzRXT2drT3RXTUptSElBUFBRT3pxYkhQcEhWT1pBbXFGelMxdUoyOGNa?=
 =?utf-8?B?VkJzMXRIQktGQUZxOUFpZXlDaEtvTVZUTms4cGlTK1JWN2YydzFMazNBVk42?=
 =?utf-8?B?WGFuNkxBWlpzZGVhNlFBZnovVnlhNHlCUUlNb3ZpQndwTUFQaEtLbkFYZGlN?=
 =?utf-8?B?MUtIbzY1VmtpQjdFQmZJSVNKYUc3SStCMmpIYitvZnpsUE5ENjI1MzVIWGFJ?=
 =?utf-8?B?ZGJna1Q1RnYvUDV4R29ZbkhGaWN3cytqTE5jOUFiek5iZ1BXMVU3N0w4TWd0?=
 =?utf-8?B?SHJEdW1Hd2NSU05tcC9Tclg4OVR5U1E5MG81SXI4OXNjbUJBVEVrakdoVElz?=
 =?utf-8?B?cGFCdmtHbVc0cjVZd3JTU09Hb0VDY0xXeVJiWUdic3NCbW1PYzY0dXZlWXh6?=
 =?utf-8?B?Y3pKdmVHOVFEeXVnNnY0Y2RPT0ZNdmZZUGtiTlFWZlMwY2RlMUE4RFA2YUFH?=
 =?utf-8?B?U0FZQ2swaWdxTGp5bG5xZXJORDZOeEtmZk40RFR3T25uOGMyb1RjOUpyUzR2?=
 =?utf-8?Q?0stNabltVPSowonU3vmabn6lV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD342499F2F07E4EBDFD8981CE5CD58D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7xGzzd3i8RFp6zaa99Z78sC+HEatVJcdtTEmwERRG20K4eusdDao5c+de6CYLuR06ui5M4VoI+4BctCZ52SwKwK1FtNHoOpQ3dATGjy/4kGX3I59f9XSwRObQaGFCa8ogUupysPAlSMkgrMMiDdQGawQuE+kyvJ/FSZtYG0eujKHDdpokdBqhmRvyhGDNvWmjQ70L6n3JkFunrf9wp+fkGrlxp6210BCcBtgN+cEELlLJPZcYpM+oi1l78T9nr99Px6LaxXkDWmSx+eMKON8Sme1fId/Y7eZTrNGgySD6/3mxiaXPs/mQPtuxfY79hjL9dPtqjmi/o0meESBstMBouuFwEwlev4u7bliqrB/74WwO0QpVOBwqArKDYB9fgLBXA834uaVcWxgEko1xW7c7p6zzeZuvPOLZTFjgp7tkp/6YdyW1rWuHysX0MujeThwSB3w9oYBzHQhmp/QKd6bBifIsuO3wP+aieD8FybkJTO3JVmEp0aOWjrMDclknCTX0p0VTLsph1EOMNSW8+3Ob4DvlQMMc5VvLopBiFfZgkUSvDB0rt8vt1mXuaVbKiv0XsoydAXd1XmUE9e6Vq87pntAKkVKSIsNLuNgUdUdN7TzAXt2UvvWjWq2nWSPppkl3x39NdThwNK6vr3vOklBXs2SGxagNIjS3gnruzXo+wQTtinrkEb9Nj3LhWRXrMiiVXy5tihO4Ms1UIlhrzqS2HGCw6l0NKB6Qit0AXfRZA5mURuufWKnShrhd/p1in5cJmP+qEJl7fkeFb5WMlJTqRIUIHdZvC1dQYraer/oFA+zrlA8LgnjXX8VQu4vLkCyyN9uKboN8kvGohMAgQqiIyIw7eePfExw3GSSS0xpjuPkvIkA7vEosXSEKbFmoslPoZ9x+1+2mP+1hbJTCnPtvw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df894b0-ca7c-43ab-a069-08dbb324592f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 00:08:09.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hOOfcclBLi1moRYokRLJrGCGntePyfPnEMJVUTCogpEvnQhEL9EZm5Q0mo38m2VHCqHv3ZdUDRvSbWrIDG8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979
X-Proofpoint-ORIG-GUID: KmengtwL7DbONf2sNFDJ_mW6whuOhHum
X-Proofpoint-GUID: KmengtwL7DbONf2sNFDJ_mW6whuOhHum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=402
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309110221
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgU2VwIDExLCAyMDIzLCBXaWxsaWFtIFd1IHdyb3RlOg0KPiBJZiB3ZSBl
bmFibGUgUE0gcnVudGltZSBhdXRvIHN1c3BlbmQgZm9yIGR3YzMgb24gcm9ja2NoaXANCj4gcGxh
dGZvcm1zIChlLmcuIFJLMzU2MiksIGl0IGFsbG93cyB0aGUgZHdjMyBjb250cm9sbGVyIHRvDQo+
IGVudGVyIHJ1bnRpbWUgc3VzcGVuZCBpZiB1c2IgY2FibGUgZGV0YWNoZWQgYW5kIHBvd2VyIG9m
Zg0KPiB0aGUgcG93ZXIgZG9tYWluIG9mIHRoZSBjb250cm9sbGVyLiBXaGVuIHN5c3RlbSByZXN1
bWUsIGlmDQo+IHRoZSBkd2MzIGFscmVhZHkgaW4gcnVudGltZSBzdXNwZW5kZWQsIGl0IFNob3Vs
ZG4ndCBhY2Nlc3MNCj4gdGhlIGR3YzMgcmVnaXN0ZXJzIGluIGR3YzNfcmVzdW1lKCkgYmVjYXVz
ZSBpdHMgcG93ZXIgZG9tYWluDQo+IG1heWJlIHBvd2VyIG9mZi4NCj4gDQo+IFRlc3Qgb24gUksz
NTYyIHRhYmxldCwgdGhpcyBwYXRjaCBjYW4gaGVscCB0byBhdm9pZCBrZXJuZWwNCj4gcGFuaWMg
d2hlbiBhY2Nlc3NpbmcgdGhlIGR3YzMgcmVnaXN0ZXJzIGluIGR3YzNfcmVzdW1lKCkgaWYNCj4g
dGhlIGR3YzMgaXMgaW4gcnVudGltZSBzdXNwZW5kZWQgYW5kIGl0J3MgcG93ZXIgZG9tYWluIGlz
DQo+IHBvd2VyIG9mZi4NCg0KVGhlIGNvbnRyb2xsZXIgc2hvdWxkIGJlIHdva2VuIHVwIGJlZm9y
ZSB0aGlzIHN0ZXAuIENhbiB5b3UgcHJvdmlkZSBtb3JlDQpkZXRhaWwgb24gd2hhdCBsZWQgdG8g
dGhpcz8NCg0KZS5nLiBzb21lIHF1ZXN0aW9uczoNCldobyBoYW5kbGVzIHRoZSB3YWtpbmcgdXAg
b2YgdGhlIGNvbnRyb2xsZXI/IElzIGl0IHRoZSBwaHkgZHJpdmVyPyBJcw0KdGhlIHBoeSBkcml2
ZXIgbm90IGRldGVjdGluZyBhIHJlc3VtZT8gT3IgZGlkIHRoZSByZXN1bWUgZmFpbD8gRG9lcyB0
aGlzDQpvY2N1ciBjb25zaXN0ZW50bHk/DQoNClRoYW5rcywNClRoaW5oDQoNCj4gDQo+IEtlcm5l
bCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBc3luY2hyb25vdXMgU0Vycm9yIEludGVycnVwdA0KPiBI
YXJkd2FyZSBuYW1lOiBSb2NrY2hpcCBSSzM1NjIgUks4MTcgVEFCTEVUIExQNCBCb2FyZCAoRFQp
DQo+IENhbGwgdHJhY2U6DQo+IGR1bXBfYmFja3RyYWNlLmNmaV9qdCsweDAvMHg4DQo+ICAgZHVt
cF9zdGFja19sdmwrMHhjMC8weDEzYw0KPiAgIHBhbmljKzB4MTc0LzB4NDY4DQo+ICAgYXJtNjRf
c2Vycm9yX3BhbmljKzB4MWIwLzB4MjAwDQo+ICAgZG9fc2Vycm9yKzB4MTg0LzB4MWU0DQo+ICAg
ZWwxX2Vycm9yKzB4OTQvMHgxMTgNCj4gICBlbDFfYWJvcnQrMHg0MC8weDY4DQo+ICAgZWwxX3N5
bmNfaGFuZGxlcisweDU4LzB4ODgNCj4gICBlbDFfc3luYysweDhjLzB4MTQwDQo+ICAgZHdjM19y
ZWFkbCsweDMwLzB4MWEwDQo+ICAgZHdjM19waHlfc2V0dXArMHgzOC8weDUxMA0KPiAgIGR3YzNf
Y29yZV9pbml0KzB4NjgvMHhjZDQNCj4gICBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKzB4MTBj
LzB4MjVjDQo+ICAgZHdjM19yZXN1bWVfY29tbW9uKzB4NDQvMHgzZDANCj4gICBkd2MzX3Jlc3Vt
ZSsweDVjLzB4YjgNCj4gICBkcG1fcnVuX2NhbGxiYWNrKzB4NzAvMHg0ODgNCj4gICBkZXZpY2Vf
cmVzdW1lKzB4MjUwLzB4MmY4DQo+ICAgZHBtX3Jlc3VtZSsweDI1OC8weDlkYw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogV2lsbGlhbSBXdSA8d2lsbGlhbS53dUByb2NrLWNoaXBzLmNvbT4NCj4gLS0t
DQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gUmVtb3ZlIENoYW5nZS1JZC4NCj4gDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyB8IDggKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCA5YzZiZjA1NGYx
NWQuLjgyNzRhNDRmMmQ2YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTIxODUsOSArMjE4NSwxMSBA
QCBzdGF0aWMgaW50IGR3YzNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIA0KPiAgCXBp
bmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRfc3RhdGUoZGV2KTsNCj4gIA0KPiAtCXJldCA9IGR3YzNf
cmVzdW1lX2NvbW1vbihkd2MsIFBNU0dfUkVTVU1FKTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlyZXR1
cm4gcmV0Ow0KPiArCWlmICghcG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYpKSB7DQo+ICsJ
CXJldCA9IGR3YzNfcmVzdW1lX2NvbW1vbihkd2MsIFBNU0dfUkVTVU1FKTsNCj4gKwkJaWYgKHJl
dCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiAgDQo+ICAJcG1fcnVudGltZV9kaXNhYmxl
KGRldik7DQo+ICAJcG1fcnVudGltZV9zZXRfYWN0aXZlKGRldik7DQo+IC0tIA0KPiAyLjE3LjEN
Cj4g
