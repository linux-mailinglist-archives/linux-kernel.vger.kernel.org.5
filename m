Return-Path: <linux-kernel+bounces-57309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C922C84D6D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BE928373B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349391E4A7;
	Thu,  8 Feb 2024 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKEIU5TA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E81C6A8;
	Thu,  8 Feb 2024 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350585; cv=fail; b=N3DtMNtSM8hp/bC7J9evvzlbxlrPUMJtMZY4P0jN8MottlgSLzLwULcGxXg40+CjjoNRAhDP1ZYwfVid3AIPZQ5GqUsy73s2mouBoDM0X5vx43L8iqJRlTYBecAILwn15f/IgOU8qJUTlM4eLT+LcdzuECiGDOKTuvnJv9eA4SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350585; c=relaxed/simple;
	bh=HYSZjewkzRj5GHoFzKafuEQaqSUX4s628ZAMlfZm0/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fEeY5simJAvHbN4L14E2N0/OU5hfR5UgSqVoKogukJFwC6b0D8XdFsmAXbXvIby/J/sQQIu3orZMW8BqWONQguTCEccy5dflpPfp4Ygma6AaPWk9TuD5ndoFfW34NyukeRItMRu5+e1WLgy9dToAceo3Yqd2Qh+xnbplu+WMzzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKEIU5TA; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707350584; x=1738886584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HYSZjewkzRj5GHoFzKafuEQaqSUX4s628ZAMlfZm0/U=;
  b=eKEIU5TAU44OrCnF+1NAl7WL7OOGIaoSWyNBfQQnLx/6bFn8JVDa83i+
   PruOui3xOU5Hj9yajkztXSzvQCtLNovZEHJPudHjgjWLdzt4f5q91OIUi
   UnUJfLLF31nJoOaohrc22beRyq1SzhA7PuBjWvkPGkot8fBrykqPQWdVP
   Ofr9z4ocJLYOXZWQlz4FlKiCZo57zirFVzkDus67z6485XvpQWflg2Aix
   T5TNPbk+18DDq0eZRbufmxrWze6EYSSPpguqljzltvDEu641IPsTHCDqn
   EOCEzkRZ8wF67SZv2Itg6eiYtcbnPI7EwUTGnKOjUtVRi4U078q8S9dxy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1003955"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1003955"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 16:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1794388"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 16:03:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 16:03:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 16:03:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 16:03:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMiZ4FS+6X3R+pTNNzz0ADJP0PEE2yDt7LuwKAU1wawwllDLcW+rAAjTPiI1h2/OZA2fsCRvdukPaDPdZro+hM3uAr13b5F0JV7Fj0+VfXzxfbp+Tk6lN9P30YuWcJviDqvWRvlWFnEuEwlMy7UPJ/W+z+FujsAQYSehwlFoz7hjp3lGPlGqcmj3n/bYZj6VXXf5bN5OVGaOnrGEUKp/gDi0PQtsmegiPARcWMNuZcZF6pb/m4tdShradDxe59qAlHOysa4BgFFfgFLQW41vJ+plmfmYUWENW6PyA0yRmDnt0aCCT3zrRXHquvZUX4kt/JCK3TKujvk1XNzTmQ3qXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltkdhVD4JbbR3qkE+UflQDp+7GMJm19IpeuQUwrOJw4=;
 b=KC04hNHR+ZGE5Wt49ty50wuADolscg5walCNWGlCQRjfvSwQ71b7GDBzV1JcQtYP4+JHNYjg85tRz/0m/7+thy+ZV4I0hZ2abiLktkSDc64dEHGaNvc4W3CKHzYpzKCyYXJwp+hi3eRBUSvqKZOLSQ8DG0BAhCzgfAsmJ87bOmMBQs8M7dvHBuCEc8H0m4U6OgASQ867BOUZFaL1yfGVPkpVIlcwjB/xbsFf+1qEcH4KdQpEOwWB05tZ4MiVaIyn8iGdO37xDdBG90uWGB1S93NIQta0N3dt5EJNC0gcF/1qSwDOMyijsClq+zp9dW/OJXUkNPWsd3xFwKUHInHnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 00:02:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 00:02:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "avadnaik@amd.com" <avadnaik@amd.com>
