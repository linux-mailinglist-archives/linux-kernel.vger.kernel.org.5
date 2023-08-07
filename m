Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303BC772EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHGTiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHGTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E0B198C;
        Mon,  7 Aug 2023 12:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqSDEIDJr3UUjHQfbZzkZbDTtBphi83j822QP846SGvB8GdK0JESW/MFwgjuQVA7uIPy5gUkF/Z/LVr7YkhNjSN9aPDzu0nd+NbFNZpiG81WdC05jlv58z0RZ+a73QXIP9u5p7Chh5oz85qHED5Va7XfKjnBqiizvdJKS07PQhrcSHBFnoQO+oLpeOrzrua/Yt6OFWLsvA3u42SSfpM10Kez6oq55TfV/2pkUSGRoyEbb0FSwqudMmGPA1jtFCT1hJbJ0xpGzdCR+ySTgx8ro7HlCMSvrVZOIJ9FAf9kUstuCGN+NlQa0XJwDWEmHo7fb5190b1h7q6hg/PRHQUF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++Os2aWfMEm3xY1Hlw2mvgEOKcfutHpDMexqcLDtSsE=;
 b=l6inirFYpxC/rwZFi/lCSu/Jcd4qhSJ/ATIGgPcv7l1wZC1TG6268hVMZHEx9j+T0I22e/agI8XUoDEUQRXsPW9Pzzb+o8IqB7snzsybo5qghfPSDvG3KoL9ooPHu4szpHmgvBzsKhjhksTyRPnbfx1pCnDztvKzWbY5znMiUZDZgUCD8rezhYZiJGBEs2LngvK5OnZLTB+OoSAu/RKIcF/ttiroWv0rqggtnwA9Idh0HwqG2AZOYkm433xEew5NnsXiRcyc0n8tNKv2paDIbUjBTtkIZBG683IW8JLjkssqMrW9zWBFeYmkolzVrsTpwrXQixCsB0/Mkj/NLK2Liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++Os2aWfMEm3xY1Hlw2mvgEOKcfutHpDMexqcLDtSsE=;
 b=RSSyci5fe0IeSXZdXlZyyG8/Qr3P1DRGOxdgeysxT+P8mnI7DoptAF4ZKhLvGxRdJQBKzfk8eSus26RAlilR266s2f792aNKdJDBUiwNBQvda7CTT2XUNojhYaL4jVCQIJbZWaOuhFgRZEHqQ33M02EQVv0AuuCYtHr706YbduI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:37 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:37 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: [PATCH v4 net-next 04/11] net/sched: taprio: delete misleading comment about preallocating child qdiscs
