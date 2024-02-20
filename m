Return-Path: <linux-kernel+bounces-73621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734185C536
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E315DB2567D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC0414A4D8;
	Tue, 20 Feb 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBd8j4zH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DD768F1;
	Tue, 20 Feb 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458740; cv=fail; b=WZaj7Ui+X+cFK34HT5ZmqByUnsjqo6iW8w61/FYsWHPactKNlYLonuvb210mqKJsukxoJ2qEsHOQ0TidKfmOAXvW0SyM1wQqjbHbIDiMzQVYMOENCt0vs6JzzANU7wZ2ccPz4DfJugd6rcybpgj6oWCbeHUExudjHgO4ZctDpto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458740; c=relaxed/simple;
	bh=FaSuLXgdfpHAZiQoXLU44BoFSGwVxvLlPh6Gwmgukv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=asPOTWoFY+jDaBpBCYNaBOS74/ufJYyAKNZqW2kXWERe1DUz1rv4mmKwRe89LPqvgzNQQflxgOR2nNxL/qBlfz305TCQsBdsqryXUbfzF1L9IYdePHAXlTf9SPEfull72pcvzrd7FjuVXulqRVhKwqNdknbxJdpTj6O2GtWv7ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBd8j4zH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708458738; x=1739994738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FaSuLXgdfpHAZiQoXLU44BoFSGwVxvLlPh6Gwmgukv8=;
  b=OBd8j4zHW+Qa8ordfDFRisx6RgR1Alju05pIAaBViAPIitRfdJQ2TIFk
   0XV/btCJqBoetnuP9vdB+MXWYJTXkUcSVr4iUCkvuGbYs8kTJsbYZgkr5
   Ik4LxlqozvSA4Obl5+Pye3ePL4cUKUZShFYxU8cmR1qsZqTZIi0R/W7GC
   whCtcZnEHOf+bJ97IkClVZKQyPTrbjNXK6GBYcKOfyZQX4JjnWKmQFx+y
   fpeZ4hIl7uF+kTyCVEYCpwHKv304KNDWaPTsJhxxvIfjh7U3wYO1QzuLz
   ra307yLhhqMu3afHCFhMnWxpkGMJJrLhGTs+dwXAxsE5Qj8mPKLg30FUq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2446123"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2446123"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 11:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4839950"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 11:52:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 11:52:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 11:52:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 11:52:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ4YKwgCutqc1UD2yUG36jUYnsmwEL1sU9xH2HNrZBlgjhp6hd7bwkrghZRBhh9ez9CEret8QnyDz9JrCClShLvmqUameNQgz1Cm54ckQ2VAWymBafWxCV60EVGZTItfgIvA7ax/+QIZ+JnSUhTMjOo9ouaU9wrCDjAWsstyyunmQEGYq9j+dL1m3sJjcceuDSCzPE9yUlwH0cLfANpkkKkR1jSq4QBNLIvM/5/YV2BODUmIHskm30aFv9IUQaPrv7eJsdCNVnuqcXzjwM0GPB6XVrgZVUy9eQoCLIZB0pRv8i00kLgED+Ty5aigtPYuvNBt7Guso/Kn8w6kGIPFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juUvTMfUyNHjHDsKRcgUufB4/TyeMDnE6b/hRpMYoZo=;
 b=MqeKeaFNmB0DefinS0aK0EvCkcNPV8EFMBpTKXvd4S9Zj09PwQXasRz1P6UsDCCPKjBQ3g92sqwVjO4AGBkhbkv5fi/hsf/d/LZ4mH4fBPmNo4xqK/HQ4+yPD23C3mxsIfKLlxQc0EXmk+4A1S3Q2fj4vpuxlhL+x0sZv5ZzOOPQ75Yl1nLCQBcFX47IEvNb+EJrsoq/fr3wnSS0uSek2Pxp3pa+A8uQCASm0HquS6yfepvK6MJ1SjhQ6ObFllxroHBms27yWfl6eg6OlC4Kge0wI/LHTNRZB0wPJwMbtShfkGeNBDTt7Dti2F52NqKuAoO4/Tiq/KUv/kpb1owYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 19:52:13 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::c138:faf0:9fa7:8a03]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::c138:faf0:9fa7:8a03%7]) with mapi id 15.20.7270.036; Tue, 20 Feb 2024
 19:52:13 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>, "Lubart, Vitaly"
	<vitaly.lubart@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [char-misc-next] mei: gsc_proxy: match component when GSC is on
 different bus
