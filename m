Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D57D8E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjJ0GZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0GZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:25:49 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB0121;
        Thu, 26 Oct 2023 23:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6aH1JZ9z8bBnrPnLA/UCs6d4JAnG+oTqZ5lUbdN2cJninSPy6Wm9Kz8d4tBvVYnPIsy0Kv1IGhxh5PcS5WZH+Ws/pR/pwHIUcc6MRHuc+KSD3jw1lkuqpWrkVPF56MDaBC+i407Cf2b6lX4/53Hb8v9vYQPsc4ifPmPkKwx6GKYI97TWh1zI3uDWH1hK4ZHL9+8iqYeRXqgKckViSKInG4cdTu07Fg7xf6OWQ3LGapM69UoFv+ZwEYeEdPJnHohSNGCE2SSj0Mu37S6cB5G2HmbmRVYEseOKUaJtUj94CC/2bxk1ExxVcn47nK0m3ey/tDq0FVfgv1vpCGOC5gBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oXRh1JtlstSnwEHdFnMmHmRRa30AF4fRI800i86Rxk=;
 b=Ha0Knr2E3X3YKG6IkI4mo/fYJddhkPXYWe8ttdPzQBiGP9JRpoOX17Z50UpKYLqwQD/pfudU5t68GdceyoTU84kRyNiPiQbXDO58EI2nnWddqz7stwp9D1JCCdxsszE/iP4wfytK5fPEZSEUuf3U93o1rTjWvGTOsesIfrKYJdxGAivhCU2vK/rmw+LI0/GTMxox1tLTcOiamdqrzqAwEFq1veWPONdU7wg/bmxrCI+ML7uM5rWNPzKH5V7iFa5Ox1a1NUfb7b4/awKamlq1UM/xBX0D6WdkeVA6QO8wdR88tYLveRqCLXfOlwfV8CHFifrtU7FBAZERqziL2zbuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oXRh1JtlstSnwEHdFnMmHmRRa30AF4fRI800i86Rxk=;
 b=bioFJrwgDn2TCSqjESifXEpZq3ZPsblwaWvq8hFj/vfnKUkoDFWiOZsLDo67P5R6QW9tikadqwBgDOw0YIrHQS4OZNMWyYc4nnqMBAEDEWSd2xXiw+CG91Ag92+f5j6thyM1GKYfzq1Vj2ufIeSB/IgEuCad9ge3rzEoreAlE+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5545.apcprd01.prod.exchangelabs.com
 (2603:1096:820:cd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 06:25:41 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d%5]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 06:25:41 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 0/2] tty: serial: 8250: Adjustments of MOXA PCIe boards serial interface
