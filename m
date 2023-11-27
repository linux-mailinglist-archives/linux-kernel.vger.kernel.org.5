Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099927F9ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjK0HKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjK0HJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:09:54 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954321FEA;
        Sun, 26 Nov 2023 23:09:08 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR5CZDP028254;
        Sun, 26 Nov 2023 23:08:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfptdkimsnps;
 bh=aZAlcwURkJ1haXGwj8JsRhEG0DYjhHg75DQeJmR+WHY=;
 b=EiXnCTTU1dsI5+4TNojq/cNG1q0b6rm0TQiKCxNxK7/YeB4rkLmoveLj2iuWq0J9+vJT
 GWSRJCembhE60oLzS2l2fl/YJx35SGUvjNtDCTujebQHDUAoZ5Ayy496/Z2Gw7ISy8BM
 bJN/VZbSqxQMEtM2k6l+0ZZkdjPxRTfngdKFu9RsDS9b1Eu9kAEAzMjZlkUJ4rZwUTyz
 ZZ+zdjs1hN0Hm/aIWBFbimM8UKQlemhm12fE5yMeUUvKN5Lup1bpOCMj6oU5EINL+zk1
 dHs7uQ1INCfyc/Cr6GrcLbFoi/7qR99HeTGKfMi9tQsZ8rJGyNySjtLUrWpDfLGtlnzD 2g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ukgqyc73d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Nov 2023 23:08:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701068908; bh=KEVkescMn4lW6FJW/7E3+HCsaRaIAJczmPmZgCh+Yhk=;
        h=From:To:CC:Subject:Date:From;
        b=C9uAnmqz57XxaNsi/jTaln866XnWfm1e2Y+nsHs5lOT88HfPbcwQitsUoAb0U/jtP
         A5bDENQQEAWs11qZpZeGC0ybf/s7Rq9Z4DL2CyLSkHolJPaqr2fOsAKHd9WjDVBq2w
         ZfEJmEPUicjueaOR777NKqDpDPUxU2xpt2UU8+1mZ2RyX2judpgoaX/8TtXVadbZFJ
         MgSI8J2N8OcJRseYeQ6hkJdUaugOQzaPoZIRHi51hg3wIgtYV2CyXRBvwmDQ60CRom
         4th6rrjqOh8TOPK5Xhm4c3MBCDQYu8t+B0vY7p6akJtNlix184Nab2hL7Z33wQxo6U
         z7h0S+sTY3UPQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5F9C14041D;
        Mon, 27 Nov 2023 07:08:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 08C5CA00B4;
        Mon, 27 Nov 2023 07:08:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Gx9m0HIg;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2B6C94011F;
        Mon, 27 Nov 2023 07:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPZ54ddVb/wy21bwHa3TLrGqU/LulUQqo3+oKoelHd9K4tL2Us2eZIk4SCs9eN/ymaco7HNf8wyn9iVMC2FcZV/PasdCuWH+c6+EMLA1E4Si2OeF2sitRjxmnnh8gtdpRWqsvMJ6PyZ/KYmx2XHoGX4egIuKKyYzoMHLfNdTepGa9RAai/BhWzYLaaq7I69c215ompk7z/YVJ0cMq/jGyXZHqJeW9wiXZLP9jqeHNDcU6z1Zo4VPLWKL4+YDjsq3g9gk+7wD95HW/+H+hvKq34+cKi2DAabldd3Us9W7FYAnCoYcMxKGxLT3KmFJ7PUq3WTOxq/KlBIeUysnWY+ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZAlcwURkJ1haXGwj8JsRhEG0DYjhHg75DQeJmR+WHY=;
 b=Jpn44rfvUpBdgOIUmOXMd+7Xxote0lmg2Zcqm//aJ2sbCTFYmAEZtqN0zGldlyIPpgUSIx65wJy6nIMTsRrDhUuqQZt6zjYxcv3c6Hqc2Jl6cToARXSKAJ8yWiah9nRuR1efELgq37y9TWRC0mVuFinImPOZ3h1/b27XQv+i4nz4k+7qlIJIiTPKo/J3+wng4q6lweymtcSv/eCx1QVYKADHLrLMhhjPU0MOurx+OIznY0rOsfwI1o19zJGWyPCflIWGTpxAbXTHUDpt1Q+5wy/ZuTJ4jY/Bgz0ubVM+dOt9CemJHXTA+9FfFt0Z5muqIJTvMDl4SGs8MUSOyV0Utg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZAlcwURkJ1haXGwj8JsRhEG0DYjhHg75DQeJmR+WHY=;
 b=Gx9m0HIgzwKmwO+RPQg1KdbOGvOem/N6E73Y1DR+fBum0Mi0MkHiLoGu0kSlzTQuH8WCqwVFPxFewXU97LRXdYDxThI6LWxCSKbgZkZGlpQ0oKXVojIwlohdMi6OFBF7C9uvMY/7frmAHvZlyDVZ44LEnzarPHCaaC6Frj0FitU=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 07:08:17 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 07:08:17 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>
