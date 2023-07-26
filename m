Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7723C762AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGZFwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGZFwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:52:21 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C21985;
        Tue, 25 Jul 2023 22:52:20 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PLPQgr032073;
        Tue, 25 Jul 2023 22:52:03 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s2by4ma1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C494ct4Gucqgul3o+WGuZCAsyZATH7aRBhkEkY2/ePCNTkYceNzzrMClrKJIrBWw37gDhCsg1NC93yNDGaVql/g1ZftMNz6yrnbv4GNQGphhxMaThMb94QQ8fKmGtPTg2BWQAsLTqiBM4t9FCZPYSDA6k4c7RUwvKGr6L/tzcDGCqUDxinko3g8CsSpkItu0Bn8SbAsU/RDxMO5aTsJkXb91FLvRNytNDVzEaqHLvgOEtaUXWIJ0i/w9Y/SddVKB9fygLyzk0+HVI/706t/D48YZ8XDXXHrWYNGjaYf23h+MLYAU6Egzo4SwZIb8bCuQ7EGIoUA3l3nMx1bTgX5yvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u//w1pieEn/63i5ClS4Q7MVpDr1sZ77KkdLBcsjBVR0=;
 b=GDzNkqVzIUvwJVP3K1hiO4i2kL8vJoKahYlUBwf6NMhsDgdDDqBMnBNHBdpgoGkiwVi6h5kmrLEwcRnSgGN0tWErR8Etk3TBlS3KpL5hXcKb4aNoz6rE+q3CbMhoxT3fFRNz+OHOGJb6BCzL+g1sBBghgH9ENkQq/y9zwfKj+BfC1wFwAf+U9DSyI8hPWFtV+2QmSWhLaDQVCCc2GT4L06kr8qRGvoFawjDqueUD2VA25q5aPgC52EO6YMTzdwosGd+XO6rsDKpQOlQkkNvisC2IBCyj+XcfCG487dZdeZeDCNHk06mXw+Q8ap2EBWwgsA7B//0GmsPrAWUP6yg9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u//w1pieEn/63i5ClS4Q7MVpDr1sZ77KkdLBcsjBVR0=;
 b=KNyYvWOnNvsHGgkHJsj8ZMaGnf5pohiP77ES+h/zKz9vN3UR6gwqLoPTa2RVDp8JGy3BsWwplxbQbDjG++RLhjZ/QnMNVsD1O9ehpGESjlukp2QW45EYCoIqKmchcR/aUnseF24LgcP2/IBBlLg8kuUAIx0A2c5ouObKtAxgqq8=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by MW3PR18MB3625.namprd18.prod.outlook.com
 (2603:10b6:303:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 05:52:01 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::7441:799:fdc0:3bb6]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::7441:799:fdc0:3bb6%6]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 05:52:01 +0000
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jhs@mojatatu.com" <jhs@mojatatu.com>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors
Thread-Topic: Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors
Thread-Index: AQHZv4VLL/jNdUAPUUSmBCHMvyqPLQ==
Date:   Wed, 26 Jul 2023 05:52:00 +0000
Message-ID: <MWHPR1801MB1918A18D9B6ED2A202775FD4D300A@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20230725032451.505189-1-rkannoth@marvell.com>
 <20230725051158.GG11388@unreal>
