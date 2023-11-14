Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F687EAE99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjKNLJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjKNLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:09:00 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D89E18D;
        Tue, 14 Nov 2023 03:08:57 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE6JQYT023337;
        Tue, 14 Nov 2023 03:07:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfptdkimsnps;
 bh=5upned94RJmGtGMEnfNY2GByuzpE7QBAhcHfiGogd4g=;
 b=hMi+p64p0mQ7EtzhgEbkVTElWIFZcz2cueMbfzfew9yFsbqyqCeRuHA5gPY5Va1XM48d
 oDh08aVAkxq0zQpIKY6bi+hrHQ48jimbCUKIuDRDtU3CfJWrcVSH7DkD6n4ElV0VkznU
 F+PO1Ot+SRZgc358NNVPyDfjpMbk7ukPil3w+ZfuuxM2iGaFFIcDarofY+tUfDuMx1Qc
 n3R+5DP7del4L1UPkTv5RAaHsrkThOjCEUgL73DDbDjCV9IUbylci7UiKcoNSr1ml4IW
 bmqS5WC3f/rMwhzMzfFs5rtyhO8B2xQu8kBvelxGXSYvxlvmK21QBHl4/Rj70X10zS/E 2g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ua9r9tenk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 03:07:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1699960062; bh=X03xgP17TOAEOIOtkhCOXnQ1OXpk0zqXjnh68ZRBZTg=;
        h=From:To:CC:Subject:Date:From;
        b=IYRV3z2sm0eXEvf3UblsnEoMjokxjciT7gedMZdYpESx2uQ8V0J8ElfRwq5/oJkQh
         2ydRswT0y9gi5+RITVgWJi6/pE0f6lxlOKRPY4MLs6vg5E8NiQ9pFay7c/2srUH0ns
         EeDM8aps3Ja+zXPCt6MaI4Sly4z9kB22IrzRtYygJrMNGoLfGcDjR05cv0bHLmJqKr
         IvtJpzNsSiSwN43EJXh0nG5Q7Ld/F01AGkq/VgDN0ugrwhyVrPdzjH7V8UCeEryLWw
         Mdn+sSYRLfh8IbYKatC5LhX+qx3aUVfJdl3JtyFCmDXWFXTx6rqKJYQRATA+Rs2zQa
         ZE9HuXwhSuNCw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 31BF540407;
        Tue, 14 Nov 2023 11:07:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 13E85A00B1;
        Tue, 14 Nov 2023 11:07:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BNjlxunQ;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DB521404AC;
        Tue, 14 Nov 2023 11:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlhZuflzL8DxUdQLwZ0HkjRqkFyqpkwFIbiFtBmWu+F5djItY7JslCycGnOtTLDlYxQ6qVk6cu3oUIY9ewSyEsAqIEaSXmrUvNjCRTFjd8eVGV0rZ8C9eJjXcuk8/3vZ3ab3+GnoM/zldZmozKF0htEf5zzOb//sEmxjP7Tm5tRhbGhVMwixG7Gqmn7w3o+w4PBi6cLsT8+oAgCsDut3WC74QLCL/H1tG48o07n/j+AHj7YczGdWAPw+aEIQagMAnH/RfcOz+bEhH0iORjQW/qUW9lNtEmmvqLKqv9VQ1UfdMf0hxAoTE81ryeEOPyvBrVVtQjdEAmQQatNzfS+Mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5upned94RJmGtGMEnfNY2GByuzpE7QBAhcHfiGogd4g=;
 b=bc5+YEASYU0hXIbvhG3M+PNsW5uUqVs0wfUkTblnqUIVO424HkOwfXqixT0+yy4Kt74MIj302xkIzkzhzNEOMvJ4zFNJj5LDNGlbVPOGxqbALBv/Ejhqh3Q3EXtn1iEnOUhI8SUCdJAuBwlNTe8Y1bhFumBVhz5z4TkL4E7DKO8NP8YVorI+dx6VorSq68Qxvhf+O3iMd3qdBu0Ik5D1CNjq4pYmALpIxHKDlgICxsfB747JpmQLkBnyZd4kcHh6Tepd2LnqO68592Eqmd4BrTU/r7MIaSmtdBHY8ELJYwVM3Igq5KsW/hDfF9wg2u7h/hVtEwGSQ/ek69fIuJlSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5upned94RJmGtGMEnfNY2GByuzpE7QBAhcHfiGogd4g=;
 b=BNjlxunQ7OlnahbAXI41iVTcuph9AvpXgTldniv90bXyVA1Ena05VnE71w5Nl4HRIYiGN8fgrm9NmsMawVdXy0PaQfKiZLmnmoN3SEsrxutIZwpk2R7rFxz8EFzCKhu683LG14l2bVIXJF+RlfLYCHkebXCUddqOi5k/SBV1coY=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 11:07:34 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::45da:22ed:5900:420c]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::45da:22ed:5900:420c%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 11:07:34 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH] net: stmmac: fix FPE events losing
