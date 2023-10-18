Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC07CD7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjJRJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjJRJUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:20:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8BCFD;
        Wed, 18 Oct 2023 02:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6+OOfz9g1+9gu0ca++1OmuuaSCdfRerr/gYitPpUUVNzqVj5PSZe82Ju8znAPYp65y9mKtw9d/qbllOs3hkUUIKJJZ232jPVl/48vbxk3hA9w1HnLlkplSNXWbdHNf7IN+qTpAtEOXgXW5Ml0q1hiH7Fha8IW4e9s49lX4KnlZel0jfmLjoM2Z0USjq1CB79MqZ4XH7TVS6S/71udm7PAoCtqMCT5vlWrS+21EwTiXJkkbHLP+TBZkT2ru9eWxNjDFS3bDMdFbTmk8EE7dXwC068MCqb0YX0UmjnFnodHy47WArYM4dAza0UDJDIKLVSMbzkaJDupz3m7utVhqyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8kGnQIN9xTda2TecGUIMThjM/i+v1RzDeWOCSj3ze8=;
 b=m6iue2CxBG4gNtIpi2C7ZLl0Rv5ATX3oJP1MyNrY6PutG+jWBA3PA6s+Fw7uUNIucUNNhlKrK3/srTDr9lKa7iEoRFoDLA0i6sFlYXPQ6OldHAfbLpiVH7dBiIwVSnJ+Kam2ShFnUzlHh7SWdlZ9WxXiIHeUDRPa+IUbDSK8GiVKErWPXvZ9czQDBvyfip69nPEGj+CTZK6z51Ps/SujORZ6Zah7UsK+sTXteK2FNPXuHSL/m3F1IYpTuHWdfEmIVDQ2Hb8PknceczyvB4bsoUqq0dsOP1aNK9T3osU7sevKsnCcKZWN6LGUocIkTiIKr2K2FYcFGpRyCSp5N+XE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8kGnQIN9xTda2TecGUIMThjM/i+v1RzDeWOCSj3ze8=;
 b=WgWC1KazbsDum1ETsjgwQvPqOtbqxnoFAB7d47hCYzMQLjICk6MtQpizrPoAMa+XyOclNpKDxyIfXvDpTxQyB4SlfDC4zOnSHZKbvS7/qv3smCuksRSH29C4UIdZf6WdUG7xCb5Yy0pN1A8Guxt9voT77kSP28IaE756yzZFbKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4134.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:20:28 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:20:27 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 0/6] tty: serial: 8250: Changes of MOXA PCIe boards in 8250_pci.c
