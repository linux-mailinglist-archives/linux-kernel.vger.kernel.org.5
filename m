Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA380C12E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjLKGNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:13:50 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC6B8;
        Sun, 10 Dec 2023 22:13:56 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB54uNR022192;
        Sun, 10 Dec 2023 22:13:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:content-type
        :content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=RhTL
        Ze3qVwfhTrFCaLCB3nZ46Rg4CTBIwdLGveQ4S10=; b=Mrg6WIJSS/FbcBkWyL7H
        5SbfxMKufysEGn0L1iL2+MKwuPwa68Mc9wys2NwjNrOxyKwP812BIO6jxfbXA3Io
        W2My22+veEitRz7w8l+ZgJDabfjyQZYFzSySV/BhWB2S3wnEILYFmwObKJrFJNY+
        eWCqMuMCiTh27UgNmg9SiV5jowxFcKmd0KJeC/v+iaZGIcgrqKBdt57huJi/HSjJ
        Bpm9PMbHZjfzbjvwoBjUfdF5O0B0AJmU2xeQSvuQI09G5CNvI6sCWO/N2ZvA6Nc8
        8/RpMfc6+3nvE8tNmC2vhZlQPADyVeQBiYtmmyXCwKFLAXwdh+cN9Y4wmTiFiXKu
        uQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uvr4mmp3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Dec 2023 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702275210; bh=cUZ6uRJZa52DCvikrLJx/uoArpLFShPPkyE90LwPSIo=;
        h=From:To:CC:Subject:Date:From;
        b=irqNMu1yRdRyuMxJddV8EBE64fClGeQkKrTJm3lRaGwObqVequ/zvtKu40eAw3aF5
         uQn4giU20iMwXHmImPOIyCkW9HahGmmIt60EZwpEG620zaLAMXbL5aQAxdB3zImeT2
         UdYvWtCtQnIlp3m+H/bABSl3dHrLeeb1mQ/V5IF+GlOqzvOpoNvUqCuNO4TAwPiYa3
         lZnk193gQChjLSE6cF6nWQ3nl6P5Q4XeEeFQpSrgJH+kpDiEtkGFj2F30QcdhGpMxD
         5/+meDioGQhSEDcLu7Fu8ofJe1wa1XPxQebWM0vyJ4lsGDwcH/rBHU8fumTtBzgui3
         IbMgPHxHH22NA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7B85D401C2;
        Mon, 11 Dec 2023 06:13:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C366AA0265;
        Mon, 11 Dec 2023 06:13:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=F8kBUsT/;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DD510401CB;
        Mon, 11 Dec 2023 06:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN3CWt/F6i7sgdxxAasc0P2jf9EnEqRlxclsA5AoCxib6t7FXLwIKLrt91euCKT2H8ITJltSlLE/L/NUa71wLAXP7JEbVUSTof5q3gGcYZMP2+MOQRwPiZahwSyL7y8CBDsF4N1VUlEn1SHDix7btf1VVfFQZ1r1sDA6sKsKdXTtAXAEJMRAvF3T2ngZDOdnK8dcJ/RXKBs6VFuDECUnx7u6DUN705CwSYKkPJXEv9XlZq0W3hWt3jbB9bIHRaMMbyGJFPya7mZCLq8ftGXKy0KSRUPb7Y0eu6eYHLhC86JEk/MlaHSUSGbajUm/cx/62aiAnkp66AkzK4VAEgWF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhTLZe3qVwfhTrFCaLCB3nZ46Rg4CTBIwdLGveQ4S10=;
 b=hg4Idnf1rngvC1cTm4Opx1n1VvF3ei1feoXmN9dtXKUg67l574n2ZD0mfAhZWnDoLt6RkzI7lZVummOcf2VxVcYoeIwb7/KrnSvFR8i7R6Mn1GesJaMHZtsfxXpz0UcF8xOZ51zY3Sl+WvEv/CU95Pzx/W77VdqNS8e2JdwpwBgIG0Z0+kOKDCqHCK6nBAPVzcUSZqbOi5QrbakLwbuVZbUXbu0akAo+qbmHbZbeDgKB3MOA2W0Np/gnVgr3qZ7NXEvCnp1WUhXze1QVTS0nH3JHU/LIMXLsMPjkz3FX/GAd7CYdBrRd1tLDTPrFFZvQX7cUReLE80eXbPIEpzv7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhTLZe3qVwfhTrFCaLCB3nZ46Rg4CTBIwdLGveQ4S10=;
 b=F8kBUsT/2hwnAeFMAN7pkjC2Ea+kh6huCutkS2NG32jlJ1Ybyvpuj7+HlnjTCT0+or46Bv/PNVOfdx88zMkiWjMOqtJajW7+xVbts8O5j3q4xSOu+J7h6uaWkePIsJ/bb7RDRRz4KH8SWzicJWylNL3rPUiLXtEm7rnzbB4zi98=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:13:21 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:13:21 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking support
