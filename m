Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996297D0FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377326AbjJTMop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:44:43 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2114.outbound.protection.outlook.com [40.107.24.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B591
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j7VMiT7yfy8lCEW6Rgowk/WSVkLlfmEtP8btxYRXIU=;
 b=G6DHvpQ7cmvIGgtDRMx867vmjOEygtt8sG4oCLrJu7KPk7SmpP3h37oWWncB2tGYLwUg2VBipY0dcpYtunlQrM1+Li7pUcZIpBPC6sAArliOJM30iNNBzQB0Y10fXfWWnFWg/70BC2ZPtQaBzuQZTJP+hdjyXVBcTgTss50c1cA=
Received: from AM5PR0301CA0029.eurprd03.prod.outlook.com
 (2603:10a6:206:14::42) by GVAP278MB0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:23::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 12:44:39 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:206:14:cafe::e5) by AM5PR0301CA0029.outlook.office365.com
 (2603:10a6:206:14::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 20 Oct 2023 12:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 12:44:38 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4SBkn21QVbzxpF;
        Fri, 20 Oct 2023 14:44:38 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 20 Oct 2023 14:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j7VMiT7yfy8lCEW6Rgowk/WSVkLlfmEtP8btxYRXIU=;
 b=G6DHvpQ7cmvIGgtDRMx867vmjOEygtt8sG4oCLrJu7KPk7SmpP3h37oWWncB2tGYLwUg2VBipY0dcpYtunlQrM1+Li7pUcZIpBPC6sAArliOJM30iNNBzQB0Y10fXfWWnFWg/70BC2ZPtQaBzuQZTJP+hdjyXVBcTgTss50c1cA=
Received: from AS8PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:20b:310::32)
 by GVAP278MB0779.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 12:44:35 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:310:cafe::de) by AS8PR04CA0027.outlook.office365.com
 (2603:10a6:20b:310::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Fri, 20 Oct 2023 12:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 12:44:35 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 20 Oct 2023 12:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4KZqEV2pW4w87KtKpFhUCeWB7IkgLWA9xwUGwpSfXuCeJcxHu8RkxYseqDc+6zOt4ziY/98aqhGNvSxXXjna47Pcwf7NU4ff+TmPX11JN/6VESVSYrkJoiJIP0oxs/bS0R/Qffn3CBOFmizNzVjQ82aZPi4wL8xAnQBsnomthcIMSJZg3tB2rEirS+rw91D5+qhvxihnbQ3PKR+G4ChR56vrKdx8SdpRAxiQBsRbuZuceuwgg3YdKqlXMwjTaQPBQry0Tog9I29J25MZKCbSUzzYyACSc7CBrjz89ieDrXgHvlJYI2DgAUeA0IJwyTgovCw2408pC0pXj3Tq7jfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j7VMiT7yfy8lCEW6Rgowk/WSVkLlfmEtP8btxYRXIU=;
 b=D9+Xhu5e19NNSkBa67W5MT1bvo2+HoKBzA6wdrQ1t8E67/jhvTmqtXl04KdZHQNa1ZHghhXbqlKf02c6QTSD4mGjI6+DQUGCt/YSriEtoEuoOa2D4ieEJ1VyJRozI845wq5Z4Ye8B2VHkmdpIC9KCjwyRiH6lHEA/lAdPCmt6EMMD00JvQw8awjXyNSEtiDnYv6iSm8GES5SC6Bl2V15LXMqobPucovkymNJv+xkL1NxLCOwUF0XuJ8hBIPZ/HRxYLEhSxualnsKEzXAIoYIsgkieHZwU5Ta9QsbNakqVgDhdHU3H0LqRf/yIbA4shxMdxmJ8DfOVOqaPWOravXgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j7VMiT7yfy8lCEW6Rgowk/WSVkLlfmEtP8btxYRXIU=;
 b=G6DHvpQ7cmvIGgtDRMx867vmjOEygtt8sG4oCLrJu7KPk7SmpP3h37oWWncB2tGYLwUg2VBipY0dcpYtunlQrM1+Li7pUcZIpBPC6sAArliOJM30iNNBzQB0Y10fXfWWnFWg/70BC2ZPtQaBzuQZTJP+hdjyXVBcTgTss50c1cA=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0153.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 12:44:32 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d66:dac9:a13:b207]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d66:dac9:a13:b207%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 12:44:32 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH 1/1] mcb: Use the actual bus passed to init and release
 functions
