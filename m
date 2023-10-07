Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4A7BC500
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjJGG0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjJGG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:26:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC70BB;
        Fri,  6 Oct 2023 23:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgJklcuH69k9BkJJR13ewcc6TtqXzRAhnMxhHHyOPwXP8JlVJ3RUX7ceyRAewKlgON4Nw/M9eF1+34lPfZkvUvo0zbK2tnCa42MrglsXR2vMwftAZaqSBuvnVYx2AKAOlYKjxe+krqRLV29eq59MButJc1+ooQAIsUdiHf87U8ovHFUo3HYawC8WGPhnfv01SIMXAA92163OCErbRCBHhiXKk2em10ZImgxYWokym+NSvl/mTYVrKMu9A0/6iAPcqK9ueGEKXxxz8Nj+DoakZIz63os6KEYwRmUvLl5WZ6HmRZrUhcBw9i6boDg8zIXumqiEu2IH3jHTu5n2PkZ1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfLvPxHrOB2fAY7JMfTnG9JPBYN8NpzVUaRGnNm5Njk=;
 b=ZOI3dmgV8/BSJfdbSaqomcbU9fPrK4LbHnICTVoBfVlcVqbf7yJQ+EkyMeKu2Qmlct3bzUA8cU4aDnHWG8FsSrJd9rT92xr/3nGAgrE4ULpJSmS6VcLgZ9yBBkZ0JZU6d1lRLielKDfNW004nyn+PU+Hzgh9Rr/0gP142ekopKjWvcYcgDAw33j+RKxF/JGeYcAHJVJBAKLqx3Ob6wOUuDBAZ+DNll8NMjY80N0O6FpJGwCSdDkyWOvDxSEZ6CAazpVQ3Yf2pQuFHNFRgCcLpnHJSLVDyF0fui9YRnwmR3Ux88NjQXPaA0veMgm4ZqvIrxJxmOG4qFObBgOWYBhVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfLvPxHrOB2fAY7JMfTnG9JPBYN8NpzVUaRGnNm5Njk=;
 b=bFVdhaF08idezGPbcOJuhI+DZVYDe2vhGQw24V2zqAl3JEDHeOuPwMdPvVf+EuMndMmfXu4x8DDvbsgIMfJkBK9qqr9m0jpzsJ80+rCfX6+Qys/uwUtTWIKm3f+Wh1Sp4zDW8Z9Q6Yd/YK6sY5c+//OoLMB+jXNQoV1oPw0+6Lg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5613.jpnprd01.prod.outlook.com (2603:1096:400:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 06:26:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 06:26:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Mike Galbraith <efault@gmx.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        Pavel Machek <pavel@ucw.cz>, "pjt@google.com" <pjt@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "youssefesmat@chromium.org" <youssefesmat@chromium.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Thread-Topic: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Thread-Index: AQHZ950NDu+uQ14YiUiCYnTsYxjU8LA7SzkQgAEloICAACB0AIAAOnUAgAAKvoCAABUzgIAAOpmAgABXQACAAF7RQA==
Date:   Sat, 7 Oct 2023 06:26:05 +0000
Message-ID: <OS0PR01MB59222333D50ADBAD1786DA9A86C8A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005150258.GA36277@noisy.programming.kicks-ass.net>
 <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
 <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
 <20231006155501.GH36277@noisy.programming.kicks-ass.net>
 <20231006192445.GE743@noisy.programming.kicks-ass.net>
 <ZSCoLllO/cYnnIMi@chenyu5-mobl2.ccr.corp.intel.com>