Thread-Topic: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Index: Ador+H1+Z6wgRV0bTDW+VJMmnuYc6Q==
Date:   Mon, 11 Dec 2023 06:13:21 +0000
Message-ID: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|SA1PR12MB7037:EE_
x-ms-office365-filtering-correlation-id: 7c8f8afe-0327-4811-5fe0-08dbfa1046b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kn93dGL96+NWidDmsTtvQQXgYUda8v0ZEprv3DFQb0SguJ6XTmwTyuUGY69NvlizaZn0dcHuoETMmscA1JxkdF5gzTEgkKLqyGObxUgn5iLi6l118eQL3SFXtuaSnp3WTQ3Ii1xzjKgzkM0XeJ+H3OcDNPgLK3M/pNr32JLo24ckPGS27mHjkIHfvpQA+TT3jBMxdhnc1IUouoERs7yzKSAKG/JODQsLDRkBzwNZE3zxCsu1rzJxogHZ2BHUyiqcPBVDUSsVgul/LMt33mHSvlwfAfjli9/77hwwSUffVu0KdxH3jhkEGsb71g13G3LBBDKWzT9WSH+oDssDOpyZ+m37A2gZdSfYl5AZZBPNCK+1Q5OSmY/Kc0y16Bm6HnXTKVeA1ir9SjJWtZ0Pq33rXKs12mQBmvKlJdywAxZh3+FDvNjEptmWdkGOrGbrnFjaJkUkxLI9uQvg7knoD7H9zslbf5QN1U6XG1F4ExsaPkrDIri2YHLtBQJxsyI5wW0tVSvY6RhLR4jkJ08cDIWojSaKvzyf5XlbEsH4FBoMTcsVch8jdGWW9JBgJGqUdOPg8k20krJq2F8spSMtgCcJ7MllwCsPzsdsr0aXwDXnYtT5bFT/JKlONE6lay4cXec9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(41300700001)(38100700002)(2906002)(7416002)(5660300002)(316002)(4326008)(52536014)(8676002)(8936002)(76116006)(38070700009)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(9686003)(33656002)(86362001)(110136005)(122000001)(83380400001)(26005)(71200400001)(478600001)(107886003)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGdSvMzzIG4BEMqslhHhYzXdyYBRm52dG3G97Or5rBVZcZgZe1/sLcGdvylw?=
 =?us-ascii?Q?9seQN39Io2DPYoWDvN/6j2mcyEqGKQcymWauOFf6jevC2aUG3mspXoz53COB?=
 =?us-ascii?Q?gaVBMsBb8xQnyTwX4x9zPm3jDOmLdd2CdpKHNBT/XBXbAxK6TG57+90FboJn?=
 =?us-ascii?Q?hiHW20pCetGVwPg3X8Jt9Gj4yEMJ6EjYi3G03Nq1mY/VxUr8q4TYgTgAxami?=
 =?us-ascii?Q?/MYiKIqAl1Ss96ZXmVorWqT/y4eQ//JGXZPkjKYTsEIcMCXroQpzqtWSKHkx?=
 =?us-ascii?Q?IRdn9cOjwKRze3kNY+k7FvBNkxtxDMP3MQtJN+Vox0t4bBjX+M6K5TltaITZ?=
 =?us-ascii?Q?KTJQHszGAC6fSIP1nq0CaqXgfMSpLFeS9NocglY3pvo/hnl5Cr0WpP2X9Z4h?=
 =?us-ascii?Q?fpZi05pYpdHo/og1mC+8JB3zCUwmn2hhEukgL1yoncoC+rZPv4xxtJ2/UXJb?=
 =?us-ascii?Q?mkJPi/4E8+v0h9t0s/Hthzal5qzb3xZpdCAwHUrEhPFSnN3PKAr9s5e2yhva?=
 =?us-ascii?Q?farNRGrgSLSe/Ir15IG6jGqaQTyfcv9MHTQrFKkMBV6HBsOwif3+hReRb5zm?=
 =?us-ascii?Q?lkI5kJI6VD+yqbILkRknYbUznbdlSpci8OfdWEuqb7qpAlxi+nVD9es9xo+o?=
 =?us-ascii?Q?rMYb13XumJ9WBR4WJ0rNFVAoAURrJVxYS/IxCcOMSF5jnD4RdrX3435iT/JA?=
 =?us-ascii?Q?69iFg12QA+qVbftH/kK3e/QBIAToitZFsNg+NZTTgxbkWWuCe5tvFnY+2kOV?=
 =?us-ascii?Q?nS67b3aO20KO04D/vKUk4tme9DHGDXg7P1EvUUewADl6gSDitYBoQX5ad1cc?=
 =?us-ascii?Q?BP++KWEvG0u+h60yezERtDSWK1FcVeoJGIFZ05/VdoQUXJhoH3xoCg9QAJ5z?=
 =?us-ascii?Q?NF3VzqNoteiAnF/UW/96WZMNQF7HbwJm4/ean8H3KW2h3DJnl/SUmq+q5two?=
 =?us-ascii?Q?iYiUVuwz/fUK1nNyEUL0UPG/eNiCyUqazbi/PAPP0PGJ1HYE2/e9XktpMJSx?=
 =?us-ascii?Q?zfihD4F9W4IHaH/wxLCYJhm9C59tOSRCamblwmsGOAaV65KZbaUlGwYY9kZr?=
 =?us-ascii?Q?v96UdPCgbVPGl9OSDpncnWipyCV6bMdMRBiNQV/XgwO+5sGVKTHolRW8PkyK?=
 =?us-ascii?Q?Uz+MNCV2aWo5qub5JdAcZOq9cGJuDzGDTJGnnUQjbzlUt8YxeHUfj1IacCkp?=
 =?us-ascii?Q?L1i1DFIIS/9CSWJwa8rAD2TI0KdoKioGAwSvlGFsJv+Q0W+PC5+mr6fUqN7X?=
 =?us-ascii?Q?e6UqXzKuvhmOd0THv9a3CRgurl4Kl42iW2hG7QA54bbShoL7YBlIcR0whFOd?=
 =?us-ascii?Q?eHdpVCW6GrZTiX+1kQpnCoA85O+aKjguhombR0CMk4qI/6xm+mSNo9PI5FTr?=
 =?us-ascii?Q?vrV5tJzCt10KfvBXA89+OiZ2jw7Wg65jg81eaqPrg2Jl5CpvQ4KIVaHMeDqp?=
 =?us-ascii?Q?NPDr7IZemflXggMkbS4ToB2Dfx7BxkA/u5poPp3jeJUKiCwKCTHbRKfMxysl?=
 =?us-ascii?Q?S8t84BAGN87PY3wg+2hI4AqAUj2Oh9HVAwC+pdVk6emk6s5GrYr11vlNVG/C?=
 =?us-ascii?Q?4/phYe/449r9mhQ03gF9fDOr5Mi2S7dssJ+ohlpz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qytrrf/V+1eMbS/feYcH7vW6wQEOhANUY1qMT2xW5UwNLXnLRTTinJMwf6B4?=
 =?us-ascii?Q?EES8CR8Zo0x1ZVV0Ps8QuscbRCwcSsTUfOcY9Sqg/SG8jhAJXzzb0ir2FDt3?=
 =?us-ascii?Q?CO3DrB/vKJwl69yirlkdNt6d1Trpdcu5sFqNTu7/EJDWIkqIwvbMUeczrwSN?=
 =?us-ascii?Q?7kz0kBkHGETvZb90XrofgDWaN+tLjR5sJ6fMmuVsqAhuMJjcjeyGNBKiXsVd?=
 =?us-ascii?Q?3ZEts1LxSTTIKSclXfsfUtUj/TRGtLkqVoAFg4cvLyIConW5yVBkvpN6mxa1?=
 =?us-ascii?Q?w27zdWZjZOyUZYUjpyxk1vWCdhs/zVUq5u+S3G2mSQpbmKDnzX/mhjfc7Q4J?=
 =?us-ascii?Q?eoj6nE3gL/oI4EdyqDf8P5KDC8VIsnjPM4Obv58nqA2rBVoyOc0FTNmeJ9aq?=
 =?us-ascii?Q?mbVPMxI/dAm7RwX53q89svN0m1nBZK1xjqOZ0k2p3zP5pt4dPMFWiMaUuE7v?=
 =?us-ascii?Q?ZQUWxrvQcDTcLG17efMISoLqjCH4yW0HD7374b4yPG9mvpuCFrb7RQHyQw9O?=
 =?us-ascii?Q?z5WtBbcIA9lhEA4uC0gLx0YzmbWeRBaSDRyzCUtLLTuLaRTMm8J45f9r1RKJ?=
 =?us-ascii?Q?8nABskvApVoTYm0diYtwkT+lfUzeGd+HtzET40GXShfVh2LHMCL3aicwbti4?=
 =?us-ascii?Q?Ftv1cr6pUvBK3OKHHQyAD6K6RSc4DYQSz+QlEnYZKKxAKsxjOpgJ1wPjchKc?=
 =?us-ascii?Q?JTWwrn2gi3BToWnPDQtebs59xEw9DdAZtUCptVpA2EqTjL3T6A22f1gT9msZ?=
 =?us-ascii?Q?Ez/NjPPca+OJNFsotBId4UkEIDQgSFkwowRJRYTl9DqM1ZJ7nPE/rjwjnNjQ?=
 =?us-ascii?Q?Q/V6jUgmz8wLhlWiOApVxCxJieefSzHBINDWoMliUwcJQVy8QsVzABvwW7Mn?=
 =?us-ascii?Q?nefNa17PHv0kWUjyvXGdruX83tG7+Kj5LgUalXwwMyuGEiOkm+VtHWH/bflO?=
 =?us-ascii?Q?cPbdTVMlLKUau/UI1Rh2tpcXO1VG10rMHepHlEM+oTipSaeFnfg8MmzQ+lGn?=
 =?us-ascii?Q?7VbgSqjiHSQtBpDjyWkWgFeLN2prsSqFILfnuzR0cfn42jnd1VXXCVjD4zYC?=
 =?us-ascii?Q?kXGXDsiEkWmkS3AMX7wYm1angqycn9RroOId9r04nbMFNbEE3aMR9j2UN78N?=
 =?us-ascii?Q?QWVnAynTzWyP?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8f8afe-0327-4811-5fe0-08dbfa1046b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:13:21.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTk4KBaDyezjuRp52TCQTQHiMjcq7lY8c7GsaHB/cBkWatrE5p6P64sw3aMAOe1RZYy2r2ND/ZWM+1mSXT7+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
