Return-Path: <linux-kernel+bounces-46911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C3844646
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B9328C764
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB45912DD8D;
	Wed, 31 Jan 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8TebsWS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1712DD92
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722634; cv=fail; b=pxbHjtTm7/4V00MfOiCxA3F356mB3L+9Hf7OMa1NpIC5qH0ufyCDK3x97SEnFrMBY+1HxsjGV4k8J5b1v9VnHYZ2RnUxTC7hG4EKb/U7llvFfvBT/kroKSlhVDNrTwu0hT3yL7SXjPRch4gVPykBfw+emylgE1/kgwfyIf9RLes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722634; c=relaxed/simple;
	bh=xve/4JycGmlL/m3xgqL1QKcWwGHsD0JV7BUksT9tZ5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYbzgPjWwUqmlYxmX+qirP+aNS72xHQdVk/8UBaEgfbtuG7krcMO/ijJ7usnMAm42BXJx4j43MwSZIh4+3QZ2qLWNUsMFqGdfoy7D5f0SKeRHcIIldRG8iaN5n7EN1/elZLDK4EpHU9niOo60ZiAKgadMRB9QkLUytPulbfaWXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8TebsWS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706722633; x=1738258633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xve/4JycGmlL/m3xgqL1QKcWwGHsD0JV7BUksT9tZ5g=;
  b=R8TebsWS3NrFgX9/UWz9SYCAvyjL/WAoPnCa8QROCB/ophzRIh2/uboY
   RH1pHlU4H/q0i8dmb1KwN+U2GDQYuPlFEIGBp350lKRKpu7xFx7Geqq2n
   sCPOectK2hPqnjYC1LIurGPBdBmPp503ohOXl/EJNXKL9ltaEjv6rkfNy
   AcKm6DlYNwMGblL7soqa627WRVGTGv51G1ORZyLPteIVRJVqZ7znCwoUI
   jF2WaDGHwLCE3vIZAzlQnRIGANCqGmlSODtB8xcKb9/WoW/ve63mWB9Ye
   IhS1XuI1Fh0txYsk7N1ftCSX5IsPSU39NE+lF0RalmdQtRL3kbKMoiuvq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25141079"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="25141079"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 09:37:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858879778"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858879778"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 09:37:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 09:37:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 09:37:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 09:37:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 09:37:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emEyD62msIUQHmJ5+WkFZNh2A3j7I1ZlwBtiTGnDwdl2UF0xU9cZbbc9h6dbxie7In60DoQ/IvDs4kIT1fBMvfE28ERVEqHfhfEHh4OZgWEcrz35WSb6IRId/XHOzy+9tyR30k+cAKh+dzhktUg0fquo2JlF21izdAnq8KaaaHgmAtP4TIrougG2NZzIykawXm8HSJN2hyWX0IllKAdd3LTzmNTZsG517flnczjRHC94igvy5GWHaHCkYR4eHd3FCNIy0Rt4R+D9t8vvjTvPzI2q917JpYdyBw4XSdlj4/Z6MKCyCfsJDy13W5MSrIzr3B15jYabYlbb1uGBDB2G+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xve/4JycGmlL/m3xgqL1QKcWwGHsD0JV7BUksT9tZ5g=;
 b=Q6mZ/9E2mHgbzP0jRqhHvWcJcY6yV0ew5ynHyw9RkGZra8jmLXVJDETf5niXh2tmTwfAIpm+rgKr1lqkKLVF1Wtl2wghVKekPbYX1zfzghqfrI6T9zu+oFWMpI4NURFNCPIX6aq6KeWWbbWxpPX3vaUjUN4MTpfsCiS0LrSesrhpGNK36LCDlcYS1S9UjDJhS1LN8GbJtkgxiBrB6qAnLljALt174qNej+w7IOnGIgA+ZqtlA039VOMNUiPpzompxyzpz48PEgKPXIvcSTh3GpZDHf3CKXr23rLFVHdFhI/j7lGWzEVK87KVrv+M4etc7dAJDW5FiONRBERJ5zhLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM4PR11MB8225.namprd11.prod.outlook.com (2603:10b6:8:188::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Wed, 31 Jan 2024 17:37:08 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 17:37:08 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson
	<seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKAgABkhwCAAA8BAIAACmIAgAAorwCAAAX8AA==
Date: Wed, 31 Jan 2024 17:37:08 +0000
Message-ID: <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
In-Reply-To: <20240131171042.GA2371371@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DM4PR11MB8225:EE_
x-ms-office365-filtering-correlation-id: 037ef241-6110-4a79-ce6b-08dc22833ff3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyhBjVygVx+kgncME69AVf/SxGDd/VhAr1lE93L1V4P6982nHsxvBaGaHNhTXHJu+69UuO8N2z4BDa33V0Uceuwse/r0hl5cFA1WMagoEhXjRFObvJQybsDyU7ATn7mHlRJDGyWSvQdbFGPDz/1hCd4vhkyDWKPIV1P5IExfcxIhCvkQDNI/QcMzwv/uXUcXOV1f3cMbwyHxxRsB8EYKovdcCTqRN/dS0YeHtNHhi3G0CgAAOXl1WRKg5cduzLp5zzDNOgwcCPmp93Nv9z9zxPJBtqVta1DFRj6PCkUnH87Wx20JNjjcs+bCLhqQlfFdw+NgDLFiPdMIoSOhzO+Ki5pBKnWk3BSvdOkTPRSjjnaN9ykvmFTZbiWfLqnRt10JTv7kO4BJtqZ3LpCeoJUACcE9YcWCpX70b7VeuczBVvkxqCfhITxWWxRElmiRTE2ABvLxx+Ygiheb1ARAv7tDPU27OwUOR+vVtQr1SY4P7drgj1Eg9VNG4/hdt5I+nrJ96+/dhUf1P7voRokTa5gJyX9nw94KeC9t4/b/wVlqOG9txLnNSSsvLiYB6lUWRD3l/i2Ht464fAPq/9Y3+ZhOYcQgUai0lJlvgnCI4+yv/NI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(478600001)(71200400001)(9686003)(7696005)(41300700001)(966005)(6506007)(66476007)(66446008)(54906003)(64756008)(66946007)(110136005)(76116006)(66556008)(316002)(122000001)(5660300002)(33656002)(38100700002)(55016003)(82960400001)(7416002)(52536014)(8936002)(4326008)(8676002)(86362001)(2906002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M25WTWhHeC9MTXdKY0trTEx0bW95ZnB6TkdHYnZ6dFU2SVRxeFMwRk8wU0NU?=
 =?utf-8?B?Lzk5NUJteUFkSldqUG9TZlc5d3ltN0tRa0wwTlZFblZPZVEycEpDTGszMEpv?=
 =?utf-8?B?MnM0M3hrM2lGUGdLZnpQbHhIR0J5N0o4RlFPT2ViQ2ZYTmxnVHlhS1dyMGEw?=
 =?utf-8?B?YVhOMERQN012cFo1RFA2bHJLWXh5akFzTFczNjhpbTg1VzF2Ti9vM2dkMTlD?=
 =?utf-8?B?NTYzbStVUXA0elNhNlFkZ1RkdUQxQ05YM2dnMHVQWjIybGFlODdyMktFQnVo?=
 =?utf-8?B?SXl6TkY2N1E0ZWt2K3ZoMy9jTGc2ekpVenNMUDYwVzBzMGdRemFrRk5ublU2?=
 =?utf-8?B?SFN6ZGVOeGJMdlBXVm9tRThhanM3S1BEZ2IzWkp5VzFJWlRuRThIbUVKNCtE?=
 =?utf-8?B?TXNBck1UWlIzeEVIYzh4L2FXKzdjWTgySWMxMmVFMGxxdEYvUENCeGREc2Qw?=
 =?utf-8?B?WExrK3Byc0k5eXZ1UnQyeFQ5amhDTmRpeEZ5MzZiUXE4akJzZHdVOVBEeEcv?=
 =?utf-8?B?eTN4MmNHcFhjdWxHMmM3VUpabGhlQWVaQmRNNjBGSzNpTFZiTmhtOEp3a3hz?=
 =?utf-8?B?M216NGNzbkxGU1g5aDZucWRqdGw1b0VhdjBjL3FONFZqcmk1OVNHNzAyWXBp?=
 =?utf-8?B?YWNoMHZHUEFVVU5HN3dOQ0I5MzRMSDNJUnIrWWxTeU10d2pjTnQ4ODQrVjU2?=
 =?utf-8?B?VGJLMW90NTVxSFhKdEJNaFRQU1lrdDQ4NjBvRjJ1eFJNRVpuSE9zVUtpUDNN?=
 =?utf-8?B?UzRhVnIzWE9udXlCb1hSVU5KcmdkdWNKSG5TU29qQURBWkdPOU85WkVzNjF1?=
 =?utf-8?B?bjNYRGhySVBPU0hmSFh3S3V6K2xUMmgycWhndDhFTzA0Q0hFeW50dkNoZXRV?=
 =?utf-8?B?ZkxIR3Evb2t1L3RjSW5EbU1KZHdFNzA2UElkU0Zpb05raURwMlJnT2xCeGJT?=
 =?utf-8?B?aEpOdTVsM3NZU2NDNi9abkR6R1J0YktKRXFnSFNGTVhGZ0cxVlhkcDZOZWF3?=
 =?utf-8?B?Q0ZxaFNCZWd6VkhBeCtwK0F2dGt6amNuakpYc3RhZWExdGU0eU9HNUx6NlBT?=
 =?utf-8?B?aS9JRmJDY0xpbEFyWkFsMUFobTU4SEdicitOWkRUYk9kZGlNaVlsY05QdndY?=
 =?utf-8?B?byt4L1M2WmNzTjJjbWo0eVJHQ3JOa3Mxb1BSS2RJbURnNHJNQkdndW1wbVpi?=
 =?utf-8?B?ZjJPanBySmdnMGduK28zWXlUUk53aXN5c1VlNDNQdkZKWG50aHFwOTNWQVV5?=
 =?utf-8?B?Vit4dFBjZzBmTGhVaUlNSlNRQzhCUzVveUJseXZEWWpsbmdiU2FKTTVUR2lE?=
 =?utf-8?B?eGZDQ1JhVTVvNkh2VEdUemROVFdaenFrYjg2ZW9mckRVVmRDSkFTVUoxWGx5?=
 =?utf-8?B?dCttYmpyMVBUSUVkdFZUMnBQT0JoNGxCd0tjZ05tdmx5dUNXQ1cxVEJVQ01q?=
 =?utf-8?B?b3NHNDV1Sk9hOXBaY3luUno3RnBxbTJZeHNNOXNlSlBXM2pOYk1mdkZnLzY2?=
 =?utf-8?B?QkFINEpsc1RZelE3L2dXc3BPT3FrRjJIblhIQTdKeUFWTGJUTFU3Wnphdzhk?=
 =?utf-8?B?M2xjZU9mMHM3dlUvditxNlZOY056YkFYZlVQV0FNa3hpRi9Wd0lTdU1pa0Ro?=
 =?utf-8?B?Z09aaXN4M1lBd3BtM1BEdVpITnhSalJXdUswajlqdk9pcUZqWXdLYWR3RlBE?=
 =?utf-8?B?K3lYUCs2eUNXUEpYWmo1akw2WmN2enJYYUZtbm9DdnZPbjF4MndHR04xVk5R?=
 =?utf-8?B?cDQ4US9hOUxnYlRSZHhLbWVlSzRDd0RYUmVCd1lpVDlQaWxZYUVzTlZkZWpB?=
 =?utf-8?B?SnFHZUFsN05oTHkzSitlblVVQkpTajFuOE5IRVF1ZnYzYUN5TC8ydkRWMktJ?=
 =?utf-8?B?d1NVenN6azdTSXdLUGpuRktORFAzdERmV3puNGoyQ01SdGk2OFh3M2RqbXRs?=
 =?utf-8?B?aGhGOXN4TTZEdEsrbTF1Nmc2YmxWMkN4cmYzM1NEMXBiaHBocWhDNHRvYVBN?=
 =?utf-8?B?RVVUcVFhbm96Mm9razFHTE1vWnZUNHkrRnk1OUd4UHM5VElhbThUU1NDNWEw?=
 =?utf-8?B?Ky8vNG1kWm92bmNsbEQ4bGh1TjZQUHpTOEJDRUZoRThoUTI0TVgxekJsWTJD?=
 =?utf-8?Q?R5lT2yjtB0ZG5jb4gpxGm0Qaf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037ef241-6110-4a79-ce6b-08dc22833ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 17:37:08.8666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8SulgHAnQ0ZnCNVHNGZ8hkK2tucbWlow1MdM/edlXFd1JLHXu3Uedlmr2CqEx6sfZ6UgoVwdiUeBipfnZJ2oo+PsVWeGEX2HNFS3hd34BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8225
X-OriginatorOrg: intel.com

DQoNCj4gT24gV2VkLCBKYW4gMzEsIDIwMjQgYXQgMDM6NDU6MDZQTSArMDEwMCwgSmFzb24gQS4g
RG9uZW5mZWxkIHdyb3RlOg0KPiA+IE9uIFdlZCwgSmFuIDMxLCAyMDI0IGF0IDA5OjA3OjU2QU0g
LTA1MDAsIFRoZW9kb3JlIFRzJ28gd3JvdGU6DQo+ID4gPiBXaGF0IGFib3V0IHNpbXBseSB0cmVh
dGluZyBib290LXRpbWUgaW5pdGlhbGl6YXRpb24gb2YgdGhlIC9kZXYvcmFuZG9tDQo+ID4gPiBz
dGF0ZSBhcyBzcGVjaWFsLiAgVGhhdCBpcywgb24geDg2LCBpZiB0aGUgaGFyZHdhcmUgcHJvbWlz
ZXMgdGhhdA0KPiA+ID4gUkRTRUVEIG9yIFJEUkFORCBpcyBhdmFpbGFibGUsIHdlIHVzZSB0aGVt
IHRvIGluaXRpYWxpemF0aW9uIG91ciBSTkcNCj4gPiA+IHN0YXRlIGF0IGJvb3QuICBPbiBiYXJl
IG1ldGFsLCB0aGVyZSBjYW4ndCBiZSBhbnlvbmUgZWxzZSB0cnlpbmcgdG8NCj4gPiA+IGV4aGF1
c3QgdGhlIG9uLWNoaXAgUk5HJ3MgZW50cm9weSBzdXBwbHksIHNvIGlmIFJEU0VFRCBvciBSRFJB
TkQNCj4gPiA+IGFyZW4ndCB3b3JraW5nIGF2YWlsYWJsZSAtLS0gcGFuaWMsIHNpbmNlIHRoZSBo
YXJkd2FyZSBpcyBjbGVhcmx5DQo+ID4gPiBidXN0ZWQuDQo+ID4NCj4gPiBUaGlzIGlzIHRoZSBm
aXJzdCB0aGluZyBJIHN1Z2dlc3RlZCBoZXJlOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvQ0FIbU1FOXFzZk9kT0VISHdfTU9CbXQ2WUF0bmNiYnFQOUxQSzJkUmp1Tw0KPiBwMUNySHpS
QUBtYWlsLmdtYWlsLmNvbS8NCj4gPg0KPiA+IEJ1dCBFbGVuYSBmb3VuZCB0aGlzIGRpc3NhdGlz
ZnlpbmcgYmVjYXVzZSB3ZSBzdGlsbCBjYW4ndCBndWFyYW50ZWUgbmV3DQo+ID4gbWF0ZXJpYWwg
bGF0ZXIuDQo+IA0KPiBSaWdodCwgYnV0IHRoaXMgaXMgZ29vZCBlbm91Z2ggdGhhdCBtb2R1bG8g
aW4ta2VybmVsIFJORyBzdGF0ZQ0KPiBjb21wcm9taXNlLCBvciB0aGUgYWJpbGl0eSB0byBhdHRh
Y2sgdGhlIHVuZGVybHlpbmcgY3J5cHRvZ3JhcGhpYw0KPiBwcmltaXRpdmVzIChpbiB3aGljaCBj
YXNlIHdlIGhhdmUgbXVjaCBiaWdnZXIgdnVsbmVyYWJpbGl0aWVzIHRoYW4NCj4gdGhpcyBsYXJn
ZWx5IHRoZW9yZXRpY2FsIG9uZSksIGV2ZW4gaWYgd2UgZG9uJ3QgaGF2ZSBuZXcgbWF0ZXJpYWwN
Cj4gbGF0ZXIsIHRoZSBpbi1rZXJuZWwgUk5HIGZvciB0aGUgQ0MgVk0gc2hvdWxkIGJlIHN1ZmZp
Y2llbnRseQ0KPiB0cnVzdHdvcnRoeSBmb3IgZ292ZXJubWVudCB3b3JrLg0KDQpJIGFncmVlLCB0
aGlzIGlzIHByb2JhYmx5IHRoZSBiZXN0IHdlIGNhbiBkbyBhdCB0aGUgbW9tZW50LiANCkkgZGlk
IHdhbnQgdG8gcG9pbnQgb3V0IHRoZSBydW50aW1lIG5lZWQgb2YgZnJlc2ggZW50cm9weSBhbHNv
LCBidXQNCmFzIHdlIGRpc2N1c3NlZCBpbiB0aGlzIHRocmVhZCB3ZSBtaWdodCBub3QgYmUgYWJs
ZSB0byBnZXQgaXQgDQp3aXRob3V0IGludHJvZHVjaW5nIGEgRG9TIHBhdGggZm9yIHRoZSB1c2Vy
c3BhY2UuIA0KSW4gdGhpcyBjYXNlLCBpdCBpcyB0aGUgYmVzdCB0byBvbmx5IGxvb3NlIHRoZSBm
b3J3YXJkIHByZWRpY3Rpb24gcHJvcGVydHkNCnZzLiB0aGUgd2hvbGUgTGludXggUk5HLiANCg0K
QmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=

