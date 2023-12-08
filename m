Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCED809CD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjLHHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjLHHD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:03:26 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E019A7;
        Thu,  7 Dec 2023 23:03:23 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84e9dH000405;
        Thu, 7 Dec 2023 23:02:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfptdkimsnps;
 bh=GCUPjS1VqgbHnMzqFnjW1WHIrQD7Gu359JVwxTSmUHk=;
 b=N/GnZSsG7Zi1g3GZtNK6viUhTLmAfyCmDPVSoeD46Cq3ZneNUHIDK+CE4wqu2GpHuuwY
 aiKasgK4U0PU2YJbABdAI4A4ABUkXmMURI0KXVLPBuK+SMQQuNZtdtUryLyYUOTc/vjt
 y25rzwDICgThbvZbhj1lUhkE2iSrIsZGY6qpSIE+97C4HoVJVFI/3s+AbUBMmr4U+XwI
 O+aJaThMql9JIEyjJAfcGpzHV/7I8yuSnt7jUFxIuDqThlU2EAu//TZNT0QQlQKv4dDs
 mNu46GQCJ79AX7fuM/CFF72+sfKx9snCPnnvQ12AsbCJLU5slH+4E3kgIxpvinOE58AW oA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3utd285wtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 23:02:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702018951; bh=Q4/tkdqI482NK6gS4tT/p4AF+h5zAvqVd1hOcSXgqV0=;
        h=From:To:CC:Subject:Date:From;
        b=Ana2HGosPNpuUADY2Gf25sfjwd0uL94P4fNzFDnK/8kTy0Lr8HxAQrFkdANZtsQjQ
         PNqMu1MSYOnFy/utArAG5Qp+2St2WI+uBmUVyTziqbGFpv73wBO3U2TDZJqfIm6ac+
         zeGTxkEfd0Fhy9f5zuwCmMvcnte8mssQFMrpDFu/eh0rs4/w6fgs6wk0Qm0tnGg2L4
         25EUEeBj3HrNkR8YWU0B8/2wHZ9B1odXkSqEGQqQG2pCTmwucWrT3pgjiupyJtCbgg
         on/RFB/GdkB3cbNx6Ts8nwYAwcX8bS1E241T//qtR3gfo5qeLN6ET+wKsLbk/kRYzU
         WcbIgb0jlJjIg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C4C8D4011F;
        Fri,  8 Dec 2023 07:02:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 544B4A0091;
        Fri,  8 Dec 2023 07:02:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jxksWs07;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EDAED4044C;
        Fri,  8 Dec 2023 07:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZQYjP1t3CkIyo3aesIaxEj3rl7lQEiAFR+pRnVnqAvrB2wXPc/ls2HXedRBKMvrYIFbmiZnhnITA9/OxIDumLpcKDbY/XZ51AuIyZDqSSDsN/W72YL2ibVq7AFJHRRjgxSAR4KZo1kxgk6PHWn++xLACP+E0MM80RFJQBJXkl9zPC8uPN31YS36vc1njIdHv7v0Y2OqrwDC6gCrIRtxFdC4BFAiSh4Lmc3h1B+Z5teiBnJZ3ZoDlS9UtKaCpt+zxx5PA5wG1mnekZTtR2mVTMRnbBHyyIsKTXD2misfq4TepAMnxulYAl9+UGggd6n2jHlX9PRHyNBAAOVpnpaysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCUPjS1VqgbHnMzqFnjW1WHIrQD7Gu359JVwxTSmUHk=;
 b=CILvoun9ROiIjJBSR0hcRFzpX9MbRJhwRVG9ze6LlElzsnXxSjPOG5YCrm8nLjKz3Oywl24XoyI1Pu+9WW9/ZuiMI4zTXauV7w8r3JOWRzevQrPNSc2bO6r9IEQQcRvRAHMVJ+Y5X7lxXLe6mSbURKDcQSxZFqyj1rFnmBvn7I0yuykNSFd6GYKRAnmWlsL43I0RR8eJj9EGQqENNoeB+iEuwMD+XTAQsLFrqXKKww0m+VN+bpMbLo89zyLTio7Rco6pOSeskvz5SEaAv97OPW+2IQzSnwxwIE7odJFWyZUQsFhtLRTgRslrxE5WS/gy1i60xjOT5PubQFG01bpyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCUPjS1VqgbHnMzqFnjW1WHIrQD7Gu359JVwxTSmUHk=;
 b=jxksWs07ItJnwAVqwkUwZtLdNUIHMCfzstFYAX1YzFxdQlIIl9GQwDYyDreoZRH7I4b5Y6uvOp5NJYtfbj1lGElZT9sNmkMNBIo9qNEgr8nbVSs8eM4lXBnp+at8Zuf0dMEx1cq1ozoDpGH6L/rCQ6hIaXLXXKdFJu4clEuVkYs=