Date:   Mon,  7 Aug 2023 22:33:17 +0300
Message-Id: <20230807193324.4128292-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
References: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 832eac62-d7a1-4ad3-6362-08db977dc12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjME+6Y/GStfbpRyhoWjUCF2NjuROQz6eDV8OPydw+IpCbJVrEFKg7+R0oZxTP/QkMwnP7mSD6MtOlO/pEfam6rCTY1e0IhRTNxCV6e2OSDMvat/nmkRwu6ltN46p0SUofSLyWlLaAwBGg2H8wqgCXDx0BsFtBcmK7EuGcBJ21xzuW4kDZF4p9M3BQcL5o8HRiEY27U+mUGJCrvRZle5jTdE2vX18THKNl35bj6aVaJPyRyDFUvqmWqNeuv84//XNsIZgVAdaa+Akl6QBwIDjbRtzVWrQK0yYw0RWvKyvAJ8VqGEAfwuliwunX429fKiEQJW+UtIym9rx2/SRj/BKfmmtukoGIn5HMOl8skekYUgkbHrpBJcbavc57f80jPPvSf5vPgRRTSgpWiQF7nPlk1zxdWtFnRU2CL0/bS0CbKXKQbe9hg6+LKxcAaQ1BMAmwGxMNOfDO4pQxDgtiss3wPMMwNAkWD/gpKADLpOkCMYZ6cjT9CpEGfH9qiydtrBWdZH60TfROyoi0r4MM+YJrvLMfH9SoaF9Wi5BZoldNqvC0dvx5LDZgyorM+NXO6Yj+iQOb25sEKJs4gYMuI6DM1MKEIh2rx/v63ctL+QegV2kcF8UzYyxzfnJpAsMGLX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zlm8yHhO06jMaDeWRNJg2R8QtMjHs2fDJgqVK4nos/Q3TtCDBn/v6elnim+?=
 =?us-ascii?Q?/3cfMqh+KJ1+x6OGaJ8Ix7wvRK1IfFE7L3ggKbNJIZygE/ljgcfQgQYp/K6O?=
 =?us-ascii?Q?CxHIAU6yJbzTVBCE6YHrBy6+TQJ8T1+zNMn8abkTbdF/icY/ygIiOQO4KXxI?=
 =?us-ascii?Q?G7okTmBEo4BrzVhV+7r889YAEfCM3nnzd2baniSnXgdKm1rdJ5TqhH57Mobm?=
 =?us-ascii?Q?0SteXqA4jlDgMyV2ZDxc1y+q9HW25cpJnExYImgtyc3Z5cJ/Nl9LxXRUzay0?=
 =?us-ascii?Q?oUbb/nnpfLCH4UwBu2NLsPt2LrfDCVzC5oLu0GSqdI3HkjvdIZQiQLbM6qGC?=
 =?us-ascii?Q?nEnDnYrr1I/xO5Tn6P2uuv4PQk9aWlqurQ8Wl32EWMhPZoIsxn/tNpUMouF1?=
 =?us-ascii?Q?ckRnjOd4gMaKmzHZ1iIhuWQ2N98I5IWUWbcdyGhf9tXKpY4WlM+DclRXJ9Zr?=
 =?us-ascii?Q?iPZzmXMim5KlmmTRP+4AEFch2yO3n/+V05o3tQgCDUInvSJQk0FqFz84S0ov?=
 =?us-ascii?Q?lxA9d/ASx3uukOXwa9osVh4lK4ULvf8D23ChGShZH9X4INGXL9lA6xv4k6cx?=
 =?us-ascii?Q?ag2Lb8xJC85uwGICmLT4sdUKxECaHTnq/mTru/PM9bw3yJGbzMsfNYFF8zQk?=
 =?us-ascii?Q?aMGlHPEhaS51vQ0qxWEp+sbbQbLvFYjh4oIgXzrucBtqq1IqnBufA0XHsD2T?=
 =?us-ascii?Q?OoPHqflwiS4ApDZD26OoINxP5ENOJL1Hs1bwmH+gmjiTEaogIzmn+XriGDGC?=
 =?us-ascii?Q?qyvQ/0ClDbUc1TbXDEfKOPIHspeEPOXscOVKdp9iAhkdlI/0iJVJgdjX+KF1?=
 =?us-ascii?Q?Z/evgERwskoJkKoJwrfZBK0bvbcQw3FTbe2amE9+1KQx+JZZ6CGYjae4e6HO?=
 =?us-ascii?Q?jXO5kswtl9cNYq0v0nq/Ba/rsMxdTXfTlxw2o5loMjXtvfzokb70olihxm3A?=
 =?us-ascii?Q?ezKSgCrmvCh0lHN8hcUPsp9bk5JVS3MZMIgIJrblacRan+Sqf9hiIu/y93M2?=
 =?us-ascii?Q?Tq1Ohtr6iFCCMLy6riGwphLaqneCR/0cCFsts7UNoQLoH9OGf9CTL1/AkpAs?=
 =?us-ascii?Q?wROMWytVEaBL4XuHTHeC9MP0EMT9+U64Bzj6z9gRbkxIG44WjvGDZNhUVJka?=
 =?us-ascii?Q?k8N1+8aSy55jbPh3wlG/wyibtrsmFpp2Nqg/YLbNZxHHpLtJNxSiGGP85HgH?=
 =?us-ascii?Q?X88z4wJPKip+bsfMqrMXaau3qSkBRTTzDfP7Qe79lO6Ggx4NCsWLP9DmvJYN?=
 =?us-ascii?Q?GUuPt5Hy8HS8ded7qx+v47VZvBoYb42kvM47PTpNcGM998WVvwvURXLIQeET?=
 =?us-ascii?Q?dH0XZUObhJ2kp9uAKhziOi+i4fUGZEHcrKxaz9dGTnR5i4K/WHqfC3FU7Pq9?=
 =?us-ascii?Q?JGSbTeqOuWQ7wYXITiEaBafslALh8EqYF7EYIB8+/zo5wvXAq4SmESZx8g5j?=
 =?us-ascii?Q?oUBJLRXa4e/sIVZIxHcZNojJtN7phFQ64KeUCD8BPYSjaHbKoHqltjwQk0bT?=
 =?us-ascii?Q?YDJn2CK/pk0W6kDQIlGWQmyejp57qCWXOythgxL7mvzsV/F7hxjPtHYqLs/F?=
 =?us-ascii?Q?7WYdU/TsHe9h4YelL1q+/HEeMOkw3APCFfWDxDkc1q9xXU9bshD2cssHQWAk?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832eac62-d7a1-4ad3-6362-08db977dc12b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:37.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdZPYGS0ylu0W92wjK37ncwxKG1eE43ocGX89UbGzD6lj00elR2QsuvYIS+ntMqlmPDoHPcvkg8ZRM2U30ifbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in commit af7b29b1deaa ("Revert "net/sched: taprio: make
qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"") - unlike
mqprio, taprio doesn't use q->qdiscs[] only as a temporary transport
between Qdisc_ops :: init() and Qdisc_ops :: attach().

Delete the comment, which is just stolen from mqprio, but there, the
usage patterns are a lot different, and this is nothing but confusing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none

 net/sched/sch_taprio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 831e6f3fda2a..d5693bd52e93 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2099,11 +2099,8 @@ static int taprio_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EOPNOTSUPP;
 	}
 
-	/* pre-allocate qdisc, attachment can't fail */
-	q->qdiscs = kcalloc(dev->num_tx_queues,
-			    sizeof(q->qdiscs[0]),
+	q->qdiscs = kcalloc(dev->num_tx_queues, sizeof(q->qdiscs[0]),
 			    GFP_KERNEL);
-
 	if (!q->qdiscs)
 		return -ENOMEM;
 
-- 
2.34.1

