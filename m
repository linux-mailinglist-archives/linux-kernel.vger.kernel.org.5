Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D53787781
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbjHXSKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbjHXSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:10:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B51BE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692900615; x=1724436615;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MEdto6h3x44ixRsEmlXHx83LWWw21xWap8lpnB9UyX8=;
  b=AXTAxsUTBcq62mnfN6z6igsYOwd5Q1DwsFPNw47WPQxpWV/UlH5Cps5s
   i/Pl9/Wex/MX4VuETgFhUNecMN7B4jfUoOEKjh2l9vPryHsWFS7cZz/83
   da0bzMNRyU7sVyWbna4Cnd/F6s4glxDVxWm4rDQ4ilxonz7g/TudOwbaK
   M/Br9uXC7Ad31gtJtalycDlUeOhVpKtQOtisxw6zvHm6JGbEgCb7V8a92
   zN746Kc7xXj5jqNluzOpXjxe5Yj5giSNXAVCiICU/FL/D0Zh3xWSIVQAU
   lpgltjzKEa81kg71jq0HBf1jdu4UD0dzQruuCYLR2doL+bUxdY1zIPQOE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374498118"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374498118"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 11:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="737149716"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="737149716"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2023 11:10:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 11:10:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 11:10:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 11:10:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 11:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1s7ui1y/g3WxOH3GTl8NgGl0gcmfsN3D+KjbhThhxSvOLWP3JCYwhtYSiWAnyBJT3BDVFFT1oKq0vbI4p5NUnw1c+T9nwSuToFLpDtnReKkW0jleNlTilmqmfXOs2Amn9+rRmFr5gjxVny+d+CRwPbXT1cER50gaJ9FRQuQV0E179sFoZIe+ulE4EioxlVqvuEudhRB2wbbsHNMz80EjZrhAlmtUbUEL6rhAyk5cnIS41tFAdtDHLb5ZsJHKg2HiSdpjy+VStTBhlGZ8z4YdQnMml5iA97K+NBbQG6Fl2vUM7V//+eO0K2NN38gXJDLuKWN66k908mgHz6HjsIYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs0E84/pz8AdnOmQjtMrtyIGTib+gWGRUOzdahwO3bo=;
 b=gwi/8KihhrXkBqNvmRJaJ37T9STpYSM9JA8J+ehXgqgLLj9BKGQTIkRZgIGetlklOjBcDZqu73PxpADVvMeWA80u9hRVtxIABrP1lPpe1rAOlnshizEv0CAa9wle2RHGa2yEpB3ia7ZTLzX2IC3BdnunodBtTUMU3pN1O/Qz1VuZtl7XLlxOAgyyDNY22ikI9iZCsfFGmY28f5fda/Ba5t59lMJ3txHWXfwC4pD4hiClbLghJ1Vom3ZxurZtWrVTmAVgbRs5rvxdmkoiewo95ft/wBa7nvFm3xZAzqa43nE0cRCky1GiyJ3Gt98LsPe/12rIjWzobIG83iWLqiJ5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 BN9PR11MB5449.namprd11.prod.outlook.com (2603:10b6:408:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 18:10:09 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::7e17:9947:411e:e99e]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::7e17:9947:411e:e99e%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 18:10:09 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: resctrl2 - status
