Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01877CD7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjJRJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjJRJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:20:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801C910F;
        Wed, 18 Oct 2023 02:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDJDBVckLy1K8NEikbabVdKnFaH0dyv90IuR3/LzyE+1jTGiPoXZBHAG9SXsNsPPu/ZKOKTvCSJpJWZp+Zymb41lB1q/IYxA/HYuingv+EobhRDdcQQiLmp84h/lelfSk7hZxMQtsXs9eJFxl5sbZ69EzOOvP6MLYFUl2waIawVFz80xtfgiq0JjrNkJDyFjzFB2ZvD92wSOjzYhtpAQn6crRH0oohDwhEO5Qt/dSozSyAGtdoQHaOi99/ishozu0omvjI+wUTQX01i7tfbKIZpSxzF6sWGXrEAumjF1Nn2Jc+ar8FiItwF60XlJDjVJTeGwVCl5FyyMtf+0JqutQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oodax8TYaAzJcHOXnEnNzRPLBGK1BDY6xVNguxVBo6A=;
 b=cAVGj/6NHdGgeNoUZReLWkYlkqse5np4cW4sByvyb3YnDFl8P9shYjBnkdsmh6LsBaDY+LRCT83lTZoyayToObN+A6/lQXADpeOe0KG+SVFtBoLpoqYyW0Xzvkz3KmaruawpNnkZwk8ud3xcHPxmZtH9QLchT90pmPxHQnoO2qTQR9fIXL62JGVlcPyxGpWnxMW43UsBYoKIYy7caP6tjsKBtbk21TE4pxR+lB3r9RxRvPPDHgj/PQ1Aq8JnsW5A6XWj3xszC6Ut00gyDVQD4+NO83BN97ZE6H8eQ7S9HNV9Ba2GuwNVmzs+y5tfTpKM/stm7/jvK8Ji4z7NSVIUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oodax8TYaAzJcHOXnEnNzRPLBGK1BDY6xVNguxVBo6A=;
 b=cARu6GaM6p/ufDLEtiQrIe9qOnJ4bdl3/OOhcVnrGpIB85OfEPc/UAY247yvjz58LFSIEIyJjKJAdtUA2EGa1/FStl9PNQ5FrtYLBZqWeIVsw1//v9BudhveayJCdYWN24LNJWp0oyGcogX2XHLgZDLa4Q6475TXQJZ+g3CMSwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4134.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:20:34 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:20:34 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 1/6] tty: serial: 8250: Modify MOXA enum name within 8250_pci.c