Date:   Wed, 18 Oct 2023 17:17:33 +0800
Message-Id: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e76b50-f07f-404b-1f90-08dbcfbb77a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1+uSo67SAq/xF4kg/OBsiwYLL/WwhZPw876B2/w20pLnl4Oy5s4y6eOpJVCdosIu1ZMKv6l+WaWdFkSHboj8NSzWHwvvS7d0sfXbmizfL/T7BnKkusfHvVwX3ycTcY5xMIltpk7DAcWhr6KMsnFEr8PR+gCsBFHN5J3ev277srUzLuDg6tItK1yp1v32boyew+tMKuyQ4TJjFLdxebJW2xaQzI5JInlG79JoDtmzc41BHwtWW3SYkzt//SYfGyaCMKdAflXwjnIQr8HFIyhlgXcUJ6cUmwxYHzl3PsI5RQd3ntyxM4Sum5fi76aPtllsq2hUbbj5YB6Lv77s5EF5Tg3R9ScCBEiYa4mhJojBdn7/oMuvaxxi4Mn/XYfA7KFTvUCLnSbfkEwp5NQ79oyMVMfBwznH+h62Ipwi/Kwpai8K7chQlRe7qkRMgiJy/76ne1vXfPXwRL8u+mcjwl5eyrlc3s3UGAfEaZxA4GDEwsmfCDUDBzlkOavyLxUH6vbAAha01UO0h08cNtfANEiZyVQdks/aTriTutggXRIVN2MzbD7nTCBfTxFGCqDembji+LHY2Wp2gjXL30Cd4UWv03GECfYbStEa42oSO5QhU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(38350700005)(6666004)(6506007)(52116002)(6512007)(966005)(6486002)(508600001)(66476007)(110136005)(316002)(26005)(36756003)(83380400001)(1076003)(66556008)(66946007)(2616005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLAmFYCq61/FlHIIJp1EGBSI6WFW8YD9MOXpiOnKnLzWnOvpokh3syBbIIUK?=
 =?us-ascii?Q?z9qMYVgS5xIO+7kuy7i8JD5Ce1SpDeokdvf5fQAvJZCH/Ibg+hcvSXRdQ66D?=
 =?us-ascii?Q?gNAyYSr8sWcpcfztH0eKCluX6DTBuwsEoe0/TO1kT6N+4h8dnYtnCmRRVnHr?=
 =?us-ascii?Q?NJX23goSPmwzZ1mL1HXS+IV5ib922PAsReKsgAtnneKFFzOgKhhErQcU0rjQ?=
 =?us-ascii?Q?S6BZOMuMzgw1iXC25Fsr6hyAFT6A7pSgknMYpwxQjdzKQL3lAzf96BrEkRFx?=
 =?us-ascii?Q?bhF9Eh1eNyA1Miq07jEswpPH74pp4WGf8Rdu+RPMOo1ibiTvlZPzwDSJ+bUy?=
 =?us-ascii?Q?5dq1zU5S/JHiyMvveycyOE4SR/1VO/i0zO0qCEYP6KnG9hcVpbdvCyHewmgl?=
 =?us-ascii?Q?Mt/IEFQ0fwLn6iVGx+onzC/05uSShaMOdXe9icO4jQremrg/KfHmDyEzLmNo?=
 =?us-ascii?Q?Y1TNKDrXL5Thl0BZyoeRO3c8R1bTeG/wm8w6x2oqYq84JT64sX5uxFSe/9DD?=
 =?us-ascii?Q?Htb4ePniuHAlurtJ1sAPlZnK7ExPgmHVx6+4rc2bNNbRNTtcHu7/e71LQDQ+?=
 =?us-ascii?Q?o6g81eR7UUn9w6/e57DBp0/p+tLbfVyW7lf/+mpXMjXY1jTNVCtuk2axSbkb?=
 =?us-ascii?Q?jEa9Yaj8CWekDzdZPSsjYojktHmUsO4ZA0kqYYxqR4sAwNJyYJ7LKloHdjMm?=
 =?us-ascii?Q?tNs/dZc4niZsYXqHmxQnQyX+cpdXCUquIqB6Q+djzhNFdsN0a8fO3em4URCm?=
 =?us-ascii?Q?pMh/Hvd4kHldll7pu1VzP0Wu+QIvlyQmjLqSVwwF+3LmjnHgAM+sISJQkRfe?=
 =?us-ascii?Q?cnwS1HyGH1ge+azadiBRz9wRHkICFaUdF2BATsH+6n0PG40gqBXN8c5iXXw4?=
 =?us-ascii?Q?hBJCyWSKti1UGQVYhpz9G5zNvdmv4Jb8ZO1TiHZdu/Ut+kEtXT/Fz7cMhyHc?=
 =?us-ascii?Q?dqbNIOOy0Qdit/gu0A83ZAjTawNrV6twsqx6vtybCGw7eF2mPovuKj8jIRPC?=
 =?us-ascii?Q?vxuFUSShd8uVFE83xNtPeIj6pX2hZoRxfPPrGVp4BmJZvjoBOTUzvv9qX7PM?=
 =?us-ascii?Q?iey1iuI5FlS+JE2bypdrnjxlaGwJMOn2tqHUXtccT2R/PrvLAyFFwlDnhM5q?=
 =?us-ascii?Q?m86/LWfw+d2vJj32QYPps/z8OmmseyPKOMtKZ/yKiA0+cC963YQxLcynL6ki?=
 =?us-ascii?Q?9K3EXIhl2lnvDYZ7SpK2gimqDgwFOCiy2WjsfbrmRBDwGs9w6OV2Z3MkiRFg?=
 =?us-ascii?Q?3evgJRJytpQD8rx2Sqmk05D7oig9dkM6X4c7Dlhc/goLmQZrwWHCew47yYqz?=
 =?us-ascii?Q?WCQTkvj2GooDWtcvRiBqDuuiEKnMIfHCHgTdRXlNBVIPVKK2wAk2GqgOssc1?=
 =?us-ascii?Q?A/eZ8YG3P8uk9di8aJrJEIxkJDWTnUqmpq0/2dY+yKJPqfpM5fPD/nI02nz+?=
 =?us-ascii?Q?LSMzQLatlItD6xW9MiEEz2WNVglygXevocJjsuyYUvUw76AJDIldiv0LSoBH?=
 =?us-ascii?Q?ku/NebEKdayULz9GOA8DTyDBdiu9/GPzswV9I7uFRdEpPdU41FQt51gN2x8I?=
 =?us-ascii?Q?eV4YJouDK4peRha7nxreXDbxNeBeD+P6hf5vraI0tPy/3rNVzg4wUu2GPgbR?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e76b50-f07f-404b-1f90-08dbcfbb77a8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:20:27.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i36wwUU2IPi0i3ZthmOMemXQI2UhJbYeF7lyb5p2BNNvnHiMeXuXk4yQvAz39dKsuW+U5GC9uds8857TTXZmUe6zf8SKAwe6TrAo1r0ep6M=
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