CC:     "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Martin McKenny <Martin.McKenny@synopsys.com>,
        James Li <James.Li1@synopsys.com>
Subject: [PATCH v2] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH v2] net: stmmac: fix FPE events losing
Thread-Index: AdohAAc1mE7NHpFkT9GQaksVD24B5A==
Date:   Mon, 27 Nov 2023 07:08:17 +0000
Message-ID: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|IA0PR12MB7601:EE_
x-ms-office365-filtering-correlation-id: 517d2f4f-3a1d-4ac1-bd47-08dbef17a14d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQqZ/Zy2PPiZzdewT/I3XEI3mNcQjVl3Ibqjo3DLyfV+QYdb3pX7GDqbewllEKR2gXHuClXxhU1Nq8LFqpzDAb0rz6HRCkwXGUFJBPRWCJk3ZOWc+CEz1uLcsXW/dizcqBtA/uWMVjoroy0Dbjo3FXkdjg4Ti4kCMqex9uQ+t4zQptDaWs6gesx5wYi9sXQVo+X+31rW78q6zGkEBSy5Zy8w8q7COhTg+33vIWutHVhZAXf9z0RghE3PE4rlybc0hfxbSG1RWubjgiaZmSdITulMOlsRB4W3pcFrrK5oHdwoH41X7Uqo6eHMhkBB6kqbBNuz/AhIImdQ17llgsjZsT9NZz6YLgiLRtrbOtFrlQqSUE8bbbZrZAuj16CSxNd/sRIHgmstCiqHU6H8yZ8KLSlJfzoMUjl9hGbMRITEmWwNlh9uGRBZFaZ8+CH9nDgYX/CneIIYVXRDOTvNDE/SvUBQ/uJH2hneQKFQMW1bHtl1BfbHOusuErKXkaDqP4lRqV+qOlCgp8WLGa50pN5gZcRpBlYyJJuOCceT4TZoNOgYJgh7BPGPvj1ZgZwI2tNemuTkeSPLoLLdMOXtVnVuBKs/BzFTaxABty0GIUVry/OX6bK1aoTiC/JPh6YaN10RcsMVNNmRHPEvu2UghfWQog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(33656002)(921008)(38070700009)(122000001)(2906002)(55016003)(83380400001)(7416002)(5660300002)(26005)(86362001)(107886003)(9686003)(6506007)(7696005)(52536014)(4326008)(8676002)(8936002)(71200400001)(478600001)(76116006)(66946007)(110136005)(66446008)(316002)(66476007)(66556008)(54906003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Giu4SpBwIfvh7Embua1yieCORceQfsPle++a6gCZr5pmB5B6cYBf2rS175NF?=
 =?us-ascii?Q?dSnRAGBjGfASe8JxreQ+MVrcNJEj1T0F5nq7NvFoac42g64iL6/RQdbsD3zj?=
 =?us-ascii?Q?cryCEb/cfvQa/f2p+oNgxbxI+jbQzGA28iQIQzRfs1CkA9xspJGDC28G4GhK?=
 =?us-ascii?Q?X+962I7LG+CbxoU+IsAl/QesbFsLi5u2jFcRyMNxjNifAsJjl5Rcv6HV/vUm?=
 =?us-ascii?Q?6dtmejeLYHXPFNBukvFAPRsI8B9+pI53PVvhxVh0dF6Ezjttj45vr2l7U6xp?=
 =?us-ascii?Q?LMXESmZq3wyOq/Bjb8TTgHjN8hGFIlebHT6WsJEBTU5ShN0o5/TmCE60GIQW?=
 =?us-ascii?Q?ZX1qnJBNj7TFX2QuzoY/cI/42ma8RSA+bbeE6/UmrgmzrdqYtZlxMUWtaN3E?=
 =?us-ascii?Q?20eglhjSTof/ZkkElRlTQhOviS+0g40hyOna99+XlQOETxF0G1BxKfNtx/7T?=
 =?us-ascii?Q?3EkD6oKMd4gWnWcuulgN4Cj1nvZIs9XF6TCo/7vZj6sWvjf9ycpRtTtN4CK0?=
 =?us-ascii?Q?tDxu89sLMyT1dEsAlYpzEh+A/LwFX31a+z//j1gzzYeqfwZ1ZfwnvWMcOeWJ?=
 =?us-ascii?Q?jStrjCU4XFZqO++88JT0WRIrXfbvjbMLc8OK2wZezxRFQL2ZFUU/c16EwfUK?=
 =?us-ascii?Q?LY0qT0BhTR9kNL1AOtn7uwjUJE7Ry4VdZnpzti6BpiUcJHKZF9Agwp7oMsLu?=
 =?us-ascii?Q?PPMjjlWzvR00MYRr59JlE5Lj2MhHoUmk2YhDBwwH8YAtWRIAVDUiuR9FUI2M?=
 =?us-ascii?Q?vsiQeR3VU3MSTvfw/mR8NEaDNQUL6FarBGTHrqN/xJGP3Kou33rZ1Qn6xTTB?=
 =?us-ascii?Q?SVtYbtbFjsrkaNmVntD9fnICXUPw3IWXz5OfJdmhdqBXWARu3X6X+b8a6Ejt?=
 =?us-ascii?Q?hj4E8OEqoU4kCZeLS+lCPd+t6LvywX7rst0nCRoezDFBnYoZSsUUh+/mkolQ?=
 =?us-ascii?Q?U3Rh+qQXOnTMn5IgutbQZjTeVwyXxwAQ70n70tLrgP2W4HpLpJOtDd0+84g+?=
 =?us-ascii?Q?584C0jb/jqK25zaS0odwoDcbnsf+3T+BkHCHJnAHftwMyy4eBrpB4Gt1MvTy?=
 =?us-ascii?Q?ljkizU5AHqO9SXIJmkgChl7LPG8fPASW3MkS9xdi5OHk6zKC/qV/wQ0YizKu?=
 =?us-ascii?Q?8c0li27c2LR9gV95k3Bv0HYXF0GO08LxphRRoybjkQ/uprFHeo+oU/wQWeiB?=
 =?us-ascii?Q?uclu+GMzAG0vWgsGIAw22pzm+vbLdPnW0nvNcZfauKEMLXf9KvUcT1ns9SmF?=
 =?us-ascii?Q?9ZP0wzJKav9QAzVQtlsdPTfZtY80Fmi1Y48x+PQ34XEtPD2FHFi8XAiygjNB?=
 =?us-ascii?Q?DTHaGBESDyMkdjssF5r3LBHXzmkYmS/UwaloLzlZlTFDOnieUAfg8ck9MjWU?=
 =?us-ascii?Q?gGdf2YItSvCpMwu9Y+ISPjUoF1HDSGn2Zjn+OeF0gyAg3a6WorZ6xzhFXG65?=
 =?us-ascii?Q?vNlLGvrMwuqayxuSpJDVcDwWhgMdPvER6bNB0vDfqAaNgP16P1Sig1ApEfvi?=
 =?us-ascii?Q?u7wjoCmT3NrVjRMHpoPwa54MshwDeiwr5g8OhGy/PVXnHXVlBpgEl9m5SLOV?=
 =?us-ascii?Q?dpeOMMjpRzi9O1k+Atr04pTth6TSlbExJjVa/YRs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tfx1BISf+Vk40vmIStvhwOaiXWPZVg6k71fKWsomUvjiCUdCJ/ETGP62G8on?=
 =?us-ascii?Q?SXIBjvZQ8NnRCIFJeu1YejV0946plz9dhOYflx0xx7ADYH31lt7EMZyvg9G5?=
 =?us-ascii?Q?qZUwK/9IWCPdDCbemdfktEO1S4OnGUoaXA7PCpMbDwIbIpnvCQ+Epo3CUjt4?=
 =?us-ascii?Q?Y/JbDK7vSU5x8x/ksEnVggFJYh0AkHMxryV56pDnrhXMEMK2uVDiAOzWIVRE?=
 =?us-ascii?Q?aje1YRpnK/tpDm78/6SpANr/W7EXDkGCaV61wZvR0rclioHhfo9SmQ/Gg/L6?=
 =?us-ascii?Q?SYt/wNLegzTho9L0JEow4WK/stc9DMZywxcjTl5XaFVdQzTLwtQSOFEl1agv?=
 =?us-ascii?Q?a+0FpNsf1plZ/Er4do2qNLJ8OSDQL7E/drgOyBMVVx0cjWyaNGoLWthdw1rp?=
 =?us-ascii?Q?UHhw8kK6fVzgYPSqLZWH4dbH5Sg/YPiGhobTSZ31wSTE4pDVQcZOO9R0oC05?=
 =?us-ascii?Q?lqvmVVJu4fdVjwXhlFtiIQDmN/vb24bPIbibC6GfTjo1s6WZ1f7IDJgEJAPQ?=
 =?us-ascii?Q?DBvFxkcwcmXRp4nicbWM9nq098e4KzbzVg8+d3mQq2G3jWKFKj6wWKTU8Tqv?=
 =?us-ascii?Q?b46PKnETDiirUXUIY9E598joRnXHpVIeq0XtI605yhU2yLwJwyMUCewA6xHa?=
 =?us-ascii?Q?/Ol5cNR/bUjz9r3CCJCzrYzr13k9u380UnhtnfrXyA22LOcTbROr7YIAyg7/?=
 =?us-ascii?Q?aLgRTzphLphl6uadCrK+YPT1tFpOgJJE5Nhy2XepC22C6HGH2CwegecJETgc?=
 =?us-ascii?Q?JzGUqK9JXDNwQkoI61cp7+E55dGk+iJBJ0NO/CI88SILdrN17IwcMwg6HiaR?=
 =?us-ascii?Q?VMamdCtowuat2hPBbtjPgsD5HU1caNsaUK7tbIJHGbK2YRSRnWpXVNasMMMf?=
 =?us-ascii?Q?eBnoOrUncDd0+yJWeK+Jixpyq6GLY8m2R+TyUXCRF88Ht39EA+tluqDHlWCM?=
 =?us-ascii?Q?2vwV9XC1x/pOwH4zep5a2qe45AaFCdTrWfujgfe60eWwYOGN+/lErE5lR2T2?=
 =?us-ascii?Q?S+uS2SMlu82NxqFS/ch7cOoKLQcg1L98jr+7thdaZ4Slj/IYUApzJ9FDWHqS?=
 =?us-ascii?Q?kpZkuPR7b7g2pq9mUdfk4+iuuuJieSZq4Th0NAY68dKQ0oC/PFoWZbxbm9tH?=
 =?us-ascii?Q?IM5SbFgEuTlt/vuKV0HMwN4zVoz79X3r+j4aW2j8mkYu+/eieCZkN9Fuzib4?=
 =?us-ascii?Q?6WHp1SDhDySL18V/govdyi6TfhtBHljQoSY5sVr1LjVFYsXUrVdMMIRUfLtW?=
 =?us-ascii?Q?ljEi26OWotcA0L3dWLJj9TvUSURkHurx5n0bfYWgWxdeMhTuqjKPMxkGB0L5?=
 =?us-ascii?Q?WRjpH/tt2X1G9fvuVEMTtrlGpWnIHcXpQ4sWuHpfuN4xug=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517d2f4f-3a1d-4ac1-bd47-08dbef17a14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 07:08:17.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TT41qQhn16lhd8VTjFyoXA7bJEbyiQNEgeH2CRAIFSL6RaxfTQhNQjTxuzjE+I4WEKTLbwoYOjXxKZl9Z/yzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
X-Proofpoint-ORIG-GUID: gPdS5GxBVMPmhcb51Xk3o9EJ-zgFMJDv
X-Proofpoint-GUID: gPdS5GxBVMPmhcb51Xk3o9EJ-zgFMJDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 bulkscore=0 mlxlogscore=825 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 phishscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270048
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
handler missing FPE event status and leads to FPE handshaking failure and
retries.
To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
MAC_FPE_CTRL_STS in those methods.

Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking pr=
ocedure")
Signed-off-by: jianheng <jianheng@synopsys.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++---------=
----
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
 include/linux/stmmac.h                             |  1 +
 7 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.c
index e95d35f..8fd1675 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, stru=
ct net_device *dev,
 	}
 }