Thread-Index: AdoW3Xfb3QHiuCaqTA2ROZ4444S4Mg==
Date:   Tue, 14 Nov 2023 11:07:34 +0000
Message-ID: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|SJ0PR12MB6712:EE_
x-ms-office365-filtering-correlation-id: 0bde247e-4116-4ce0-2f3c-08dbe501e779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1VYw6RZrapz5J98gumkov8A/FIRU1U1lorOj4zpRst4vacewJwEoJt/iHYIQI3ZodeSqku7N+2b5p/DOBM6U4YjG9ksy1o1CiRnnHI2Kvm8UEVAd/IeYh469bMuAuxikyYbLXmKiwgL4GF2D2jBC5b0Irg/vs/tTHZCEP6P5ZhwXUMGNgBcbsIqBIXtw6Rco7ixd3cnw7MUBIj9PXF+9uRC0fwivm8nbiYZpyaMdwC16vfUNW5vx0Qpbzd6nmYlXgyijbqqeaoUvKZAIE/GUznb4ZyLjzpt3jWerYNhELbY5ZCBIIcw+bdzg4yl0UhAWumXGdqJe/1FhMTeuGYHcVaDREJEuIhOZSm3/lmuLh4eJdjFt3+STPzKj0PUFqoS4GkLEQBB5HLd6fnEDAQehPqcLCHdTCQaP2ufEFRyr3kh7I3dMCMuZjhnz+dvJiVm8T6QfmJiNSYSnJoaaA2ae57n0VWGq1f2ek61qfkqp/fuZ9o25/5PkjktzM6W8Au5Jgm3OQcoEU9mPqxxPkPy6pBp0zG/IVNW7aIWb+DDJJCcw1jtXbvauXK7xnhCQpaPKJZML5FjcL9N+Fg30vzmtiw6dV8gTX0inx3Ycy9rwxIHWu+mjmaD8D8AwIeb+TDZQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(55016003)(7696005)(6506007)(71200400001)(83380400001)(122000001)(26005)(9686003)(33656002)(7416002)(41300700001)(921008)(2906002)(5660300002)(8936002)(8676002)(4326008)(86362001)(52536014)(38070700009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(110136005)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uJtJ4IRT59PLAAXK21klsvBFhGsmMmVKwF1Xq93JN7zcjbZM4qG6xB25LY+T?=
 =?us-ascii?Q?dWFE76vRuoaI2EWai5oxA6G9qeRrtpU7eMVgBtdw3NQET6bSUhQp6OHXtIF7?=
 =?us-ascii?Q?JtgPTpoHn9q5W4a1aJ8hwTGLMwEQbmUCBF0cd7iyEwykle/dTv7yvZk0q/FP?=
 =?us-ascii?Q?v3vumbcv1e/RQDhhIOATa8ZcU2npMS6YteQeOg+s/kPWZ7coOuFNmnsjlBAm?=
 =?us-ascii?Q?1x4zpTxXYyyMMdmlZW5BZoDPGihZTUK6BTZY7YhAatGt4hwj/rjU7WWdoqp0?=
 =?us-ascii?Q?dj5PI9jDCvT19pstvBJmgiJHaXQo/XOgDk3PruoZoie+odolQNRDVYdyJp05?=
 =?us-ascii?Q?c6zAf99kv7RJL8yCJppaKvJ6lD7KJHFxCy2j7n+3en0RVkiHGEHKBIw4SfT0?=
 =?us-ascii?Q?udYJsFPCLV1yQLC1oIcGlS96C0w90RcDXT+lXGokHVsZGmLGn9kjzgoeqm8o?=
 =?us-ascii?Q?DK63oh+RSRdRrH+KJ5MP08K4SUAaMmFKyhbG6w8qmy1r0fmCe5YiSB+hu2kv?=
 =?us-ascii?Q?no5pugGa7NPm4t7VWuLrP4rAM9ZarEe8kSqn558HVVHiaEljkP3s/f3h8k/d?=
 =?us-ascii?Q?vM/jOe9n+x0PC5kJBASbNPXxs+w7oqX9q68D0C95Imnr89DvdDwUT1MoNiPW?=
 =?us-ascii?Q?XyXjiYpocsOKSIJQiJu2n0ehRrI6dIPLax7gnNGzmFnPVanHJu2Hze4F2Fbk?=
 =?us-ascii?Q?hFCipfNKszzv5vpzGmDHRu/DshuJ0eqDmPAirMBt2PhiFnAFCHyK5if2xXYF?=
 =?us-ascii?Q?MClp4YyrwrPpwPxPF/8hmm5d/J5GSD4G1Ea265jA2ah6wuAfA2VcRghqMVMD?=
 =?us-ascii?Q?J09/2BLTULyZbUGLOHf33tFZYQL0NjnPIWFTWukB8copPFw00j+evRG0ad4c?=
 =?us-ascii?Q?PwNBTEYm4HXjiU/5h0UIvHv5sWM3t6jVpsSZ8Y01V4YjctoQrwCKrek9feA6?=
 =?us-ascii?Q?o6Qe1J0I82T/r65rLG8LmzNxKWgvRw9AnOGrTDavvbzvKxp+seGojrxdRepF?=
 =?us-ascii?Q?u8ocU3SvWiONtcdDimLb9edK0o2qV/JleQ8No/IqR4kF0QdGiYPTcFGGPl9N?=
 =?us-ascii?Q?gvxYvNPp41CLhVigTePHWaNpVycn8NurXjFXR+9LHN9S08O4svR+Ur5LKPaH?=
 =?us-ascii?Q?zLz+HYHW+jfdyblWwoL8NG4Wqww/3/FN0dmKqjcvCiFCgZhwuvn6kBD6onqZ?=
 =?us-ascii?Q?S+lGVhtuxT9IoZ7WMYyzOu1fal1xHCQHWW43OPKiSBa7A15jIzY0Ub7cTnhe?=
 =?us-ascii?Q?n9vnK30KKBEaJsCffxxwCnpPnH4YpmctSCuNK0DvsdK3XrhSRU/fS51Gqqwn?=
 =?us-ascii?Q?sllRuTOjxwyS3/gQchq80Cgzx1vJ+T4CjHEe/S0vdzLlAOlNMmuQezbqWPNz?=
 =?us-ascii?Q?YrVzLMRj+4g7bsNogpH8SXkZi+Sr/No4HrSs1+Nredg6tf1RZUDrBlnyL0Gm?=
 =?us-ascii?Q?0Ps9eNGaEMDiUNOjbw7hVYcJbxwXlzy4iYFcHrWyLB6+Z5sQuU+x/3Z0zGZl?=
 =?us-ascii?Q?VKSkoDc4jRWCTcIY3Lu9dHRcNiboSKs/OhAkK5O36rMtq+/1SNdvPFbNg0/X?=
 =?us-ascii?Q?xnOm6sPFgbjZv6ERyLWS8DudcN6Sr7e1mQMeD6H8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?l8J6qPWxpEjfZqSQpBhtxou2/ohcMQf9f4GtBaLoAkjdWOkJU9BVFuUwXWnj?=
 =?us-ascii?Q?Jf3X825f0MFUE8nDfkxBaywnwZSMHbNyXvc+GAalmzl+s3U73wMCw5M1TEDm?=
 =?us-ascii?Q?hhup0e+X5RFwxjRFY4s+VUua0k8GP6OzfkTyA+AWmdhe0DE1785GEwkfil62?=
 =?us-ascii?Q?zFbVT85FZ8PbQXVCTAYNxVZeQLMvzDz4dpGH5Yq007zjvlPg6YI66Z8iQm6A?=
 =?us-ascii?Q?dCzRo+LE4T+jDl1dIah72TiPPg70OFD+kqeKtoqql6jqCuONeRDGW/Jby2AH?=
 =?us-ascii?Q?juwm3EuDLB+MMZyjIjufCmRvIB6pdJ28cj15yhnonRnT257nzIYyYEivb6hG?=
 =?us-ascii?Q?0vocsi+P7C460SWWg/DGc6wW1svhwAmFK2AHZvd0oIsRjVnxJgFlM9zpe4CF?=
 =?us-ascii?Q?PoKYlzEy0kPPXQbATe/fU9ydASFPiNa55zMUS+uVXF6pGNz7+WGtkS4HeVHC?=
 =?us-ascii?Q?cOlVBzt4ediXlEtaUKmly/swcIQOBn2jVPFSvmNiS89qCrKaWEnf3jf2aeRQ?=
 =?us-ascii?Q?dLSjtpkI2GE/sOQYQaRFx/sxVRb9KUbwnh/bFaU6c4i716xy6FXc+upgHua5?=
 =?us-ascii?Q?L2avx4F8l9zzB6Gpese9kTcCZ3Jv5cIOl3mN3YPQm3piaka5QCtfYeBGTpxp?=
 =?us-ascii?Q?4OQ7/iYvV9/TgDt4fHq76bSW+1dAlH2g+eZ3S/+G9LU+K2BezWg6K9hMmHz0?=
 =?us-ascii?Q?Zm8h6yE3k8A4Ql3s/0ny/szHfY2GGrMcLOXN1DO0KYmtfsFA/MMBJ/3wkZ2/?=
 =?us-ascii?Q?t93bRWz6vuqNCrchPtv0EcbIPzhT7EOl/Didt22KFMlZvaheXLZie4dmywD7?=
 =?us-ascii?Q?HnBQF8nabLYlQ9UKW0XXOkunPD3qfnMc1ZQzlLH8rGMuz0/w0YBkTWtoIrOW?=
 =?us-ascii?Q?t/lOGXXWvdUH3B2O2sL1fuEahcojYMqcOSZyq4abAujGx0esItbFYbzTgU/4?=
 =?us-ascii?Q?nWFYxHbN3o44J7V0P63fRLCjzg+iUqKZ+/8CC5dsmdaQV/5zXgbjXCiLVPbB?=
 =?us-ascii?Q?Cl76bjKFDnxH0r3ClGGCIGTC1pjhHIXlFCIn9Bd8wjJVSCzS2M3WagiNt0jV?=
 =?us-ascii?Q?jsOGimqrwkznURSvcaJ3LWIwu2Z/2tPr7YoGEgEowCxaOAuvWqILNdoSsO+U?=
 =?us-ascii?Q?4F+ykCmfIUJnIn8jzZo+BGD4Jx/wHw3lJg=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bde247e-4116-4ce0-2f3c-08dbe501e779
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 11:07:34.3679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBNVnHDLgsl9k0g9MRUqZ1fVmVwzjkhCi9CN1krDXkeJ6OS6YI9EeTOh0jvqbbm+jBbUX9qPb4H9ujz5Qb2UqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
X-Proofpoint-ORIG-GUID: GbqgLbUAt9C87f2uyes8MwUluCym8mn3
X-Proofpoint-GUID: GbqgLbUAt9C87f2uyes8MwUluCym8mn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=648 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE status
bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bits to
avoid unexpected access of MAC_FPE_CTRL_STS status bits that can reduce
the FPE handshake retries.

The bit[19:17] of register MAC_FPE_CTRL_STS are status register bits.
Those bits are clear on read (or write of 1 when RCWE bit in
MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
MAC_FPE_CTRL_STS control bits makes side effects that clear the status
bits. Then the stmmac interrupt handler missing FPE event status and
leads to FPE handshake failure and retries.

The bit[7:0] of register MAC_FPE_CTRL_STS are control bits or reserved
that have no access side effects, so can use 8-bit access for
MAC_FPE_CTRL_STS control bits.

Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking pr=
ocedure")
Signed-off-by: jianheng <jianheng@synopsys.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.c
index e95d35f..7333995 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 n=
um_txq, u32 num_rxq,
 	u32 value;
=20
 	if (!enable) {
-		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
+		value =3D readb(ioaddr + MAC_FPE_CTRL_STS);
=20
 		value &=3D ~EFPE;
=20
-		writel(value, ioaddr + MAC_FPE_CTRL_STS);
+		writeb(value, ioaddr + MAC_FPE_CTRL_STS);
 		return;
 	}
=20
@@ -729,9 +729,9 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num=
_txq, u32 num_rxq,
 	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
 	writel(value, ioaddr + GMAC_RXQ_CTRL1);
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
+	value =3D readb(ioaddr + MAC_FPE_CTRL_STS);
 	value |=3D EFPE;
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writeb(value, ioaddr + MAC_FPE_CTRL_STS);
 }
=20
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -770,7 +770,7 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum=
 stmmac_mpacket_type type
 {
 	u32 value;
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
+	value =3D readb(ioaddr + MAC_FPE_CTRL_STS);
=20
 	if (type =3D=3D MPACKET_VERIFY) {
 		value &=3D ~SRSP;
@@ -780,5 +780,5 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum=
 stmmac_mpacket_type type
 		value |=3D SRSP;
 	}
=20
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writeb(value, ioaddr + MAC_FPE_CTRL_STS);
 }
--=20
1.8.3.1