Date:   Fri, 27 Oct 2023 14:24:38 +0800
Message-Id: <20231027062440.7749-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e07228-3998-4aa6-37ac-08dbd6b58abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXGZLcbCOs0GQ7r8A0srKpCKZ/Bubkmur0n+sDeh5T6DS5CGaxHVeW4sn4TdZ+J1JIexaiYNiic9pUGWTOwlRMoce3EUzLBRFGPw0y+4N+lwzulobmJ7whRFZMT123j5xahUoJ3bD1NvAorXgNNqjAhBhVRchB7zeWN4u3zjRQQysUJH46W1CRHPa34vVS3UNwdmw8/zHeixDjIQRhkeWD8PQQvXs7yBi42xYcXIflO/BOhae0Z6sG8XPHkU3kGoOwatw7oUPas1cp8W7KAdTIwh7skMiPxTaa5LH5AtW7ndxV/YQ8Hj83+rwXXYWCLIR1MbfvG9erPjpKpahe94lRHNO0IQA6nSKxz/xlmzBnwCwmyxBC7lcaN45Fh49309hDHmyqHAE2nq7S7LVyetnE85q9/tqR89/bKtZfwBjgvugRwpm+QitMwQ9X510Zx9o0ucpQJ1gOCsROhMyUsMGDJiaFSzvUCb80uigO3qP1g8bgqxrPa+1Lcczd8YH9Tbhso348Ffh6lN3WFDY6fFVIMLyTADZ3M1ku9F7pkh/hadWTNVaNUx7SQIvBt1Wd5JLn7saJsXUwho97WdqICVsWKK63L7Ibg/Xx5qjHixITMkqT9PwTCktEcJjSxfW1HP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(38100700002)(4744005)(52116002)(83380400001)(4326008)(36756003)(8936002)(8676002)(2906002)(86362001)(5660300002)(66556008)(66476007)(66946007)(316002)(26005)(1076003)(2616005)(107886003)(110136005)(38350700005)(6512007)(478600001)(6666004)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/aIONdxucr7awQkyjcg20KHD1a2WxrNiFNW8OQqSxVoJTIhSoeGmDaoNj5/P?=
 =?us-ascii?Q?8prXo3yK5g63zipl9PIfmjVhnQAHT2eRkvRNCTqRIOuz8Zw979FvQMcqPjcq?=
 =?us-ascii?Q?Bc7Q+cccDGlV0Hw1ixD025fzr1HFHLzZOn9SaH7vK494ieURfvHWehpbIiui?=
 =?us-ascii?Q?TXYgC92G9gV2ufQPLSkae1pj1uhu/xdS5GQYYWT+65lLBBvgcmiAw4z7UYZ5?=
 =?us-ascii?Q?IbkXHRN8E6zQ6pNlUYVeL6QxowCLscY0ddGD2dIhN7g79KKjpi7ilPGQCv2B?=
 =?us-ascii?Q?yMilmYpxMhDCCK+zDfOmrYKvLbZy8BNoroAjyluxKwjAasqveJxytNEU+fXo?=
 =?us-ascii?Q?Q741Ui76njm60Gn0uAO4qjNU388l3G5qouKl9Vvtd8XB2MsrrhCZUkhBajpu?=
 =?us-ascii?Q?y9XFFhkAXm0jYP7JE1Z5KrIk3rAVrv8dWvJks/lOTk0HXgpG2/Dr1fuvjCT3?=
 =?us-ascii?Q?wFew5UhRdY0PiRqkwd+fgsku8l8s+YQKjKCnCbgLRhFY8z9296DuPjblC+3E?=
 =?us-ascii?Q?3sLrg88RJhMPTi8J/lNbybpi9Nr2uQIC8Tfaley39hTPBMs4zj/9MycnGzsf?=
 =?us-ascii?Q?TK4rTpSJbL2GSBOiikI0gDaNU2lAKD7LaVbCDbwuPPQ1nZlohx4YHaYAbIeV?=
 =?us-ascii?Q?Cenfyv65cKYsqDfz2RfbHlU26j0F5LEYrii2pcyStyxILMbJVvCVRhS8vEj5?=
 =?us-ascii?Q?hjI8tPOTsQXp8krt6i4VAetWhE+wYSmlkGy42q9Ht5KinC9HxssAEChDNXUe?=
 =?us-ascii?Q?P9xX4fivByzl0gBTJHIQCllckyIb96tWxL/xVlvvhRJrxlHBIePum7kqMF57?=
 =?us-ascii?Q?eKtGkDJ7/zFULxpPjIPzrLHWXpC/giThJLdEglqTqzxqoIARLWJsDt9ovDze?=
 =?us-ascii?Q?LhEWaHZm6Kb7G5z86pn1lshjnWFRdkYeOs2eIJtEpVGxbKXcySjVECryFgsM?=
 =?us-ascii?Q?xzkx+HcL6oDJj6Tci4lJv1/QyHxrqLq5Cuqktyw765ly5lUQxG4JbErl0rqZ?=
 =?us-ascii?Q?0YGxAP5kDi9BC57IDJNiWny4aoNXD217jVtFvTCkkg8XnL78MvdaGBMnr7bt?=
 =?us-ascii?Q?rXGczGE9HdQdlk2x2VBaSi3/zM2iP7iRUXUihDm3fmSX/AMHeMVVzGyexoDm?=
 =?us-ascii?Q?L+6/YVEAQudDBBBzJRH8C9UBDTZvm+jrKcU4Ob2Q1YS/U7olyptDbMftR1js?=
 =?us-ascii?Q?dtmesKv6YizdG4Evts1Nl7SrQ/cA3mvEbaGd/NeB9ghNHRzjxJ1nPn/kCOU3?=
 =?us-ascii?Q?5dVwYy9aPfzCvEcw97dYbUwN9RmPvfEgyTR2uj+MZo09vjukrXeYuQJo5fTL?=
 =?us-ascii?Q?3jL0945BfCEDZFU8SsKg8j9Rr94fTKBqjisA1W4uH7JSUl7SZhB6r5KypvlP?=
 =?us-ascii?Q?eC/IziBa5DVyzCYhXPQei8TF8Pwdwmy6rEqYk28MLVdlabK5m7VLzWDXIqiL?=
 =?us-ascii?Q?3WtScpxSLLdgF+ynTkU2MgKA8fDkExFRHi/wyrFjgTO7fPdZFJ9H1TLg0Wgq?=
 =?us-ascii?Q?M74BSvyaoYrEISK2XXxhwd/dyz6kxNcbvT3PKv9Zx1C1E/Iwe4MyzcMJGHMT?=
 =?us-ascii?Q?ympfQTG56RNSrj9+xHSLTb4y5Pa+QRNOVu8e0cRtTzf7BIbMPJ9uihee2APe?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e07228-3998-4aa6-37ac-08dbd6b58abb
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 06:25:41.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql9WAxra5s/RPHRjsKrdFQ3+ytLIDbi0o6KAs2oncRDbumnPqfpirjdedb05769s/cGcSvfiK58qzw/65k+v+/XajqGF1x36xuZ6RS5PBLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5545
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series do some adjustments about serial interface of MOXA
PCIe boards including:

- Fix MOXA RS422/RS485 PCIe boards not function by default
- Add support for MOXA PCIe boards to switch serial interface

The second patch depends on the first patch because the first patch
introduces a function called pci_moxa_set_interface() to set serial
interface and second patch utilize it with ioctl command "TIOCSRS485" to
switch serial interfaces.

Crescent CY Hsieh (2):
  tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by
    default
  tty: serial: 8250: Add support for MOXA PCIe boards to switch
    interface

 drivers/tty/serial/8250/8250_pci.c | 102 ++++++++++++++++++++++++++++-
 drivers/tty/serial/serial_core.c   |  21 +++++-
 include/uapi/linux/serial.h        |   4 ++
 3 files changed, 123 insertions(+), 4 deletions(-)

-- 
2.34.1

