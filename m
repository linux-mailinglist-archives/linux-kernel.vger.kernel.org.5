Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE3980B57E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjLIRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLIRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:22:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A24610D0;
        Sat,  9 Dec 2023 09:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702142537; x=1733678537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JdIlXYu290R3kcehflITfTS6MKjLv92ON3P5eoXJOok=;
  b=PU6WjN9DPppQkG2aV/RLLI/kN+vzxxn61oSesSuHZo4EjlrcVhtDGg3C
   xphMGcJcT1EHpLaJ4ukzOoalsYsu4NvH8SoVvxz1pHHsakuNClCMu5Z5M
   XL8KlGImCAmT1elI8P1klTNGK80MFbxucP6PZ9JgOxdYXi4UIYoRMsuTW
   P557RzhB/zatq4BwUXj+NW4eJ9df7OMuqu043Ho3JtALnN1zmCIN1t/TI
   fREZI/AEkKHM8NQZsYfuiltESW/g26IyTEvPwtauKDpbHQz08UiFdE8MV
   +HQpslOzkfpkAY12ozFUnhhrzAz/sp5pnsvqWaZa/IPYooL8qHMMePxwP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="384928507"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="384928507"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 09:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="916300377"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="916300377"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2023 09:22:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Dec 2023 09:22:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Dec 2023 09:22:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 9 Dec 2023 09:22:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Dec 2023 09:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffo1LNNiwwrBCmbD3euJEnX5Lkc5ebsfpFlQ+JYbiyeZgpZkTfjflNRv0t8sIwb8IInbbDRTzizgnCYI+nybyv1Kp8AHuP9TPL7zrtVO5LVYTuRXw2oa5MhHaaCXlvf/JH/6k8Oz69dFS7hsnRN4Wuzf81E4q11cCllatrIh/PKcuvyb7Gb0/DyiJ6J8lwS+gHwYkgV69KnDbdag+Id3RVMeDcPOGj4f+md+6hIjd502f3klPCoHJcDqe8NMsHBa5N1rO93+6EEMIkz08h7rIB1h08KDl6YM9U2ZkQlsjwlDcpdhBXHThdE5Zqqj+QiD8sNrfgFvhC53/MGabQuPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI4EUtVOpOcw+O7ILs9MG4Nbgyn7YoUo6o6gR4IkYko=;
 b=eGpgXQBGZ7XIpGJNmfmLg+81pleBUo9EmZjMWhZXzTru5emPs7o1ZbgCSkkYYEy0+zBFzV2P4uMqA1HcjriD0rPNUOkPULhQwYK92/R0zygBiQ2QZFOf325woMrWDQjDM9buCdBB/Ldj/i+MOWO91sTJmYPLESvD05sSjWiXnKOZfNHxwSaw0XsnEUQV8n+p0OcCGsnMy3Z+p8QNJoNxg41vqUwLm5/80bJFM5II02RszyCkfYrIVsHzsSVYZUKd6dB9CNmkfWVChyaxubhTiTGoi31bHdUI6i7+CWlTg/iT3D2TZpZJJD55LH24iPyNtzWhkEPtGrvllI7Z+UJS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) by
 BL1PR11MB5333.namprd11.prod.outlook.com (2603:10b6:208:309::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Sat, 9 Dec
 2023 17:22:10 +0000
Received: from DM4PR11MB6094.namprd11.prod.outlook.com
 ([fe80::fc6a:26d5:11e8:8487]) by DM4PR11MB6094.namprd11.prod.outlook.com
 ([fe80::fc6a:26d5:11e8:8487%5]) with mapi id 15.20.7068.030; Sat, 9 Dec 2023
 17:22:10 +0000
From:   "Chilakala, Mallikarjuna" <mallikarjuna.chilakala@intel.com>
To:     "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        Rodrigo Cataldo via B4 Relay 
        <devnull+rodrigo.cadore.l-acoustics.com@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kurt Kanzenbach" <kurt@linutronix.de>,
        Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
Subject: RE: [PATCH iwl-net] igc: Fix hicredit calculation
Thread-Topic: [PATCH iwl-net] igc: Fix hicredit calculation
Thread-Index: AQHaKecKtZcyqHkzjE6/SXpDp61lzrCgIKqAgAETW6A=
Date:   Sat, 9 Dec 2023 17:22:10 +0000
Message-ID: <DM4PR11MB60941A401AF5BF6B70473A768489A@DM4PR11MB6094.namprd11.prod.outlook.com>
References: <20231208-igc-fix-hicredit-calc-v1-1-7e505fbe249d@l-acoustics.com>
 <871qbwry9y.fsf@intel.com>
In-Reply-To: <871qbwry9y.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6094:EE_|BL1PR11MB5333:EE_
x-ms-office365-filtering-correlation-id: 60cee8eb-8e06-442f-02c2-08dbf8db606d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gn222fF6BFxYjm2dQdSu1Dp9gNnO7Jfz1H2gtegps4j2XiX5CRrEv1sj2pQtHv+J9UIIQYnCUUkaGRpP85L//FGnpINLTsAcqo0gGMpoqIjYoT1GWbPYjmhTzAXGuEe5L6ODJ6hfBM8KA25zer94bg13Jw6mllnEnmcNKLpcmKPUK6tO1eXClEK9krzGI1k3jQLtdtbbe/9dH8p1NNpLnGC0vsUgZyCjg/n4aL0YlQAqlfPnH1XRIjClIpHdxo4ud/Jq6cWOP9R6gOXrrWy12hBBYgThzX1TDIwmNG86KlslzhZ+ZimH6hvoInZSKsBMIQ3RZUUnHQn9A8mEhf6F6baIT/1mjdiFDMIR1/9pisOqzcdAcMsBSVYSqBuv9a5CkTE3qZcwxHFPg0WhGYALly3Hyk9DrbuBIRB6091Ekf46ge1+LvABqO2Q21qmivlqcV9Xq0WIZqjroFGEb4N35V9JUMcU3AneMP9R3+iEge8E/rPKID+4AAL1oRRLZ9YfEdg9elLlhJZSaVMwHksZ5aW2BKVJuaVVSxIQdLdqnb+DC3/AoxysmPkm4t5+PRtx4PA4+UNAFU5eRHYbcvI2MBL3877s4aeWv2EIp3rzlj1oSRCCOFrpcO+qDC/sY41Quy6rdDz9GGSHrSAK5VfVfWFgbbcGnKK9kaoUd9r6dSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(2906002)(41300700001)(38100700002)(122000001)(33656002)(110136005)(86362001)(82960400001)(9686003)(26005)(478600001)(71200400001)(6506007)(7696005)(83380400001)(4326008)(52536014)(5660300002)(6636002)(316002)(76116006)(921008)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(38070700009)(8936002)(8676002)(55016003)(341764005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A1YfQAX6+XsM6Ff1RnPTYiS1/xjYQLgDTf3tWweCGU3dPV+x9YSIwx7XHlch?=
 =?us-ascii?Q?xfvRAEsVfvc4DPHfFitbKT88akE/AW3jeHgkS6RVCXV8ELA8EWirSs9W/u9l?=
 =?us-ascii?Q?a6YH4Kd3zHaljTm3nMnrgTyqutNw9ubESI9DMn77dxO0Ia7HCg5bL8/mV7ty?=
 =?us-ascii?Q?Nh1R1CSvjR8bMqnvEBkuB4q0LimW8LxHmROfGDVvsOGrrGd3wCAos1YH4AaF?=
 =?us-ascii?Q?EfFPwwuRGRPUUwxCGnFDOsq38aBZCugacFfLBLud8SvAVQXhxD4ql8hzmS9s?=
 =?us-ascii?Q?AUCXeBckp34WyXgsXycKfyS2ZrpPjmePuPMSunpaIx/SzUvMl1iEEFInaa2O?=
 =?us-ascii?Q?yJbjikKQcAT/oKW/D80uGL8HQFWBZHmMkX3TwI5jhTqkouKPxI1Odc9M+Mby?=
 =?us-ascii?Q?iOmaMeuVJyb0ce3WAPhqYwezGDAWyidNWfxcxeSt7tX3R6vr44h1QXFTIdyV?=
 =?us-ascii?Q?2+1TNSVHGq9SpWYRxME1ji3ksG0Ve2D3Vv2zzMXGdMiJyoW7t6PZ9PsU6X+b?=
 =?us-ascii?Q?ZAxlMll5PLUMOBolBdsCGoTdb0buwmKn321nzQE58q2jiAhNKZMUfY39WGbn?=
 =?us-ascii?Q?M4LJIRmBPfCRe6KdBVMfvW7ok3TwT9bQ7bY+ZXRjtphJm6JvSeDUHJpL6j9H?=
 =?us-ascii?Q?IIsU3yroRQj6j4tehOCl6bxJD35R0mBQ3BJxpgwUgKpmmJh6UMU1Sh7p9X0x?=
 =?us-ascii?Q?4naKgDr7Yt7WZcGzSoSvAKm8XumbSRPN3JGXEQrruQ/ADTRathk6dUPO3QPo?=
 =?us-ascii?Q?HpfTbBfX5NgLgbBkJpHlLdjGP1UAqmtp1pDseQhrHPa+UmhqjoxWexEAWoko?=
 =?us-ascii?Q?dofDTvsH1U2TmOnn5RbnbG4YDiC+cBRb4vF9wxh6pp1ovXNJ1naUqczGOt4Y?=
 =?us-ascii?Q?r4OFjKkIK5b50Y/lYJFktkfWWAAvv3R7Tbq8pqShUyMpeIaXQsq3vpGBGtjH?=
 =?us-ascii?Q?4QL6neTY0YAGHNiSGEiR8PQ0j2eqHD/fFqVppzr5FbHJ8v0wyHBd6MVCFvkR?=
 =?us-ascii?Q?tqrvu1n9DdJ4k9Dv6pwW6bJHaNOiVe/824BZ8g2DSknf3DZKyPw61HbrvKdq?=
 =?us-ascii?Q?9chvxuetmblp41doAuAw65P4Ucd3EAzPhvVZ2dPsK87wVvN1+2G8mjB35sdP?=
 =?us-ascii?Q?t7ecr7afx2zsTq+q9PGPUJt3iM7H5YFefTFxCFAMz60+/FE+0BXGoIWNFAc7?=
 =?us-ascii?Q?p+aZJZJPepeWycf3bXPUkcBTFkqBQ/fLBoMLGZlynypxQnZAd5xXkJYMgCC7?=
 =?us-ascii?Q?Ptg9xEiqYDSO+QYylxM9fd1gL2lpYPV9cYMXZ6MONgMfjLm3IoHp56lERjbK?=
 =?us-ascii?Q?SDXDM6evPNG8q7W8CkVofTktwu0ite3OVPcLCrf/mqvlSw1F0wwQE3G/25Ac?=
 =?us-ascii?Q?8ufzBgMoR1yP8Qm1Sbx9tEQyxdICmDSxFFmgusUKBmw2WEmDJSVCUnYBQCFH?=
 =?us-ascii?Q?jkcfi4N3LTda1mTE2DtcVRvfiRcIgroqkN4z7nJoWj7Ity+0UJxFlTBL+Pkf?=
 =?us-ascii?Q?aPwe2Ozpnbz4OpQKc7E/ag+IKAdJYA8V2ES04v7z6ZDuFXW9c9B9sMIm4Fpi?=
 =?us-ascii?Q?AOj7BwThKPDf734gNbWvPYHOHwr6japZklzzMYBzYSAGABcZP83UXt0tgC8L?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cee8eb-8e06-442f-02c2-08dbf8db606d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2023 17:22:10.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSMWOtajn7E3rvdyhdhtSOn0jlOitE7VWIRnPuXolwdLxgj9CFPVkNHbxkPvOcR2CdChIrobF9CWmRyvCkNmNEJVHFeM6q9LBbj0REUkhU8ICgIfFnW5nq4sclicn7NJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo Cataldo via B4 Relay
<devnull+rodrigo.cadore.l-acoustics.com@kernel.org> writes:

> From: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>
> According to the Intel Software Manual for I225, Section 7.5.2.7,=20
> hicredit should be multiplied by the constant link-rate value, 0x7736.
>
> Currently, the old constant link-rate value, 0x7735, from the boards=20
> supported on igb are being used, most likely due to a copy'n'paste, as=20
> the rest of the logic is the same for both drivers.
>
> Update hicredit accordingly.
>
> Fixes: 1ab011b0bf07 ("igc: Add support for CBS offloading")
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
> ---

Looks good to me!
Acked-by: Malli Chilakala <mallikarjuna.chilakala@intel.com>

> This is a simple fix for the credit calculation on igc devices
> (i225/i226) to match the Intel software manual.
>
> This is my first contribution to the Linux Kernel. Apologies for any=20
> mistakes and let me know if I improve anything.
> ---
>  drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c=20
> b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index a9c08321aca9..22cefb1eeedf 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -227,7 +227,7 @@ static int igc_tsn_enable_offload(struct igc_adapter =
*adapter)
>  			wr32(IGC_TQAVCC(i), tqavcc);
> =20
>  			wr32(IGC_TQAVHC(i),
> -			     0x80000000 + ring->hicredit * 0x7735);
> +			     0x80000000 + ring->hicredit * 0x7736);
>  		} else {
>  			/* Disable any CBS for the queue */
>  			txqctl &=3D ~(IGC_TXQCTL_QAV_SEL_MASK);
>
> ---
> base-commit: 2078a341f5f609d55667c2dc6337f90d8f322b8f
> change-id: 20231206-igc-fix-hicredit-calc-028bf73c50a8
>
> Best regards,
> --
> Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>
