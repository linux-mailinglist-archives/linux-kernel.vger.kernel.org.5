Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0530875B361
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjGTPsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjGTPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:48:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2134.outbound.protection.outlook.com [40.107.96.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D55114;
        Thu, 20 Jul 2023 08:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0Y6XfKs3o4RmsMCPjET0sSEVsVOBAZP4gM7QAcddGdrvyafKaNY/dbkduhaQP8InyyilDi+hv6dIlIXDJ1FJvQwJYY1ZvRXwNHzl1Q5TOZGICSnaq9zIIIJyIzaskmLZ3FzRjMV2EAfLjYYgRTALnqMnPZ314F+ZUcnoIcMW7z3Q8F//RLdmDZcxnKQPRADHveQ1GJwBwMNqYt7OvKDnZAtVZxYCAvW64g6QBfKKikxktrnWOvcTJSdS8WHOjlorK14APRnGkeyvUzUMeoZ2/uy6sm3n2l5FHLM+rhsN+AV0mWI3cU0wl+DXWwj3YNACXKvcRcpy5z+sWrPX8mcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h/kg7i0dtLphrYuWEzQjlEfUdTOpmYJ3l9VEkvVm+Y=;
 b=bHztcxbyrw25emCIff8x1oWyQElHVghS2GwzbjpW4tYXw6Vycc3FIvPxai5yXmTRmxI4VPg7u9ksBQygOOX7vYagQceITY43z5Pouw/PwMij+gMeoR+I8ypZX9tnn5n0oIZU2LnsbKjeZ+5GLIY0+ryYO2CcEhAqkfNhOyHdgMXqDx4q9jowZlhV6QOyY/H30EU7F1F3fDCnMVGjJqFIlDEcxWVVBN93euWO5xiIWmk05IDoNQ7BLOdtYiqj29y5uWUqTYgF8huSZf06C8qzD3n81FIboSeKXzx2A7oZLrONbRs2QWuyo6i3MqPmFRADANc0Aru/QrfPzXTgO+RFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h/kg7i0dtLphrYuWEzQjlEfUdTOpmYJ3l9VEkvVm+Y=;
 b=CEo0lU3X1tS6HsR6xvsjbABjvIkQtF5o5DygKInEzaos90NppeMP3EVlwVU97uR83dJTcB4hxOHkPpw41GZ6wu+hFxYB2e5eNC7mKQ2OrHr7XpqE4Q6EUinTEx/hbBV4dks4mw6nqnQ43A5HneXIv1/7U+hvwMIXVCXdyQWhW5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5848.namprd13.prod.outlook.com (2603:10b6:a03:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Thu, 20 Jul
 2023 15:47:58 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 15:47:58 +0000
Date:   Thu, 20 Jul 2023 16:47:49 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v5 06/12] can: m_can: Use u32 for putidx
Message-ID: <ZLlXJTL2Qm4C4bOb@corigine.com>
References: <20230718075708.958094-1-msp@baylibre.com>
 <20230718075708.958094-7-msp@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718075708.958094-7-msp@baylibre.com>
X-ClientProxiedBy: LO2P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: eeea84cc-582a-407d-d2a9-08db8938b0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0xtzBHmEoOUwjEkIs943uS74h1ALP2elZrCBnh+crEzHxhIU6bWmMOAw+2UmoB0xKAqs26jtSzJCwngF1Gg9PnOIM3UJh51fSWBy/3qoYno4X3DudNRPsXH1B4e/wwemutP0hGj1l+fKF4Azpsq82d60MRuKHCtgHTicY69cWh8s+DY6A4UkrkirF/FX9TsfyLZy8l1R/mJZjwVMZ4UuN/hScNa3viPgnsAMJknniDQxiOLsg1Ud/zJucNfdRFaIpuA2M9zl9K8ZZaef44V4WK9WnAdaFMnpuuJ2roGmAbVITP7nm3QfSWHd9Us29O1fAoEhUcIFlOzm6JeSsJyHgN7PUJzkAkdufEKiLQxNfFqqLKPzzir4L8iM9Pktbr6rXF0Uuiz5i5QdS9Q7Pm48qc4HBq1+IrM6wWX8Yp3P/H4ltY9ai4Da/WNmgRrYz7XtSis4sz4aL2s3Nsi6mL+RvCmKSxbVBJPcGyU6WCdL5J3bhlRRr6F+ksaStSyKTPruRA95ElAp3zkXfiv6p1C10xj6gvbPb8rC4U56vAeVLjXyJaiRJi2gLcmpDbCkobZp4jSdr9XERcRXjhk7PbwF7a9+bH29U0pIwI2EG2Pa14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(396003)(346002)(366004)(136003)(451199021)(38100700002)(86362001)(478600001)(44832011)(8936002)(2906002)(7416002)(5660300002)(316002)(558084003)(8676002)(6916009)(4326008)(66946007)(66556008)(66476007)(54906003)(41300700001)(6512007)(6666004)(6486002)(36756003)(2616005)(26005)(55236004)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0e6giLMrZ20zjusiX+JLp/4+IYftajD3xjXfblvjvu0WTFJaC68SGz636/vz?=
 =?us-ascii?Q?Rdiwze64jKgjQLZaFc0E5+UWrsYuH5xzri9djOKKWyTNHferpnmli3F+3u70?=
 =?us-ascii?Q?cmix1JvMf6Qb60RyidkoXKElLFrjDAq/ZDvsGYiAuO+EU3AFrPL6OCJ3ZzQ6?=
 =?us-ascii?Q?cOmtmetuk/Colj1zs1t7n3HAzI22kZEwX2lpc59IerDCjpw7qIkDo51CyhkS?=
 =?us-ascii?Q?uJIg5CQyS9lcPHsxdllxxaxkwBnvUTgO+hrO2FKMVmbJcn2AOnHL/KSBos+7?=
 =?us-ascii?Q?3/U3fZVO7p7TaRHXReEklszK7rA1T7OpOXsN1FUL6e/fp3klbdYuRB/ygDrD?=
 =?us-ascii?Q?icY1A1rcShdznCf7Npru3ZWAvf8M6r5/daP5M1moqO34FVrI4s6rr0bPA67t?=
 =?us-ascii?Q?L9GnKZrzzVELKNmSgvU8/0W3c9bDe4UiH6H/fe9LLSCZ6BOgUfSHt3wQJkkl?=
 =?us-ascii?Q?dv8c5755WTLJb5zBXAPiTWPfx8RjLsnn8DpX8kkSZuOflvLD8DMJjPon0Y0c?=
 =?us-ascii?Q?a5igFoAw8v05V1ix2GHaJr7I5RTOgsHJgWzc2NR4hxGgIL1Zi6WUR/0GszRT?=
 =?us-ascii?Q?2wPgzdRs7ODaQs/tFa/GhdS9F2V0iHX0Ddx3hV0+J/RKla6eQUux65kkXGg9?=
 =?us-ascii?Q?H774eFrTIMFyXLcxIA51dfr1YXx6VPxvNYttl0fOoS71COTA/Ge64v/pVLWb?=
 =?us-ascii?Q?RsmfN9NFOXN+zaPLDSAXmcAgY3dCAErHkqKasjjWwTTQYc/FAQvmPMx058Lh?=
 =?us-ascii?Q?Tjo5J5QPRfrqDTVxu6MeOcHnuyi34HCOfXdOUISjvOQP21IsbMWWamaW7/yS?=
 =?us-ascii?Q?nhwg8bRf/X+XqrRv5MVQwmS66wvgBU0QST50k7iGgw9RGK5zxGoDAKmaSr7e?=
 =?us-ascii?Q?5K1kMrIi6q9xLkWZqix7+vTTX73j5urUZ3m9ppcF2l8zXyBc1CVKgJypMxaJ?=
 =?us-ascii?Q?Bm0igO6nxqAwdHdzM5u+23n3cSWw0eLomCeP0cV1alZz0rbalnlCzQ406Ydo?=
 =?us-ascii?Q?wrua+0lESjh8W2CmpiNu7Zsk6b7CP1cr5uBCeW91qzqIasQFYoYqxzHNfNoh?=
 =?us-ascii?Q?ncYraFpumMnAc0fx6EFcikLqIOWbn7u9Ga2cZssldwWU+QPSGenvtFjEwl8R?=
 =?us-ascii?Q?WaabzzBu9872prx3isRJNGS8Mqpb+I1zLW8m4MuL0gAl5DoPwahaaEPcPc8d?=
 =?us-ascii?Q?iIp9TKjHpw7UNFslfnmBs8dcaFxjYz0BZkNJp4ElCxFgoopm8FZWfOALdbRM?=
 =?us-ascii?Q?AAlpOe+Tg44kikOGPKq/ioF8Suyu4gV8UfU7bvJU4mN7kSZFcxEdT5WwJzPc?=
 =?us-ascii?Q?NshZAfNEetTHdBZJfz9aTRqC6gXAr53qutaIV2H7830gr1tbGfiYZr8qWbPS?=
 =?us-ascii?Q?J/5QMHF41t4gGEYfErKfgxo11mro7JZc30F5upeXDUnaYI2gyZhLQatcL5YI?=
 =?us-ascii?Q?Bs9ayRcoYIJ5X1pCOrAO4wGIpJFpVa7kfVslwIabDQIkL1BB7I8ZxerevoS+?=
 =?us-ascii?Q?AP5jEFY2KRtLT+goJ6QTwbWWq/ufoXXYenDct/TI8R9Wa1jRnzuC+BmHjzSo?=
 =?us-ascii?Q?AwKY9w6eMc4HxP4FRVtwLFJwL6Sti6Zh++1pvm+rWbYdI0bhCOXjKlCE3lwA?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeea84cc-582a-407d-d2a9-08db8938b0b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:47:58.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k72weYfuSTNjdslmNtG4BckGdE80/T4coVV27FYKbJGAB8mOiZSDmHLr9W8vtoX0k1irsyAVolCpPXYvwY0B6CBiXcG3Q1jaZLuCo2+TIBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5848
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:57:02AM +0200, Markus Schneider-Pargmann wrote:
> putidx is not an integer normally, it is an unsigned field used in
> hardware registers. Use a u32 for it.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