In-Reply-To: <20230725051158.GG11388@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccmthbm5vdGhc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04N2Q5ZTlkZC0yYjc4LTExZWUtYjZmNC04MDM4?=
 =?us-ascii?Q?ZmJmMmM2MjJcYW1lLXRlc3RcODdkOWU5ZGYtMmI3OC0xMWVlLWI2ZjQtODAz?=
 =?us-ascii?Q?OGZiZjJjNjIyYm9keS50eHQiIHN6PSI5NTEwIiB0PSIxMzMzNDgyNDMxODAz?=
 =?us-ascii?Q?NjA4MzIiIGg9Im9lZ0t1cjkrS0thNmxaSVZ6Qm9oOGNHQk1tbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40UEFB?=
 =?us-ascii?Q?Q0FGREJLaGIvWkFXdEp5ZXVydUI1bmEwbko2NnU0SG1jWkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRRUJBQUFBSTdxVHBBQ0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFa?=
 =?us-ascii?Q?QUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?us-ascii?Q?QmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdC?=
 =?us-ascii?Q?MUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJqQUhV?=
 =?us-ascii?Q?QWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFNQUF5?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?TUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dC?=
 =?us-ascii?Q?a0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcw?=
 =?us-ascii?Q?QVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0Jm?=
 =?us-ascii?Q?QUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhB?=
 =?us-ascii?Q?Y3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFHMEFa?=
 =?us-ascii?Q?UUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3QnpB?=
 =?us-ascii?Q?R3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdjQVpR?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0FjQUJm?=
 =?us-ascii?Q?QUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFHWUFh?=
 =?us-ascii?Q?UUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpBQmtB?=
 =?us-ascii?Q?SElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQWdBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFG?=
 =?us-ascii?Q?OEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFC?=
 =?us-ascii?Q?aEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhN?=
 =?us-ascii?Q?QVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFiZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FC?=
 =?us-ascii?Q?eUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFB?=
 =?us-ascii?Q?Y2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhBWndC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZd0J2?=
 =?us-ascii?Q?QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?YkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3QmtB?=
 =?us-ascii?Q?R2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFh?=
 =?us-ascii?Q?Z0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FH?=
 =?us-ascii?Q?VUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?RzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJn?=
 =?us-ascii?Q?QmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3?=
 =?us-ascii?Q?QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFY?=
 =?us-ascii?Q?d0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFH?=
 =?us-ascii?Q?RUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhBYndC?=
 =?us-ascii?Q?bkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3?=
 =?us-ascii?Q?QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FI?=
 =?us-ascii?Q?SUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1BZEFC?=
 =?us-ascii?Q?eUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElB?=
 =?us-ascii?Q?WHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1QUhV?=
 =?us-ascii?Q?QWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|MW3PR18MB3625:EE_