Thread-Topic: [PATCH 1/1] mcb: Use the actual bus passed to init and release
 functions
Thread-Index: AQHaA1Mssaf6X0ZstEmtIpDovTMTAg==
Date:   Fri, 20 Oct 2023 12:44:32 +0000
Message-ID: <20231020124324.54692-2-JoseJavier.Rodriguez@duagon.com>
References: <20231020124324.54692-1-JoseJavier.Rodriguez@duagon.com>
In-Reply-To: <20231020124324.54692-1-JoseJavier.Rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0153:EE_|AM2PEPF0001C70E:EE_|GVAP278MB0779:EE_|AM3PEPF0000A799:EE_|GVAP278MB0037:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e794a7-0f0d-4ad4-ab99-08dbd16a52b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3Bbsydg1pdBkMP2bOtwQsO6WOPS+wGSLGhH+dPUhxLdg9XaNVDSS20P8tR4aQOsGURAfn3Fcf8R58hvOYvk6vZTG/AeUfvjhs8OZq8B6aBANncOtOL5yuhtrBU54TLbTJtCmpaOMLOy0D66Vn1hrky7Jk+/2kUOuqTC5LodmRmMXHrwJFjq7Z23Tkd5nZn2zV08Jr7lSyeXuLtzf1goVNQpfgMgacj2Q2IfkW82ya6a8LBy8vnM7QxMkkQQbgu2H2O3A5Od9EgyH0SxNB9V/UjKXDjp/0tKxGnPtpDLDnDHeA2/XllyW7+SnE8OmwrYOVE0fNsJqqdZjcSpvDlbVsAEU9e1503OP24pknWxcUlAv2BaweWZMOvhxoKHvGq2gLyEzHNw8D5COKUyfjB0RUDv3jaW5RG4YYp4jf8O2am+nn8/91nk8J8gHbvQYINnF3kzaoKNOyOnzWShEa6+H8mGk1ghRRv9kDMGTzy+SGhgqIdEuT7N+kouk+RwQHhaThdBbnloV0PdoV9dMMmcVOuVXFMKpm+N3ALnolwj4vlOghla0wDTjynvaqH1U/fu8e1dX3mxG1yq+GjmeUrCDV1siapeLcOsqTM+uKlm3W7Ugoz46ykqlQFbUrzQ13dMe
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(26005)(83380400001)(2616005)(86362001)(107886003)(1076003)(6512007)(36756003)(38100700002)(38070700009)(5660300002)(478600001)(71200400001)(6506007)(2906002)(66946007)(76116006)(41300700001)(64756008)(110136005)(66556008)(54906003)(66446008)(66476007)(316002)(91956017)(8936002)(6486002)(8676002)(4326008);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0153
X-CodeTwo-MessageID: a233b71e-ca02-445f-a185-7260f8e72ce0.20231020124433@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c79c6a0b-fb4c-4b69-5ad1-08dbd16a4f3b
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vaOdblBUDE/2Rqn3Lywa5GzrjaA/2XxNHVkGZX/3VLMhLET8iOPM1YVlzwQgNc+U+QTfRlFneDgIls+1u2xcAiaD4n24MuHopnCBzpFv+FgEsxaufzBD1dvXVSWahF3qvENCVHQNtdpbGBhvVS4KoVn5fELMOptiQWu/CWzNvf//U/TnKrXgyIjXB25SAcJt0yVL0j5u9e8p6c96vnR7EN3Q6fB6UVw3CED7ssZnwfI3yB0T/3aV9nF1U0q/5G/BMvi3gJEA3BNAl0mW+Vuv3OlYxW1g2P0XZLAnOA+DApnG+K65D+NAHH3fXajZRxRDd8GeN6nrERFpFdB0IuMwR5bMYjnB7lqan4dznQh6nMU6wN2/08uJbVqfoALDHR0I7cA5sS2t3r/GfSWYCPaVD+Yndh6vq/Rqv4JIWPbZC0j+yXdUhNVOiSlYDPRFTv/v0LOwQx6R7hw9f4CGhUPaec4yfgptAKPLA87vBRDl30oRJGM3HlQ3FZb/hwenIZw3hs+ViTlFcJLQn8IK2YS5vtNIWH6dVEm8h4Vua98INBGOrFep283fKa4xYBIXOwQ9E9biVJMX4HggsDv0FQElCvGJ96r384yzXGHTKgPx8gKN95eiDXFH6CULUIPviACFKhxHt68HP9GDxC2iDTqi0hh1NrUgcOAgWZURq63NaHulAfVDCqYwZKsdeP+lNtKPhZEU5eLIzho6Op/Dcbsu5Q==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(36840700001)(46966006)(40480700001)(70586007)(36860700001)(47076005)(356005)(7596003)(83380400001)(7636003)(2906002)(2616005)(6486002)(5660300002)(41300700001)(54906003)(6506007)(70206006)(6512007)(336012)(107886003)(26005)(110136005)(8936002)(8676002)(316002)(478600001)(4326008)(1076003)(86362001)(82740400003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0779
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4159f071-b278-4309-56d9-08dbd16a50a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcyCj6zCqV/LS1YzkSOf9LCL71BkcYET++pevHHvpnRv1xBZs8pHR5a0bZH1vyuR3OpwPfLiFTpVxMTPYJFS7N14beg1H/i2ksvzjBCH+OXWZ8E6tTKuIgLp3jCSnHdcX4K/GxOUD68v+x1q4ItOSmnCkmkzDsv9DeVqwPXI28VjddflYlNmWLJr4VUJrZfuJPKA7B3QsP9FCSw6V4TCnePG5HRp66nL51r362KHY3pNZL156apMIflxpfjmI08vHbpB6HpS7BHTz0i1ogN7pwchDfwemO6+UsekKbalY9/g7gyhdYl27VWi4q3h634vpqnTwYx/B9iL/su31zrR8b296NbVBCuGxTzYjqSHR/NMvwBt2PG1+eO++4SESRgicZb0EBuEeKi2BJ3viAoHFLPzIpIyKpf5KDteSDn4+93IAQOjKYGWaCJ1qpAtLDoOtMnCdCnJg2naJcPFzU9TrkAZbWBzMQYcXog9X7QDPK664Vqbaw9p2vjGMHD4eNNApTdpOJi+E763yIFgz97nfv8H9na3l4FzOlLLAKmAIIOSv/jqfB1Ojskjh3prSYkRcefLi0WFYms4JXavnsMblKutHU9ePuz1agEOQqXQ0Bk61aLGnoCR2jNVtBpGENAYab2vnf5guiC9yjenK3pv0j/Eu55kpCQO67VQUtmBl1iErLfN0WtN/Y3uLiaGIjvTJ7nBTOGTJUZXB5Zl7yBsP2pEGIugyjJaeGSEyoiu0hjEPNgSCW7EuflHRlv0NtN/he7qETVOfRNUO+NyASnJ9Q==
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(47076005)(26005)(336012)(83380400001)(2616005)(1076003)(36860700001)(36756003)(6512007)(107886003)(86362001)(2906002)(40480700001)(41300700001)(5660300002)(110136005)(6506007)(54906003)(70586007)(70206006)(316002)(8936002)(6486002)(40460700003)(478600001)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 12:44:38.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e794a7-0f0d-4ad4-ab99-08dbd16a52b1
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions mcb_bus_add_devices() and mcb_devices_unregister()
take a mcb_bus as argument that is never being used. This implies
that there is only one bus.

Do not ignore mcb_bus parameter and get the actual bus_type from
the device related to this mcb_bus.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.=
com>
---
 drivers/mcb/mcb-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 5c6157b0db75..2a4a5e71ad4e 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -311,7 +311,7 @@ static int __mcb_devices_unregister(struct device *dev,=
 void *data)
=20
 static void mcb_devices_unregister(struct mcb_bus *bus)
 {
-	bus_for_each_dev(&mcb_bus_type, NULL, NULL, __mcb_devices_unregister);
+	bus_for_each_dev(bus->dev.bus, NULL, NULL, __mcb_devices_unregister);
 }
 /**
  * mcb_release_bus() - Free a @mcb_bus
@@ -406,7 +406,7 @@ static int __mcb_bus_add_devices(struct device *dev, vo=
id *data)
  */
 void mcb_bus_add_devices(const struct mcb_bus *bus)
 {
-	bus_for_each_dev(&mcb_bus_type, NULL, NULL, __mcb_bus_add_devices);
+	bus_for_each_dev(bus->dev.bus, NULL, NULL, __mcb_bus_add_devices);
 }
 EXPORT_SYMBOL_NS_GPL(mcb_bus_add_devices, MCB);
=20
--=20
2.34.1
