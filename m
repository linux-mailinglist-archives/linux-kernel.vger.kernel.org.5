Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7C7E1D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjKFJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjKFJLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:11:33 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739F134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:11:30 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=K2b+N6iPGDEVJmlB8ILMIH4n2Yal2VY+eXLIMM7IU+VoUevbh8rDs7/sh7MZ4LMTyFfCLUhT+8ekbVx+GJrJxTsy8K+RYRGAUugsGoaqYpel8HzKLpxAIXc/7gcgoYhFTuv8PYPxKjGKPwpXb9AjmV4399s130Z+kJzeMkjk+OkzRkjOlzxFttlgNfCUGUL3EfAIqUL7PC7GgZJVPrboqRtNL9y5Rj/7p9F3aYAYHrOONywwvRd+gnfVjVe5xCBOwXlR6HGAUzOl7W/JwlhP5QUiiQTVCJgd5H0jsgC99UoNWYkFA+Yyo59bCHu5a9etTcn5JJtf06vCJrlRRhZy5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=L+T3nYesQgA9c8I4r+oIA2fk5UW0TLQdqGeRsWJJOWoXq6mfVQVgAAnl94CujW2JfFbr8Q8LVub9jyPo+HV64qj2OOuqO9Ii0A2ZKtX63kRjREUkP9zScUFocF040lKMcPzlEO2lLyjCCF2vt8P3A6tjonmcMMOGKtRIBv/qan61Hdyt0MdZ56YD+pZkK/aIFicvr3O2Ghl1vaw2HfczXT3/Tvr/a/P04cLmjrFEiivAVfQB8QN/0p7B6MDJu35fL6Fhoo9QN5TqzE2tLHK258JpIc9yq5VjYV2oQq/mUKA7TOkEnZTUWtFs1viD6GjcOzm7S91b9DSPu1HV3LLnNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=SlnI7C71gCYW7BkvB9BG9XVmXRUhhWC/0abRSx72g2j9UaCJFsL+xzRNUlZZ6CZGGWf5jt5QSW/IpC67B9oYIrMaz+cxleZObQkGF2/jmgcuIW2SJAm6QrgnU8B/2RCD7PiFXx7lvGpsLkL9TR7W88ZcNLfDiJG+ANNbxif4c7Q=
Received: from AS8P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::29)
 by PAXPR08MB6349.eurprd08.prod.outlook.com (2603:10a6:102:15b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 09:11:26 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:2f2:cafe::94) by AS8P251CA0001.outlook.office365.com
 (2603:10a6:20b:2f2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 09:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 09:11:26 +0000
Received: ("Tessian outbound 20615a7e7970:v228"); Mon, 06 Nov 2023 09:11:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2fd4e6ce7bdd9698
X-CR-MTA-TID: 64aa7808
Received: from e72ed4ec88e9.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FE551C90-730A-4C5F-9B10-C5B9F18E7677.1;
        Mon, 06 Nov 2023 09:11:20 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e72ed4ec88e9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 06 Nov 2023 09:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfWyu7c0Lc9flCJ/mwFziAU0yo91yN6Ay0WMifexdHQh7jwufugedM81oAs0xaSYfSDFJul47EPu9xoorW+Puvg7t0YIN5dMpgDvUoNCLxGzGGskjEvrb3VoLHDpg+9A8sheAmPNJaaeh2/QqR+ni9CFYPQHlUborDW/UrQcQhEnEFAFsQNzWzGfFhCj5iHwhJWRhijt6nVA+ghFR4fapie41r0PfZNn4Lj5ZzYwN4+CpsT5eKsZJvrb9jThuZ2llCckkmB8HP6r0JfOc8mszQveiWPY9MBAcCn8dDMjtBTTuFVe0NM8EjA7HWxBMKCf2oyQPW5RXNPxvumPAnGgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=DqzdJHeacnB4RGkTbqjQOV7IJ4m8mwOriwF46Qvkx0M0MxOc9q5hzO+N4jtmx70wrSknVVKSk5C6xAbgx/jZX6SyYtWCnr3OQdQBM0N4zORnBGGeicBsFTAfRo2KxpOzvzdxOF9AxiacyWDnKCiUe+BARNtOgqjpw/O6VNJwH+vQYRJAXzjbx3Ai6s+kU1cwlppOPuJr264EOt+g+1aLu7xQSZsk3F+ev8TlfIwJ1Z0nuQkoKARSgTRKbvMytWcEB42myGzV5zm2di2rpBWlabUeB47vvwN6QOlh1NgDWR5jXQGtee4ZatF8jMfyQ8iWDwLxgmCZYBF01oHofz0RBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=SlnI7C71gCYW7BkvB9BG9XVmXRUhhWC/0abRSx72g2j9UaCJFsL+xzRNUlZZ6CZGGWf5jt5QSW/IpC67B9oYIrMaz+cxleZObQkGF2/jmgcuIW2SJAm6QrgnU8B/2RCD7PiFXx7lvGpsLkL9TR7W88ZcNLfDiJG+ANNbxif4c7Q=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAWPR08MB8838.eurprd08.prod.outlook.com (2603:10a6:102:337::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:11:18 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::1dde:912e:5599:2729]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::1dde:912e:5599:2729%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 09:11:17 +0000
From:   Justin He <Justin.He@arm.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH v4 0/2] fix dma_addressing_limited() if dma_range_map
Thread-Topic: [PATCH v4 0/2] fix dma_addressing_limited() if dma_range_map
Thread-Index: AQHaCYh/HkxQHzgqYkq+Nqv+9m8GdrBs9PgAgAAaQoA=
Date:   Mon, 6 Nov 2023 09:11:17 +0000
Message-ID: <DBBPR08MB4538F0C2E53B4EEE86582A1DF7AAA@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20231028102059.66891-1-justin.he@arm.com>
 <20231106073656.GA17712@lst.de>