Thread-Topic: [char-misc-next] mei: gsc_proxy: match component when GSC is on
 different bus
Thread-Index: AQHaXOsIdX3xgemJDE646gGDbr+G7rERhiWAgAAYpIA=
Date: Tue, 20 Feb 2024 19:52:13 +0000
Message-ID: <PH7PR11MB7605656F961FC6D31106BD47E5502@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240211130408.3478-1-tomas.winkler@intel.com>
 <2024021927-study-schilling-9dfa@gregkh>
In-Reply-To: <2024021927-study-schilling-9dfa@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|DS0PR11MB7767:EE_
x-ms-office365-filtering-correlation-id: 652ce5c0-750a-4684-4aaa-08dc324d6f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4k2w3XO4J5hnqU1r9+HLbeXFEB70YEGJHygSbmD9SPCAb2kaoh2SZhFYyxRBuPYdyPntJa0Vm8OehuqUVgUlTBxgFSlzlww/vABCeMV7PiAWgC5Q3EYXZtMf/fqBBDg3dGHSli4jH5Mc/OPfJsHjVAWT/9b3sTSbvynG5tZaZofaATFQ6u9K8jqBxMGxQlg8SjU70Eq+OAI9iCwkXHNWgI7REJE+JK3oMEEijL9zSRj92/orot6tdMMY/0Ki1NUsKsYimCp1cUXtArkvUAd6TYZxzb1hErXyUO1N+RfNHzQAby6QGhKNAPw85FAlHJM4uuOK6FgZgGmbbtZzL5H5zJYVR5H9BfW8kmMDyjao0vlRe2UcW6pNoJXH2BwFfAPbkiWkd5+acF90P/6W+oyKZeAmgaBt06s0OdnIe7wc9y8mSN3GTwvmBMtjgzRBpbV167+QKJ0XmM1/E7QtTByUAqiiDQQ2stQUz6hdO2FdLvJ/PClxRPK6p/fmdKlyXt3zi4bU5VLZml0/iZDI1K6ngyOmfNfiWyqE75ObdRSoTSctvbnYmFyvKRxWBRKLuPlCiZZdIHsdoZ/Xm0BZyv0VqXf5hD79W349jnTAaGXXV/AxTHsFRmy83S96XlRiDFa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+OVxdsZsBeIpmNB258+6PTFIkqCalbBDzpcQWV3P0te0p6zPqt03zdglFm1?=
 =?us-ascii?Q?XHeP1KAxbKiVrZfR/v9zP8Il2aJ8Vq7rXmQDKtktphTpQDMs+K7Ov5VTt9w3?=
 =?us-ascii?Q?2zeNpljZW793xKP6rxt4yW5a7li9D62bkJnXrBnU0WE9EySrf3VjDCmD4u8N?=
 =?us-ascii?Q?DisMPNndxySqaQ3isk+ttCjqMdgdJE5LBd3w4tVh5vbvmTcN1w5paZ6odCI5?=
 =?us-ascii?Q?KHay9+I7zyr13ZImwqthDdj8JhNOInMTAcZbuL7V/2gdDA4YmNVS2/gofoHg?=
 =?us-ascii?Q?/GfjrHn/i6XikZV5G7u1gTUA8KP8VcM1UvdK85pAN5P0Yvp/VX2TiMTDO8B3?=
 =?us-ascii?Q?igfHvFEL10bBd3yhhlT6JNYZGZReqzQWuqG/9ZTPqP6oQMwPOTLKcn+3IZSl?=
 =?us-ascii?Q?4pOzDPUdTvUcwcbWIjny2FMosUmTVtQms1v91FxpFuTu0vbc2bFBqqVyGn2d?=
 =?us-ascii?Q?OjMeTlolfvTAwdvoR6DRykzxaG8WHTGQ8A0N+4ylk3HCvZf+yrs2NUavryP6?=
 =?us-ascii?Q?2BZAHP11yMBpRVrWMhyBkN3Gw4qzvDnz+OriAuCCl7FG6DIwElppC0E1Y4Za?=
 =?us-ascii?Q?7bFkZlikNs6sv5idMD47qywn8uaiyryLum4yb76h+JSPiprT4gOqN00tWPI3?=
 =?us-ascii?Q?iwYInHXA7onGB984GarFJQXCPiRPvhkND8IRWfT3PsEfL6Dh/sE3c761iv4/?=
 =?us-ascii?Q?mVDriA5z5I/EnKWhnGs1sC6br5uiF+5N+yFav3jWswchvsvvfNLQJbGu2cXp?=
 =?us-ascii?Q?di7eJY8LwAZnG6KyxdOJ+Xk01xLRehgv3sAPy/0UFaJomxSNm0vZde01IqsB?=
 =?us-ascii?Q?IE551LG2PvG+KYPP6p8BRTIwLVUcuMvNVjt15NaNsJsaOtz9FXGoeRW9nSVe?=
 =?us-ascii?Q?ugNcVHyLhOAPtF4+K9OWBcVFrhEhxypbhRMmffOAIVdIKdMLvQJqy1RHxtKh?=
 =?us-ascii?Q?d+Eqh2uM1yvQ6wv7HXSO+0HlNAqlTXH192zf+wUInbY9PfyaplNwcaYdmugz?=
 =?us-ascii?Q?C+deH4y7KfG9iLI2ALnW0xlLGlOVdfoe5e+0hoBPNUjTQyYUiKwx/VoJtEvV?=
 =?us-ascii?Q?2fIf35F95yKQa+NeVkVA/TXyZBUxqfsgXSHan5TwmyypEoMRQn48dj7ZtIuK?=
 =?us-ascii?Q?7arfrFoxCqhZgEeyfOu0Fl1wBgE5e7O+DLA0lge1hENdtCYvdxmFvkEdwJuH?=
 =?us-ascii?Q?YK3UFuLyaGZmuGNG1JoPDpSTsq+mjCHRdRb3EJeILsjRbstMl8mhseHjVhZb?=
 =?us-ascii?Q?btTL+FLBnxqrjHFTOgRcAW6tq0oViBq4MCrUXK8kqgcurxS9Q3GGwU3ofChA?=
 =?us-ascii?Q?TLYsR4fr8EFa4m9H6dn92sChSRwHO2e2N7VQ/eQ52sIy7Y/Wf7BrjuvbnFkk?=
 =?us-ascii?Q?n96XDMFS7FHeTqOcZ6q2gvqJglT2Hn0QKtykCc2MR6b6xrTTnqGl4R5QShmy?=
 =?us-ascii?Q?wkOw8wM/V9vM0WKwURkcXafp5ILbO69UTL17zSITciZdjPOgesmW+XO/UeSo?=
 =?us-ascii?Q?j22yTf3ZFoVPuKLzcibGxgC3fcqxUoc7DnEK4dBUvjqGNE6x3yOgWue+77rI?=
 =?us-ascii?Q?DCAVaxh+JuSXOtwNwf6/xnAPjiJFuts8wB3kGEgU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ce5c0-750a-4684-4aaa-08dc324d6f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 19:52:13.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxc65w9O/2HSmGm7aPwR0lU4gIlRPrDReovpbKkM8thMFFZw8nGGNU7ouAkoDmHHrGgJPNWSblXT8eLXalH1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

>=20
> On Sun, Feb 11, 2024 at 03:04:08PM +0200, Tomas Winkler wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > On Arrow Lake S systems, MEI is no longer strictly connected to bus 0,
> > while graphics remain exclusively on bus 0. Adapt the component
> > matching logic to accommodate this change:
> >
> > Original behavior: Required both MEI and graphics to be on the same
> > bus 0.
> >
> > New behavior: Only enforces graphics to be on bus 0 (integrated),
> > allowing MEI to reside on any bus.
> > This ensures compatibility with Arrow Lake S and maintains
> > functionality for the legacy systems.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>=20
> What commit id does this fix?  How far back in stable kernels should it g=
o?
Should be backported together with 'mei: me: add arrow lake point S DID'
And 1dd924f6885b ("mei: gsc_proxy: add gsc proxy driver")
I will send v2

Thanks
Tomas


