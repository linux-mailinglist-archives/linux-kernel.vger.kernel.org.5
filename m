Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4C80D45E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbjLKRqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:46:35 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E6C3;
        Mon, 11 Dec 2023 09:46:40 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=BUgY3qtVL1XVNPkoZxpGYWvsrAxWM2ZWOvgl/LJ3YOtbhk1p8CZyKTvj+FKTz2UdCI7iGk4MPRXamYNKmj7XJZxqTbmRy5+bzUrlYb/7RQ8ehiIMkPYUhhsbWOWJpwLxQnoMlApvJtsP/Go6b+GEeFjNrHr/7VrIgkxsXGEj2QHd4SF8OAOUIGcjT0z5QbIFcYEjGgN34iaXkXnma/GJwZigbC+E4FGkwadeInyGQsI6y+tACSSSnWVUtW5+lPrf1+jkTatXo9THHwD0H/kW4qe4h3n+7xmbJJdLXq1tSjqZb4fu1iK57uie+unMSUjos5Dv9A7cz09SJamvvgIs9w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd1hwlEtG1W2t8J9aVgRhuNjoF8ywFjyTb6Z7hd8jOU=;
 b=dtZjU/anKPJmoFVyJ1fU83TZG21ExH7LoQUQ8KXa2WtoMQ/Vj/HxrEvAhj9DbIm31Gh8eYjvBXXsl1xq1ylUpk4d8uVTantjPM/XfWzeQdcYn8GDYzrhNyLrzLoYOJ35GuHDR/4plkR5uEqEOcUvApmZKXfMFux44rAqk58tnB+YmpYlvXRLA68QZeYuNSXHZEAf1iXJBc0GHE/b1AMPpHJ0Gc77fxh9eyj31aB8WEaj84O4kacB+Vi1/TkMPv7mp42YtiR2y39uB9ophQL+TP1nIZXNzGTPGFS3Ku/ZXvRakE+cYI7Cy0uP0LR5uc3FngL9dHqTx/CmVBd4SMYS2Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd1hwlEtG1W2t8J9aVgRhuNjoF8ywFjyTb6Z7hd8jOU=;
 b=OQ4aFPunZ6D012y1OcdYfrulhHnat+QX5rVUXJeLBdimAkc4xCcWrvSroIrbMi3XDFdGiQL4EZvOrL/LrpGBT4q0ccA09WhR7ZH24sqfJgC52PipNSyuZRnZoL/dZM99l7NxKOu7HEi0CXT7hKmrQA3vminUZIddQ86rtJpj0NQ=