x-ms-office365-filtering-correlation-id: 6b5ceca0-7ad7-4b20-746f-08db8d9c6e55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+K6tH750dO2Nw82aSgxc3m/HWv5KmNQYL1iBEpXKdVZRZR9I4fWG94so33/VVJxQwBKV1huoc0vxGTAuYit9QnFsJJxficyKQJHLWrDx4/lnkU5XpZP40uHpyuUDLud2xUqFlx1jwa1mKEdPdRlaE/36fXkG9ZEl4k8Ecptbe0Pzw/Pm815KjBVlXBtIp0i32gF54Qd0D7OPS0nMorYwqatPaWmwy6d6XJuH+52quwPJjwGy5/riuWcQLfU+8MaHgzHCACn7O7rjgSWW8Dl0h39dGF18NPUrZGrGheaTS0ahzVUHTVBOphv48iugTbDFq1brIHdNAFoS+f3ECsSZ3dLYEQxWQAeE2dJ05RDK4NsLeMQIhYo/KpNDULFL7pttDC+FrpxhJ7tDIz5SAQsWkk6VKkEZ0trymLmdjAIJI3jAndHdlnGFqxewsk1Cm9RqIsxU/Hi1RRzdhpQkbsrwt92COe/xkQpyfpbwc/TjUCpLlTJYXVjwfJ1iZdk7OoSskYtboadyzqQ3WilFD5DRO6uwx0N4SRzulMC9P+gXRoWmUE1nojVr6fu7zsRU3kQfk3M8ZMZRlEUei+GF483PVcSrM6QM0qCWSPfJDMAEGFxhGLs0Tz69NITEQwgyfQn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(7696005)(66946007)(9686003)(478600001)(71200400001)(83380400001)(55236004)(26005)(6506007)(66446008)(66476007)(66556008)(76116006)(54906003)(64756008)(4326008)(6916009)(122000001)(186003)(38100700002)(38070700005)(7416002)(5660300002)(8676002)(8936002)(52536014)(2906002)(316002)(41300700001)(86362001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KKDCrwdCKaettX2FdPXVc2ipiFoaKUvAz+a7NqQve0+IhwPzT9icVJJdCVzu?=
 =?us-ascii?Q?XmSgnnF4zlB0FUhOV8+pRxpOEA3OtDPnNhpUvDHcTTrr32rxIFUy5stCyAew?=
 =?us-ascii?Q?4O3CWm0hxvou9/LLZzLfNujdgB2J8uZI1yOLWEHxi0L45+bWrQM2CQWsYLbi?=
 =?us-ascii?Q?Vqb7f6FVDdL49CtVnUCZ8sKEHhkNEFuQfIxdI4yVWZn+OmsndgOU65IWsimh?=
 =?us-ascii?Q?ljVH1rAYQKOyUI/rMzjVLYzJJNsNljUx6rx3AKbWQX5nohICA/79jOcDTqp0?=
 =?us-ascii?Q?l6CgVRsnByrumMTBqXqJQ7tRRRocheO+ylqv23SYW4rKE8HJDeZ/lOCPEvPl?=
 =?us-ascii?Q?X0zTTbAs29/lo86vEAjZ88jicUFThr7ybVCXPBmq6Vv7aDnRz9F+Gd85uTUL?=
 =?us-ascii?Q?6aKOxcT4YfGUGU95ZQ3A+39ZHDX4vrl2v8gX/N4b2rTcRAiDPuVGk3B5cQ7H?=
 =?us-ascii?Q?7uHeKD86kYkcPsHmXprHs182XzpNA9SivKreX2+QTS0siGxPqlPIEspvIeY8?=
 =?us-ascii?Q?zLJNpR2lbkLSVjai2pqRsFY21EPUN+auDnpFfssgXbUs5/GSMnwxwqjub8IQ?=
 =?us-ascii?Q?Ljs49FU0WaMTNKC4I8TtUlxcwboK/HMvd0PhHNSw+8aUs2oFZ6IoKsuRkZ5O?=
 =?us-ascii?Q?RNbUdjIzuKmWPZWB3CBalFEwXF39EZxNe7jk+AsOeSJRtDVb5/MO+Re3xhZo?=
 =?us-ascii?Q?wiuJ2OqwKTaO7FFpTNuT7GI+1oK1UC/jiWE8A6f7+ZlGAeZo+mQdEkcbjo+d?=
 =?us-ascii?Q?3kwBfgwcYOKlgzhgBOv0OWri0k3FMwxX5MPMRlbq07rBqj9T2ep5cCx7oQHO?=
 =?us-ascii?Q?DlqLTmnObXx/jubPACcqu1v3Oi2XxcgQcQL9ys++TlixtPv0cNE8SVu/SIzo?=
 =?us-ascii?Q?FTTyPOh8E0T7Yo+FcypMQHuzQSI0MUGfQIaPq9irxbEENO1YTRNy4MHhmmu4?=
 =?us-ascii?Q?d9jx7ODtyLM86/hsgWcM82R55kO6VFoN1U3zkm8ycZTGMdcagIbgnLoCq07F?=
 =?us-ascii?Q?m4AdkS1tKlFdP47pVQLPavQYJ+LU0pgZnshWr2F4XeSgSPPXf2GU/UNLJWAb?=
 =?us-ascii?Q?kImJF+wmiXSYNu2TdJnyt6D6R+dsMKwNUn5IPd8mK63wqDXMhC7TUTcSKtYR?=
 =?us-ascii?Q?dYNEOpHfiqZ2YAEJTX9/3+0t4zaa5N9GAf6HyWEL5UdvKjfVcPucJLVBJhCG?=
 =?us-ascii?Q?bnjjtqdp8WY+HQLij0USefgb/gbvvJ4mtMK/J5afbPPhJll7ZZ4k47D6PiRR?=
 =?us-ascii?Q?KtK8NkRRV7wowAgF3E8xR5AU7LDTtXzlUY4ZZGKUt5sMevqA+IH+PLb3TRQa?=
 =?us-ascii?Q?rjVFT4n323CvwhYP6jytiH5Blehx8sESvpIO90ZeFbew2swSYkwYLhogdVG9?=
 =?us-ascii?Q?dInP04VbC11r5PGU6Y86Z48qTb5wcjCaw+g6nrrqvXE36PYWZzUPTUR7bSNE?=
 =?us-ascii?Q?xNtP09LjAgEm+rPQv47E/dblk7OyiCUzj/dVxZkP/MgYimWyP0qeqT55OBvf?=
 =?us-ascii?Q?OXIClDYR91H2zJr7X5kFXUINHopQz2gHBmMHvvyKQ/HrjJ8JyrmxcT/3W0ZB?=
 =?us-ascii?Q?Zr/4itVkloINR2ROW7VETw/87F1XDPYfCB9kMFgN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5ceca0-7ad7-4b20-746f-08db8d9c6e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 05:52:00.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ix7gZO/0DQQxCQezURwHFfkM2yoB0YdjiBpGkTtjOmTXnQYEDZiLfbo9WzlSBtg/cAbCPsZ0IltyrHSyCKU4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3625
X-Proofpoint-GUID: 19-wtf7b5Wn3t9yD36SJi1LTu3ZJ2d0r
X-Proofpoint-ORIG-GUID: 19-wtf7b5Wn3t9yD36SJi1LTu3ZJ2d0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Leon Romanovsky <leon@kernel.org>
> Subject:  Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors


> >  Support for dissecting IPSEC field SPI (which is  32bits in size) for
> > ESP and AH packets.
>=20
> Please don't add extra space in the beginning of lines.
>=20
Ack.

> >
> >  This implementation does not support NAT-T  (encapsulation of ESP
> > packets over UDP).
>=20
> And how will user distinguish kernel which supports flow_dissector with
> NAT-T vs. without NAT-T?
Ack, will modify code to return error if ip protocol is neither ESP nor AH.=
=20



=20
> >
> > Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> > ---
> >  include/net/flow_dissector.h |  9 ++++++
> >  include/net/flow_offload.h   |  6 ++++
> >  include/uapi/linux/pkt_cls.h |  3 ++
> >  net/core/flow_dissector.c    | 53
> +++++++++++++++++++++++++++++++++++-
> >  net/core/flow_offload.c      |  7 +++++
> >  net/sched/cls_flower.c       | 18 ++++++++++++
> >  6 files changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/flow_dissector.h
> > b/include/net/flow_dissector.h index 8664ed4fbbdf..ffec739f049a 100644
> > --- a/include/net/flow_dissector.h
> > +++ b/include/net/flow_dissector.h
> > @@ -301,6 +301,14 @@ struct flow_dissector_key_l2tpv3 {
> >  	__be32 session_id;
> >  };
> >
> > +/**
> > + * struct flow_dissector_key_ipsec:
> > + * @spi: identifier for a ipsec connection  */ struct
> > +flow_dissector_key_ipsec {
> > +	__be32 spi;
> > +};
> > +
> >  /**
> >   * struct flow_dissector_key_cfm
> >   * @mdl_ver: maintenance domain level (mdl) and cfm protocol version
> > @@ -353,6 +361,7 @@ enum flow_dissector_key_id {
> >  	FLOW_DISSECTOR_KEY_NUM_OF_VLANS, /* struct
> flow_dissector_key_num_of_vlans */
> >  	FLOW_DISSECTOR_KEY_PPPOE, /* struct flow_dissector_key_pppoe
> */
> >  	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3
> */
> > +	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
> >  	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
> >
> >  	FLOW_DISSECTOR_KEY_MAX,
> > diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> > index 118082eae48c..9efa9a59e81f 100644
> > --- a/include/net/flow_offload.h
> > +++ b/include/net/flow_offload.h
> > @@ -64,6 +64,10 @@ struct flow_match_tcp {
> >  	struct flow_dissector_key_tcp *key, *mask;  };
> >
> > +struct flow_match_ipsec {
> > +	struct flow_dissector_key_ipsec *key, *mask; };
> > +
> >  struct flow_match_mpls {
> >  	struct flow_dissector_key_mpls *key, *mask;  }; @@ -116,6 +120,8
> @@
> > void flow_rule_match_ports_range(const struct flow_rule *rule,
> >  				 struct flow_match_ports_range *out);  void
> > flow_rule_match_tcp(const struct flow_rule *rule,
> >  			 struct flow_match_tcp *out);
> > +void flow_rule_match_ipsec(const struct flow_rule *rule,
> > +			   struct flow_match_ipsec *out);
> >  void flow_rule_match_icmp(const struct flow_rule *rule,
> >  			  struct flow_match_icmp *out);
> >  void flow_rule_match_mpls(const struct flow_rule *rule, diff --git
> > a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h index
> > 7865f5a9885b..a90b0e3d351f 100644
> > --- a/include/uapi/linux/pkt_cls.h
> > +++ b/include/uapi/linux/pkt_cls.h
> > @@ -594,6 +594,9 @@ enum {
> >
> >  	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
> >
> > +	TCA_FLOWER_KEY_SPI,		/* be32 */
> > +	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
> > +
> >  	TCA_FLOWER_L2_MISS,		/* u8 */
> >
> >  	TCA_FLOWER_KEY_CFM,		/* nested */
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 85a2d0d9bd39..7162594d7940 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -205,6 +205,50 @@ static void __skb_flow_dissect_icmp(const struct
> sk_buff *skb,
> >  	skb_flow_get_icmp_tci(skb, key_icmp, data, thoff, hlen);  }
> >
> > +static void __skb_flow_dissect_ah(const struct sk_buff *skb,
> > +				  struct flow_dissector *flow_dissector,
> > +				  void *target_container, const void *data,
> > +				  int nhoff, int hlen)
> > +{
> > +	struct flow_dissector_key_ipsec *key_ah;
> > +	struct ip_auth_hdr _hdr, *hdr;
>=20
> In tunnel mode, this struct is ip_esp_hdr and not ip_auth_hdr.
>=20
> Thanks
>=20
> > +
> > +	if (!dissector_uses_key(flow_dissector,
> FLOW_DISSECTOR_KEY_IPSEC))
> > +		return;
> > +
> > +	hdr =3D __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen,
> &_hdr);
> > +	if (!hdr)
> > +		return;
> > +
> > +	key_ah =3D skb_flow_dissector_target(flow_dissector,
> > +					   FLOW_DISSECTOR_KEY_IPSEC,
> > +					   target_container);
> > +
> > +	key_ah->spi =3D hdr->spi;
> > +}
> > +
> > +static void __skb_flow_dissect_esp(const struct sk_buff *skb,
> > +				   struct flow_dissector *flow_dissector,
> > +				   void *target_container, const void *data,
> > +				   int nhoff, int hlen)
> > +{
> > +	struct flow_dissector_key_ipsec *key_esp;
> > +	struct ip_esp_hdr _hdr, *hdr;
> > +
> > +	if (!dissector_uses_key(flow_dissector,
> FLOW_DISSECTOR_KEY_IPSEC))
> > +		return;
> > +
> > +	hdr =3D __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen,
> &_hdr);
> > +	if (!hdr)
> > +		return;
> > +
> > +	key_esp =3D skb_flow_dissector_target(flow_dissector,
> > +					    FLOW_DISSECTOR_KEY_IPSEC,
> > +					    target_container);
> > +
> > +	key_esp->spi =3D hdr->spi;
> > +}
> > +
> >  static void __skb_flow_dissect_l2tpv3(const struct sk_buff *skb,
> >  				      struct flow_dissector *flow_dissector,
> >  				      void *target_container, const void *data,
> @@ -1571,7
> > +1615,14 @@ bool __skb_flow_dissect(const struct net *net,
> >  		__skb_flow_dissect_l2tpv3(skb, flow_dissector,
> target_container,
> >  					  data, nhoff, hlen);
> >  		break;
> > -
> > +	case IPPROTO_ESP:
> > +		__skb_flow_dissect_esp(skb, flow_dissector,
> target_container,
> > +				       data, nhoff, hlen);
> > +		break;
> > +	case IPPROTO_AH:
> > +		__skb_flow_dissect_ah(skb, flow_dissector,
> target_container,
> > +				      data, nhoff, hlen);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c index
> > acfc1f88ea79..bc5169482710 100644
> > --- a/net/core/flow_offload.c
> > +++ b/net/core/flow_offload.c
> > @@ -146,6 +146,13 @@ void flow_rule_match_tcp(const struct flow_rule
> > *rule,  }  EXPORT_SYMBOL(flow_rule_match_tcp);
> >
> > +void flow_rule_match_ipsec(const struct flow_rule *rule,
> > +			   struct flow_match_ipsec *out)
> > +{
> > +	FLOW_DISSECTOR_MATCH(rule, FLOW_DISSECTOR_KEY_IPSEC, out);
> }
> > +EXPORT_SYMBOL(flow_rule_match_ipsec);
> > +
> >  void flow_rule_match_icmp(const struct flow_rule *rule,
> >  			  struct flow_match_icmp *out)
> >  {
> > diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c index
> > 8da9d039d964..7ba839057d3c 100644
> > --- a/net/sched/cls_flower.c
> > +++ b/net/sched/cls_flower.c
> > @@ -72,6 +72,7 @@ struct fl_flow_key {
> >  	struct flow_dissector_key_num_of_vlans num_of_vlans;
> >  	struct flow_dissector_key_pppoe pppoe;
> >  	struct flow_dissector_key_l2tpv3 l2tpv3;
> > +	struct flow_dissector_key_ipsec ipsec;
> >  	struct flow_dissector_key_cfm cfm;
> >  } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons
> > as longs. */
> >
> > @@ -726,6 +727,8 @@ static const struct nla_policy
> fl_policy[TCA_FLOWER_MAX + 1] =3D {
> >  	[TCA_FLOWER_KEY_PPPOE_SID]	=3D { .type =3D NLA_U16 },
> >  	[TCA_FLOWER_KEY_PPP_PROTO]	=3D { .type =3D NLA_U16 },
> >  	[TCA_FLOWER_KEY_L2TPV3_SID]	=3D { .type =3D NLA_U32 },
> > +	[TCA_FLOWER_KEY_SPI]		=3D { .type =3D NLA_U32 },
> > +	[TCA_FLOWER_KEY_SPI_MASK]	=3D { .type =3D NLA_U32 },
> >  	[TCA_FLOWER_L2_MISS]		=3D
> NLA_POLICY_MAX(NLA_U8, 1),
> >  	[TCA_FLOWER_KEY_CFM]		=3D { .type =3D NLA_NESTED },
> >  };
> > @@ -1894,6 +1897,13 @@ static int fl_set_key(struct net *net, struct nl=
attr
> **tb,
> >  			return ret;
> >  	}
> >
> > +	if (tb[TCA_FLOWER_KEY_SPI]) {
> > +		fl_set_key_val(tb, &key->ipsec.spi,
> > +			       TCA_FLOWER_KEY_SPI,
> > +			       &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
> > +			       sizeof(key->ipsec.spi));
> > +	}
> > +
> >  	if (tb[TCA_FLOWER_KEY_ENC_IPV4_SRC] ||
> >  	    tb[TCA_FLOWER_KEY_ENC_IPV4_DST]) {
> >  		key->enc_control.addr_type =3D
> FLOW_DISSECTOR_KEY_IPV4_ADDRS; @@
> > -2066,6 +2076,8 @@ static void fl_init_dissector(struct flow_dissector
> *dissector,
> >  			     FLOW_DISSECTOR_KEY_PPPOE, pppoe);
> >  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
> >  			     FLOW_DISSECTOR_KEY_L2TPV3, l2tpv3);
> > +	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
> > +			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
> >  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
> >  			     FLOW_DISSECTOR_KEY_CFM, cfm);
> >
> > @@ -3364,6 +3376,12 @@ static int fl_dump_key(struct sk_buff *skb,
> struct net *net,
> >  				 sizeof(key->l2tpv3.session_id)))
> >  		goto nla_put_failure;
> >
> > +	if (key->ipsec.spi &&
> > +	    fl_dump_key_val(skb, &key->ipsec.spi, TCA_FLOWER_KEY_SPI,
> > +			    &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
> > +			    sizeof(key->ipsec.spi)))
> > +		goto nla_put_failure;
> > +
> >  	if ((key->basic.ip_proto =3D=3D IPPROTO_TCP ||
> >  	     key->basic.ip_proto =3D=3D IPPROTO_UDP ||
> >  	     key->basic.ip_proto =3D=3D IPPROTO_SCTP) &&
> > --
> > 2.25.1
> >
> >
