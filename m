Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3A47CD004
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:29:25 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013008.outbound.protection.outlook.com [52.101.49.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FF9F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oev2sg7hhSh4bGKRF5wD+T7W7y5mGSoiPHRFbHna9JCsIzBrG6maiV2F6fuicucr3Gz6MDww9jxElD+o+WwJt+mXr9CiHj35IK6LqJWZmNNgZw8oYd1bGwYR18+qvkTSqLgujQHuhAEPUZWGMYywkWQMITAOMs1ajzXWfICyJkxH5vpj+Rk0MQA5gRRZzrdcN3xHwEXGXyPWMBaXIAwWS3j0PGB0Vn10sq5cLuZDLAseU8qAvQq+EJ0nKYBtEFt9UXgq87czEfDQsIYsyPhoejywji65+PTGHfYJwk0vj9kO4hGwpldjw5e22EpeU5DNDtRGTh37RUjxNBKSEXHdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YVrS5VSVP0Kl4IUSfdWeYyaA6MBZlqXX+XQsn22O/c=;
 b=FEdE2kamflo7/JJ/M82vX/6zn98HpBRi2Dr+UkzH6mns4WeWA4sl3ZWE+AzNbtJZ+OlCoIPJj/SSzQy2TgVr1CQiAqifumm4BRG/tw5Gx8Mm+qShdJpphdsYIUwl0pdGZFyl6c0eUjy5vInkOYjqS54VfFuLrexqYls9zWOsT8U35DJreNKRxm5GWDJL3MzTldLCIMx7x8Zfn3c/SwI68g9WYBhNSj64tJdrvrQU+c3OXgDpytG+X/G7CaWphqR7UfCJwQi31cDVOluxNLBOiB7AQTldNmrtzINyyyr8lpg5In+sT7nRqhlLk+DtsCABSHwCgbmN6IvVitCqVPGmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YVrS5VSVP0Kl4IUSfdWeYyaA6MBZlqXX+XQsn22O/c=;
 b=rOjeZJZqqrcb9gWN33qI8HcxPIHrv8KN2zHHVTOa+yKYrT0+h77eJFkiIGxpDoN4wXqcU0tKqgAemvpcQNnVVSVhBcvvp9Mp8qym/xQEQNlMWogOedS+UGvX7VqNAs5a8xt0U1shZ0T5nC8RCSbBZ+VP/jI7ypmwv2FeUePdBWw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CY8PR05MB9524.namprd05.prod.outlook.com (2603:10b6:930:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 22:29:22 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.037; Tue, 17 Oct 2023
 22:29:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Uros Bizjak <ubizjak@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Topic: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/Fg==
Date:   Tue, 17 Oct 2023 22:29:22 +0000
Message-ID: <2419C44A-2467-4FB2-A6D6-BA49856A9D85@vmware.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
 <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
 <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
 <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com>
 <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <10930088-3B4E-4BED-896C-CA66AB196010@vmware.com>
In-Reply-To: <10930088-3B4E-4BED-896C-CA66AB196010@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CY8PR05MB9524:EE_
x-ms-office365-filtering-correlation-id: f0d990a1-29d9-4630-8410-08dbcf6082d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwXn8SkK3DStAKJxKTldbuJlBbp6Ko6kS4TDk7Sg89Rj5FtxvhBRS0tN3cVD6ulqPKCh9+77ViADf0wbzzchozfDe2hlCEPeJG+m3RG7hVUzQtbxfHnnC46fMKSkinKah4JWUF2l8pOzg4BIqc2z1j2ofcPv1vzwRw/cwQLPyvshEbWpAEsUR8MCHRaVMzIGrG0ErO3W8lByh2Ct3tBjP7focl3xTCz9i47uAxDkQTmc2O8oyi2MSrEK6OEgHAoiRsKyr7MwcqBHXoQnSV2qq8hQ47rHYqBoRkhfFFWiB+JrCKYAa3ejnspO2GO+8tEv4/ydUdnSxJRauYfZNmAXGL1NBI4fNgYQriUINssg79wdHZ4czCg3xqTFIsDIOYc1vfHn3KEeyvBp1YE/WGaAa7ufUMUPLltCdU9968X1eifjCjMGBesOaKXD41ytiOyM8GXNTi3bXjl1N6kUuQPYwBlzu2cQ5CruFFEotdlDxzx/6FAY8X3ooVy3b+eLkPTtdomXSoB4r4cljfo8aCivfD6nExoUZeA6NAxnntDi4pKBCUBGM7fF7WRb3HORP030q65Ga/VudzhWlcf02AqZJWmxPpPLnjtvyiMqob9siyHaUBdOC8TtYBDoJkrc56Qv2w046cfuIioBd20OdV88Oi6ksBzx4V9u2ho2IlM9XtiS4zNYHf7EqvoSIVg3xayQe7okpIUnJeGRZWkrK+YxSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(2616005)(64756008)(316002)(6916009)(66446008)(66476007)(66556008)(54906003)(8676002)(4326008)(8936002)(38100700002)(38070700005)(71200400001)(26005)(122000001)(6512007)(6506007)(53546011)(91956017)(6486002)(76116006)(36756003)(33656002)(2906002)(5660300002)(86362001)(66946007)(41300700001)(7416002)(478600001)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?he58VjC6ovse5cu+GoejlfNk05iovN6We37IgfmaGRAUdnBdnO+NHvc3Wdmi?=
 =?us-ascii?Q?YISye/Kgj1zr43735EJH4YHYw7fXzPnkydQDDJnxa+nb7abvv0SMZtVMbHkS?=
 =?us-ascii?Q?V2736sqs8L3YzJl+grpauH7yDJbRJPIaXjHn1X6YcrIQzcyzvHkl5UJsWUS6?=
 =?us-ascii?Q?SeKLcvhp6KjOEd4f7df4lnvJQAQFnzQgrQBxYA7U3z7Pqe4HLaa2KKpu/qJb?=
 =?us-ascii?Q?ST9/P6w+sQGZ6COoX14YuHpm7P/ZJ7j2kOvOBQyywJNXux1Gfash8j3y785H?=
 =?us-ascii?Q?TdFaef55TfVfe9XYFCNT98anMAm5brLep64wf1JeZwPttUOmMs3i2NhBH04Y?=
 =?us-ascii?Q?ClHS24feCaQC3JAfaMjX3v+2b4DWcc+R1UcfRVQ1NIQYJjkq2Yua+DNfj98o?=
 =?us-ascii?Q?rhTlE0uS/xnVEfATzKjX6/oZwwlLB4c85f3MtcIP8BCNScjtPSJAzgTUsUKK?=
 =?us-ascii?Q?KHYYbaikRm+2/z6Mp/CxhixLK9z4G5u/Eq1VLen6m4yntC+kINDJ/RvF7a0j?=
 =?us-ascii?Q?fKfrJ8ko09NVEjI61irUfXjKUP7TTRUjlh5o4oXAOf39yiRgaOoi60c8l8EJ?=
 =?us-ascii?Q?0CecgrrsmXqrSmta6FHuysWpM0PISde3sVV/TtZN2+cmdoNzsTSTuEK27KEo?=
 =?us-ascii?Q?jjVmzJk89vciRZsLAWv8JBXwnHdSSt0ykNxr7R4javdWrVkyUWwjXYMM+4Dh?=
 =?us-ascii?Q?moT9y7bqmsduRR8jxOrvZgXOJ/dxCY6SClziAmtnfY4urFBGFaqzwy2TEAMt?=
 =?us-ascii?Q?4inna89xB/0v/E9ZeSnLxCsRuNV4SkZht4v1McwYxlCa2YnVjmV4/gckAZ5M?=
 =?us-ascii?Q?kzs6atuoWATfDtXCBH3BqvRJFlL960W246uTVLQ/dXNRTAqYAbugfMX4B4aV?=
 =?us-ascii?Q?URjHpyPPNP++N/2h/HASrRRFCB9r702M7PUw5w8GonBAPfoVuO/viLN5alVE?=
 =?us-ascii?Q?dDdRftehNxNgv9y/z6WQv0UpqOJ33aQhGSBIAWzIImnWvuT5E9gxCqRZ83y2?=
 =?us-ascii?Q?F9tagEPc1XqrBdnZ4492sboLJzasQhWkPWnAW2s7mgoku8WYrNM4UtWeZ8qS?=
 =?us-ascii?Q?6UeTl8/C1k2XGKJeZlO4vWYpZeBU4ACzF9xN5JKPJr0Cy6sYuhZ0zrUC5jZx?=
 =?us-ascii?Q?O7nSH+bJ9NsCeuPYHPaPfeJFke7cwiafzWicrTnKvRxS1kzxL6uvZdHM5dIR?=
 =?us-ascii?Q?oXJG1APaKnBWvpU6WLHJKZ5pITapDZsWCo6kVXedCr8Nq55S/1s7tWdS7EMj?=
 =?us-ascii?Q?u6RWY3ZWRBVTC5LMxjGhekDUHI/fen43oDhEZ8GLIWddSybwwSJDfbBce5+g?=
 =?us-ascii?Q?naMx6jXZoZoprHu4jTTSryL9nRI4t0Q/nW30pM3dw+5GXYfNxDswAY9CBQZ2?=
 =?us-ascii?Q?HxbRWartXkqCvSyxqTyeGX3oCr7rx5xEA1vgH/iTG4E+WY0HgGqH1Ibc22Ll?=
 =?us-ascii?Q?efbEmboEogETaDnW0YWl2Qonp60MzUNo30z264eOpESRIpgGNaSHnxUSJP9r?=
 =?us-ascii?Q?hD0Ip1o/uv4u9xEUHMgrQy3aICgTHkykQxoBSYLKFqWoWwfb0nkCHSYuSFRo?=
 =?us-ascii?Q?fBNmv5IM9WwpOIpAaICAb2MCEXTGtsYRb1nUF5Jk?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CDD1EF7A3316F43AC4FDC0534A1E668@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d990a1-29d9-4630-8410-08dbcf6082d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 22:29:22.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Pt24XMdQ44JsaDO5lhu1ZhrKFfIH7VL+Y6QxfkDe0YSnlabrWea01YURItNQoR1h3dCTAZcAh+PtFbLqGq1wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR05MB9524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2023, at 1:06 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
>=20
>=20
>> On Oct 18, 2023, at 12:53 AM, Linus Torvalds <torvalds@linux-foundation.=
org> wrote:
>>=20
>>=20
>> but none of this should even matter, because by the time we actually
>> *schedule* that thread, we'll set active_mm to the right thing.
>>=20
>> Can anybody see what's up?
>=20
> Could it be related to exec_mmap() -> exec_mm_release() -> mm_release() -=
> deactivate_mm() ?

I am probably completely wrong. Sorry for the noise.=