In-Reply-To: <20231106073656.GA17712@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|PAWPR08MB8838:EE_|AM2PEPF0001C70D:EE_|PAXPR08MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 259c1121-3707-4b81-9a4b-08dbdea85b25
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Hpaqwg/xtdYdGQtI1MDP2bN6kaVAsEVS+Yp6i+OM9kaAWQjdzGq4tyIoydZ4yTRjRXAlI8Rp1iZ9VRIktP1wd1SPw8WdG5C7jiUvwjsOip8e6Yu3Zl3Lw5Qc/XnIrSgvRS/em7EHfyNCXIyUeklAIVUx9dvsWCloCIFWfe4NvdGTR7yG3QZFWJzNhvfevuyp1HW/IywHqeRwlikmNoDLHOuKquLI4/XIVKewH2g+3J9y4NySMsuCCe/ecbgIpH1mpiOhhsZ9GWxcDd8dDGUbTMFYFuihgIOn79T+3rjybhdyaP7wUwoLfIgM8SBUQv6M586l0+HFznwJ8o1EH+OldJ7DrM3B0e+kDAuIL6tn4GVb5bADo2UySLtU5fE9zoS8CfCrJATKzd6pIyi/6tQU43WnxAB46jL+HFToZs+nDqftdt7+gCrxCsvXMDCyiRFGtvbqllH1dGYNuF/BWdTsZdWtuMkLlKDTkETpJx73eXAdxmsTwqHdOTVHSR2I/EhzR0XPknRMPVnE7z/1zBovC0qFNmkRKhenS2/+ncq9QRrRPcfX8kT6+jhW9GQtoVOcGB1vwunJhtelz1qBEVmtoaOfezT/mPLAWT1pajPF4jqblju28lEMPu8h30xQyPXD
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(9686003)(66946007)(76116006)(26005)(478600001)(7696005)(55016003)(6506007)(71200400001)(52536014)(8936002)(8676002)(4326008)(66556008)(66446008)(64756008)(54906003)(66476007)(316002)(6916009)(5660300002)(41300700001)(38100700002)(122000001)(86362001)(2906002)(38070700009)(33656002)(558084003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8838
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b06cba9c-5c3e-4ac8-75de-08dbdea855d5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrPdKGbnjK/pd4sFc3wkiNxzeR/8ijCM+Pt210ePtspliUCItsOGpwjbc7vM3Qsck7AooSevNztb1+d8iKpTJc62CwTwKQaAOwWueVKNaORLt55JEZxM6rhbEHWmiLTNIb//RhGZM4/EUIvpWWz6cYrPvZR7o+DoSqNdWebd1uelAz2f6tj8+D/X2bBZaVoDSLEsbsS0EcR8xAN2Wm2BUNkS69p+gZjM3SfujKn5eo+EjqPwRGpTn0k54lZs5JmXQqMHtbC9QHKjL7oxM4xomHxU8JeQvFAd7kGogNkd3RyCenioFrnl1E+L9WABdhd3mCvgmaQScfrADRuDEYA7PHp0sowQQEguGvhTq8UQZ74TtO7kQPXlaBXBF4RsE8FYISYCCs+QEAaz8CGr5nKZpJp2AwT/+3lCesR+V1SFkrpqz+PG3anx4bBR4yZO+3ZIyn1twHhE4akRk1XwEENsnZWDnjF+ulzTW+9bQVpR/cIHa8KkRPY4DyqkIeUlyX7eEW9lZXg7j8xTbk272gS3+h7S/THWdAPOd2tgrf/jc+Bx757El1CGWj/hnxe4Tq0lUaHPb4jx2h1PY4OCYukkSSf2VNc1LnWIjUK2QQ7eMmuONcGihrSi2/aYddp/ErpP5w/p+WIfDzieCFY5eYw2F5dxDzIaKqstVQYUXyQFCsZ3D5jDcXpAQBplKjVWeGlzxqiBjOlKK1RIVaVy2urXJXLepve5Ibc7U+VQ+9fCAwo=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(9686003)(47076005)(6506007)(7696005)(336012)(52536014)(83380400001)(8676002)(4326008)(8936002)(6862004)(36860700001)(2906002)(5660300002)(26005)(54906003)(316002)(70586007)(70206006)(86362001)(356005)(81166007)(82740400003)(558084003)(33656002)(40480700001)(55016003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 09:11:26.7651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259c1121-3707-4b81-9a4b-08dbdea85b25
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6349
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IFRoYW5rcywN
Cj4gDQo+IHRoaXMgbG9va3MgZ29vZCB0byBtZSwgYW5kIEkndmUgYXBwbGllZCB0aGlzIHdpdGgg
dHdvIHR3ZWFrcyB0byB0aGUgZG1hLWFwcGluZw0KPiB0cmVlLg0KVGhhbmtzIGEgbG90IGZvciB0
aGUgaGVscCDwn5iKDQo=