=20
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable)
 {
 	u32 value;
=20
-	if (!enable) {
-		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-
-		value &=3D ~EFPE;
-
-		writel(value, ioaddr + MAC_FPE_CTRL_STS);
-		return;
+	if (enable) {
+		cfg->fpe_csr =3D EFPE;
+		value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
+		value &=3D ~GMAC_RXQCTRL_FPRQ;
+		value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr =3D 0;
 	}
-
-	value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
-	value &=3D ~GMAC_RXQCTRL_FPRQ;
-	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-	writel(value, ioaddr + GMAC_RXQ_CTRL1);
-
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-	value |=3D EFPE;
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
 }
=20
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct =
net_device *dev)
=20
 	status =3D FPE_EVENT_UNKNOWN;
=20
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
 	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
=20
 	if (value & TRSP) {
@@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struc=
t net_device *dev)
 	return status;
 }
=20
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_typ=
e type)
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *=
cfg,
+			     enum stmmac_mpacket_type type)
 {
-	u32 value;
+	u32 value =3D cfg->fpe_csr;
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (type =3D=3D MPACKET_VERIFY) {
-		value &=3D ~SRSP;
+	if (type =3D=3D MPACKET_VERIFY)
 		value |=3D SVER;
-	} else {
-		value &=3D ~SVER;
+	else if (type =3D=3D MPACKET_RESPONSE)
 		value |=3D SRSP;
-	}
=20
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.h
index 53c138d..34e6207 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct =
stmmac_est *cfg,
 			 unsigned int ptp_rate);
 void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/=