Date:   Wed, 18 Oct 2023 17:17:34 +0800
Message-Id: <20231018091739.10125-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 954625ac-2f3d-45e1-353f-08dbcfbb7bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6b8oVn1HwT+1/kh1l/FMXfQ3f3QbIDi7RfXFApn3gKh3K+BR10edVHEhD/9/gCgGBdYegTth0Ih8cIxUzWeMYEkwjtHdt9YkQssDNbkASRfKEVEZZ1kcSbyUO55cVc40J58OEfLO6VXfZGRBv3z6eT606oJcnUX5KRhHQtRLlskznf0Ul3Z4JRVWAFmSYHzekw/IjAd1twvACmEGJG3o81plQuCkBTUkLlSsk/rktcaJuEKl7sNO+x54FkODtHXn8QxyzUOkGYYrFc62QK5ZrCiwUkwXp8H8Ha3Wz1bfWPndkSGr6XFUFt9KYMF2mVJPcVSEV7Vlvp2ewHXD9oTDdFBiKxli9l7nya2RwqHMYVOdJBizPnoSdX3ekjiC48qmE2KV4e/PGSekmJc9pq8N++GXQn8wZaMCUN8lFSuLKwnlyH1VDcR6g+DYZTt8eaCM0w+vxYBOU6KLc6eey00/XLeGX/fNqz6VusJ7atJKE86zoIN83YH9C/FA41UUWQGFdlW97KwYCyTaizX10fty+/nmRrfXX67KKAwmQ0i4w/hQKrLf/fK8R0O3XZa+Shewa8B2UqT/GjH33I74O4ouDh46/nut/6CbOYkoOyfkqCbTGpWqrPxM1xzrytfJ9rSw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(38350700005)(6506007)(52116002)(6512007)(6486002)(508600001)(66476007)(110136005)(316002)(26005)(36756003)(83380400001)(1076003)(66556008)(66946007)(2616005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TK0JNDWCD86ocSQs3g1M8GgB40zBSZ1+T/9L3UkZ0kyHAPvu7fuiSSTHP7mB?=
 =?us-ascii?Q?Nzdw0Oci2k6eYSJCfcVM7FY6XQDiUnyGqm18xmyKm/bcBIL9Cz+YJch+EHNM?=
 =?us-ascii?Q?FJPgU9IcNL3xhra5oVgdEDCikehaZqokuXroLEJt/AjgO9jOPDpqWGX4Gs7N?=
 =?us-ascii?Q?FUgHrVCHgIj1rlKUR3lkqacNHd8h5vaIe1NokT+5pvGN9Kv3YRfj4yBaH8sS?=
 =?us-ascii?Q?gt4tVtReb2JhbPFmNsFPwLNU5fC9xJBv0eLGt3ewataYbnPejqB64mu8HfYG?=
 =?us-ascii?Q?hjAm9zgy3crFrDpq7QV0fk+sGqmnvUKBrZ7Cv6cVY8SWy0YNVVK1BhTzus+t?=
 =?us-ascii?Q?23EsfNywdqgUMyC9B//cJ8oLKUXnvoQUZHEe4pIKvQjJlrR/aYdrj90mH6aa?=
 =?us-ascii?Q?PM25ZIKRhqYJwS2zKYthIFEE7o1x1nAKr++T0nIEe8q2qoXtEyaynKMqGI+m?=
 =?us-ascii?Q?JN0BWQNT3EiZ+j3gnhRz5Fr9UHZcSELEyJVp0jUHxHpy8AqVqjn6UlYD0X9X?=
 =?us-ascii?Q?jw0tyWVhK49yKY0vmVlziRQaAzKn8MiEo2whkIgqaaAbMjUCMaQ+4la8C22Q?=
 =?us-ascii?Q?Yd9BCaHHPwOHu+83xw+rqzkPzoY9XxH383NL2T9CWuivOucwsm+0qSK5WsUE?=
 =?us-ascii?Q?hJSJgkMHG3dyC0cuZGTGnfJzHN+2+4Ni/tJdvEf6wGwrI0ZqSdo8fl518sba?=
 =?us-ascii?Q?ili3HsoV4G3HMPma0Z/y7rza7Z2fU4LlaghdB31G1lW6P2gKDcivyR4wYPby?=
 =?us-ascii?Q?u5Bp1fbGr7CWAXZuQDrp2KPZjroHoF9f2Mwmwh45ys+X5YIqgUxKAy1zvltX?=
 =?us-ascii?Q?92eZ1ZUvKlY81gCSG2eo/14V0GdxRtsKT/M0IC3kwQ/GNPcVyIUydbjaO8g3?=
 =?us-ascii?Q?Rx17gkgfNTjVrYYoxqbap2aUNNFd4Fk+Jwgc+kyMPv8LVkS4FxVRdVCXmR76?=
 =?us-ascii?Q?Pc9fTkdXQHCf4TyxnEoVe8PPmyeFThRiOlBI25MtwR8/Ghi0IempcjM7MrcC?=
 =?us-ascii?Q?sX8boufv7xIC8cARW8bG0VZB+BSHSU7P0Le2g0lmHJjfz+JcaWZQbVqz0L+e?=
 =?us-ascii?Q?JzMqD/NaoMAH12LzmCaw6JgTzzuVyPGezGS8PzPZhEX+FqZApBwr6ACLgly3?=
 =?us-ascii?Q?qOsbCe6fqnuuwkTfFfzTEx1EBbVrgcPnvcKnhnyR+gOBURzWezDnVbh2xWH8?=
 =?us-ascii?Q?m4xK05bgbiAZbZzJtktiJpscD0mnjg5OKcAoZ2mezkmRqHL36KB6QSBvdt9f?=
 =?us-ascii?Q?XATyVTmj/ClxQ9qXBs7GTM/hb6SRjPdUwyvHB4UaG9ZeXFdQ43BacaASDmIt?=
 =?us-ascii?Q?U/d833X/KhbLMUzJgqBHzK9p0vj81iWt2LQdAaSlfsyMKl47QdeeuhXTmres?=
 =?us-ascii?Q?ZTe0HJPvtJXULXJIZ8fMD98BBYl0kJNkjNIdkv3Qf045zSKAQO4UOffn0zqE?=
 =?us-ascii?Q?aT+g+Rk56trjB7R9yQ9Kh/j/yfElJvmEhNTiIkYyKbwHxyVIgr2Cazciymx/?=
 =?us-ascii?Q?+d/1mF7AW9nxDU/ecrKPhQQT4bJHyHaz3v/WjP8G1+kxQHFG3+TqS6Ix+g3X?=
 =?us-ascii?Q?5PgIzHSr1pxrwtD7pSOHR2o2OjhZYX75+/eWtBxg9Uko85KwQu8njgTbzzVL?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954625ac-2f3d-45e1-353f-08dbcfbb7bcd
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:20:34.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuKw96f7kepiEouojW0YhrukvutX3vx/o3g+lmmwkGBqhNKQmo95iZLv+FP7H7bDXk8+9sJK4vBYDYRD4RXCDo+ZKgOOwl+r5EjBjFz2QCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve clarity, modify the MOXA enum name within pci_board_num_t.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_pci.c | 36 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index d2d547b5d..b052b286d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2852,9 +2852,9 @@ enum pci_board_num_t {
 	pbn_titan_2_4000000,
 	pbn_titan_4_4000000,
 	pbn_titan_8_4000000,
-	pbn_moxa8250_2p,
-	pbn_moxa8250_4p,
-	pbn_moxa8250_8p,
+	pbn_moxa_2,
+	pbn_moxa_4,
+	pbn_moxa_8,
 };
 
 /*
@@ -3626,19 +3626,19 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_moxa8250_2p] = {
+	[pbn_moxa_2] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 2,
 		.base_baud      = 921600,
 		.uart_offset	= 0x200,
 	},
-	[pbn_moxa8250_4p] = {
+	[pbn_moxa_4] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 4,
 		.base_baud      = 921600,
 		.uart_offset	= 0x200,
 	},
-	[pbn_moxa8250_8p] = {
+	[pbn_moxa_8] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 8,
 		.base_baud      = 921600,
@@ -5349,40 +5349,40 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 */
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
+		pbn_moxa_2 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
+		pbn_moxa_2 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
+		pbn_moxa_4 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
+		pbn_moxa_4 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_2p },
+		pbn_moxa_2 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_4p },
+		pbn_moxa_4 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa8250_8p },
+		pbn_moxa_8 },
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
-- 
2.34.1

