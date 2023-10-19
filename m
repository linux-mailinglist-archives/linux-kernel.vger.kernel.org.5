Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89E7CFC44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbjJSOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbjJSOPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:15:48 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2133.outbound.protection.outlook.com [40.107.23.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531B184
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWCtpRjda2+Sg/PLxo6gsCGRcrv1fECSnKoCcq1AT6s=;
 b=D3OriMroKhYWp7kaNuPszoI4NhYdkxOV6AxEc2AyUIDKI1+yK5eiuyNzrWWeGWw+qfvUNs+Qo6OIBbfr8v0CU6Hf8mv8LuCDspS/Nx81kE908km5NWSKGqHZivWXMunOmWyJtBAPyL0M9xURbTcjRfFWqtgx3q9UurcmU7i8h3E=
Received: from AM0PR04CA0063.eurprd04.prod.outlook.com (2603:10a6:208:1::40)
 by GV0P278MB0049.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 14:15:43 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:208:1:cafe::7) by AM0PR04CA0063.outlook.office365.com
 (2603:10a6:208:1::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 14:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.4 via Frontend Transport; Thu, 19 Oct 2023 14:15:42 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4SB8rZ1CtCzxpD;
        Thu, 19 Oct 2023 16:15:42 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 16:15:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWCtpRjda2+Sg/PLxo6gsCGRcrv1fECSnKoCcq1AT6s=;
 b=D3OriMroKhYWp7kaNuPszoI4NhYdkxOV6AxEc2AyUIDKI1+yK5eiuyNzrWWeGWw+qfvUNs+Qo6OIBbfr8v0CU6Hf8mv8LuCDspS/Nx81kE908km5NWSKGqHZivWXMunOmWyJtBAPyL0M9xURbTcjRfFWqtgx3q9UurcmU7i8h3E=
Received: from DUZPR01CA0315.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::6) by ZR1P278MB1070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:5c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 14:15:39 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::1d) by DUZPR01CA0315.outlook.office365.com
 (2603:10a6:10:4ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 14:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24 via Frontend Transport; Thu, 19 Oct 2023 14:15:38 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.104) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 19 Oct 2023 14:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsVLkleKTubYm8BQg2KfIhEmcviVuJgBuwSx/uS6J/ig3h9PaYzyqoBlRN+zchy69mH0//T1LTOpXuH98ubmDVknfBbQANQrKG0pag2RvL595HZBJKoMqS+CT2/eSXiwHZda3zUWB7SuGA6TFhDQrtFg4fn4XwuReQBfHUXddscZ55Or97bXs0yxt7uYNNGXM8LwqIdkgh+IyZPT7/iVG+QtUxx2KuXRvAGDq+SqsqV8siHXq6Rrr4uhvkCYuh59RacTTt/tDBPQZkH6OmqnDYVF4C+ukgtXlgqlw62YWb+idwepd4dftG0mvVKkdBBbj/lM9mV+rejygqFCGH0Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWCtpRjda2+Sg/PLxo6gsCGRcrv1fECSnKoCcq1AT6s=;
 b=hsqZl078Ez4UyLjglmiPjaP2anl+TBFp0hlGPWlqcr3PXMQ3FDvMK9FcJI/7cd19P3nO9ub8c27yFQM0YSmr7pwBhwtNHZlI3UbxQrFb52JXjq07hDWRqOcOwaquJ3CQg6fYFMN5ia8jymmV7IBVGsTfVOg30AfJVlx0kd5WE0oaqubpO02kpGU1F1gmiMcK4o/aMSFj0EYsWzkz7cnPfPYMOKEgf0kAFcnGkOhb+iCZK/WaBT1MocCwE02/VgTqF27Xn2Fhh/n1sBN0cnGhntoqPdG07zgwUphE8XUxw2k3Vqt8GitKgC2Ym6inUTQLbKUaEv6fZ7Xt5nf9ttTMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWCtpRjda2+Sg/PLxo6gsCGRcrv1fECSnKoCcq1AT6s=;
 b=D3OriMroKhYWp7kaNuPszoI4NhYdkxOV6AxEc2AyUIDKI1+yK5eiuyNzrWWeGWw+qfvUNs+Qo6OIBbfr8v0CU6Hf8mv8LuCDspS/Nx81kE908km5NWSKGqHZivWXMunOmWyJtBAPyL0M9xURbTcjRfFWqtgx3q9UurcmU7i8h3E=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GVAP278MB0038.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 14:15:34 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2bcc:953c:406d:24ac]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2bcc:953c:406d:24ac%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 14:15:34 +0000
