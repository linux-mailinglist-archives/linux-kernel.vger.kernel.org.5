Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC81D78E0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjH3UpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbjH3Uoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:44:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ADACF7;
        Wed, 30 Aug 2023 13:42:15 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UH2AUk004297;
        Wed, 30 Aug 2023 12:37:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=/NPeVllYJ6X8D7VDxvJZmBD+NVz+w1iFmiZIpKpYF04=;
 b=VBQNGPuhKjDxtmYwegw3aa9Tytsyqrt56mgBV7K5d6wllMvB3aGRgLKk0qLnaFvYISO6
 OS9JPzFSaRwHlOVsUpeIlMe50yP1MVk/M28rNOB/CZWiQcs5V64Cl83QIg75J5POYSEx
 mhyVpSPF3hresDg2e6pjj53YddRYJjliiLMNOYhFuTsPzlVHlOJMRyra9Q4oHU5CsKBn
 dvnm6HcsU/uO++QWOX8uZHhE9d7xmuofa8/aCTvT9WW+VJs6EoUQ08G/DWUokMt/F1G2
 aH3KaF+nhgUN/xe05G7YagE+CUf7+/PHW0EZbEfVpsNzly+gtvyCKF9RKM8ou3+rH84v sw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3st0jgwhjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 12:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRgMaLbE7d1qBe9zL0NGQd3C7Lmtngr28gIdwzhB+PE8kl3w41BcKkUp8FlovDtAwDiOgz5CVbQqxaBU1LiXsFW+WihMhdgS/t+LWeSrMUlDZQnkq+YlhP6V8cwagh2FF9jca+567fUxg6x04FqUp3Z/9UD+XDluNwSrxgvRSJZkyy9WjYAigGGNMI8PIgK23F6TzQJmX6EF3jNYMc5VSOGa9LfQyVaBzOV0i8XVoegVFK+VTeumJGi2xMIy8sW3VDg4WlmauqZeAM9ux7fFGdMCRvyPgKvc/gqe1AyC3aJg81tN23IpPzgrjUpI14BMN+93BfceP+Iyk3PJ27TQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NPeVllYJ6X8D7VDxvJZmBD+NVz+w1iFmiZIpKpYF04=;
 b=E7yysO8VehYZwM6rMOxcF8qMrGWud9YySUfgMePleayaxYlRn+6KkeddSxNAZBwUXxcBDyIXGakVrMCYZjWrRG5Yj9rRjz0CxL1Yo6+IWYuPCe9Ow7l8o7bV7b0zTDIOdDd1sP9vH5BCewhd1Oi+R4X+I4fh1AKSkP0mpMMgMKsE+HHlzrbcuUi7TG3Yd3qnoXKvxnS97cb4V+TyK+ShqY1m6m4JK6RTgXh7Lb3urDdrdny2Uv0iNAHVwD9qRiZ7C22jRe5JbkUrpsxAKkJXokmYL9PZw6/GU2LUO7xXHdjSxbqT4Ow5d6Fwx6YB20U9WCGFVfEdOedOicTunIj7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from CO6PR15MB4145.namprd15.prod.outlook.com (2603:10b6:5:34a::13)
 by PH7PR15MB6083.namprd15.prod.outlook.com (2603:10b6:510:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 19:37:27 +0000
Received: from CO6PR15MB4145.namprd15.prod.outlook.com
 ([fe80::4231:7faf:1ad:f076]) by CO6PR15MB4145.namprd15.prod.outlook.com
 ([fe80::4231:7faf:1ad:f076%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 19:37:27 +0000
From:   Michal Grzedzicki <mge@meta.com>
To:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: pm80xx: Issues with SATA drives behind expander
Thread-Topic: pm80xx: Issues with SATA drives behind expander
Thread-Index: AQHZ23logRSHR9KwrEa//gHvEqoKEw==
Date:   Wed, 30 Aug 2023 19:37:27 +0000
Message-ID: <A57AEA84-5CA0-403E-8053-106033C73C70@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR15MB4145:EE_|PH7PR15MB6083:EE_
x-ms-office365-filtering-correlation-id: c8e2c4e4-46a8-4090-18bf-08dba9908ad3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yBawAZ8AEEkKa1PLxJ9fAmdzxMsx4nA2ddL2DvDqxB3ntjt+cfy5L7OpuECvWNWZhZ6I7WmdY6rweeCJF8JQsjnzcnTfDvK2SnagCEhoH5NwhUBBOiuXrslu5GBZ6JvW6yiCXGTWxO78ICdwZxX3dqkwCpXbd8yuZAroZpneTMt8Jh838O4GSpQcmE/bJpTAyTg1rLWFj7tgIBylYvG0EJ0j1ntXTki3JkK4WDNre2sO529wy3Nxanqvl32t7mrD+VrZd0q7+I4c6XPiYe6A04v6EoHwHsHdwCTVXk7D9IV6uhqArTnrbWpQBRSSN9iMioKyjMAULKPuLDz6C9SU0MjYAMkhfOSkn6uk/faM+YCuYbD/LMw+XISmrCJFs4r1inY+gK6z+emFO2lPmuwM5RvKvF7gw/E1i3syuplLU0HHS9Wj6mPfuHKzeT/SlEbXFUvlRhvE+ks0wL2TouAgNg5zFeVgzEqrGU4pXq9xrnqknL6CWAZAYfpCDBoQIWpIsgE15U/ameHt0iVSaInx/vTKTmSRBJsnP/3oZAPXPvxWl3NSmcoeWNL3z6CYrKMVdf58WaO9F7OXcVXNzhIEyEGWdj1/KHnYPLoMmOisNig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR15MB4145.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(478600001)(966005)(83380400001)(122000001)(6486002)(9686003)(6512007)(71200400001)(6506007)(2906002)(5660300002)(91956017)(33656002)(8936002)(66556008)(66476007)(38100700002)(8676002)(6916009)(41300700001)(4326008)(38070700005)(450100002)(66446008)(86362001)(36756003)(316002)(76116006)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xP0//qDie9zuvJNO166GWZGrrMwicBEwIDIsaVsIUused5p5WSV/eb8K7Bc1?=
 =?us-ascii?Q?NaaLm23mGSy7+zop0nPilWpr8w4Gn+g/L9zKVcUHORD6GHBbF/U4rYeygVS6?=
 =?us-ascii?Q?EhTUGvRMve4bKKsYDgZ1q2h6laSRWZfOyo8W3eWpB38di/NNhW4jzKEpG7py?=
 =?us-ascii?Q?8iUFW06/9DhFwLUaPyx9AwuJu/qJma9bNHf4k0WYkt2A97PIQpN2A4kpFOU7?=
 =?us-ascii?Q?spA7/4nu3owiRwSYFKASySmKxajnntRkLQL+mmw8XvA8PfoKBlHv+BZ8dQRA?=
 =?us-ascii?Q?wXjfc0JMG+GpTDctYP4z4xN2qvIfAwJjzrzu9eRFIxVyP4wgcvZ/6ADLyEZ6?=
 =?us-ascii?Q?2yP56LnMZSLVtAUw54fuwNCKYzCvhLRPjDkQPsU8hRwg5oNPKaGeEtiYwhfq?=
 =?us-ascii?Q?DeG8/kx04tFVwN/GQOEDFVQi/XaWW14ozR9NvkX42epEOW/k+ZNtxxZRmi2F?=
 =?us-ascii?Q?pqXZM2GJ5aYFt9YtevPuEMkcGZXT2vUtmaa6xXwVeaqXYfPyhMGtBcTSi59u?=
 =?us-ascii?Q?vJpKek2Nq9SXYFDxSnGlXqEryvrMWAyi+N4nf9SkGhTqq0/9f2Kh37UZc7M7?=
 =?us-ascii?Q?kzxcM4h8b7s3e9K1J9Hmw7oJZc48ZdCxIpqyhkAnUzyIqLiZqxlcGI6WVy8f?=
 =?us-ascii?Q?Vuve1DPL5WUWhDBmLDjnrTJLjoBSYRJkUYwEJBNidYFhnDQZcMEg/V0UVIPt?=
 =?us-ascii?Q?osmVXgIJmyE1yc/gC2wAg8BBDTLeP/BLM+oOZ2YNBjlYPOrZM5W7TSg5o0DU?=
 =?us-ascii?Q?CzpRTLwJcXJaha2eLDw71v5dhBAo5reShf4J5k5LajeSbDI4RIodF+pj+J3J?=
 =?us-ascii?Q?ZoSNWvIaRmy9couVfi1Xa+mfB8LD6fGG7S74Cvmhy9isDt5k/WfokKpuW3SR?=
 =?us-ascii?Q?Ciji6Yf6uSs3+sgS1PAGNDBMBo9oRy5aDITKFsRofY6njS2zvBq6gprTRHpV?=
 =?us-ascii?Q?4HHEFuXOK7GqXg9yIHCwrOgA7oMAihpp7qYA0FisgBSFo7etFwmMZkmTlG07?=
 =?us-ascii?Q?wqgggGNHFQ15uOlGbBzdL86XZ3IaQ1+ZxK5DfQXesnK6WWCKmUmuHuZTWtEA?=
 =?us-ascii?Q?vHG4lKuxRWDxtKzxIxBIoWJhmQon+Epo/c7Cs3XKDsFPHEMaiptPD1R+mwOC?=
 =?us-ascii?Q?i2mxwef4L70JmoBQscI5/DP7GkZScLMpCpYmFYdWVAieE93SbEuncSr/PTsI?=
 =?us-ascii?Q?ZTRD6AWYnqYS7amomYX3Ts3oJN8bqFpEOymEYLtS507nJ/JFga2MRJRrV/o+?=
 =?us-ascii?Q?NasxYqhfhYYeQfDUsC5XNDJVryjEjvSA3TiILPQHMclHen0CK3Ez8AoHZLej?=
 =?us-ascii?Q?SDzkCvTbYkrYzgWazTFF0fFsrh4+v2Ywu/tGZzhqya8R7ekgx55xa1hE0T0/?=
 =?us-ascii?Q?jO6lQhOzmyTIuX35fHANmTqTPiqTMk/X9LblJnw1X6v9LSmgB2vYSSICIfL5?=
 =?us-ascii?Q?m6LmYkj8U91nBJ3XpyEDGfnv0VjmUp4HoYb2G6/OapKQqRpU5ohZs2Zpv/vy?=
 =?us-ascii?Q?XMxuRe7dRe7Q2SoxEZTJUCQZGGm+8L94vudBwnhGCPOzhghCY4hBUaz/CX6G?=
 =?us-ascii?Q?t99uRRd7JLrOYNEbKGzNl6fihilqt4wdqFbpfEbSeSleU+XuQFim/ADWwYEg?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA18B423566F5F4F8246D3DE486EF654@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR15MB4145.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e2c4e4-46a8-4090-18bf-08dba9908ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 19:37:27.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmZg4NbspD7NotqV4w7Zdxl+/JYbT2iXIvP6IjQZX+8XQiMch3AmD8AADgX4GS8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6083
X-Proofpoint-GUID: jI7o8WtWMgf5TJ7_v7tcktyEhpSnHnHp
X-Proofpoint-ORIG-GUID: jI7o8WtWMgf5TJ7_v7tcktyEhpSnHnHp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_16,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to run Linux 6.5-rc6 on a x86_64 system with an old Adaptec HBA
using pm80xx driver (Adaptec Device 8074 Subsystem: PMC-Sierra Inc. Device 0800).

Machine has 2 expanders 10 SATA disks each and 2 SAS drives connected directly.

pm80xx -----  port0 (3 phy's) ---> exp0 ---> SATA, ..SATA, SES enc0 * works
      \----------  port1               ---> SAS * works
       \---------  port2 (3 phy's) ---> exp1 ---> SATA, ..SATA, SES enc1 * does not work
        \--------  port3                ---> SAS * works


If CONFIG_SCSI_SAS_ATA is not enabled, machine only discovers 2 SAS drives
and works correctly.

When it's enabled kernel runs out of reserved task tags and never finish the discovery.

Both expanders have the same sas address, but they are connected to different ports.

If I pass "libata.dma=0 libata.force=noncq" and with bellow changes kernel is able to detect drives on the first expander,
drives on the second expander are detected by the link layer but they all fail to complete ata IDENTIFY commands.

[pm80xx] : Do not leak reserved tag in mpi_set_controller_config_resp()
Save 1 tag from leaking.

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 97f54fbb3812..3a6157b9a77b 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3673,10 +3673,12 @@ static int mpi_set_controller_config_resp(struct pm8001_hba_info *pm8001_ha,
                       (struct set_ctrl_cfg_resp *)(piomb + 4);
       u32 status = le32_to_cpu(pPayload->status);
       u32 err_qlfr_pgcd = le32_to_cpu(pPayload->err_qlfr_pgcd);
+       u32 tag = le32_to_cpu(pPayload->tag);

       pm8001_dbg(pm8001_ha, MSG,
                  "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
                  status, err_qlfr_pgcd);
+       pm8001_tag_free(pm8001_ha, tag);

       return 0;
}


[pm80xx] : Decrease running_req for null tasks in mpi_sata_completion
Without it the discovery process never finishes

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 39a12ee94a72..97f54fbb3812 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -2292,6 +2292,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
               pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
                          ccb->ccb_tag);
               pm8001_ccb_free(pm8001_ha, ccb);
+               if (pm8001_dev)
+                       atomic_dec(&pm8001_dev->running_req);
               return;
       }


[pm80xx] : Increase PM8001_RESERVE_SLOT so it can abort jobs on more than 8 devices
Without it driver runs out of tags and loops while trying to abort all 10 failed ata IDENTIFY commands.

diff --git a/drivers/scsi/pm8001/pm8001_defs.h b/drivers/scsi/pm8001/pm8001_defs.h
index 501b574239e8..f7d348165f7e 100644
--- a/drivers/scsi/pm8001/pm8001_defs.h
+++ b/drivers/scsi/pm8001/pm8001_defs.h
@@ -90,7 +90,7 @@ enum port_type {
#define        PM8001_MAX_PORTS         16     /* max. possible ports */
#define        PM8001_MAX_DEVICES       2048   /* max supported device */
#define        PM8001_MAX_MSIX_VEC      64     /* max msi-x int for spcv/ve */
-#define        PM8001_RESERVE_SLOT      8
+#define        PM8001_RESERVE_SLOT      64

#define        CONFIG_SCSI_PM8001_MAX_DMA_SG   528
#define PM8001_MAX_DMA_SG      CONFIG_SCSI_PM8001_MAX_DMA_SG


Both expanders are visible, and discovers the devices correctly using smp. Same HW works correctly on FreeBSD,
and the devices discovered over smp discovery are consistent with ones reported by FreeBSD's camcontrol smpphylist.

# smp_discover_list  /dev/bsg/expander-0\:0
 phy   0:U:attached:[500e004abbbbbb00:00  t(SATA)]  6 Gbps  ZG:10
 phy   1: inaccessible (phy vacant)
 phy   2:U:attached:[500e004abbbbbb02:00  t(SATA)]  6 Gbps  ZG:10
 phy   3: inaccessible (phy vacant)
..
 phy  22:U:attached:[ffffffffffffffff:00  i(SSP+STP+SMP)]  12 Gbps  ZG:8
 phy  23:U:attached:[ffffffffffffffff:01  i(SSP+STP+SMP)]  12 Gbps  ZG:8
..
 phy  36:D:attached:[500e004abbbbbb7e:36  V i(SSP) t(SSP)]  12 Gbps  ZG:2

# smp_discover_list  /dev/bsg/expander-0\:1
 phy   0: inaccessible (phy vacant)
 phy   1:U:attached:[500e004abbbbbb01:00  t(SATA)]  6 Gbps  ZG:11
 phy   2: inaccessible (phy vacant)
 phy   3:U:attached:[500e004abbbbbb03:00  t(SATA)]  6 Gbps  ZG:11
 phy   4:U:attached:[500e004abbbbbb04:00  t(SATA)]  6 Gbps  ZG:11
...
 phy  36:D:attached:[500e004abbbbbb7e:36  V i(SSP) t(SSP)]  12 Gbps  ZG:2


working SATA drive
# smp_rep_phy_sata -p 0 /dev/bsg/expander-0\:0
Report phy SATA response:
 expander change count: 36861
 phy identifier: 0
 STP I_T nexus loss occurred: 0
 affiliations supported: 1
 affiliation valid: 1
 STP SAS address: 0x500e004abbbbbb00
 register device to host FIS:
   34 00 50 01 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 affiliated STP initiator SAS address: 0xffffffffffffffff
 STP I_T nexus loss SAS address: 0x0
 affiliation context: 0
 current affiliation contexts: 1
 maximum affiliation contexts: 1

not working on the second expander
# smp_rep_phy_sata -p 3 /dev/bsg/expander-0\:1
Report phy SATA response:
 expander change count: 36861
          ^^^^^^^^^
reported change count is the same for both expanders, that looks suspicious

 phy identifier: 3
 STP I_T nexus loss occurred: 1
 affiliations supported: 1
 affiliation valid: 0
         ^^^^^^^
affiliation valid is zero

 STP SAS address: 0x500e004abbbbbb03
 register device to host FIS:
   34 00 50 01 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 affiliated STP initiator SAS address: 0xffffffffffffffff
        ^^^^^
does this mean the affiliation was successful but was undone by nexus loss or other event ?

 STP I_T nexus loss SAS address: 0xffffffffffffffff
 affiliation context: 0
 current affiliation contexts: 0
 maximum affiliation contexts: 1

Logs:
https://gist.github.com/mge-fbe-com/084abe34038f5f10630b5c4519f301d2

Verbose logs:
https://gist.github.com/mge-fbe-com/a7c830599e6cc7f8017b4722bb58a901


Thanks,
Michal
