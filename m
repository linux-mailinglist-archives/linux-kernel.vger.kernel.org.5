Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4919F800483
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377709AbjLAHQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjLAHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:16:09 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480491736;
        Thu, 30 Nov 2023 23:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKXPt30vFLV/3Yy1h18VgFO34MQ3R2+aMGx0aZfH6rPuq79TVYpwrwXKrPzgLWWbV09J2h7ok2DdCFG5ATjBrHs7/UoCA/09ubpzUgz8NX1okClXyNIH7oslhzGKbqLEujzyVm/sbXWLqF6LLWUyP8bgVjnCFLrd6FV1d/WDlU6comBe1FrQs6fIb00KszI8G4IksqzATmoIa4oXXRKeRCWsWVpUc/ef/KzE7iBb4LLRmQ8uu22nJl8x3MxDqlIRj5RloOk6EnRbGymBMhTKpsJf77PY98yw3YdMwVFmEuNFLu9puTUiaYsnGv8M3YdVKFJGShKajC8Ugnm53BPZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPe/JAnJRzg8q07aLglJpFSq4dYQBevMYjFELUnIfzc=;
 b=enkK1ubb7hVF46otL+uRoO7aFbTcOLfmKOO4fNYCy833VA5lluJz4xD7GjB+v7pOHH7DwJR42wB12zVUXhzPjhtT7dS3b+crkMz0a/V0GiHHXVHMzwGDGKM1pOeJvbk6w/zUfrk+KoEwAj5wB1y7HXVIITVCtd5CyLDdywKd2D0Nq2DXvm+ETk6gFQJ0hgmIkMuomjW95Nu5Ez9/JcJ7Ba6NZyTsxq46NU8hWYbX5jfspeEWUkaz52nnk3/gETD5MrdpeY3qDbu6vXZV4V4gneucmrJquHcHSuXaHoxDVtCBlsBsT1VyHeGf2oiAMvldwR8gv8qmsnhdtvSiV8EZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPe/JAnJRzg8q07aLglJpFSq4dYQBevMYjFELUnIfzc=;
 b=UY4EBXMTKvvlrib54DsB61nHKZPDFwxR6eFkRf4D/bNaO4QAnn45z720Uqs0/hwc/h0O8PaU7b9drK1lbqUQ4W5ZhlGTPlOLoXWBjw5Zcy5KzTEZV5S40bkU+9MIdPcHyI3AvyIZL+1DyXiFbrd37oIrITzSAl8QsRxKQdSea4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4821.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 07:16:11 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 07:16:11 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v6 0/2] tty: serial: Add RS422 serial interface