These patch series do some changes to MOXA PCIe boards in 8250_pci.c,
including:

- Modify MOXA enum name within 8250_pci.c
- Cleanup MOXA configurations within 8250_pci.c
- Relocate macros within 8250_pci.c
- Add support for MOXA Mini PCIe boards
- Fix MOXA RS422/RS485 boards not function by default
- Add support for MOXA PCIe boards to switch between different serial
  interfaces

Each patch depends on previous one.

---
Changes in v3:
- Add reviewer tag in first 4 patches.
- [PATCH v3 2/6]:
	- Make commit message clearer.
- [PATCH v3 5/6]:
	- Delete pci_moxa_match_x3xx() function.
	- Introduce pci_moxa_match_second_digit() function.
- [PATCH v3 6/6]:
	- Delete pci_moxa_match_x1xx() function.
	- Replace pci_moxa_match_x1xx() and pci_moxa_match_x3xx() with
	  pci_moxa_match_second_digit().
	- Add comment at pci_moxa_rs485_config().
	- Revise comment and return value where device not support RS232
	  interface.

Changes in v2:
- Split cleanup patch into first 2 patches of this patch series.
- Reposition macro list to the top of the code.
- Use PCI_VDEVICE() instead of PCI_DEVICE() in serial_pci_tbl[].
- Replace some C99 types with kernel types.
- Introduce functions for checking device ID pattern.
- Replace magic constant with BIT().
- Sort macros into pre-existing macro list.
- Rewrite set_interface condition architecture.
- Utilize unused flag to represent RS422 interface instead of adding a
  new one.

v2: https://lore.kernel.org/all/20231016033705.20669-1-crescentcy.hsieh@moxa.com/
v1: https://lore.kernel.org/all/20231002015702.30509-1-crescentcy.hsieh@moxa.com/

Crescent CY Hsieh (6):
  tty: serial: 8250: Modify MOXA enum name within 8250_pci.c
  tty: serial: 8250: Cleanup MOXA configurations within 8250_pci.c
  tty: serial: 8250: Relocate macros within 8250_pci.c
  tty: serial: 8250: Add support for MOXA Mini PCIe boards
  tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by
    default
  tty: serial: 8250: Add support for MOXA PCIe boards to switch
    interface between RS422/RS485

 drivers/tty/serial/8250/8250_pci.c | 370 ++++++++++++++++++++---------
 1 file changed, 256 insertions(+), 114 deletions(-)

-- 
2.34.1