net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 453e88b..a74e71d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioadd=
r, struct stmmac_est *cfg,
 	return 0;
 }
=20
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
+static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe=
_cfg *cfg,
+				   u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ether=
net/stmicro/stmmac/hwif.h
index b95d3e1..68aa2d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -412,9 +412,11 @@ struct stmmac_ops {
 			     unsigned int ptp_rate);
 	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
 			       struct stmmac_extra_stats *x, u32 txqcnt);
-	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			      u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd5..7791e9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_=
priv *priv, bool is_up)
 	bool *hs_enable =3D &fpe_cfg->hs_enable;
=20
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
 	} else {
 		*lo_state =3D FPE_STATE_OFF;
 		*lp_state =3D FPE_STATE_OFF;
@@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_pri=
v *priv, int status)
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_RESPONSE);
 	}
=20
@@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 		if (*lo_state =3D=3D FPE_STATE_ENTERING_ON &&
 		    *lp_state =3D=3D FPE_STATE_ENTERING_ON) {
 			stmmac_fpe_configure(priv, priv->ioaddr,
+					     fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
 					     *enable);
@@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, b=
ool enable)
 	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
@@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
 		stmmac_fpe_configure(priv, priv->ioaddr,
+				     priv->plat->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/=
ethernet/stmicro/stmmac/stmmac_tc.c
index ac41ef4..6ad3e0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
=20
 	priv->plat->fpe_cfg->enable =3D false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
+			     priv->plat->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 0b4658a..dee5ad6 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 };
=20
 struct stmmac_safety_feature_cfg {
--=20
1.8.3.1

