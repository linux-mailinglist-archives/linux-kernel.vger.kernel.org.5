Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCFB78DE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjH3TDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245619AbjH3Pn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:43:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE4122;
        Wed, 30 Aug 2023 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693410234; x=1724946234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=heG6TlhsxuUjfx7gYZvYhLCS3oKg3mbtnQcWAEY5Zbo=;
  b=KbfrA0PWXM2Ou6hk114GvVwoArZNXMRRna1lxKO1bfB/zRBtyYmegTcM
   v2ADR3u3DIcQRQ5EfxmtkGDrhoRTl1V7iHkVHNp1Mi21bFuvCRUubESfR
   oxKcwd2xKjpWMyYvQ8Y0XOPaA7pR5T1pUlm4TZaHimeqN/KH/eExQDtMp
   n8zB1lwes4LSuJACffuaEjQIbtHLT1pz2+5ePvLC2Hpkaef3rr/L9hiPs
   K8ifLpHvC5oQ6PUG465xauufzTUClPcrQ0oNFc4cImhETd8blokKtYV0W
   7ho2b1lq8grMzq0ksJLO9wdSdyCVK/ML8u9JerVl36wPWC07RQmhec3YS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355992167"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="355992167"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 08:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1069879269"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="1069879269"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 08:43:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 08:43:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 08:43:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 08:43:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 08:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSiqWFwSaDMX4s4T4D9cuXRF/YC6gJyQF2hM/24KgA5A2tY5Qzvqoiq2CWC41blSa/LFUL9gbx/3Hq7zD+gY2d7oKCo9mZWBTgkovsn4DBaBePwgzaEhAGnuVN8/E18HYnJi4T+ZRHdckyi3WH+TDufelfUKJhcQIonoPurFH58/kC569ninZ84NSgGDwB2bajamLoqMFR9QXWP1NLO2Qoe+9rA0oFmYal16JhxLh12sVTuymuYJHZWQ7+A7Izpg9xqdkAmfK4qo+GDboPVuroSqVhX77ABbd0IEjsQ3GXL5XsSPTP4f46dBNn75/WSA4ZSxoO73XXFT0gOx4YIA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2q3IKaBscChS8uwdNnheguv9emU2lrstRt0BigRi7Y=;
 b=JWKhYtelOvQTyxBvOOq+coXT/f0VXW0iq7lOYaqNibv6IkIfTMokUeCXq877jaJ4VefOAdSVkcJeqbbhYrThmeKfXuwCguSt4EC3g7Puj6uHn/wF20hrUpllksL68eGIir5iGwLmsTyu3c7I9thrZ0Ge7hcMw4XjsCvp6isSRfVlvYj2uytud5Yqzwtimdm67/N7wwibAqQD7frw3v3FFUZaj/VMn8UQIlBzWaDT6hqMYA6z4AJepJ0SyU8vdglUdpqsYn8Mab8vEXBPL4vK0W1x/Hos83zp0SO6jcISUDBoJdmO7/T2YNvOKmn8uhAi0ndqZQ/SMMT/gaEEyBaMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:43:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087%3]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 15:43:05 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Topic: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Index: AQHZ2tLQzZViQZuDwEGXIVxBB0yNB7AC0IKAgAAi0cA=