Thread-Topic: resctrl2 - status
Thread-Index: AdnWr6S/HyyETPT3Q2GfFYcuexQ3cg==
Date:   Thu, 24 Aug 2023 18:10:09 +0000
Message-ID: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|BN9PR11MB5449:EE_
x-ms-office365-filtering-correlation-id: f5dc7b6d-2c34-4880-b766-08dba4cd5a8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 899UDsYPwa7r3SwPb08dWGWYvzo3/KvYvogviyUFMYO+73qmudgxNHxNFqz0piUjEty4sWULfWgTPcdlktkGY3qst9ZGoJuin78HjM1RuEKyX0m9yd35tt+/SExzUJWXCzSSNlk76+BFUdidSRNS3qOoOj9ymnS/pmW0dVIkvsXcvyLZZdw/Kwfg9AB9IgNLDjB2n5fMfS/uATKfHpe24b5RGSsOpA/a5ig0JcIUInkTGDbWvgVhllK/3R5/wXafhM1FDvJWyrKnLEzEhqv+y7rG31UkMw2WDeI0n8kOriJcCXr0hvze6C2Rw5VDy3AKks994OjhpZjgz/mW7ack+3jqtUljRB5ibr04v3NXkFJfM+V41XG3S3t4iLfuGt2Xh+90slsy/ugX/UHCXovBf9CSvtiAwHsVEtOW62MKZwfDXgiRCn2M17hnTSlwt3BNSmkOPJx5hUCe97Nv/v13k0Nmjn/4e55IB2HIwYn7zJTvE1pEGc1IM03TFM3rmlrKObYBGsrfCNtNkk+U99pq28hW4MqrC3Z56/MWUhHpn9srnK8w2oCyueoDHVQvN3UjAS9o9s6uZbxpZXV7pxGBrzP0YnM5Er640WXRW3UzVMqyjAuUese6z+bmGGiHcUbWqB5GGR2GohKDQGx6Nbw2KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(83380400001)(33656002)(7696005)(55016003)(26005)(71200400001)(921005)(38100700002)(38070700005)(82960400001)(122000001)(76116006)(66556008)(66946007)(66476007)(66446008)(64756008)(54906003)(316002)(110136005)(478600001)(41300700001)(9686003)(6506007)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qmcevJkEDFLV/3Csa+3NV0sx/dnlcW+rx5uNlpX2j3+OKbXV9xFlsvAAV2aj?=
 =?us-ascii?Q?elUDKnWt8Nd069tEbz+Rx+4P0hYndXuYAPxtAKZOsiIQM5e4ZkFjDl3FylEA?=
 =?us-ascii?Q?b6TqprZ+7c0FEMyaRZX8MTmax5ZZiOCv53nqZisfsqP+MfD79pYx+vDeDbdS?=
 =?us-ascii?Q?sre4LQ/0sX4DRqAonDp4d1+7XCDMQ0ZgsQBqXoh90B9x+n+USYjOPaZCUWdg?=
 =?us-ascii?Q?X9/WelG7s2hZuIg60hr3bCojowuVjYXbarJ2gUmOX+W7rp2tE8n9sSvN7n8B?=
 =?us-ascii?Q?OfEL9tS1bS7ZZ88JKTsdbeAjif+XurE6DyFsi7OnKwSVLEZlEj4qfrr4rCod?=
 =?us-ascii?Q?td9J0l7bIbZSUGyWJiUQ9ERoxpDyCytY7yhecbLCC6c5kHAzDPv2wf5T9SQW?=
 =?us-ascii?Q?J9u+ZLJubu3qc3CoBY2ja3s4zq1E7QFDCELIFqwfgY5PdAdyB0xOVWjqO2cz?=
 =?us-ascii?Q?ENRPEMIKQo9On6oo39ahNIfRE5seuF8+Qgz/YTPcVDy6j/DH7M7ZLJqVrYxm?=
 =?us-ascii?Q?U6Wa0YvWH0DUi+I9esGjfF5xXP0o0IOU3IRGroafWLpGZnpI1YJDwKWzm3qr?=
 =?us-ascii?Q?X0cXKf6mrGLtnCed9LO7z3Y41YBAHyp4E5qjAsNh26PBayr/8Wyvm0W4wMY1?=
 =?us-ascii?Q?NZyBTQqtngahYqmKdWW+lvbuR6NAHn30SOoy517ND7+GqTuD/dLGgz/079UV?=
 =?us-ascii?Q?XUENMK5ZwKx7XW5XwUIbAGrTlXNlxVNsozFQHC1WQaSQciI9Xeiyrewe1JlN?=
 =?us-ascii?Q?GVxfjM7SVD3RWVNMgPJcguTcOjdtylZ4yxSVVTyT69/c5ilBI6MKiuIs2thW?=
 =?us-ascii?Q?mch03DQs6cBxeyt5soIwmjNMHiiWvAxjl2LBEvAc6r5KZCOtpV9Q4uTCCo3F?=
 =?us-ascii?Q?BUsw5I+Q4mQjFip2a963dOSF+iO6CPOyc4LXtCrMf1ehm8OIs1itdS4TXdp/?=
 =?us-ascii?Q?/DkMUy++00u/wf0QlbTZdF3rRW8y3xMXkCkFqBRsUxpMVqHSHPR1gWPWNiz/?=
 =?us-ascii?Q?iTMh+VZWEHoiT6pKamZMIZEEYuhsFmLOSaPnfSthR8KlbhuNXFJmey83DpVg?=
 =?us-ascii?Q?cjLgU+1FpCh5N881mC+ZHTH5YgSvdDV6sAB1xern4X7Z3ZUZyOyu5VLNOWzr?=
 =?us-ascii?Q?YYNDEOj9JWrrob0hJ7tdQUntYDRPNhZ+wacQSkaaWhlWDWvIttfrdikOgg/M?=
 =?us-ascii?Q?bYMWS/P7N+mo5M9F33zmODB563P2Vf484iaEcJN/A4vOeL7F3vbtT+kjv0kS?=
 =?us-ascii?Q?rsOcvscD4D96RQkfQ/UYU78USqkfymjV7muLAV4bz6GmTCAQTnag9tu5auYJ?=
 =?us-ascii?Q?VwTYHfGGyv8hDU+pjP58QVbbs5gWKr7Gd3/miV598Abm0dQZINj6GhIBMqJx?=
 =?us-ascii?Q?mKENdmWtaoEKqQmwMx+SyY4DWgopkcL0yvxYxmJArAB3ImTOiqAga8AQWMuH?=
 =?us-ascii?Q?8W9wcSQApkrT6xeOz0YBgTTDJlUVlD+Ew4r5Xud/zLZUFBGhgKN+e9FQqKea?=
 =?us-ascii?Q?yE9UG6WEhw36/SjtYrgth+7Vi23XCIcgJOhM+3AYeIa/RYJNYsiuqMUI2sQc?=
 =?us-ascii?Q?a38k3YYl/Z9nRBIViy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc7b6d-2c34-4880-b766-08dba4cd5a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 18:10:09.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /G3T6arnfxReTJVI8mL5YNP66oaNv2z4rwpkEqRGN/WKNp9qo4SJUCp2kIYluba5Dv805VJpeM6+9J93vWtO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5449
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted before about my belief that it is time to re-invent the
Linux resctrl implementation to make it easier for CPU architectures
with different underlying resource control and monitoring capabilities to
implement those features without being unduly constrained by the quirks
of other architectural designs.