Received: from SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 07:02:20 +0000
Received: from SA0PR12MB4413.namprd12.prod.outlook.com
 ([fe80::12ba:707d:284:a4de]) by SA0PR12MB4413.namprd12.prod.outlook.com
 ([fe80::12ba:707d:284:a4de%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 07:02:19 +0000
X-SNPS-Relay: synopsys.com
From:   Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>
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
        Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>
CC:     "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree parsing
Thread-Topic: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree
 parsing
Thread-Index: AdopoV2G4U4p6KhERnimGhWz15Hefg==
Date:   Fri, 8 Dec 2023 07:02:19 +0000
Message-ID: <SA0PR12MB44138E48A245378CF54D2F9ED98AA@SA0PR12MB4413.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamlhbWFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iODkwZTc2NC05NTk3LTExZWUtYmFhMi1jYzk2ZTViMjczMGNcYW1lLXRlc3RcYjg5MGU3NjUtOTU5Ny0xMWVlLWJhYTItY2M5NmU1YjI3MzBjYm9keS50eHQiIHN6PSI0OTMyIiB0PSIxMzM0NjQ5MjUzNzU0MjAyNTgiIGg9IlVDQzBod0ROR2R4OGhCUDNQeVRSeVBqOU9Fbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4413:EE_|CH3PR12MB8851:EE_
x-ms-office365-filtering-correlation-id: 6673443e-a292-40b9-9e42-08dbf7bb9eb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y20D+8KzdaITNjK2foqsuKMruj+1svP0yqSNDtS648uLtk2xBq5XWvUamCv6vABFIjm3nq4iYN8agMUMrhiQnOWNiHexmOIlZ2No36tCXXAy34iqbvTj7h49uv4iI3nl0AH7IQ2jxCgVf5UM0c5dO2791Z0Br0UmeUI0dCRntI052zb1L/xOmXGsnNanMFAgPd9heTu9xFX5OJxwIImyd0KKE7imzthBd8M+eKBnNUFKNE2sEO8u+6ReyJ7ifgdQIcc+B7bM3/EwwenCb9e8jxv7vAqGZRLNf/5dDp9vrX4DwGVTrQDxkJircBDBzfKcIaUuVfs2YmEAE5xTGIBYoMusnGmzltoj1cPaVvnz9BIB/QePQoWADeRVmgK4qx+L+9yL210GYHN4F8UvpedZzCrE6hA7jftzFAU1ptcC6zGdnBMNl7LrOkuaJVr5q6UjBuvxmFL7zufXL4uuIyGzlGdX2/sJ5je7XQeIoP56J3+T+Iw1Jz/kEVuVbvdySdTT5Pu66vAIhx4tRufq9oorvfxNxr43C84bubmmBtOM/ft6b62/jj0C6IecYocy2l1iu1M4ikSM3X5e+Xfdbdx/gT/Wzy+mROU1NFM2sFXiL2G/qNBe0PPFazmEom5au9+CTs1jSQVFLfiC7rWt/nH/rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(33656002)(921008)(38070700009)(7696005)(107886003)(7416002)(478600001)(26005)(71200400001)(6506007)(86362001)(2906002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(4326008)(8676002)(8936002)(52536014)(9686003)(316002)(83380400001)(122000001)(38100700002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kPygtv7u6zRw4l4RVO7jmubN0tmuLc3CzjhEHLlue2EB3iHqV3xb2gE5+YQo?=
 =?us-ascii?Q?VApwC9OTqPuWE85W4eGjdTb2B4QwsJbNISshPig+u8jOAspji3nZDgnymH1l?=
 =?us-ascii?Q?kgTzgzkP0Gol82a5Onq7Ia94IuF0zRHsKqySqslg5EDoNEXUqSmsA0ktdvwz?=
 =?us-ascii?Q?dkkRluOz9bPHquf4AmtLR/mwhIJln18Lxkw/27SgL2QGKImG99zyXOLDfKxB?=
 =?us-ascii?Q?O2vxCF30cJctBp9dAwL7RkHdPuqcs4ptRvlelpAbubkr60IKVzUh38UQk/UT?=
 =?us-ascii?Q?MpEyiqVTCkYnjx+sygAqeNILbsV00FfERuQ2sS48aABgqF6O7KFmtRzO0mc5?=
 =?us-ascii?Q?y8pLzcNXZJ2HRqOzDsixUsxtYmoaicFufHx2D8/9521m2/WZZWDJGJnINi9K?=
 =?us-ascii?Q?RGoAskJ9xYr7GUgTuUDBdKMuR4LQsznBS3N7ThVzEv9Fqh+GUTJEJgzlRNZj?=
 =?us-ascii?Q?f1GuNwOgMgtFMBkEPSNzeYegPf5PnAjQdfMcrAVY/oZ0PaPz8meeEER3S268?=
 =?us-ascii?Q?7d/9U0Rco3fIFg18yq5ePqYJA7e+vxAziAt2Su4s1GhogOm5Ju38acUI/V54?=
 =?us-ascii?Q?Xc5cQR2nU6HhteJ24+wttJhTsarNDVeWP1NI+BVl2DBZ+/yrYaJOKWJ7NnBB?=
 =?us-ascii?Q?B6LGKFecuq3QQRWogMs53W5eitr+Vngd6vyzE/HaZNlgcOxRYF3SvrkkHuGf?=
 =?us-ascii?Q?AMQn+3ZgIaGGfVyjQagWnZirzWEVl9MMenoz8WHcGeeDbqXahg5rasrwsrhI?=
 =?us-ascii?Q?ANQRuSIy9WJfGGmhYWcZ8jI6ZGwiEFfYBTtTrqr9f7jc3EBHKtgDmqNDbu0m?=
 =?us-ascii?Q?9UqmfGDPIhriRoabWPMacTxFEyhrxtclf5qJEM/Ptqm649ZPsKtIajFW/III?=
 =?us-ascii?Q?4bUODPo925D4XoXA2JNem7HRZzFchrvd9t45xJz3NCuAeMGxqb1KhX3SVdm2?=
 =?us-ascii?Q?TJ5ywau/dsGUYkawdP3ax6mdb036h6pYnCYjkFIhesXERH08U4MR8mRyn1kt?=
 =?us-ascii?Q?4burDkk0EcNjNKbl2E0kxelRCFJ4g1mUNnkf22g7iBtseUUtXxD/NeFwkNsJ?=
 =?us-ascii?Q?p/YDCVduMWTpFjGEIBfjWnKX4mB0Pt7hz3Uv1Su71+U8vUX5ZUyDCLtJiv3L?=
 =?us-ascii?Q?CwLiCUVSWM/KjMN4Mq8tK3XiwL6GAw2RMKAAyBhWm0snshNNf1J9pL2tsyAR?=
 =?us-ascii?Q?b3JORizQux33g7NYpivKPll5QA/fs4kfCad8dVwMJGvuyInwj27JlvKnDFQM?=
 =?us-ascii?Q?YJWRrETKLrfgU2EBl/YWteaal2fq13hGc6EA3ZorT9PWSrGNTkgoxkA5UPYX?=
 =?us-ascii?Q?Rd9JrnIWTiuJRQZPFor8GgZXCWa6UFMBxvL2GZ3WOYaR+0jR64i8wT2WSZT3?=
 =?us-ascii?Q?HFML0NCN4wZ+D88XdDJcnQwQ9TydxojrbwAbUXtr/gw0Rxqh08r/n/dkV+cc?=
 =?us-ascii?Q?77t2cYZVO5WhnivbRXeUlVSub1twRYAyk+5WwvQnWYxZz5a0bEiJVi+BQsAw?=
 =?us-ascii?Q?oN+KePuTIdsdp+tKd86EdGIot7vNlghR7rXbkhFCmaJiyxU+I6Lh0IXPkisS?=
 =?us-ascii?Q?TSgEvFPHesA/kXWP5BU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gjrmHc8NwC0Pb8SWPMgB1GIQMLR7iDzHt/I0kV4TNRpfujAo+MUniGHbpa3W?=
 =?us-ascii?Q?NPHdXJbqfBDX7RFtcr/UKEeaAbQGsV2kBtfZlp0yBUFQ/r+9FhSuVJnWaEHw?=
 =?us-ascii?Q?5ni+fiS9yJ1cl45P1j4CLmkbgT6VXqeFmoQgoYhgBL7xTkQw9n8Xko5erlLK?=
 =?us-ascii?Q?qRHKpjdEa4m38+MixnmfttT9RsaBjkEGnGhJfZ5cppI4SfYdd58v7+xKEQxK?=
 =?us-ascii?Q?1iMagPoeB8MTQuGbdUQbjBqT7pSvxrl7AwMbIzIW9Ebu0/HUOQ/xj4LgplHY?=
 =?us-ascii?Q?sqDr6sp+WQ4oF85b8Ej7XU698AwXjvjeIH0fZRMvMhZkVdAibbNUxzRbqliE?=
 =?us-ascii?Q?aWtFUG7cP6b/ejcO90zUzDhnobvgjBiscxAL2mduR3EQG0vpOxTbQbb3gk85?=
 =?us-ascii?Q?oqT2XY2GgH88Xr/luOFYFQ+a0heppAp9nRbrZqcHJBhUGpfaQfHs9yfl/bbO?=
 =?us-ascii?Q?YKHYQhybNdaU+mXl/I2VPqedUA56uPq6/Qo3qw3uD7yeces/+ZnzkT9C4N70?=
 =?us-ascii?Q?gqwvXj/pQLGSkt0Nd886W9u2n5ftv54FHi/rxKJCYoehgQnqLdMccQMTSns1?=
 =?us-ascii?Q?3vNqgvaX/NVAk8fyX7gwps8Iu8pSUZ5PButE9GNJOICrtJHCaSz75N4F2Sxw?=
 =?us-ascii?Q?Hle7TRivZUcoXog9snumn9wjBEOWiOrOPiQZOVdrjJyp8hZyBPZO17234pK0?=
 =?us-ascii?Q?FDFL+i9GjoxvFvgy9dlRS8unmSvQ3pIimSFtQUU+mf/6x9kmjJ3z+8z1byoI?=
 =?us-ascii?Q?x9mq3o1bcRvj1mFPEvgZFjgUG36Bk9grAFiGU1ekL0rrzWGeR+GiP5gZidM8?=
 =?us-ascii?Q?4EZDA1zJq/bsB/O6KI7EIOeQ42tKF/c2VvAZlGd/utTSNQp2HeIPWOBE31dL?=
 =?us-ascii?Q?lPlApAS5vtUtTknPxuM7TbkXNtI6vgyrg35dichx5E5DPgcF5Cy71y1LvoKY?=
 =?us-ascii?Q?Khh861xWShsp7l3D+a4NATKtUxXmZOUfcpAbidkp7+b+fOBBxr9PwkyFqFf2?=
 =?us-ascii?Q?HUid2UNsSeX9sKS5C8qtev/1AWw74l2/jhtkX9iBBv/9fJn4HwxxpBiUG0n5?=
 =?us-ascii?Q?i+DjM8YV25E1emmjjRTX9AsHzVOrsrJxu/OF4hWbkRl5sN/xD7gR4ik7+crG?=
 =?us-ascii?Q?7FzTSYem4dQN/yg/KiEeUi/qRqgYQj88/oAu5iYaCHgJw+ADTf4zT04zZMA2?=
 =?us-ascii?Q?4/ffbRSb0saQeSjI0S5DJlmFH9tBq3nLuLwI4giHspUl4bVxazAGIWeMyI6C?=
 =?us-ascii?Q?cAIxJ6Zhx4TfTiBXvVfDt4DhxJXCs6z+gdQFaHddpOz6H5MIj7xXSFLWLNN7?=
 =?us-ascii?Q?yOMJ3PUvqwnLtOAU3hDn+A4q?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6673443e-a292-40b9-9e42-08dbf7bb9eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 07:02:19.6136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEypVRFpnX6yaAfo59bmPPDcwZvMlji2YrAoavdoa+5AY6HW7BRz5+RHXBNzsVBP/zZ67RTc4pYt1fjHOZNJWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
X-Proofpoint-GUID: QshAu9IbALMXv6kYSOX-DvpYXTbcQS-p
X-Proofpoint-ORIG-GUID: QshAu9IbALMXv6kYSOX-DvpYXTbcQS-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312080055
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        HTML_MESSAGE,KHOP_HELO_FCRDNS,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to setup xpcs, has_xpcs must be set to a non-zero value.
Add new optional devicetree properties representing this.

If has_xpcs is set to true, then xpcs_an_inband should preferably be
consistent with it, Otherwise, some errors may occur when starting
the network, For example, the phy interface that xpcs already supports,
but link up fails.

The types of has_xpcs and xpcs_an_inband are unsigned int,
and generally used as flags. So it may be more reasonable to set them to
bool type. This can also be confirmed from the type of @ovr_an_inband.

Signed-off-by: Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 +++++
 include/linux/stmmac.h                                | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 1ffde55..6ebc2a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -324,6 +324,7 @@ static int stmmac_dt_phy(struct plat_stmmacenet_data *p=
lat,
 			 struct device_node *np, struct device *dev)
 {
 	bool mdio =3D !of_phy_is_fixed_link(np);
+	bool has_xpcs =3D false;
 	static const struct of_device_id need_mdio_ids[] =3D {
 		{ .compatible =3D "snps,dwc-qos-ethernet-4.10" },
 		{},
@@ -345,6 +346,7 @@ static int stmmac_dt_phy(struct plat_stmmacenet_data *p=
lat,
=20
 	if (plat->mdio_node) {
 		dev_dbg(dev, "Found MDIO subnode\n");
+		has_xpcs =3D of_property_read_bool(plat->mdio_node, "snps,xpcs");
 		mdio =3D true;
 	}
=20
@@ -356,6 +358,9 @@ static int stmmac_dt_phy(struct plat_stmmacenet_data *p=
lat,
 			return -ENOMEM;
=20
 		plat->mdio_bus_data->needs_reset =3D true;
+		plat->mdio_bus_data->has_xpcs =3D has_xpcs;
+		if (plat->mdio_bus_data->has_xpcs)
+			plat->mdio_bus_data->xpcs_an_inband =3D true;
 	}
=20
 	return 0;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6..dea35ee 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -82,8 +82,8 @@
=20
 struct stmmac_mdio_bus_data {
 	unsigned int phy_mask;
-	unsigned int has_xpcs;
-	unsigned int xpcs_an_inband;
+	bool has_xpcs;
+	bool xpcs_an_inband;
 	int *irqs;
 	int probed_phy_irq;
 	bool needs_reset;
--=20
1.8.3.1