Date:   Wed, 30 Aug 2023 15:43:05 +0000
Message-ID: <SJ1PR11MB60838CA98A341F59260BDE18FCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <frfa3olxop3xjnouvvv7y2s36varmto5qwhmkitvslmiawzwkd@zh2jhob4o5qe>
In-Reply-To: <frfa3olxop3xjnouvvv7y2s36varmto5qwhmkitvslmiawzwkd@zh2jhob4o5qe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB7040:EE_
x-ms-office365-filtering-correlation-id: 49571ea7-db88-4d92-55c6-08dba96fcd79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsEOka4E6Ae64zBRrHztSZDlZvbeaFL8NOgw3O9j/NrjEVAa3aSMZgsQCdx1gXsXBBNimywCVCn1DZDATzcue58ItNabWhC36/xSm/NRYVgqD60omxnP2QASwpTWQ6yxHOsTTN9bh1TqQYNimFfpD8y2DQD4BkeLKBdBvjjIZuFlqlH94ZM2RbrppCVibVySseCv10BQ6r/STeXLSxUgo65WSR8HcNzIWCNhVMrwXTOrVzSgf3lW3DF4BrgiyL0TDIqsoUMl4PIKt9cSo64KudMcMnYHPAZt6GricfWJdw3TgKnl3bqjnvF1SIUQZXUeHa0eFKYTC500w1Y/QDsnKOgKrOOz8UYCaCtIk6KQyWmVqW1uXRY8DZBTabXgYBuubYk00ZFMGJ+GgYZOYXKG9fFYYm4L6MFIL62o2kbo0kIVTV4uK4YaUh/fhTyX9Jxs5pFA/UqVACfROtPAyIPCj/vfrSjTxlBruZwo2v1ysoARoE1IW07BAU05WHXy1GweIV2nbGyqCEf4nVFR6au/uICqHXzn6d4l5YolnU5W+xXmWwvRGxAbGHXuvM+ijOYmYHz7CKa+OcI+tUUa1zXzPOzQ/Es7pGUmVLClGcF6iEBlfwMH90j5QupK8wlK/Af0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(1800799009)(186009)(451199024)(8676002)(8936002)(4326008)(6862004)(86362001)(7416002)(5660300002)(52536014)(2906002)(55016003)(33656002)(478600001)(38100700002)(38070700005)(122000001)(26005)(71200400001)(83380400001)(9686003)(7696005)(6506007)(316002)(6636002)(66556008)(54906003)(64756008)(66476007)(66446008)(82960400001)(66946007)(76116006)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MngVP85y5VILgBv9TL5L3zsTL2twB/sNpVPp5mHwSxiIYR0V1Sz4CCuKyE4A?=
 =?us-ascii?Q?JfsB+jOPi/DDZbZXOsTTvlSMIto5APTJZMExfRVnB4ktDXpUTg/zVc9jspsm?=
 =?us-ascii?Q?tnnggR/aTEKiDXZ2W0EZv59z6Kl1HRgEo4V7jdlNMBAbKXSZh4Qw2pys8Jcf?=
 =?us-ascii?Q?ekMDQ385mOib1sCdq6aa2ukElTimVs3AiYQor+Yy/LHp5IdyChR29NVPAsvI?=
 =?us-ascii?Q?BZG3ZLsAdgf7Ekh+JAvVyeQY9beQtybyQh/OHXL7aIasmGtoNMyEDwy9Tbgl?=
 =?us-ascii?Q?iuAsQB8xpuG9UGevaUdwy0SegEgyp8A0JqFEEIHO/eUmmt7VTN20kzhtYOwY?=
 =?us-ascii?Q?6Z82SbY1j3swh5ZKOSVMPGj0l0UMoUy2aKJ/ygYWIW3e3G5EYRtBXGCnjmvJ?=
 =?us-ascii?Q?RaC4WtopG5CtQ35lmLnT+TbjSaxGSziqrClGke0fvkrAnCEuvAqoc7W01Kas?=
 =?us-ascii?Q?kkS1asXjb6JWlAVUF4h75Q6jmkbA7B/YXw9t2d2FjPjSOH88zqkCu2dwCKA6?=
 =?us-ascii?Q?YrdRZbN3SIaRzF3isXVQt6YLtD3BvEHcLgVFRkt3/DM/MtGXXCQnTbf31ZXR?=
 =?us-ascii?Q?kuxQwaX9qKmCF08Nwbn4qTtDzY8pPyy4pfI+sy1JVmjmaQ8Zq+kSzhUSXA8Q?=
 =?us-ascii?Q?1Oyndubz/Ufcx2zoUS+GEeDMFwIXGWzj+BPCUnlCSbwgmHto+euucm4J7sGb?=
 =?us-ascii?Q?BGT4AQ4YEDlNEnbmvG+crTBKCNL4XXNA/COWPN1/QcGBfbaJ+9VWAcfpej/Q?=
 =?us-ascii?Q?prtIJHBsm0ujPuXAheqMIiGUiz/j7TaSGpCpygQkULJ6+xtLb4HVvCD2/bKZ?=
 =?us-ascii?Q?ISjKaHfd9xxNCIfvAlXb9GD34EP/8bfZAhMiU0fyAfxk9Czr+r0nuXt7Gfmv?=
 =?us-ascii?Q?EOYIVBo8s6eocr7oEMr5jc+cnDGBeh1862PORxRBDcfaFGR8l2wlEN7mNXB3?=
 =?us-ascii?Q?ic5bcuok7JeOWeU4hny58CMvtLTOak1h3pRRlxHm93JMLaVwMxw3S+0EgX0g?=
 =?us-ascii?Q?BSCSoEBKUA6DLZc9smwgPV+Kwlf+/VLRjY03UoaqrErMQQCrXBoVwzKPqrez?=
 =?us-ascii?Q?1NtZpSWOHoFoTBps/d20zP8npDOgh9nu71TDFnWEoVB8BSk+AlP5CbZXBnRy?=
 =?us-ascii?Q?XAAHY5TTKIPlb+RPe0Snye9i613YT+72XleuJsa3srp+dOHpOXhY4N2hqmVj?=
 =?us-ascii?Q?Ig0mrWRMobuKhLfvRY4fJJulho8vxYGMscGXbN8B+7DqFsbhKxg6bVVcZ4U4?=
 =?us-ascii?Q?MOyclvXVOcSIxVa7ne8IWgNJG2cDB0WMn2DeyGDC1cy7L+4xBzQXApy7wnDl?=
 =?us-ascii?Q?7uq9DJ7d/VI0OiF/rix+di2kJhnUd6PIv7fGftO8hyawUAw8hcYveqh4H7vJ?=
 =?us-ascii?Q?zBQiZ/QDChmqTbPjNNJ6UGZX56RSUgJEVEQKdLKn9WrIQhq3gJKaLWa/zNDY?=
 =?us-ascii?Q?PjZKngdrYc0i3b/GIeqbnv3fn9HAZw8JPOMQWBb7LTEqrpqKEbuwb68sbzEA?=
 =?us-ascii?Q?UEdfRxeh0zTnHNHEyhH0JsragbosTF7DBYJsvtE+x9Qvf5g64hXXgzbuQvXD?=
 =?us-ascii?Q?em57AOKrSKspnDXCpzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49571ea7-db88-4d92-55c6-08dba96fcd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 15:43:05.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwsCJ/wQ/2Jd2zISjw8EFZmdvEMnbpA0V7rsd15fFi0okb+vZutX2/xzZP44aN9xDCC5iJlahObd+vKsAx1pgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >+static int count_sys_bitmap_bits(char *name)