X-Proofpoint-ORIG-GUID: QNacUVCCHTdEFpUP2PbuzC2HP8OuvCHW
X-Proofpoint-GUID: QNacUVCCHTdEFpUP2PbuzC2HP8OuvCHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312110050
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the HW specific support for Frame Preemption handshaking on XGMAC3+
cores.

Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  6 ++
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 65 ++++++++++++++++++=
----
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/e=
thernet/stmicro/stmmac/dwxgmac2.h
index 207ff17..306d15b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -194,6 +194,12 @@
 #define XGMAC_MDIO_DATA			0x00000204
 #define XGMAC_MDIO_C22P			0x00000220
 #define XGMAC_FPE_CTRL_STS		0x00000280
+#define XGMAC_TRSP			BIT(19)
+#define XGMAC_TVER			BIT(18)
+#define XGMAC_RRSP			BIT(17)
+#define XGMAC_RVER			BIT(16)
+#define XGMAC_SRSP			BIT(2)
+#define XGMAC_SVER			BIT(1)
 #define XGMAC_EFPE			BIT(0)
 #define XGMAC_ADDRx_HIGH(x)		(0x00000300 + (x) * 0x8)
 #define XGMAC_ADDR_MAX			32
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/=
net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index eb48211..091d932 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1439,22 +1439,63 @@ static void dwxgmac3_fpe_configure(void __iomem *io=
addr, struct stmmac_fpe_cfg *
 {
 	u32 value;
=20
-	if (!enable) {
-		value =3D readl(ioaddr + XGMAC_FPE_CTRL_STS);
+	if (enable) {
+		cfg->fpe_csr =3D XGMAC_EFPE;
+		value =3D readl(ioaddr + XGMAC_RXQ_CTRL1);
+		value &=3D ~XGMAC_RQ;
+		value |=3D (num_rxq - 1) << XGMAC_RQ_SHIFT;
+		writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr =3D 0;
+	}
+	writel(cfg->fpe_csr, ioaddr + XGMAC_FPE_CTRL_STS);
+}
=20
-		value &=3D ~XGMAC_EFPE;
+static int dwxgmac3_fpe_irq_status(void __iomem *ioaddr, struct net_device=
 *dev)
+{
+	u32 value;
+	int status;
=20
-		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-		return;
+	status =3D FPE_EVENT_UNKNOWN;
+
+	/* Reads from the XGMAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
+	value =3D readl(ioaddr + XGMAC_FPE_CTRL_STS);
+
+	if (value & XGMAC_TRSP) {
+		status |=3D FPE_EVENT_TRSP;
+		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
 	}
=20
-	value =3D readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &=3D ~XGMAC_RQ;
-	value |=3D (num_rxq - 1) << XGMAC_RQ_SHIFT;
-	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+	if (value & XGMAC_TVER) {
+		status |=3D FPE_EVENT_TVER;
+		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
+	}
+
+	if (value & XGMAC_RRSP) {
+		status |=3D FPE_EVENT_RRSP;
+		netdev_info(dev, "FPE: Respond mPacket is received\n");
+	}
+
+	if (value & XGMAC_RVER) {
+		status |=3D FPE_EVENT_RVER;
+		netdev_info(dev, "FPE: Verify mPacket is received\n");
+	}
+
+	return status;
+}
+
+static void dwxgmac3_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_=
fpe_cfg *cfg,
+				      enum stmmac_mpacket_type type)
+{
+	u32 value =3D cfg->fpe_csr;
+
+	if (type =3D=3D MPACKET_VERIFY)
+		value |=3D XGMAC_SVER;
+	else if (type =3D=3D MPACKET_RESPONSE)
+		value |=3D XGMAC_SRSP;
=20
-	value =3D readl(ioaddr + XGMAC_FPE_CTRL_STS);
-	value |=3D XGMAC_EFPE;
 	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
 }
=20
@@ -1503,6 +1544,8 @@ static void dwxgmac3_fpe_configure(void __iomem *ioad=
dr, struct stmmac_fpe_cfg *
 	.config_l4_filter =3D dwxgmac2_config_l4_filter,
 	.set_arp_offload =3D dwxgmac2_set_arp_offload,
 	.fpe_configure =3D dwxgmac3_fpe_configure,
+	.fpe_send_mpacket =3D dwxgmac3_fpe_send_mpacket,
+	.fpe_irq_status =3D dwxgmac3_fpe_irq_status,
 };
=20
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
--=20
1.8.3.1

