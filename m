Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E88756FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGQWad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjGQWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:30:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2118.outbound.protection.outlook.com [40.107.101.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1AB3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q42gOKKWDV4vvud9FOP4LJVLzahsMWQJHl0DooYgwcOH1eUDWeyyh2+mxLdxraRpOf3yfinuZwv01qZCq5fHC6CpTj1JRnLB8N49zzWufYWrRGE6pH1dVKXZFKn2V3xEvcFMtPBqqmwZ7sFlavJoJd9Y3A/r8UGrmr12CmhfcdgReZhX6h3g9DAtrJMDIP5C9QXyuALQNMiD9ZXkvhULxE0ReWrv6nSwFd2/wv7MHCJrx5YAYatOsBrh8w1AtZLgRVJ1TqK3X6kq5+EeWNmD9iNNxPhGFyOYNQfNqIr1KTEIZefbzIQrLrOy5UYLszEvrW0tKWXHn2rv7CZ2RxvjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJSbphokxrarGtpoVMrK05gXaHkmNAVmbYQ29ca9CzE=;
 b=VVTmZnl+B0WSI/kxGieZ2jfYV3AJ82yWwZiwS9N/BTxUxHF77yFittF4S3zqkyJa65RkzQG21rF5owfiDZXgafrI0Vzjk7CCimT18Oxj2ycxS+UPGIHewd7TueryrDs0lbz+y7xzwpcOiGCKoqd/p37sBjWIRTP/viHOIxM9sRgru35kWSWppvyXVc0xhh1RQZ+BRljosDvrQdNk7xpDJ3PdjFLjQM4UF7EPSHskhrtRq0WXqQkLBqzckoP1CUA/dAMZyzubKWOQLpJW3S430RqEU8yM7d8sTPIZr83IoqTb6VuvVEGO9hM2JJkhgTI3ygunLVuKjhhluzlHMGVYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=obsidian.systems; dmarc=pass action=none
 header.from=obsidian.systems; dkim=pass header.d=obsidian.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obsidiansystems.onmicrosoft.com;
 s=selector1-obsidiansystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJSbphokxrarGtpoVMrK05gXaHkmNAVmbYQ29ca9CzE=;
 b=SzgoHBjH054mEczITCLzGHl3TYlfyt0ra9j94lrjnCXY6m5kTjDjKydaF1k/AMigYLE3pabZoLxu8xS5j2Gek7/T0wTjcNXzzG8Y/scrxInwKw1NiWxy5FBzRKXb+4p9INaIYi6s27YWSTYILsp/khsSlNTaqiFGKoLruCVty4o=
Received: from PH7PR14MB5569.namprd14.prod.outlook.com (2603:10b6:510:1fb::16)
 by BL0PR14MB3859.namprd14.prod.outlook.com (2603:10b6:208:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 22:30:20 +0000
Received: from PH7PR14MB5569.namprd14.prod.outlook.com
 ([fe80::a501:92f0:c256:c2b1]) by PH7PR14MB5569.namprd14.prod.outlook.com
 ([fe80::a501:92f0:c256:c2b1%2]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 22:30:18 +0000
From:   John Ericson <john.ericson@obsidian.systems>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Nathan Homesley <nathan.homesley@obsidian.systems>,
        Ryan Mulligan <ryan@repl.it>
Subject: "Resetting" an overlay fs entry; clearing the upper layer and
 revealing the lower layer 
Thread-Topic: "Resetting" an overlay fs entry; clearing the upper layer and
 revealing the lower layer 
Thread-Index: AQHZuPyPVjqAOjROjky9Pum6cGQnIw==
Date:   Mon, 17 Jul 2023 22:30:18 +0000
Message-ID: <PH7PR14MB55699F84995FB1FBBEA5663BF53BA@PH7PR14MB5569.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=obsidian.systems;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR14MB5569:EE_|BL0PR14MB3859:EE_
x-ms-office365-filtering-correlation-id: d0047970-1cc2-4cfb-0b95-08db87156674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtu6sL8WdUV+1b4dsiLNAbMztF4DV7ZoHNGbeAJYZIvt6fAJmcjH3X9SlPLOp/c5fNeGB0creU5LKAIV/Vi2M3wqWDCoQRRDJHk4VOvSGrHbHk4TwGY1FOT/yG7gNDUJvv3QjhtHI/m15JxEYmClZ8l6DpVruc2uRSqutIV8UmaAXbraAHmymzV0MLulAc3mw28Q7/ZPQOt+SuTo3/WkHwnRWObL88QVBG4Sgxyq/Oh9jvSmE+KID0Pfe/cIaV8pYMZNESQzBPDZ7L8sKhPjEyeBLFH8cuD6TGukzgzvLKF/3FTGRgKbINaRXbkayHhlav+j4BFmo+olmBVG02ZzhTpsJbH+hIqi4pGBMEIeuWccZwSXtl1VHWJuxHDwzTaaQ4bCpvn+VutdY1HW/juHJWhUTC9u9hPmMnnJ6E2dmp7Qp/cdpej3X/M3RbyRcsiLQgGu8UfdpplorzcA0f4xNpjw8s5ZscNDdpJeRzRS4vOkBAjjjcXkR04V5j9nfMlIcCnhp0LyglZVPbr1vW4AgrRAtPWQVhMr5i1kMHaWl69Ai7wiYTx5iH+wy4wy4yycG/yZU3xP3Z4iUuI/7BTEWs0IthRb+ixvq6EBz6XamLa5BIbHoSQIdDn/s/UkwDFynjukkGwZ8aW+jdnINtCy+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5569.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39830400003)(346002)(396003)(136003)(451199021)(54906003)(478600001)(71200400001)(7696005)(91956017)(186003)(9686003)(6506007)(4743002)(2906002)(44832011)(66946007)(66476007)(6916009)(41300700001)(4326008)(66446008)(76116006)(66556008)(52536014)(8936002)(316002)(8676002)(5660300002)(38100700002)(64756008)(122000001)(33656002)(86362001)(38070700005)(83380400001)(55016003)(46492021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9AMfIgGO67sJFuCee8PxfRKX5OdzGwdRv/DFMgTclCExSv47FThA2Am32u?=
 =?iso-8859-1?Q?QNsOdBizsPdG/CP0KB7BS8JHBSE6wVVQE05baOrNUro70L5zgyh7hX7Jqj?=
 =?iso-8859-1?Q?uyEsMmwNdtb3CHMQTz0dQCJ2Ji1QDsKlW0T4RY5uxeeWlZDcM68mVn9mtF?=
 =?iso-8859-1?Q?PMw7TyUK7II+a5oeYpyfI1lkJYze8m6r/UXr5N8NfagASvRDugCNgYalC6?=
 =?iso-8859-1?Q?wDz4BjkCoZ2rHM1S+9SUyYX9OcK3grOKuTrHWuW9EirNc8zJU5qwRKH9Ty?=
 =?iso-8859-1?Q?Y56w4naf1mHJjCmglnRYPyZd/Mq+DB3xNCeKx3Tk9hRhCSRfuuq0wbNqYd?=
 =?iso-8859-1?Q?DUuFet7opMuwx7IanrQeLMPtZ453rhzs9Y7nMjGYczVzTrqR/x/z39RPvc?=
 =?iso-8859-1?Q?/QLi6PM8uqD6ij22E0IUf5epD8PEL03h2a1hD/PXuTSC5NQdf2+zqhjUIo?=
 =?iso-8859-1?Q?PMaoJHaur4e3CsWKTmEa2J5nPm2UbtdpPq+IShYeT212mP+2N+NJ9qsVVk?=
 =?iso-8859-1?Q?rxlEor18iWppL8MeNT7TEGLeMy2PkPJv07qqUthEIHUkQlJ4F0tFkiuT8I?=
 =?iso-8859-1?Q?XhMdooIkJQeHUBQJSxHLv0rte5dm3I7N74IzS9hydxgSZA5Tl7bC5NJw3p?=
 =?iso-8859-1?Q?4yhxKJpkmYufBlL9u6dhdmPDCSDibrP/FxBNe2lx2aLLEJJJOztjojcMtQ?=
 =?iso-8859-1?Q?D0iA5qlEHaNCzdsEVRzQz0Mzs1cE7KoIBR60NEayxY81nQU7q4BGl2wQm5?=
 =?iso-8859-1?Q?i28rhZxnoZ7trx7hoRoY6xBxhc13AYLcuos5Fbu3sk/LfV6wDGbc3o0/uy?=
 =?iso-8859-1?Q?zyLN1zAp0l5QNd/YhSlxjmgesQsa0BTRtPziYX+A9tNtyCOmL2jn3b6gAN?=
 =?iso-8859-1?Q?nYoxdANpi/K0LIvxMB1oeJeHZ4vg/PTmrgiW4SYcMwmy2tfFRRg5Nh7xTL?=
 =?iso-8859-1?Q?IJcigItVGMZ3Wx5itL8un8DNY8EGW1gZ71CG5Danp00tqkq/cRy7cV/oFg?=
 =?iso-8859-1?Q?GwlFRt3igJDFKLxbp5n6sySvhU9zaCe5epVJd0/5kw1PgpcqI9ztrdVQJu?=
 =?iso-8859-1?Q?8Pr4BClEK1Y8dXxAgBBKM+ObdUoIxdZkOKXuQJVK1PvGMzc3opZYmgsacq?=
 =?iso-8859-1?Q?vrxGodxW90ZeVJmQVPW17/NS0ve8UPqY4j2JoDdJlNSvcn6GI0gVC5oxAr?=
 =?iso-8859-1?Q?0WFLSeAbKDHYg4B+tw9Nhoob9nvm/1lknCpGiwcIrmev3T7dCtkS2BYYpK?=
 =?iso-8859-1?Q?ANHPM+hFThUvFs36D+5rxCRlwYb4xCZW46aAIM+eXowUll8L2FOZroMzeE?=
 =?iso-8859-1?Q?laYSL7pGJlwOGNRk0sXMbJAk7w1498eLCmXzMln0Zi8QE3V/iwdsGdSbPc?=
 =?iso-8859-1?Q?tnhwpXIjXkrOgRijX3WTdYVtX0ucCWeEmH9QhyvROyyw10ROG0S99LgwUY?=
 =?iso-8859-1?Q?VRZmPHS+uLYo9QSq7XhTepiWVmWklV9xFiMZP5OGRqyx1LY4ylgiuZ5a70?=
 =?iso-8859-1?Q?mvt7c26LykuE6N61yxcD0N7msx6UnEwTEpKUUoR0TIVUQTL0YXwUhuaLhV?=
 =?iso-8859-1?Q?AD6hfuXF7vuwf20pOVKUG405YCJRoudw7jsaSb6UyF26nRaQYtrtdaXHza?=
 =?iso-8859-1?Q?n0aLG88NL7N8rOdw9pCvfEDWwVB61GtpRvmdIgnajyaiYOILFrBq6RGPGX?=
 =?iso-8859-1?Q?cCk2Nmazcw0DSyNfhttSCS67C9k8Ky60CG9/P1MnMFyKxoUhxI5WXZAqdn?=
 =?iso-8859-1?Q?Utvg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: obsidian.systems
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5569.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0047970-1cc2-4cfb-0b95-08db87156674
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 22:30:18.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9e4fbd9c-5fe9-457b-906b-5ad50664f878
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZKHoXY1/YSPfnokwe87H7CJkNWSBZnPLHLsPw6VD4IqfYdN1qGihVkAYO2Rq63srX3PVcuQZVIBNVd+hrKEnVMrmvIxRLOuazTQRqE7qRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3859
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to be able to "reset" an overlay-fs directory entry, i.e. rem=
ove whatever might exist for this entry in the upper layer and revert back =
to whatever is in lower layer. This operation would be akin to a regular re=
moval, except without creating whiteouts to cover up anything in the lower =
layer.=0A=
=0A=
As far as our team could discern, the kernel currently does not support thi=
s operation. Thus, we are considering what would be necessary to implement =
this ourselves. Our initial exploration led us to `ovl_do_remove` within `f=
s/overlayfs/dir.c` and in particular this conditional:=0A=
=0A=
    if (!lower_positive)=0A=
        err =3D ovl_remove_upper(dentry, is_dir, &list);=0A=
    else=0A=
        err =3D ovl_remove_and_whiteout(dentry, &list);=0A=
=0A=
That seemed like a good place to begin --- if one were to force the first c=
ase no new whiteouts would be created, correct?=0A=
=0A=
Assuming that is indeed the right place to start, I have two follow-up ques=
tions.=0A=
=0A=
1. Since the desired end result of the operation is strictly closer to the =
lower layer, should we possibly eliminate some of the other operations in a=
 fresh copy of this function? For instance, might `ovl_copy_up` be unnecess=
ary because if the upper layer already doesn't "contribute" to this dir ent=
ry, no action would need to be taken? Additionally, what is the significanc=
e of `nlink`? We have not found much documentation for it; from what we und=
erstand, it's an `xattr` used so some information for the overlay-fs is per=
sisted on disk.=0A=
=0A=
2. What is the recommended approach to expose this functionality? We assume=
 it would be through a new `ioctl`, but with no existing overlay-fs-specifi=
c `ioctl` as a reference, we are unsure if that would be the correct choice=
. We presume there are best practices on this matter that we are not curren=
tly aware of.=0A=
=0A=
Our intention is to upstream this patch if we write it. It would be therefo=
re beneficial to discuss any objections or concerns beforehand. For instanc=
e, one possible issue could be overlay-fs usage which presumes that covered=
 up lower layer data is private and inaccessible. To make it possible to pr=
eserve that invariant, permissions for this operation would have to be dist=
inct from write permissions. This concern can thus be addressed, but it wou=
ld increase the scope of the patch.=0A=
=0A=
Thanks,=0A=
=0A=
John=