Subject: RE: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
Thread-Topic: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
Thread-Index: AQHaWhj+UP20KTudoE2h8U2CJGtjJ7D/j4dA
Date: Thu, 8 Feb 2024 00:02:59 +0000
Message-ID: <SJ1PR11MB6083E1876B8CFBA76F1B3806FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-2-avadhut.naik@amd.com>
In-Reply-To: <20240207225632.159276-2-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB8295:EE_
x-ms-office365-filtering-correlation-id: 22008364-b27d-4583-5888-08dc28394fa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgwx9STzbxralLp1EDmModsHG5emCuYHhiHicBCde3Kff6O4nJemkzyd6CZSKJR1Z16FMNWMiZhMRWdwTNOUi8njdcCNSCRf+UbO60NSAQM50V9u+2gahAE93+LHE63Jxi+Nu1eFyHy2m/P7pTfNrKnQpUzJ1qfNl2JJ8L5UzVdiwjyAtQ+6M+KVXEOrC4cYkp1oMoKl8kzwQv7ld8c7YhwY3prtOWnCIIKxpp2qmMEVGKOEctLsvWZ5m6AIubuDgP78zKNSFVNhjxZqBLHDavwCGfLdoR3aVek9rA6dA2ehfMroNi90A8A9nG0G1l+1Nc88hxh6nfFMAS2lDg7IadcQAQeAeLenkwF9/roKskeT+gM+Rx6BEfHrZPViU861+InohfU6qw8cwaYcu4L/93idqrK083NAedojEfj9n8hMtwyvRCgNtTNP/1v0uKRCVo/PnR3WNdVyuur0dFkqJLZoZGr4JDaZwWRjSsN2aW6sIwrqpBCHbX9ejwG0pjLPaDAWO2s5mrWO1pXIyH1UlgUjkwATQD0wfUYchZpzFjNGqbet+UbRfCfvdp1NlMXt1YMcxM4DkdbmipZ+eVvrJI1RUK3NZdRouovWf2TvAQOiZMOPA/lMsaeY+SV5uxUd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(122000001)(82960400001)(55016003)(52536014)(86362001)(26005)(2906002)(33656002)(7696005)(71200400001)(6506007)(478600001)(558084003)(9686003)(66446008)(66946007)(316002)(66556008)(110136005)(76116006)(66476007)(64756008)(41300700001)(38070700009)(8936002)(4326008)(8676002)(54906003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BN2o315UGp6R8gj/f04kEoJYRLxNwjJnVEB83BgRVL2ZoEWoC8WNOk7k2265?=
 =?us-ascii?Q?fGqZWzPiIM0grLI6IEiRtqjZNuTL3J2ZoIx8sow7PDmQ6jBzSaIKtwae3o8N?=
 =?us-ascii?Q?mzn62ST/Z/c/TvE7KubMFkKCfwcdS37cIDGkskmO7kiTqZq0SwleO7Cf7oWy?=
 =?us-ascii?Q?7L7eFQszq90xbFF8vpL6SDj6pyNJREHc1XVvpyvM0/cZUMxAlGZ6dTm8jOTx?=
 =?us-ascii?Q?M91iBnFlGQWK2tEM+OgjXaWejHJaFBttW1e60DaKvavP0hF+QGdG8DQmwjC0?=
 =?us-ascii?Q?fElnokfzb8y6xAOQSQjZ31AeGQTZusR8kTU5EXudLcqCoM90H2x3iaOJ+wqW?=
 =?us-ascii?Q?Ac3J1wTq9FY8FjdbnctvDLsRiBzcWC5vkBnfxKP4ddjaYTiEzYbqMxI7pN/2?=
 =?us-ascii?Q?MAymeJoKZhdxRHHmZnAlEWiRnJ4p58UE/lylOqn9himChGez0wSP3BH92dmX?=
 =?us-ascii?Q?Vl1wgtexH0Ikk2SLM8Cu2pTP5+Z3tS/gP7YPNAieA6LTMAK2hO+3vSVFU/wD?=
 =?us-ascii?Q?Q4W9Ac2tv1b0R1MQcyuI5zfzANyyuq7EbWLL8dal9u+u/z5iFEnpt7g29Av9?=
 =?us-ascii?Q?Zpxuqn0xlwSsntCDXDjHa7vyUqqpwRIlV9OnUl7cz9eTUCrXb4BobR+vs0m0?=
 =?us-ascii?Q?U+wfCOo8GMEWyNPu/6kAmrPtj6SRV/IMd7eGScEKd2C759pqN+SZNxwNn5OF?=
 =?us-ascii?Q?kx1SzsrhPGP4rKUn4a+9g06wGqYb1lL//PRgbC/dl4zgPPJfdxmOuEWxdARt?=
 =?us-ascii?Q?rOwAUZHZQkM7r6iiBzf6BdpSZmu9sMPnm/Z76nCKZpqupwQ9UvS/YKmYN/Dl?=
 =?us-ascii?Q?/dMSYj5ExPtHqEUDQIJOeXIPA4Yh1m8hhZtx9YUTorEI1ptb4gnQ9aRspCkz?=
 =?us-ascii?Q?ls13Wh8mSRTeJSl2AfG8k2vZMOXRa+XYO0JKLiFkVj0pXvjjzi/eqEkwWHG4?=
 =?us-ascii?Q?ol1UUDiEJnajE6bTjaN6/gHxK1UYvgEZn6Xa8yU35eYAT5TexzuinZq3xmx/?=
 =?us-ascii?Q?ZAi8bWrVZvXFrPbkb3jvAO7io2E1gxyEUTGFBAlcT0I8N740XgLxuvtQsS1e?=
 =?us-ascii?Q?NKiyNcot2Izvr9SrRMekh/CKjcxNxegKalxCzGjF4CG6BuhCCt0uQ21iC0XB?=
 =?us-ascii?Q?eut7SaXwmSJwnOwFwXiNt3TYR9JymMhMlv9lZBnO/8tv87gN+UEormro5QgH?=
 =?us-ascii?Q?+a95zXA2hEY2Dg/3Y43mh2uOjoPQ16R8PvPJeh1WduAoB+c/sJqoY94L4KL1?=
 =?us-ascii?Q?jM2tHl8KgLT5/rrdEqinGJuDIeXrHjjSQ34ew4goLMMuUPmKr+pFFnU+ozPA?=
 =?us-ascii?Q?j7avwvzTiXSwKfAhv5uIv5IQ10dDAyabx192GVzY03Hj17AoCbo9fUF66/HT?=
 =?us-ascii?Q?OcIW+kTjYYbAZiaoiotNvn3K8BpMGMoCkwcYQCvKs/E4Z1Ac0VhRLizhy8nr?=
 =?us-ascii?Q?KbCMAqmxbWoMZTCkUcMpWOOnPxtne0TuaCHbrA0mZvYLKbbX93n+CtuQpXP4?=
 =?us-ascii?Q?J4M3I+vRLUiAzfU3P29L5txPE5wUisDw69h7mgX+TbHoNLKk03ivufsGpEAv?=
 =?us-ascii?Q?Xi1CGGat+LElOqR2lpCTKCoDql4+Wzhf1gorN/QB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22008364-b27d-4583-5888-08dc28394fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 00:02:59.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHjeMFq/exCtmWeNNkeO5oZL07Mc4dhoAcEsQrT4wQEs+ZOWo9udtXxUdwjagPyaDM2nM9fQPHRIVsSOg2XW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com

> +#define CPU_GEN_MEMSZ	256
=20
What is this define?

Why isn't this "sizeof(struct mce)"?

Or 2* that if you are trying to reserve enough space for two records per CP=
U.

-Tony

