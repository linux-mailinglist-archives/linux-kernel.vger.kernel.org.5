Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5AE7F5F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbjKWMeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbjKWMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:34:35 -0500
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AAB1AE;
        Thu, 23 Nov 2023 04:34:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhVhdfFtHAVUhM/IVQ8h55eexdAWILEJvecWvKAvF8jOAGTN5PASWUbnve3voNNzVdPg1GwCkqxr+9Ss+28yaBkJcDt+Q0qzb3aIZx2I10maRNnqh2gh5p3wM3tfWIPei3LdevgHbmZ2Rk+wF8cae3x1o+1F+N/1zRCw9mMhC6KkXjOW8F03wuxKAAZdXsbLACKzSYoTPshrU0tIh/2k+k9lMRSoW4ZFeBX6PwAl+vcOEo5LVdoFyg6soxaEXukSjKMt3nEYON1+4p6XCLIleoXwBcXuj5ESDp3erfFxGnOsF1TsQMuGE3OFJrYQMJi5U2AeqCAmCglhZEz+Iesc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cOSddZ4rdY5FbQ/2k/btGYcZ9vK+qHyZbESZpRCeYc=;
 b=ZcYS9PJPbr+KKuEHg356bmpf1r+vvVB5y486I2e0MAyVvsor4vjM/4UCbMwSxwv/1YwpH1A+00ZTYjATCSFqEDNFi0jV4NfGEm1t4VgU1wRbWxOyFxSg+27ZYpmB0bUxaNBRVeGhK51LAqLsw2X0R7Y3SVhyxgQ+0SZs4Q/wortNWML3M3Ez54IPwXxDyjbH0M2iJNWCI1PfH/6HkdVXV9v89nHCXOJPrhdyFu6S7Aulu7vQWczqezK61CH7ddImUTPMYRlX6fITt4Hg4rzho50GgqOioleEXb6cza5LmjA8A0E4/dAiafWMEAUepHbOiv6xXjlnT1AgtfoP7vOw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cOSddZ4rdY5FbQ/2k/btGYcZ9vK+qHyZbESZpRCeYc=;
 b=F1tMh45pzzgYHmQ8fPuYrW2Xviyeh49JfCANx+8kK9mTgh5hOyDb0SDY7iRtLLaVgWkRKKq8boWsu3ksT4lFd6uZJW2j9lI4a+SVtQMfC33YXPiKn8Bdp7YYDCHndL3Rzern4pjJwIJ2ogRvGnZScZ8A0dbdm65mwyyV8BOAUqQ=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SJ0PR05MB7547.namprd05.prod.outlook.com (2603:10b6:a03:2ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Thu, 23 Nov
 2023 12:34:37 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::275f:d574:ed18:7f36]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::275f:d574:ed18:7f36%5]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 12:34:37 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        "lkp@intel.com" <lkp@intel.com>, Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5] eventfs: Remove eventfs_file and just use
 eventfs_inode
Thread-Topic: [PATCH v5] eventfs: Remove eventfs_file and just use
 eventfs_inode
Thread-Index: AQHZ9wQ7SoHlgP3tL02dU2THKHIjdLB+1UOAgAAEKoCACTgnAIAAEy0A
Date:   Thu, 23 Nov 2023 12:34:36 +0000
Message-ID: <E9E4036F-2BB9-4656-B018-783C422F6EE3@vmware.com>
References: <20231004165007.43d79161@gandalf.local.home>
 <20231117142335.9674-A-hca@linux.ibm.com>
 <20231117143829.9674-B-hca@linux.ibm.com>
 <20231123112548.9603-A-hca@linux.ibm.com>