I'm super interested to hear from ARM folks on whether this can
be a suitable base for implementing MPAM.

I now have a reasonably complete example implementation that divides
the resctrl code into a an architecture neutral core layer that is
responsible for creating groups (directories) and associating tasks
with those groups. This layer also manages CPU hotplug events to
update domain lists for each control/monitor feature.

The architecture specific features are each implemented as loadable
modules that register with the core code to receive callbacks for
operations at the core level. E.g. modifying the schemata file for
a group results in callbacks to modules to parse changes to lines
that the module owns, and if all changes to all lines in the schemata
file are accepted by modules, there is a callback to instruct the
module to apply the changes (e.g. for X86 by updating MSRs).

Current snapshot of the code is here:

git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git resctrl2_v65rc=
7

The commits aren't yet broken into bite-sized pieces. Everything is
in four patches (first two of them are huge).

de8bb88b3285 resctrl2: Architecture independent code
        Although this is big. The code is broken into fifteen file
        that each handle a specific part of the code. The largest
        (directory.c that handles mkdir/rmdir/rename) is only 481
        lines. Most are under 200 lines each.

98831f3edd3b resctrl2: Arch x86 modules for most of the legacy control/moni=
tor functions
        This is also divided into code for each loadable module
        to implement just one X86 RDT feature each. At some point it
        could be broken into separate patches for each module.

d0f1b0a0a555 resctrl2: AMD Slow Memory Bandwidth Allocation
        I did put all the code for this feature into one patch. Should
        give some idea on how easy it is to use the core features
        to implement a specific control feature.

2a1dcfebba2d resctrl2: AMD Bandwidth Monitoring Event Configuration
        Ditto for this which just has to provide writable "info"
        files to allow a user to provide configuration options for
        an architectural feature. Needs a new hook to reset the
        MBM counter files when the configuration is changed to
        completely replicate the legacy resctrl functionality.


I don't have AMD hardware, so the AMD pieces are untested.


To try it out on X86 you need to pick CONFIG_RESCTRL2_FS=3Dy
and then pick which modules to build. Full list is:

CONFIG_AMD_MBEC=3Dm
CONFIG_AMD_SMBA=3Dm
CONFIG_X86_RDT_IORDT=3Dm
CONFIG_X86_RDT_L3_CAT=3Dm
CONFIG_X86_RDT_L2_CAT=3Dm
CONFIG_X86_RDT_L3_CDP=3Dm
CONFIG_X86_RDT_L2_CDP=3Dm
CONFIG_X86_RDT_SHOW_IDS=3Dm
CONFIG_X86_RDT_L3_MBA=3Dm
CONFIG_X86_RDT_L3_MBA_MBPS=3Dm
CONFIG_X86_RDT_LLC_OCCUPANCY=3Dm
CONFIG_X86_RDT_MBM_TOTAL_BYTES=3Dm
CONFIG_X86_RDT_MBM_LOCAL_BYTES=3Dm
CONFIG_X86_RDT_MBM_TOTAL_RATE=3Dm
CONFIG_X86_RDT_MBM_LOCAL_RATE=3Dm
CONFIG_X86_RDT_L2_PSEUDOLOCK=3Dm
CONFIG_X86_RDT_L3_PSEUDOLOCK=3Dm

After booting load the modules you want for the features you want
before (or after) mounting /sys/fs/resctrl.

There are no mount options. Just pick the right modules. E.g.

# modprobe rdt_l3_cat

for basic L3 cache control

# modprobe rdt_l3_cdp

for L3 cache control with code/data prioritization

# modprobe rdt_l3_pseudolock

for L3 cache control with pseudo cache locking support

-Tony