In-Reply-To: <ZSCoLllO/cYnnIMi@chenyu5-mobl2.ccr.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5613:EE_
x-ms-office365-filtering-correlation-id: 4070fa00-eb58-43d5-2e8f-08dbc6fe491b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0jdatI76alUMKb6bAnmAqPNIFrh3KdGUqhR3cY4DTV6/t+/TXYrZd1vtgOScsyw0rPr55i+mi4iG9A83kNbCX8LUGOAMa+Sl0QYuQ4BWBH3cSyLqv38cPv5u7rLJgdq4aiG6pl1RhrfLv+JSPb6RTn7XYXt7eXnB03GBNcML0p4w7vvO4yDcJiJcuCBHWDsaLX/Fc66vteyrek0eC2RL7S/hNTWS5gFPn3wCw+rv2O+YZw9tMAMrMJEOaO5njnwI0JWEHWlOj4ZbH4mhuuVKnHFXGdfJrUcWBa3MaIRC3t8bx8JvQoBBRGJFZtJZWd+XeRniZa6lHtyewRyEKImC7D4VM7mo5vH6O5bUqKo3ZKUJX9ywnW21aabLHAeicGOd7j1BEks+C+TJjcXqvMd6s9LjFUnzfoegMLcZVt8huR9uvORISLs5ePlpSpy/pfrQeVzOx73dnZkTyP0XwDOrlxwPPZLRsLMArGSHefZnVvVDeEJXXbVDJUyMqtHt2pmgM/xbYieoBV/MIN0dNyanckglEdCyVIun02FjD5Tl0fP8170/ZC9nCt9Yh5p6ibZqBBaBtku8jgp/L/PZIye8FgmuATD8nSmUPGUuGLLkqTh5G0J554YJgmbz1GMxJKy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(316002)(110136005)(66946007)(66556008)(66476007)(41300700001)(64756008)(54906003)(76116006)(66446008)(83380400001)(5660300002)(4326008)(52536014)(9686003)(122000001)(26005)(8936002)(53546011)(478600001)(38100700002)(6506007)(38070700005)(71200400001)(33656002)(8676002)(2906002)(7696005)(7416002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B/L5MdVPGlHx1yGjKsB0Sik7DvV770iBkNAi1kzYPoWKFucv513HkfKzDQL3?=
 =?us-ascii?Q?K6t8tuRDNvDSwMvwtAwwKAIsq8AWKUorcLlwvxliQAYisYezCPjymP0fjTt4?=
 =?us-ascii?Q?UVgBYTfu1/jS/6xidzCbr3RB/vaaDkHm0o299wV63OUlMwnMAHe99hh0azao?=
 =?us-ascii?Q?IyrPqoZ/6wyxrmGl8vkRqGn24lcodwVNoPOoj5RSdyqnh52kT4Z2NA/Xb7Po?=
 =?us-ascii?Q?5rzm6CMyfmEoQPAzXsmm89V5zOGxcY24QuF3IzWyWRthR/C17Bfq6P7oYCzb?=
 =?us-ascii?Q?AkwT57zCdCRRZjFefmE4UIkW9zTufed0qMowbKQyU+PFNg99dK2JUMxZWOPg?=
 =?us-ascii?Q?GNBEHwOKw8USr+xAffzal3523CVINhyy+swOFyHhcxMcXccdkTLXNf/D4u3J?=
 =?us-ascii?Q?pXojJ2ZXgRAckyWMa8goJirq29W3lG5KVxZ8V6ql5GK77KpIdfC+C0mzli9o?=
 =?us-ascii?Q?8RfZUiwixrArE6TB/l5X4oFaAu081vtlppkjbK8Sm3HR6/qizeqbGwLw/55l?=
 =?us-ascii?Q?7I4qbVNAs4JEa/Bj5+J+/mGqhjRzxOd37pj0r0L3bf1Q3gBbLUP5rA7CE7zi?=
 =?us-ascii?Q?94tdf6k/I9v5Uco1VqjORWYTUe4t+PBBDgh81CyxOSP6wRO/GtyWQbmNkN8j?=
 =?us-ascii?Q?5DKvZXA06XJnwyxJA0ItCxmhFo/vRxtPLvyZ67mbdWtS0JxleAuzv+0UKE00?=
 =?us-ascii?Q?f4QLiX6wSZ1B/noMeDQCKL0gigWhcXVFfJJpUDR9/KhlZ0G5a5j3+CMK/iwv?=
 =?us-ascii?Q?8bS8ifrGFDcaLqAVn21rMDBSL0gLQNUjUyoEKHV5zYYcJoywS2Zitm6LY3ip?=
 =?us-ascii?Q?WXUX7m6y1CNzS+ZwaoC8RyLgyr2bqMoJXKMoAi2KEDHwE3Kg+IgOCjGbEAYB?=
 =?us-ascii?Q?SpXV6b1lWrtRJWFNaxitHnqLUggQY4F4n0qU8Gc8eRXSao0uO5WR5AhCM2W5?=
 =?us-ascii?Q?zjy8eoAIrtTuplvHbsgd2t0vM5yzTKuE7v5MxhKoU6wAlGOmAG8opG+6z/42?=
 =?us-ascii?Q?Ky075n0u+o6aNmU0/xnVDFFGjhspsKuAFnnfRehpDI0gvOIxiRGcyQkc/4E/?=
 =?us-ascii?Q?JZ3Mo90LidM086AomIywaLAWuqhwMluthC84/TKZUaOVWGAzazxTRWU3IHTL?=
 =?us-ascii?Q?ajJFO7AwtQCeaTmua63tfsC0z6CjgKB1FJFyJxQ8ZHzLtBCxwbgUehkWEGvp?=
 =?us-ascii?Q?9Ud+aZSBT3n1ifouuKPlk1yONU8rOlnqEJXzimSZTh+bj1j63DTLrLJZ7IZQ?=
 =?us-ascii?Q?7kNzYnVUAMssf970lAYuLz59IxfsKqv7uUuflw8QhL0PU9Pj2m19zR+Crm/m?=
 =?us-ascii?Q?mdiMSYGEfXoS8rvGkZeWGePWnPOm7IkCjYgbfiQMv7UkYw5qB72nxob6MVD9?=
 =?us-ascii?Q?3o1A8qHPy0oSnI4ADsmNfUnU4RmaD6aKTL3WOA46I7pnXrcYmWlNhcXQQeAX?=
 =?us-ascii?Q?4olMQWcS1MdfT4eMcnJacoG7ql6wBHUK7dvihzR5waYz8N/UWaqDq5vEfkT+?=
 =?us-ascii?Q?uS7e6z8I8aaDg01xxQRz7sg+D83fbXIcJOof5XKJRvl0FkEF+c49LEAzexzg?=
 =?us-ascii?Q?WM+L0fqtXB36RPy5nyZETB1BsawASLGMy2TQNvFn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4070fa00-eb58-43d5-2e8f-08dbc6fe491b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 06:26:05.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n70kkbPBlQkSV5FiJpYRZIp3q8dTsNgqBBIhAD4UxSmMNSwfitKjwYed+WhSeajGbAchS69bt7X41ax6zTQn4B737tZonl0+/u66KNWh7hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5613
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

> Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correc=
t
> se
>=20
> On 2023-10-06 at 21:24:45 +0200, Peter Zijlstra wrote:
> > On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:
> >
> > > And yeah, min_deadline is hosed somehow.
> > >
> > > migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
> > > migration/28-185     [028] d..2.    70.264277: __print_se:
> ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -
> 66302085 E (11372/tr)
> > > migration/28-185     [028] d..2.    70.264280: __print_se:
> ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -
> 66302085 E (-1//autogroup-31)
> > > migration/28-185     [028] d..2.    70.264282: __print_se:
> ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 =
N
> (-1//autogroup-33)
> > > migration/28-185     [028] d..2.    70.264283: validate_cfs_rq:
> min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 =3D -57987256
> > >
> > > I need to go make dinner (kids hungry), but I'll see if I can figure
> > > out how this happens...
> >
> > *sigh*, does the below help?
> >
> > ---
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> > 04fbcbda97d5..6a670f119efa 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq=
,
> struct sched_entity *se,
> >  		 */
> >  		deadline =3D div_s64(deadline * old_weight, weight);
> >  		se->deadline =3D se->vruntime + deadline;
> > +		min_deadline_cb_propagate(&se->run_node, NULL);
> >  	}
> >
> >  #ifdef CONFIG_SMP
>=20
> Is it because without this patch, the se->deadline is not always synced
> with se->min_deadline, then in pick_eevdf() the following condition could
> not be met, thus we get a NULL candidate and has to pick the leftmost one=
?
> 	if (se->deadline =3D=3D se->min_deadline)
>=20
> Regarding the circular locking warning triggered by printk, does it mean =
we
> should not get a NULL candidate from __pick_eevdf() in theory? And beside=
s,
> we should not use printk with rq lock hold?

Is it not a useful error log? At least from the initial report Marek Szypro=
wski doesn't see "EEVDF scheduling fail, picking leftmost" but seen only wa=
rning triggered by this in the logs.

Cheers,
Biju