In-Reply-To: <20231123112548.9603-A-hca@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|SJ0PR05MB7547:EE_
x-ms-office365-filtering-correlation-id: 3f3ad85f-035d-4e92-3ec6-08dbec208e0e
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5s3dv19/WKWCnf1y0U2KwFZKn0Wr90WG5VxtLH4xpL1jN7cr6+TiKSO6YMuyySj60l8gblPvmx9i4+Fu6/Y71ZkChK45xIZmlPmZlNKejTeWc8HICs4MzcjVJXUykkcPd9JVJDWKWzvDiLsKTNWCGEGlYf8HJrj0L3GELnu9jwYS/f7/pMvUlI1XJfYAoELX8FeDHBI5elRQfN7ceHHbzkXgtxMj/Go4qiM4Vo55UBvnXHobrWRB7l5+wkYvgk+//lPB1pioMXjRzseaKOM+Mjjww9lyg/0dIfpAb5OuqDKTR+wCAkk4kxBTg+wAxvsvWf/oL9hkXlzEmv7gyqncD34DaYs9plKaN59/pUWs7SwqbS8hM2Mk8Zup0YHuoFL46cGUA3tRCjbwLuSH+6Asa0Dg/etFaaw42sunAFgzgRT/u9CgfB3WmTPCHpepAbH4XL3wcWAHY9XuLShm98yYH8DucxLqkFG7+XLcHBNAzPGs5jJLWZeIThDyVb/btqTQXNug52JOySyABrqYOPuzshoJJPiDgRx+dzrtWew8Gv6v5cnoS6RE8mv64oKrUR5807ea6aMdyjwuRMiclv8dOAW50K6zPIMpGVo0RpScFOFgx6PIgbca7+MHwWu+HamkneyffkfYJVnyPXbcFiklBqdB0H+x8Pyc88iToMomkxwPvf8F9OpkkRY8QMaz1ddViWoXC5DQ9QkmuAf0vVkMDVjrIpgBrqo6eLKZ6A18K4chsVlkrEmchhd5Ks7LC5gjokZg4Cp1j0LBGIj0J3cUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(91956017)(83380400001)(122000001)(6486002)(71200400001)(966005)(478600001)(6506007)(53546011)(6916009)(76116006)(66946007)(54906003)(66476007)(66446008)(316002)(2616005)(66556008)(64756008)(6512007)(26005)(8676002)(4326008)(8936002)(38100700002)(7416002)(5660300002)(36756003)(2906002)(86362001)(33656002)(41300700001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?10N+WRx6aIk3/yP7B6+7jcsAfNEBtH8UZChk/jicNZzCL/36MiAM08Afa5/H?=
 =?us-ascii?Q?oBIU3myakhFMg8KkSD6rIDFZ9DBpZ2f/JIy+xVQW672y0rupyqn7phAsXEWP?=
 =?us-ascii?Q?uWOfr7Sh3A2poGUBv6q3aZWUR9hDt6CFVskSzT38lOunClG30/LDOg+CK1eq?=
 =?us-ascii?Q?+9NyMaRnhB5CJ0N6szRslwvGisg2hBZ5dBdtZQl6M/MY761jZPrNNf2iv7R0?=
 =?us-ascii?Q?cvquNzWm3u5FziSyTMXtyYqht5A9fFVB1s8AS4Hc/E40T0RnjJQU+4bGsPxR?=
 =?us-ascii?Q?6urgt5SS/iPZ1b/LaEIEgMPqU3uVBzUMi4eklq27fvmQ0f2pzLxGe+r9+xnm?=
 =?us-ascii?Q?l2gk2mUcbveVT7GV9LcUDiEe0A3p9xXEyNnJ8sVv+dcPGN4UZ98pTZ8Q+/8E?=
 =?us-ascii?Q?4r/JLokNrSCcPz3pYF3fvN5jNGWNdGRmpL0zH3lkD3F04cdN5HXGb77+hbJ7?=
 =?us-ascii?Q?nSm1xiJwjbf9mx9VH42sCxwPCWxcsh/ojkQgCgXMUEoCJLjeO7TjxaS3ZdwY?=
 =?us-ascii?Q?vbUfcFtPGEZ9b3e0r6GDRBrbX77tgdkzCcmqbkXF4IJB6uuM/2ePovgpGgFI?=
 =?us-ascii?Q?GeWvP0LRcUhU2YmGmhO8Bu2eBg3FRAaXIB6DZz8Z6prVPV4QJYxx4msCpi+q?=
 =?us-ascii?Q?k+/6Yk+H/0FXKZ45INLVIcYICxnfGTYQLQkyYUVoDo8PNC4ZCp6PnY91LmVA?=
 =?us-ascii?Q?Y65FTpqGYAieXW4EA0IzmeaJYamHiMkUNVspZcaPH9g50EOZoz6Goid+8gcw?=
 =?us-ascii?Q?BPqE8bvAs4C4XSDD7psHOvp4DOcsKW3Qe3RpeSolgpZeolEOnbzpYp8/Cd1V?=
 =?us-ascii?Q?xIOSmIZ2JA1/vQXQXp479LiJ7eui8Fm+XJCyvZkQqT51JBedPBByr5TxDLN+?=
 =?us-ascii?Q?kA+jGtwQ7/Tq5BMyWNzS7RmhQv5xBHDQmPuJR6F6dGL0o/e94g+5/MncfRRG?=
 =?us-ascii?Q?GkQWYvHNzq/+plkq8UNU4IObpd4NnXS2mVaaA9odZZqIuQOzBlv1pA4itoXr?=
 =?us-ascii?Q?jKD3KmqIyVcC1Jav9fEDbVHjcOFcqeZsm2/oQfulnHERfPOvANnIAl9mqdbA?=
 =?us-ascii?Q?rrARbAemtLejxwmSmYY6ZRkY5MMsx/SDZDO129YEFN7PkfmwUElmiC9wTiHS?=
 =?us-ascii?Q?kIr79pW2Fjy6HYOR7a0VXqND1C8jBvwPMChvAOgk4QC7ifKNyP5FUOBDmt54?=
 =?us-ascii?Q?jWQgeCyU3T6kpHX1wfbcHv0WGz5pcA79YGg0tES6Py1byKWYQjdlG2fsgiOI?=
 =?us-ascii?Q?W3qyaOH7cYOW8dq7fgDOKF2u0MTBNdPVDM9SPbimdEn2UGqZuvQsZ37JJakC?=
 =?us-ascii?Q?XKExZixV3e8DYa96w4vxEQHLP5mXBNuNA6KX9k16MmoozIC5yc5qJ4ZuWnTm?=
 =?us-ascii?Q?vwz0FRK/Sjb1yWbX8dxyFJlRgYnKG9NqIIoa7T9FkzoQ2c4XUTfGms/gDAmW?=
 =?us-ascii?Q?/d1VgaHAL0g1pMUt32BKrMrBmzW0u3miO8qEzk1CZZ51G0cu2Xk5J8dxeJTM?=
 =?us-ascii?Q?GUTOJ5jOTp8RLIUjpaqsEJHUfhtP2riF/3NLkZHnVjjgMZIi7eq4WbvvRhjO?=
 =?us-ascii?Q?1FJ9AM0OMPSP5iagoP/iNlmUvIvK9cN1MIAkp+Ai?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <407BC8BBB527C2488FF33C037C4F528C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3ad85f-035d-4e92-3ec6-08dbec208e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 12:34:36.9275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMt7qlO6jlMCKPeM7PpRnnznViBnbwB+yBOFf7Wx0k2XN04/EycM6AGwhu3UtuNwvOAQDUF4UdnXrJe29MTpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7547
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23-Nov-2023, at 4:55 PM, Heiko Carstens <hca@linux.ibm.com> wrote:
>=20
> !! External Email
>=20
> On Fri, Nov 17, 2023 at 03:38:29PM +0100, Heiko Carstens wrote:
>> On Fri, Nov 17, 2023 at 03:23:35PM +0100, Heiko Carstens wrote:
>>> I think this patch causes from time to time crashes when running ftrace
>>> selftests. In particular I guess there is a bug wrt error handling in t=
his
>>> function (see below for call trace):
>>>=20
>>>> +static struct dentry *
>>>> +create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry=
,
>>>> +            struct dentry *parent, const char *name, umode_t mode, vo=
id *data,
>>>> +            const struct file_operations *fops, bool lookup)
>>>> +{
>> ...
>>> Note that the compare and swap instruction within d_invalidate() genera=
tes
>>> a specification exception because it operates on an invalid address
>>> (0xffffffffffffffef), which happens to be -EEXIST. So my assumption is =
that
>>> create_dir_dentry() has incorrect error handling and passes -EEXIST ins=
tead
>>> of a valid dentry pointer to d_invalidate().
>>>=20
>>> But I leave it up to you to figure this out :)
>>=20
>> Ok, wrong function quoted of course. But the rest of my statement
>> should be correct.
>=20
> So, if it helps (this still happens with Linus' master branch):
>=20
> create_dir_dentry() is called with a "struct eventfs_inode *ei" (second
> parameter), which points to a data structure where "is_freed" is 1. Then =
it
> looks like create_dir() returned "-EEXIST". And looking at the code this
> combination then must lead to d_invalidate() incorrectly being called wit=
h
> "-EEXIST" as dentry pointer.
>=20
> Now, I have no idea how the code should work, but it is quite obvious tha=
t
> something is broken :)
>=20
> Here the dump of the struct eventfs_inode that was passed to
> create_file_dentry() when the crash happened:
>=20
> crash> struct eventfs_inode 00000000eada7680
> struct eventfs_inode {
>  list =3D {
>    next =3D 0x10f802da0,
>    prev =3D 0x122
>  },
>  entries =3D 0x12c031328 <event_entries>,
>  name =3D 0x12b90bbac <__tpstrtab_xfs_alloc_vextent_exact_bno> "xfs_alloc=
_vextent_exact_bno",
>  children =3D {
>    next =3D 0xeada76a0,
>    prev =3D 0xeada76a0
>  },
>  dentry =3D 0x0,
>  d_parent =3D 0x107c75d40,
>  d_children =3D 0xeada5700,
>  entry_attrs =3D 0x0,
>  attr =3D {
>    mode =3D 0,
>    uid =3D {
>      val =3D 0
>    },
>    gid =3D {
>      val =3D 0
>    }
>  },
>  data =3D 0xeada6660,
>  {
>    llist =3D {
>      next =3D 0xeada7668
>    },
>    rcu =3D {
>      next =3D 0xeada7668,
>      func =3D 0x12ad2a5b8 <free_rcu_ei>
>    }
>  },
>  is_freed =3D 1,
>  nr_entries =3D 6
> }

Heiko, your analysis looks good to me. Seems -EEXIST is from:
https://elixir.bootlin.com/linux/v6.7-rc2/source/fs/tracefs/inode.c#L533

Steve, as per me error handling should be same for create_dir_dentry()
and create_file_dentry() or am I missing something.

-Ajay