Date:   Fri,  1 Dec 2023 15:15:52 +0800
Message-Id: <20231201071554.258607-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0255.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::15) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4821:EE_
X-MS-Office365-Filtering-Correlation-Id: f0021861-f096-4258-f711-08dbf23d6564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Au1cGQ5G5mxwv1Wa0+xIfUc6fgkna8abecFipyYAqc6M8yUt5pti1UNeqQZrBT/r5ABhKUDta+ElFc7RiIcSIJIoqfm1xkwt6q/l/ZCBZK/0sKKDnil1ZIqT8N7IgZgZ/VnH+n7G8opm83qK7zCBHIHKN92hDGmbFtJrWwXX9Q8b1GeIJUnmJZMsj6+LjVFb+35g0sQEarlb+SMy6ogVtp6uEKOCo+sOFd+G2yNTJDSKubt9+2gyPRG+vnFMqi8TiXWlK/flPRALhZz7wilRGGpxZiltAuWHzNo8nvq9vg5o+da5siH8ZtHL5eRZPm98/8i4O6KhO42XNr7ojrm6JZeMd4Z/Du+xqiG9YszoCL+gwzKRVJDm126+a4ixlNR9LxmRUnXa9awz6NgoKnSFxrltYBhqW5mYFjdTUdvinAx1J0meSTDnbfIIKkdAXWdiFX8oY/WW8IILNIwa6SCky2yCHMzewQErA5oKpE9NARrIuhCXOpOziZ1juK3oAZDd62YwMzC4V5ErRMICkUH5N0aQKjWozdOMiJyYvdiYSEPBaBnMGj7+Kmfm9wtiiLd+1t2x1JxxDXDIybmOVY8y6Bbg2dl/MJowKLqCCYQBN2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39850400004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(86362001)(38100700002)(36756003)(6486002)(38350700005)(966005)(478600001)(6506007)(66556008)(66476007)(316002)(26005)(1076003)(66946007)(110136005)(5660300002)(2616005)(52116002)(107886003)(6512007)(6666004)(41300700001)(4326008)(8676002)(2906002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z4kpD/6CC+A8022q5XihvUFcoEal0WoODemJ5arVrBNzfhIEUVbhDd8uXfiA?=
 =?us-ascii?Q?t67whcyCs9+BL7Anij/7gB4v5LERVn4VwuUeJkntBPtjvmBg0SG1XKJcKY7x?=
 =?us-ascii?Q?EYUeqnTZU3CCBHGrWLjlI5aH0jxtze9JsplCl7Y5vJqwoob4c5YzDBfqY1rl?=
 =?us-ascii?Q?aFj91nb0P6tzVl0bRsLC3unwv2XkNvKDsWzrYX4AgwIBkBRNIPyZOFdr7LDL?=
 =?us-ascii?Q?yh4jL91v2KqM0A85QoMVdneeFp+XTviJoYastL16KDJ5QLeHQoWWcuk6RSNa?=
 =?us-ascii?Q?ywpXtiA1LygehbroeWlqewyEs1b/WbrawH+yiCQu8n1Qqecu0AvNKSgVSlTS?=
 =?us-ascii?Q?B/O+xJ2Y8XpowRkflEdU1GfNtuKxCMHe+q03RgQB8rJ/HHLZ1rpH5Mcx8HlD?=
 =?us-ascii?Q?1uD1nHw7+4ERZz9ctwFTOryMUYMUs+EXdpQLy2/Eyso8Phk1o2r8NQmHuxsV?=
 =?us-ascii?Q?/AQzsigl8QGwBNVp/iw+Xrei2S5GDj2e/1+op4WSuoQSC8MLfnoo5eYZL24d?=
 =?us-ascii?Q?UBn4JnpCCMd9DImsqQtwYYReBD90+41ZUGgcLMH+RXdXkPCsknqbZirWkJOA?=
 =?us-ascii?Q?fOGPKt5k6A51iWgPkkJxlcyPpkxRqfXIHfk31Xzb5eBwMUjDW6oRtATrO4Ed?=
 =?us-ascii?Q?QtWoqheJF9xFTXIZiZV26/yWR/Xq82Kn12YNnNHriwmle6CBsJE8TJhQ0Ju4?=
 =?us-ascii?Q?0JbawFQ6r9hOsiRQtXr0foXuetV5DMPDWplK1Wz0st7soYafLOlfNwNVDhOh?=
 =?us-ascii?Q?T/kjiA+do+3fQIj4VPCltSpvTBOy9/b2U/1yb7ilRNCybbXVw9bFji6hgnDv?=
 =?us-ascii?Q?oqK/q9LvS5g7Zq7V1PdSpJN+i9O9TB4PPJ2wJd5glXoqT+pE5oqWw+rMpRZm?=
 =?us-ascii?Q?/+FCEqDKVsys5wR/J0VY48DzooLWZGaqQfgflL0NGU7CYOrufI8iivHSG6/t?=
 =?us-ascii?Q?QeJL7M46WlJen9DqtHcGq8bn1JVqfLLBcRib9MbaPIzQB8jJBKW0RxoLTc2s?=
 =?us-ascii?Q?NZS5to9WbK/olc70P7Vyt6dsbGHfhvUpS4201OH4OABk2XK7amEjENHuiU0F?=
 =?us-ascii?Q?fQ9KxJJkVcRSaH5sv6C34XxjBAY4uQ9Lv2m/w1b7nzUlccHmtBF6jSymC3bn?=
 =?us-ascii?Q?ObQxgTe/CWKFKTB01ZG0IkHocRM4bjsp/fs6iJb/7k1OW7aLBGAhDEgEtlQC?=
 =?us-ascii?Q?ISLFBUqM7WIGy3YazxhepmJGQlZj3v+E71GTAPPhhEhet1B7Lm+LnOF5vNRR?=
 =?us-ascii?Q?inHtrCEz4Rtse5XmV4eg4UxIG5YoptE/SXpijUVB7FojR/eiPbcAPcpivkkT?=
 =?us-ascii?Q?cgNyUOgXx5YM1EgOZSCoTzuZSFnVdmERC0K5p62LeBMvAmf2twBB1ZYO875v?=
 =?us-ascii?Q?RR1pMtnLw4L5o0M+03CuQVrj9w2z4P6cOSjyJEu32xXcAFtMo2JxoW6PePkQ?=
 =?us-ascii?Q?fTuvWqs0v9OImWIE9f/bHcflCb3JOXffHJRO7QwNJaAL/mF67ZFJPgYEQcAG?=
 =?us-ascii?Q?anuaR4/oHAuL6K/xVCA1WM36AJ44pVN+kQ9pdiSI+LL/SdNpAWxg+eQp32Nl?=
 =?us-ascii?Q?dtRHAG2zGL7pt1GlNiQfvVpzTtWenYMlTHG/Cd8zUGt5JxSpP3JeLH+Tw0Qi?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0021861-f096-4258-f711-08dbf23d6564
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:16:11.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHzTJB63Jj6Hs6wm8JLzblrfjRUMs7ypH6+kxkwe8bX9QQKaGlX0xGKZFL8x5gaQVGHf0EPAVQzJrD9O8RIPcTJQNrkNs7PwHVOQMwN+jHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds RS422 flag to switch the serial interface into
RS422 if supported by using "TIOCSRS485" ioctl command.

---
Changes from v5 to v6:
- Split patch into cleanup patch and new feature patch
- [PATCH v6 2/2]:
	- Add termination resistors support for RS422

Changes from v4 to v5:
- Revise commit message.
- Delete RS422 checks within uart_set_rs485_termination().

Changes from v3 to v4:
- Include 'linux/const.h' header in '/include/uapi/linux/serial.h'
- Replace BIT() with _BITUL() which defined in
  '/include/uapi/linux/const.h'

Changes from v2 to v3:
- Remove "SER_RS422_ENABLED" flag from legacy flags.
- Revise "SER_RS422_ENABLED" into "SER_RS485_MODE_RS422".
- Remove the code which checks the conflicts between SER_RS485_ENABLED
  and SER_RS422_ENABLED.
- Add return check in uart_set_rs485_termination().

Changes from v1 to v2:
- Revise the logic that checks whether RS422/RS485 are enabled
  simultaneously.

v5: https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@moxa.com/
v4: https://lore.kernel.org/all/20231113094136.52003-1-crescentcy.hsieh@moxa.com/
v3: https://lore.kernel.org/all/20231108060719.11775-1-crescentcy.hsieh@moxa.com/
v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@moxa.com/
v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/

Crescent CY Hsieh (2):
  tty: serial: Cleanup the bit shift with macro
  tty: serial: Add RS422 flag to struct serial_rs485

 drivers/tty/serial/serial_core.c |  6 ++++++
 include/uapi/linux/serial.h      | 19 +++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.34.1