> >+{
> >+    FILE *fp =3D fopen(name, "r");
> >+    int count =3D 0, c;
> >+
> >+    if (!fp)
> >+            return 0;
> >+
> >+    while ((c =3D fgetc(fp)) !=3D EOF) {
> >+            if (!isxdigit(c))
> >+                    continue;
> >+            switch (c) {
> >+            case 'f':
> >+                    count++;
> >+            case '7': case 'b': case 'd': case 'e':
> >+                    count++;
> >+            case '3': case '5': case '6': case '9': case 'a': case 'c':
> >+                    count++;
> >+            case '1': case '2': case '4': case '8':
> >+                    count++;
> >+            }
> >+    }
> >+    fclose(fp);
> >+
> >+    return count;
> >+}
> >+
>
> The resctrl selftest has a function for counting bits, could it be used
> here instead of the switch statement like this for example?
>
> count =3D count_bits(c);
>
> Or is there some reason this wouldn't be a good fit here?

Thanks for looking at my patch.

That count_bits() function is doing so with input from an "unsigned long"
argument.  My function is parsing the string result from a sysfs file which
might look like this:

$ cat shared_cpu_map
0000,00000fff,ffffff00,0000000f,ffffffff

To use count_bits() I'd have to use something like strtol() on each of the
comma separated fields first to convert from ascii strings to binary
values to feed into count_bits().

-Tony


