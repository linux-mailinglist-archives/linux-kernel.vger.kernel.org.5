Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24488812EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444002AbjLNLfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443981AbjLNLfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:35:44 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF92F5;
        Thu, 14 Dec 2023 03:35:50 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5ouHs014114;
        Thu, 14 Dec 2023 03:35:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        pfptdkimsnps; bh=X5wH0n7oiuIAPRZTF7gbzj7kxNW2Q7LbmqTNuou2WOQ=; b=
        iFiBDhc53HYNU+M7VXy/N3IW6Xp32ICHvF8AWy2MHVha5k2Sfv9kekC9vdWZve/Q
        mlMaPqXqsQLvcjC9nkRRK8AD4La308CxQPvdT3RPHj7gCBX7itur/9zSF123vcJS
        FnCDx0D4TwOp6KF/bOrsGsV1oYlis605f1wrF/yD29E7FRy8KnaJlIH+2y/Y/Qv7
        /Ewu52C0McfogiyFkJ8MkughD/Tny4oFogWOA5iFTehxqbQMTOZNQO/UXXX8dWN7
        hffT30KW3C35MAmITX+MmkJnP6DCT/AOqrs0JSxjJ0sn9FynjCFOsMnMAY6DL/YG
        ZjpOqmDbf6TsFfUpKG45jA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uxcr47nv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 03:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702553714; bh=X5wH0n7oiuIAPRZTF7gbzj7kxNW2Q7LbmqTNuou2WOQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DWCfZIfhMEfmskR1JRxlohOAQyWz5jGgOPsj67ohIDRkrkyHqzQtYrLcFAP/i4C2k
         /lu090R7ZuLh8EiRlWdF6/oJNBC97jjrULCrg2x8b4s6iRJZpcE9fwsZRug/iiHplh
         ChHAT7cJ4rsTUlZXSDu10CCrfk42xsurKkqYmdUwgE1UjMuSEwpZD/7SrlhLXBtsLs
         yD0fqEmeJe3bYD5553q0+ULWycjRsDsqD4UTSo89Ql8wnLvC5kyCnfsrB5rMCd/cVh
         tmNJavzqbhj+OYDxCiuDVDAweOSTKLuakarEZ4gwxNDIi7FS0X57Q2skMf4sANv9UK
         /wMFT7L3+MDoQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9217540528;
        Thu, 14 Dec 2023 11:35:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C7714A00D2;
        Thu, 14 Dec 2023 11:35:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NsDA50bE;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1DA04406FF;
        Thu, 14 Dec 2023 11:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmyCDZjza2cuLjjHzavYigBreZnPji7uwjUn40XLmdz9U9ymu53YjZNMojqnmCIdzXcZACR3UYYm9yTUP0MeSUuwP7RkwD4rmhrGfRVVKGu+jPCQn7Y9IHLFuR2Y3D+y0bOEgUio8WVsO5lYBGmX/uAgjI8tsYZHSKjA5rCerhQSqqHXWHmeO++yA+R6wZVmkQHW8VH68pMAwpVB9bKVoBW4dgSxvr19TyY4epnDoJBaDlnDKGNMLDA98LMw2PGYIh8btO9jAWiLIjzf9j5wdEjeuKj2nXUlwm418q79jFOyfpZS6qUr37sriHj40C5FIRsYaDAkeiKH8cwJN8DjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5wH0n7oiuIAPRZTF7gbzj7kxNW2Q7LbmqTNuou2WOQ=;
 b=oe43fmQ7lNr63J/xavoM5I63RtQs8TKdP1625NGNcTYnlhjblclZRxlHJT59KrWYEsexr6tB9Krs/iRI4nb7T4R6zP0HBfceq4bBp4XnmNV633w73hb7wIBwJoWex7bz/6flgwjFVwUXpAv91ZqNDOtsJ+u8Yk0QhkfVGdyAKd/yWIi/0jjEXDV4+yBvgKY+gsN+skkmzT7sOfew5vEdEimJmLIT4S/sHivKMp0T8X/EI+lSL1tAto/YvKQ0/5bnKKMhvnyxNF7s7jUmxK0TNkMAura/h9j4yfKIp78YIuWGD8dsbcxwxACubLEN6o69yfklESWVmXjhjMMcleUy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5wH0n7oiuIAPRZTF7gbzj7kxNW2Q7LbmqTNuou2WOQ=;
 b=NsDA50bEcwTLJN8PPO/yJl8IxkveofYglIoOdxZcculiit/+aesZTV+/foWopxyWXFf/TIoZJRReEKYY0tH1I7x3pOt6mnr57XR6k56oY+awYbvhoGvDY+95mpL6Qpl4lTuZayxir+76xGnjl8wB9jpx8s6Deh7uTUtA/DxRzoY=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 11:35:08 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 11:35:07 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Topic: [PATCH v2 net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Index: Ados1ZhSVt+NBU4hQ6SxQlhk3wznGQAfKkqAAALF5IAASIXWMA==
Date:   Thu, 14 Dec 2023 11:35:07 +0000
Message-ID: <CY5PR12MB6372C564179B362B7B41D081BF8CA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <20231212152347.167007f3@kernel.org> <20231213004311.nptkcubaxuiineec@skbuf>
In-Reply-To: <20231213004311.nptkcubaxuiineec@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|SN7PR12MB7024:EE_
x-ms-office365-filtering-correlation-id: aee18a57-5a96-4efa-4c04-08dbfc98b92b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XrNg6Hv58uO3Tak7YN0qKRHvF5ndJsmzrCNxN2tnz5WAsO7vpsFqxfGpAxPGJZxKRAnx+LKDXr02j9MszC4dBuTSA9gZGcfnAbXzYQdKy/v+Z3n+2vE/nS9f1kSORYGMvg5yO+PaUan94SdUPuj9yxPMUUxtzr+A64lztBEp8nzKII7m9B2+B4B0OI6VhlSt4/qVIZTx1SX4mBfgreOa2mciO3yB8KuuxZ2/4EEH8vKP6oejcwx73MetgbLsFvgM5/GVhmxIPsY/y32F1HA/ByShICzoxzgSE3bHwHgTz5VlPmcFtnklE4Vv1NE5CcST0daWEDRs53Fc++RFcDTWo7Q4YBhl+BSTDoLaH5/uqksDEQtGX0XTKZ10h59pqvbN52HrUwPKzgTPtztHrsUKmc0Wg2NO1A5IqY7HNVU3SioiPgfUAHpVG62OXeVqbclgLlgVR6LJ8mhv0kFW90KJ/2HFvEvX7qqR6/AqIQSDf1+E25Tkc1H0P4yVRG7wQBCPGvOX2EH1CI9fC7ue54ZEhf92EWaeeE8ycocIouCxjV0zqZ81LWPFPb/TgGprbqskdsAx3w7XUlH3i2rc8lvSXzKiG3KYE16FZ/JDaZZfig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(4326008)(52536014)(7416002)(2906002)(5660300002)(966005)(478600001)(6506007)(7696005)(9686003)(53546011)(64756008)(54906003)(66446008)(66556008)(66946007)(76116006)(66476007)(316002)(110136005)(8676002)(41300700001)(38100700002)(122000001)(33656002)(86362001)(55016003)(38070700009)(71200400001)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VHLRdH92YrhLiaX4pvIfqfgNu20T0nZoMvMpzcGQ4njIHH04u+CZ0n0l2Ywg?=
 =?us-ascii?Q?QpGBds13HtXEALeTs7S9SgPv2CmQfJONLCMh+YQJN/p4fibLfny/bGvw8/BQ?=
 =?us-ascii?Q?mRjO/YfkXwBP0kGmh1Zb/MlgHXF1Eq7vIsplAh9a2EJXzDX4el19g2VvENXT?=
 =?us-ascii?Q?P+7OfbSuKJOc00/wVZLbS+LaKss2LKP1UWyfXYp5mLyLatw00jMObsN/DM6a?=
 =?us-ascii?Q?+jziJ1UxrRstzLAXI1FETnWfi1N+VY8OMu9ZVVyEWERiXu7x1/XxAiOsHVv9?=
 =?us-ascii?Q?BQxVafX/LxRVsGXFfprfUZzvjBmK1K+yeBUjkf2ZuMG2m7rpdF3bjBZ3MiWx?=
 =?us-ascii?Q?OGPidSiDuJBPjdrJ+uxqZCf9QV1hNkjxWaNj1cNKN4NzMw84wP61mDdFWmop?=
 =?us-ascii?Q?tORK+ulHMY9kXlCIpuN3Lqg2EDoGL32nhWO02RcItiEJAxpG7ajJhuw3UWzt?=
 =?us-ascii?Q?ymajCWVrt03vfwJhPnkcQl7guwxZ0gbu4Ve85k84CnOjt1pwezBGpqyPLbDz?=
 =?us-ascii?Q?DZtH9613O2xmjnWni5eTxdmsDEahu0579uMs7n3YE7cFubzcH1H0xfdXtZKi?=
 =?us-ascii?Q?BWuWBKIlYTHQJvIw8GV6mHgFKB2Wp/EtXH0GVa9xTSqApehtmmWpGoc4au3A?=
 =?us-ascii?Q?Th6t7ct1Uu2Gb6aTz9j0t4AvjbULmcbFpIZrrPUePjtNbkyFJQh7aea14etf?=
 =?us-ascii?Q?6Oi8iJYWMgncRIJldP2Ulfg/S7M06ta2NW9+KLhhL3a1OST266OyhHRDSFEb?=
 =?us-ascii?Q?Rdu/TWO5OvXucZkTpwPPBdDSejyJFAx3DDyxyHd0zRoeEJjlyql2RhBdMIOL?=
 =?us-ascii?Q?zdxPF0UEgpONApQ1IHxLK0spJ3kFDAMT9tTA7mCRuEL7QDp+eYk8tolPUdJc?=
 =?us-ascii?Q?RWPhWTCO1hzIDiqcokUR7Ad8d3bzqliZ+abSy1jc/T+2JC6qjbIeDIiRAtkR?=
 =?us-ascii?Q?pXk9Nb7R65OhAc4WyUisq3O3ZAgjeDt9Tq4CKUPjZ9fjnggrdKJLnlBPoeM3?=
 =?us-ascii?Q?qTe+m3YkR8Dhl0dRcxAW4i53QmqkYPkTHKcz0aEXO/JkI/0ITANUiAcdftwE?=
 =?us-ascii?Q?E9vn/oAXq1s6AcErQ+Qe/yXWgyfSMWEqOIENJghLcB4z8RLvkbu0KGVfvrYs?=
 =?us-ascii?Q?k6FceyeQEUP72k5sDdCxSTQhbUEzNHkmT86jVjki4Y2vAr6r6wcGgHLqoCbl?=
 =?us-ascii?Q?DeIoQlryjIyzr6KnwgT20tAzQ/ACoE1Wj4Tw/eqT3+03O8okLMSuiVj9efjt?=
 =?us-ascii?Q?EptD5ZSBvKuDt9hMCLmt2rF+3k53VECLCCb3rY4m1rA+xOmUGSpbdPgn2fx0?=
 =?us-ascii?Q?aeioXGHoEb04w64u0KwMp8VRY4IVhipSS4svRIiANhU8e5ajsL2jVMs6oGFj?=
 =?us-ascii?Q?v1NSpOz2hsYELUuyjPOXW5jktzyW632NOUdyCGKs7K5EcMaW7tGhBM7BSTNy?=
 =?us-ascii?Q?wwRbjHxSb41eXVXVQxCRM39SWdsuWKD7G6gsWcO/QVeGTtI+EbGWAdgnt27K?=
 =?us-ascii?Q?XtUrRXNzZJZDSFYTzwuzD7Sr6AyVSH6ze4TbXfupl+4q1nAndPhaEs53ppoB?=
 =?us-ascii?Q?NKSTu6hiY8zbNByx33DPHzMrZ7TWvDMOG9CrgAWX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uqNL2egtIbeHQ+BqMgFNyC/V5rHtZ8FKHF8FLICoVlsxhFF1cZPjmqMf3OnpVak4B9ikgLV+rLXPH4CUOyEJZvElkaAS7BhZpCn71gHtayGJxXMiyQ/dSDNxnA9QUG2RIxPfgXYXHs2iyoYXb1sbt3Hlum8fu27CtFCm8J2UbIw+m8KgQuEXGWqBDBDyzpkS+Ss/dk+ESt9XtitFy1tL/jSY7fdlh1/V++fMalgWsx2sfYg22a1PT0gNlVOwPBLKSWVd+b/uRZ/JLZE5nHWQvL/DxMv75Fexzzfl40jSy5jq6bVeKkZZdQN8s83wP91zRmc8GXAqxUokIV+0QgXFB++lo8AN/ib4aovtLmeHV3rUbSU9tY58YfEEVdbqS9LSTXEVRry5RSuZKMZVkEyvOfq3VVCR9d21UWraP+ssRP+LzDN+g+jLihwi9wtr1QIbqlAngf2/NoXnC81qRcjyydp4jaVLZPkk/MnCYrVpCZX4JZnPuhEGwMkwlIM73AT8mtR7Jx//4wZbgEpKwv580wy/2elS9HagzMySPJ9TcauD8Lr8/oC2RJlZWKS2qf5Dh5FywspC96AgMlT3xnnAP9HbStU3elJK/nP1rGcMVfcBl+mxK7ibptOkln00xk4ed8GE6QcLBucQB2RtFFaXCw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee18a57-5a96-4efa-4c04-08dbfc98b92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 11:35:07.4802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cr1AFfdDJmc/WYkniaWQOLajjWJw8zHAjLsh8XRs5bkZCqUUcOe2kJnH2KFOErA7i1iC4nUPY4hkgyEAcX8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
X-Proofpoint-ORIG-GUID: 4B__ezDOcAmaTT7TmFIZE-C0LO9jgNiX
X-Proofpoint-GUID: 4B__ezDOcAmaTT7TmFIZE-C0LO9jgNiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, December 13, 2023 8:43 AM
> To: Jianheng Zhang <jianheng@synopsys.com>; Jakub Kicinski <kuba@kernel.o=
rg>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@=
synopsys.com>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo A=
beni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>; James L=
i
> <lijames@synopsys.com>; Martin McKenny <mmckenny@synopsys.com>; open list=
:STMMAC ETHERNET
> DRIVER <netdev@vger.kernel.org>; moderated list:ARM/STM32 ARCHITECTURE
> <linux-stm32@st-md-mailman.stormreply.com>; moderated list:ARM/STM32 ARCH=
ITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list <linux-kernel@vger.kern=
el.org>
> Subject: Re: [PATCH v2 net-next] net: stmmac: xgmac3+: add FPE handshakin=
g support
>=20
> On Tue, Dec 12, 2023 at 03:23:47PM -0800, Jakub Kicinski wrote:
> > On Tue, 12 Dec 2023 14:05:02 +0000 Jianheng Zhang wrote:
> > > Adds the HW specific support for Frame Preemption handshaking on XGMA=
C3+
> > > cores.
> > >
> > > Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
> >
> > I defer to Vladimir on whether to trust that the follow up with
> > the ethtool API support will come later (and not require rewrite
> > of existing code); or we should request that it's part of the same
> > series.
> > --
> > pw-bot: needs-ack
> >
>=20
> Here's the thing - my understanding of what Synopsys is doing is that
> they use TC_TAPRIO_CMD_SET_AND_HOLD and TC_TAPRIO_CMD_SET_AND_RELEASE
> as implicit hints to the stmmac driver that FPE should be enabled.
>=20
> Hold/Release is merely one use case for frame preemption. The "fp"
> argument in the tc framework gives you access to the rest: preemption
> without scheduling, preemption with scheduling but without hold/release.
>=20
> And the ethtool-mm framework gives you compatibility with LLDP, so you
> can adjust the minimum fragment sizes according to the link partner.
> Roger Quadros is adding am65-cpsw support for FPE using the generic
> framework, and the TI device has an erratum that the minimum fragment
> size that can be received cannot be lower than 124 bytes. LLDP allows
> link partners to discover that and still interoperate - which is very
> important, because if first-gen TSN hardware, with all its pre-standard
> quirks, does not deliver, there may not be a second-gen.
>=20
> By using LLDP, you can also enable the FPE handshake based on user space
> input - when the LLDP daemon gets an LLDPDU with an Additional Ethernet
> Capabilities TLV, rather than during each and every stmmac_mac_link_up(),
> and hoping for someone to respond. Depending on your hardware design,
> this can even lead to power savings, because you can power on your pMAC
> only when LLDP says the link partner is also capable, and it will be requ=
ired.
>=20
> Ethtool also gives you the ability to report standardized stats per eMAC
> and per pMAC, and standardized stats for the MAC Merge layer itself.
>=20
> Also, the FPE state machine from the stmmac driver is so chatty and
> spams the kernel log so bad, because it has nowhere else to report its
> current (fragile) state. The ethtool MAC Merge layer gives the driver
> a way to report its verification state ("FPE Handshake" as Synopsys
> calls it) in a standardized enum.
>=20
> A small note that the mainline iproute2 does not even expose the
> TC_TAPRIO_CMD_SET_AND_HOLD and TC_TAPRIO_CMD_SET_AND_RELEASE netlink
> attribute values. To quote from the manpage (which is not out of date
> with the code; I checked - again): 'The only supported <command> is "S",
> which means "SetGateStates"'.
>=20
> So I can only guess that Synopsys and anyone else who wants to turn on
> FPE on stmmac has to patch their iproute2. A Github code search made me
> land here:
> https://urldefense.com/v3/__https://github.com/altera-opensource/meta-int=
el-fpga-refdes/blob/7b050c
> a9968f5ff71598e86bb3a10bb8e011439c/recipes-connectivity/iproute2/iproute2=
/0003-taprio-Add-suppo
> rt-for-the-SetAndHold-and-SetAndRele.patch__;!!A4F2R9G_pg!cj_LK6iKkOj8RlY=
yKdNK6wv23ddmwT3_3
> ebNC0gb97xaKddBhm2B0uAZMIffG5vxyRHCcbyez2aY-JaDt-tNTg$
>=20
> In principle there's nothing wrong with not sharing patches on community
> software with the rest of the world. But I cannot help but get the
> impression that stmmac support for FPE is abandonware / extremely low
> priority / code written to tick the boxes. It's not in the best state
> even in the "good" case where the XGMAC3+ support gets accepted.
> Jianheng, please contradict me by showing what testing is currently
> conducted with this implementation. If none or close to that, let's get
> it to a more "observable" state, where at least others' tests could be
> reused.
>=20
> Even this very patch is slightly strange - it is not brand new hardware
> support, but it fills in some more FPE ops in dwxlgmac2_ops - when
> dwxgmac3_fpe_configure() was already there. So this suggests the
> existing support was incomplete. How complete is it now? No way to tell.
> There is a selftest to tell, but we can't run it because the driver
> doesn't integrate with those kernel APIs.
>=20
> There are long periods of radio silence from Synopsys engineers in upstre=
am,
> and as maintainers we simply don't know what stmmac's FPE implementation
> does and what it doesn't do. If a future user gets into trouble, having
> a "known good" bisection point, by means of a selftest that passes, is
> going to allow even non-expert maintainers like us provide some help,
> even if Synopsys engineers go radio silent again.
>=20
> It may be that Jianheng just needs a little nudge to help the management
> prioritize, by getting a NACK. It's a simple "help us help you" situation=
:
> the framework is there and it is a gateway for better Linux user space
> support for your platform, you just need to use it. And what better time
> to integrate with new API than with new hardware... :) Because it's not
> as if FPE on XGMAC3+ ever worked in mainline given my reading of the code=
.
> So why would users not start learning to use it with what is becoming
> the common tool set for everybody else.
>=20
> Allow me to change the "needs-ack" into:
>=20
> pw-bot: cr

Hi Vladimir,

Your insights into the current state of FPE support in the stmmac driver ar=
e=20
indeed on point. It's accurate that the existing FPE support of stmmac reli=
es=20
on the mentioned patch. Before the emergence of the ethtool-mm framework, s=
ome=20
users might have been able to use the FP function in this way. But with the=
=20
introduction of the common ethtool-mm framework, it is more important to up=
date=20
the existing stmmac FPE implementation to support ethtool. And I now fully=
=20
understand that it would not be appropriate to add xgmac support for FPE ba=
sed=20
on the current implementation. I appreciate you pointing out the problems w=
ith=20
the current implementation and providing suggestions, they are incredibly=20
helpful for the subsequent refactoring of stmmac's FPE functionality. =20

Jianheng