From:   =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [RESEND PATCH 1/1] mcb: fix error handling for different scenarios
 when parsing
Thread-Topic: [RESEND PATCH 1/1] mcb: fix error handling for different
 scenarios when parsing
Thread-Index: AQHaApa5dKq0OKthFUC2MOoKwZvalQ==
Date:   Thu, 19 Oct 2023 14:15:34 +0000
Message-ID: <20231019141434.57971-2-jorge.sanjuangarcia@duagon.com>
References: <20231019141434.57971-1-jorge.sanjuangarcia@duagon.com>
In-Reply-To: <20231019141434.57971-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0516:EE_|GVAP278MB0038:EE_|DU6PEPF0000B620:EE_|ZR1P278MB1070:EE_|AM4PEPF00025F9A:EE_|GV0P278MB0049:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d50870f-0ffd-4016-12cd-08dbd0ade11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: P1uJAC4czYSD14HepXYO07IXDP4lm0sEuUEeYCFOEWs9G+eAqPEZzFqeSV4GKL0xODOoQrbqRMwocG+Q97tfl36lUM4mUihAaOPwKmp/xp8TI9SG8g+kjv4lUgbTa9RMn8zH+FANTU/I+aTc1gQZuNdQfIqqReW8SZjj0qHJStodnMu3sHfY70f3A9wkdmzwMCbwwW3FcSbChDhVlR7iCsktx9CdMULQvtFhazPlCkpfHCE8cKpV6YwChTRW/b2eFdNtdopOlo79/RqnNBXQnFYI81h7ddynGOY7j1+JxL1sp99dMGqeE4wQLFPDGsg9eoVwCNhtqYLZ/NxaJwhxxA7XZwR6MeoVG48tclpVRSg2LHu3iHTT47cXCxjg9AbBDGT6Squ8iCieNEBy8ebjyvA5CxqyVAEL2RUfr+44N/r2mVlWwIVv08RwvbUa5uX97hmrRV9hLkaPieIDhGpKtNN/LEE4oD9QCUkipNc2e/kBNsBbiOVaTgWXwN0Z1R1bZCGykmSB/aWOKwx2SGhKBlDomYo+990Y2U+zYJvQD8vjh6ObURTT69jjzV8W74lIhjTMiDsAG7ouplWvf6eBlS8h2JUZweN7NxMZ7gaBpZ02ZyMJPkKxbx3vbUljEs8t
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(6486002)(71200400001)(91956017)(66946007)(66476007)(66446008)(66556008)(64756008)(54906003)(76116006)(6916009)(38070700005)(86362001)(122000001)(38100700002)(316002)(5660300002)(36756003)(41300700001)(8676002)(2906002)(8936002)(4326008)(26005)(6512007)(83380400001)(1076003)(2616005)(107886003)(6506007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0038
X-CodeTwo-MessageID: 1f3daacf-fcbb-41b7-9b07-bd2b63269999.20231019141535@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 796804fa-99df-4e59-ba31-08dbd0addc41
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5U1HDG3yQzHeHmrAJIT4yoRZnv5qyTIgAnVyv7TXnFEzg4fPdZ86EyZEGAwEUZUGCWNiK6D4+FlULk/5PCOf1H0ehhgvcZkCWn8ANNImtSWNwpgtk/PElxt0bM1d9o/O/82TaVQYVZ1Cg0gYfTkb9pGAoDLbWQP5kCKGYHcSYm9k6gFTRur4P5zfHXieC949U8v2CioroTmnByY1tDq+BZ9qbJxyzM4mneU0pnN9lffmf5idlyziGj6pMV9HmbLsBMjmJV6ncRCZSKuEfsTIAOOGTlCm3ROqWbWDC1JC3RI4WAFGuoK13b2uiIvXEP8DbraLvkH21nLS0uUlPTw6V0EmZkEryhewah8M840/2jNvU5vrWx7/lEihVJEm+QXfIpdamF+F3DD/xto4gdshGrpYO+0DyxfUMNltUTExmJfMjxym5xoNs2Ydo2KGwApm3BkbMSXssh8MvWMzDI/NC5w3BPhW2bmy6zeYiqiCGbBXEggWf7Y4mTP8ptqkJ9fM2c2XnsFZKa9Kmlf4dU8dXgZUjqSQNDY9MTZTuVPLstz2B0bCiIhfqyrLqwkhqRs7NpPZ46yUsaTWXkc91BE1QzyRp661oPpcot6LuZhKS9aCk1ZJSek64/xXfhRVEYfWwNYtXNFtx1RAXl2NLUFaHWp1UQ5OW2BWG3wERdaXaP5xmnpVKhytxwTs+4P1pQ7t9KoJXpVnGpRBwLX5+6c+0A==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39850400004)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(2906002)(6916009)(26005)(5660300002)(4326008)(8936002)(8676002)(36756003)(41300700001)(40480700001)(54906003)(316002)(86362001)(70206006)(478600001)(6486002)(70586007)(6512007)(1076003)(6506007)(2616005)(107886003)(82740400003)(336012)(7636003)(7596003)(356005)(36860700001)(83380400001)(47076005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1070
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f2b40ac-eed1-46bc-e66c-08dbd0addec2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3YWYvlUAMtFzr4BYjHN23ohNYcnMUqI8nPoFjPBfiqTgHZFdCSePqK373kurBGxGNlM1NO0YKmAEr0gOR7QiK/t/0jU5Xf76G31eVLy5nKbLGZiE4b/SoBF+OcQx84739Pjrl03RZEw2lXYIP4Jtb925aqDAvXVL5zrOFX2N379c5rXMA3BLV7T10EabAjzI0515Oo3uV1jt/dnmZzPqls7ug0T/9cMDljQqEkDQJHQef/N1LeR9Tvn7BObsQn2c22nhcig6DrbW1EDVY5bJohEEZeKT6fDA7AHrG+VryF0uGx1fMyAGb+9DU9qOG9D4LPyHHwoWzaoRYN/1kn3qoX0bxgWpZnoglWABSqrb0pugdDZ4sE2crusEIUrxcS553LagMqlxkxvVX4Iwswo5lEYaDK5OG3dRXhVwLbaKdE6POhvoAk0cGJnKPFug55MJ2pHU7j6nlzCb5sASoUOIcKc5F8uCf9tCLtv9AnPmWyoYBGeMZoSLoqVVwy/wf0Mzdfq+FsOo64Aip/HZlQuf00KjRsQI+iQdhNed6t18dAyIxc5EAQjw5wvWbBKp/G+EWLYxFm5USHpSx+9enXneiEvTNtxzJCYb/ywrl2SlrOjEcwhPkkBi+oDsRpOU3XwIwhawzCzgWUQCo6ADpbyEsccAdjuTe2efN/iAysuGXqijtyRAu41VYf0het3CCixP4KZQktUWyEJuOVakw7BAV8gOgnXvF27W0g+EohUvDTG+B/2roBzjasFcdHwZjzmjTcSFa01kuz4HIXsAwVeUA==
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(40480700001)(54906003)(70586007)(70206006)(6916009)(316002)(478600001)(8676002)(6486002)(8936002)(41300700001)(4326008)(36756003)(2906002)(5660300002)(47076005)(107886003)(36860700001)(2616005)(6512007)(82740400003)(83380400001)(336012)(6506007)(81166007)(1076003)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:15:42.5543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d50870f-0ffd-4016-12cd-08dbd0ade11f
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chameleon_parse_gdd() may fail for different reasons and end up
in the err tag. Make sure we at least always free the mcb_device
allocated with mcb_alloc_dev().

If mcb_device_register() fails, make sure to give up the reference
in the same place the device was added.

Fixes: 728ac3389296 ("mcb: mcb-parse: fix error handing in chameleon_parse_=
gdd()")
Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.co=
m>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/mcb/mcb-core.c  | 1 +
 drivers/mcb/mcb-parse.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 2f23b9c3b751..f797d078978f 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -247,6 +247,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb=
_device *dev)
 	return 0;
=20
 out:
+	put_device(&dev->dev);
=20
 	return ret;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 656b6b71c768..1ae37e693de0 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -106,7 +106,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	return 0;
=20
 err:
-	put_device(&mdev->dev);
+	mcb_free_dev(mdev);
=20
 	return ret;
 }
--=20
2.34.1