Received: from AM6PR10CA0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::45)
 by AS8PR08MB8420.eurprd08.prod.outlook.com (2603:10a6:20b:566::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 11 Dec
 2023 17:46:36 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:209:89:cafe::99) by AM6PR10CA0032.outlook.office365.com
 (2603:10a6:209:89::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 17:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:46:36 +0000
Received: ("Tessian outbound 7671e7ddc218:v228"); Mon, 11 Dec 2023 17:46:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e38cb1925a5edd6d
X-CR-MTA-TID: 64aa7808
Received: from a809d27c7474.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 07829BAA-2B14-4939-9C6A-5C4C3BD194EE.1;
        Mon, 11 Dec 2023 17:46:25 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a809d27c7474.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 11 Dec 2023 17:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSYvDixkeb33DDT5bSOBpTCopWA415u+TDOj1Y9RSewcG7+EBviqJfaAvwgXSfFRGKwvt7ec+UdyvFYvwZvB2dlud+ee9j/iGmmqIVRHISveH1Zy8M6YmGNR9mqtKl+83Isg9Fk9ts7mHWSUzxzwQci5rR/FdPhPRb5yKjE7XTkDukH5CkuLqOS8r7WfKqLir+jLHWumop99Ow3sxvwlfrpGePLNm+l1H65+pzILTK4BSNoYghKWU8VcM1K7OUCIREPpfwPcoebpf3xoRFqCFGmYVVapFrY2CYQpJeWTGfpruqqebCaLCNNjpDYPfMbKUN+f6wQb2dYJokiRdnsJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd1hwlEtG1W2t8J9aVgRhuNjoF8ywFjyTb6Z7hd8jOU=;
 b=Aa1Y8Gsh/8UQ41ezbWvQ8LfERfksaM40EzqxZacvocV0WQMFYWLrFfn6VZlAruBZdnSKpjmFhrQgosSmVdv0ZvmjGfDhJjrH4ahH8MAn69KUjFt2kSm8fH6QjCSSowy5Faj5243WvJ6q0k3rwddBXwpf/k/i/fHOoTNDB5nDTm59BmuNJjk4cTDn67QEj3In2C6X7UvrGJla5z01GphnKjl4SM8jmSegTVrO/7oR07SACgjzXpj+RVdkWjQiW/iLjmkyJ7PddsZ8ONTsQ0NwBA2dHLCZGzzC7VY613y3GMzNWfVGPUteY3p5GtxntbAt/CeokEZ/ugk7wXhWD1v4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd1hwlEtG1W2t8J9aVgRhuNjoF8ywFjyTb6Z7hd8jOU=;
 b=OQ4aFPunZ6D012y1OcdYfrulhHnat+QX5rVUXJeLBdimAkc4xCcWrvSroIrbMi3XDFdGiQL4EZvOrL/LrpGBT4q0ccA09WhR7ZH24sqfJgC52PipNSyuZRnZoL/dZM99l7NxKOu7HEi0CXT7hKmrQA3vminUZIddQ86rtJpj0NQ=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by GV1PR08MB7988.eurprd08.prod.outlook.com (2603:10a6:150:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 17:46:20 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bfb6:4b42:707:fed6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::bfb6:4b42:707:fed6%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:46:20 +0000
From:   Ben Gainey <Ben.Gainey@arm.com>
To:     "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH v1] perf tests: Add perf script test
Thread-Topic: [PATCH v1] perf tests: Add perf script test
Thread-Index: AQHaKTSSMSQMuSRe6kSA2XUpgTX3G7CkYX2A
Date:   Mon, 11 Dec 2023 17:46:20 +0000
Message-ID: <1ba595108f13fbe9e062b92e2c717f37e6a5ca93.camel@arm.com>
References: <20231207174057.1482161-1-irogers@google.com>
In-Reply-To: <20231207174057.1482161-1-irogers@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB6646:EE_|GV1PR08MB7988:EE_|AM2PEPF0001C714:EE_|AS8PR08MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 363d90ad-04ac-4910-b934-08dbfa711f6b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0X3MU6+5nl3/8/IgXgA2i4XB+ZfUZR1nPDsgF9pvQ9+iT4KMJqN74N7tFv3K06ehO6SN6eZncT3E2HEFyVT8xnRRVaUL9zT3YlRCpk332lc7NMDwAk5ugv3zVkaaCBW1XUrMFIU68reSZJjzmvuwJJqXf+tPbbQfYWjRjoBy08+mR7AJwj1nlbMN0yi3IJtZYel26nFvGV3wb++LgCKFPNkF6o5IOXG5g7c1wgvH+jfSN+JQlXNWjZfMgc+rf44vEWhzSlj17h3eyk//rHdQKrGb424yCEOt/Xv+S8PNbqsfXUNE2BMU2jkQcMWY/khLBDRztSdHVLHO1awxQAqGYCRxqBeLzLU03eGZtgkWQWEsA9RJ+WrrNElyvF3rsBrcEB/f4iWpKr4kY2khr/IB8/fX5sogOgghx0FjbMil8GDmWGT5nQAt9j69/AMaVXLda7GyNm+GkyipjemwyZ8nEVjp3G8C6RCWprrQnECjwslotVHL0EKtw5JmNeDeaqPQ/dPdihq+4gpKLA7J/uuqwbX3NL/JYP5v3DHrqtNHAh50+arC0KT29sO90WscC5BZKQCHEAyk8VqFQ2QySGy+tWMGfcur1rA40bqeNyEQXNdehU54RMZflkwExLYTXccP
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(26005)(2616005)(478600001)(6486002)(966005)(71200400001)(83380400001)(4744005)(7416002)(2906002)(5660300002)(41300700001)(76116006)(91956017)(66446008)(64756008)(66476007)(66556008)(110136005)(316002)(8936002)(8676002)(66946007)(38100700002)(921008)(86362001)(122000001)(36756003)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABEA31FE50F38C45B61C7BAEEE2BAF99@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7988
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0d2fde85-c7c1-4080-1b88-08dbfa7115ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDL8q9JHEU2LYRt7OShSezpRMLjIahrifKv59TnuOQRcRmdLrXlqGAxELnrQhcKTld9CpVwHAMch7v3Ml6V1LRkjYsawSbz7UhWvEEZco273MrKn5Wm+9Wg/2D/bEqPgfIgte9UNlp1yDSlOpwDJIJXcD9/9c8VfgYNKFRcYfTn81PXoXaVgRbetdP1VSZn6/6ipvt2cHVT6JgdEtTzv6EttIhzXkQhTaySGumz1nwBlpfxPJrbFILQHeyef8tfXTTkH6XTRAZ8ot2QfIgwOzg/3uSn3Y6aOK2z10cYv38nNbAI5YkThXFZ3fYzx0J8QNprBVeyPbeYtJJqo7BzHw6eN1vI+H3346ZepvHPhdPjjej/BUDq0SlzwBY1/aRZxiXlYv4X0CXlrIg2JYGXejSXNI9mVrHN8eshpdfQlZ8tPTBsaDzLSIBIH/kUrV5Ty0F3uQINWNl6g2JkH+yBcepABUWLi1R5e2WJ6sTKdehdStRm02x6N31WCwrWRILf3lySaxB6NHXRxFrGDPZmPK4Zdtz+vL9s6r/mq1JO2Cvd0iDiVuciJgOna7ZWHHg1nrrGftwWkoWHGz/qAw7TaqUNuvWpo6Gf6yHDqUn+xtiVovKb3oy4CthH9BMjbjiLlJKtexlcZkw2oKk9L6rgI25XtA8nPM7CxvwfiYXt6/YGfa8HZvNdyN05z49WZpOObTvFYgHcRm+mBhxJYSHJa1eY0f6uLBIK452i+7qOtUwLEzOvxP6NTDaX76Lv1Q0A/
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(26005)(2616005)(40460700003)(83380400001)(336012)(478600001)(6506007)(921008)(82740400003)(966005)(6486002)(6512007)(5660300002)(41300700001)(356005)(36756003)(81166007)(8936002)(450100002)(86362001)(36860700001)(8676002)(110136005)(2906002)(4744005)(70586007)(47076005)(40480700001)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:46:36.7834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363d90ad-04ac-4910-b934-08dbfa711f6b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8420
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDA5OjQwIC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBT
dGFydCBhIG5ldyBzZXQgb2Ygc2hlbGwgdGVzdHMgZm9yIHRlc3RpbmcgcGVyZiBzY3JpcHQuIFRo
ZSBpbml0aWFsDQo+IGNvbnRyaWJ1dGlvbiBpcyBjaGVja2luZyB0aGF0IHNvbWUgcGVyZiBkYi1l
eHBvcnQgZnVuY3Rpb25hbGl0eSB3b3Jrcw0KPiBhcyByZXBvcnRlZCBpbiB0aGlzIHJlZ3Jlc3Np
b24gYnkgQmVuIEdhaW5leSA8YmVuLmdhaW5leUBhcm0uY29tPjoNCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDIzMTIwNzE0MDkxMS4zMjQwNDA4LTEtYmVuLmdhaW5leUBhcm0uY29t
Lw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+DQo+
IC0tLQ0KDQpUaGFua3MgSWFuLiBJJ3ZlIHJ1biB0aGUgdGVzdCBzY3JpcHQgYmVmb3JlIGFuZCBh
ZnRlciBteSBwYXRjaC4gTG9va3MNCmdvb2QgdG8gbWUuIFBsZWFzZSBmZWVsIGZyZWUgdG86DQoN
ClRlc3RlZC1CeTogQmVuIEdhaW5leSA8YmVuLmdhaW5leUBhcm0uY29tPg0KSU1QT1JUQU5UIE5P
VElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUg
Y29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwg
dXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24g
aW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
