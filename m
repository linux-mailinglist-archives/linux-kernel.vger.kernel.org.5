Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF07FB1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjK1F5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1F5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:57:40 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3DD6;
        Mon, 27 Nov 2023 21:57:46 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS0rpqU002556;
        Mon, 27 Nov 2023 21:57:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfptdkimsnps;
 bh=gjdGiDOHd3iCirswDrV0wpbzHHP33BBR3KOOa41r3Z8=;
 b=et9E1za2IjxpAxH2rpcnVLdU+x/Pzhm6JTu9XyCatFF7+MNYSVWN1h1f9wAau/0D0THE
 SRgeiFX4zX7geYcIer+k/ZwWzKpcTINdTiQOd9RT3tnPXCiJccR/nvtroTB/xl3O6jXP
 D7/cliBInWyxFWYDn+ZJqasu1YF3w9cYsfsolaQifBJPnQCMRnPSGu6iqY80+5Hg2Xdy
 YV/SulfFeNAoDiumLkYgEkmCox9dzRs8Pei/qbKW/PwPh1aoHTQygrd3fEhtcQMKdljF
 h3VDCy8Q6QP9j6VlFbronps+18c/vPUFBveyoT790+BfSrD7tDRR9mCzJAKR3d8mnaCw /w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ukgtugy9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 21:57:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701151020; bh=L6tXkYwe9F2GPyQLMay6soRAnBhzrOYNVPe8kLlFxGk=;
        h=From:To:CC:Subject:Date:From;
        b=TwdExHZUORxDopdRLH/dQqtdrXv5I3ooXgrae1zVxWJ9VWHQoK2RpgeIB1YIxKEWF
         S3JPxaCXGlgU+GiPL5z7NNFYARX+pv7Hq2hhcpvd5X9iF65qAjyPtERsFrLDANUedv
         HhuTohl5GjImJ3wV1aBxcVQmodSY7JocLs+gEbt5+52bGxneXMOlBG4bv3fTABr1/f
         bEw9DKWiv9neM9GlDqW0DWUtTlciIiQ60CsiLeh7oMjfY0aBrTKvczUlW6G+QlucP+
         TWkhPB3cZhVsnsKlWFg1xEwBmZQ1L8kwI6w0m88xqJOKZK9A1DHDdeYQ5iLuHVVQAE
         27QUuhbFuzl6A==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E0D6F4041E;
        Tue, 28 Nov 2023 05:56:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EADB0A0084;
        Tue, 28 Nov 2023 05:56:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=B8aIyI3+;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4718640408;
        Tue, 28 Nov 2023 05:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeTyByTzf5Hp+f9kY/mI4LhYiVbc1LQsG4eq5D7ewTw+BK6ZZlLtspJ4AeSPI8WEWzYK7cR/ynkARD6OpkvgHF8MkHnEX3+39T3kFBvdowkpvgEuV6pXkhFroer3YlUWnEmrlHdEEl1SDM+ZBciGaw4ozil/s2r+ozPNDu0lm6m5ftpFYt96/ySJFKC1rFD2pTk8Y5pRVStb+kDByqyDNOxoKRafcerOiIaWqn3i23RK/8yib7n5W5X6gjbh2uTs0KbEmrjSUUREUUFwIq1zZS69ToHidnIHf+oGZ2GO5sczaT2rC8wSYifl3eb8cVTIl6AJuheJ0+mgd4mBCA2w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjdGiDOHd3iCirswDrV0wpbzHHP33BBR3KOOa41r3Z8=;
 b=f/BmeOs0vNmFw/HleUTYNfKaGGiYh39AmY/DhoYpY5itR/wEbcsPegpKDaU9uGwurQ2xpqRnC+Crc+NfcqJ7jLW6PtW2j9UQkz8qAofCJ9FhqbWv/2O7Ns9Lv2KZIxoIh3JLNWCb+25IpZHiOXumTDfHSGemQiY+d14v05pBvPIC/eZNd/a6X+sOak16GRM58S1nVzJIEpOdzXpicGjkA3vZRApP6iQCkH4eBujiV74gteDwsk6bMMnkkqYIfy5+wi/xAUHvw/LHWZWURrtYpzqRNdNPYlJld3wUKLENUGVwIC/7AEHwNkf0l/BszSMCF4oxSsUpeoPJ814EvXWwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjdGiDOHd3iCirswDrV0wpbzHHP33BBR3KOOa41r3Z8=;
 b=B8aIyI3+O8SuAwZc5AL6b9hlccLVXlrpb7I+IfwAJQUOQKWgfVUAExlp9GvygSHXnJMuKh3RK+oVLRuJ3lGNOYQmkyU/HA7m/OXuMdx4/Qj73DthGHdnSoKZPG0sfJNb1uzODQOPM9nVaRt1e8OuspG1b2y30NUhXmMifz728Tc=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Tue, 28 Nov 2023 05:56:49 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 05:56:49 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>
CC:     "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: [PATCH v3] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH v3] net: stmmac: fix FPE events losing
Thread-Index: AdohvweHzQycQ8B4Tb64fZ2hsahwgw==
Date:   Tue, 28 Nov 2023 05:56:49 +0000
Message-ID: <CY5PR12MB6372BF02C49FC9E628D0EC02BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|IA1PR12MB8261:EE_
x-ms-office365-filtering-correlation-id: a617cade-243b-4e31-3d04-08dbefd6d017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KP9JjXXZgfmovZdE6f0Zs4NzYlhzOHScm3UgASK1qW/TIeD8Aer3LUZFFs4tFp3/Da0lHfdIxgUd43196w4Ua+qISaS/6j33qTis8NZNydR62RMNTQIxPa/5px3cKjUkVEKwMVnZfW6OcT4vJuziR1vGBcPP9x2f6X4VMdWEQ9xuduEs+ItuNE8IbPk9wb7mOaTEkr7YTGdwh+wKKma0N5YohRdaVUxxY4TQgZ95Y6HRiDX/aGivyE6BSlH7nDbsS3XoDg1RHHOQUkHaaQ+PmD65rB/4tjUuwcJM0+I2/53P9R2HaTG8BlLbIn6JSyjED3bmoaQu0duaq02I1TmoJMM7aTnFFIx3Obnivilf1sDnSjhFx3viLXmzU+Qi0H4tNN4cp70s/xs/9aw2Q+boYVeP6UwQHcaW/RkIHhsHQIkO6ZIiegFIy8ou6QzX08tbrLXCgxOFPoH//v2BAyMuf+L6PcCXqx+xkr6ZPwRyzrqBK3Fmwyp5HM0baUD+N+Rr1sy62P5FasVMKYWkujs5XEt1uUdlNIiW+6PtHE/lpYS5KyU7TwoCP2nk0ioOLiECtCJbQKn/zSO1ROzitv4ioEV15+nBOD58mnnYlxcKzV+snrC/F9Ci1ppsm5PxXfoONDNA8ehDdXWMLAlWTRxZ0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(26005)(71200400001)(52536014)(8676002)(55016003)(7416002)(8936002)(66476007)(4326008)(86362001)(478600001)(110136005)(66446008)(316002)(76116006)(54906003)(66946007)(64756008)(66556008)(38100700002)(83380400001)(122000001)(5660300002)(6506007)(7696005)(921008)(38070700009)(2906002)(41300700001)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FeVbMzCrCXKsNeqLpcLdh1nN9enNiwLPXyUXpuBjyICgRgoga5e+stUYWTHw?=
 =?us-ascii?Q?lx2yFMZBKK02AOd5Kqj+8e7a71c/JzWmI7qVUY0bZZAqKqbZz3yvgmMkKGTa?=
 =?us-ascii?Q?tVTW4Uru3pjeLZSTU1/3PPwBfcHcPkKDkbe8Noc9zEk5CxSgRot/UMe/JdEP?=
 =?us-ascii?Q?iNRMTmMt9wX2sFhReHXHWJw+t5QvzSVnwkuB+7FHLhydf6owyJrqLvXD34N0?=
 =?us-ascii?Q?tguWia+FqZiyoIjdVy2e43Wsk5Xwvk6jlueLf+pA8bokEiY1jZgHQUGpqYn0?=
 =?us-ascii?Q?T8LBFyqEHJj2pCNn8V7cVJvNSD1lLJTsqdtcw+vb4+Nfj0EBmxgd6QZ6mJaW?=
 =?us-ascii?Q?/ce4J31k90zTwm5rjq6HHzuhbHm37QY3qaGpttGwEyp1oXmcunUMRJmJEXxi?=
 =?us-ascii?Q?/hITo0DfOPPF2tmGjBk2Sl1JPMeahMrSlVeVTyV56BOvxwRhhXwuBnuZ0rZn?=
 =?us-ascii?Q?AhaVs2ZxdsTiOC/B38HcX6KQ95Qj/6YprFztcsE8DbooDc6jytWXv+Bkhe+E?=
 =?us-ascii?Q?xMF3bVkfDeLt5bNs4s0LCF51ZO4TK1fB9MhKr0ibEfrud98hURxvibVdAWj/?=
 =?us-ascii?Q?5r+3+W7qoyVLh8HUaDrUEX5T7/PZBcz8QBQ7BepLz3E1laa5A9j3FDil4XMF?=
 =?us-ascii?Q?44MNrJyCCUH2oBZ0kjBmoyIaNdJbxg5aPiDQ84KAeK6jc6kB5l7ZPL22jvuZ?=
 =?us-ascii?Q?ONTn6njr5z/zLF6MUuqI+RhjxRfY3D3CPWu+2dcIlNBvgZeozXa8Wpf6vY1x?=
 =?us-ascii?Q?0dY7HYgeH9czJU81iEiuXLPmmJZmrilzNIpksbQhwEn6KVu84KmJNPwAoS5b?=
 =?us-ascii?Q?uYbH38us2Zm2XnTluWeVNLZeWuUWjGWcupm0NHHkI3EKbtnttCc/YcFnLVnN?=
 =?us-ascii?Q?iZaPI00LQod0XCq+CHgopNzfDpXYjARBN1Y499lbvsS3CXW8IEF30/DwECAz?=
 =?us-ascii?Q?r4xRSIeEJI9KOhH6u8MoufQqbp+c4PyIGRnVtbfrw3mhDDrCTq2TvYA1eLqi?=
 =?us-ascii?Q?qbk40l1eBHLovP2NgeSoRCkV5X5hflQ1PaS4JwAL/P62Ej31Caqn9zGmMCO3?=
 =?us-ascii?Q?pyJYSbIaKpZoRuV/hkjg9lBOnDfmIS7XicqDET2DV1WfOyix7Cf3u11pKylt?=
 =?us-ascii?Q?/aQOBXFU5hnooAiAEnDChTd8e3VTqmRyxkuLhTalkJHO8fmlAEVb30ksWTGt?=
 =?us-ascii?Q?fOraibsKwVpPH5TEI+mFUzZdopj6E5Y4u7nzPKuUl3yKNObMokUKd/2jmbls?=
 =?us-ascii?Q?m0qXKjkUaTVg1BEZUbq9RWVrowwqthkw3qMNWfQRTUPJIk613kbOoNo8UddX?=
 =?us-ascii?Q?Gap8jjV1GlTJv6btSk6BNMlz6M8xaip7SeTB6MF+lUnRkGbNllClF8CA8Zee?=
 =?us-ascii?Q?sFmINZCBnsA9EETtfUS3f96pHPyty7WootvBHfDqJWs/XRBdArZMIUSTlhHe?=
 =?us-ascii?Q?kzfv/NTbT9km550RL8t+IjxtRAjIq2Ia76q28ds4pX5040XtCkipv5ld+KLu?=
 =?us-ascii?Q?z1gXHf0nq1SjFaq4VtMzozEtglxb0kC6YYLo51U08pDaWlbRQ/pOjhoPJ4wL?=
 =?us-ascii?Q?fv0VygRb1KFDLGUsbuwRNOd5LUjQnPSWFq7H0tKj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GK25wEIWBqlDEprqHD+iRrhZW8DitZg26A7gcptjFGsaC1agGDU446FT2Kok?=
 =?us-ascii?Q?APeQrCEgK0ZgwawbyhQKerTGKpSBWKYzqNw6bX+bqz8gwkmB+tnuqI91uZ2d?=
 =?us-ascii?Q?5UNhWmd+NNn82NN/ry63vBZ7YwqjOx+bCqQzT/jHb+e/a+R8W76hfVs0Yuqv?=
 =?us-ascii?Q?3xwklsx2Fijz8gu0Av9vPXmJjTF3zEX5ceO3ZCrlwGpghlZv0DeihtR/JEKr?=
 =?us-ascii?Q?YaI9itWxHvIXeEfKvVz1lot4Y6YF2+FYFi0oMKEhEGSm8JTAkbz7H4Yyd2Rp?=
 =?us-ascii?Q?kQiCRWazFzHoIuRwMsAXiB/JpDLRo8FiaNzM33ylOGCD2SB1imHkSnqir+Gr?=
 =?us-ascii?Q?DF8YWSfFo9KgB7zIqT66TghofZOcIBncqQUx1Rk7OThI7s6ev5uMrPKNdw7L?=
 =?us-ascii?Q?gtMMTxrnlPypdZWm9fmk7+GLYn+ZodfvJ8jP4fAWfKOh5i9Dzwt58ybNMOIk?=
 =?us-ascii?Q?r5OFKo08M69NOHyosU8oAcbZfAXqRx6Uc+rtU95c1R1wRj2IbvytqVU9QOrq?=
 =?us-ascii?Q?1jqxzwGqYtHpyoNb5fGtt6NX27IjtZYrGG2/YPFZsrkmO7AbOwQiS+14/DKA?=
 =?us-ascii?Q?NNc7GFTd/12DpiWyCpTx0U2Y13hTOTuHxuHLropDQXESdD8AZAVnBX+RBdg9?=
 =?us-ascii?Q?r1MOrcL0Yj0tgLPnYfPFU6rKm0At+rARO5bh4YjGZO1esoNWIVLgnEwnBSSK?=
 =?us-ascii?Q?j3w5QBoFSqi9YvT6kf/CM1DRtwCqpEwQyJAiY5bU/yICpsdkubABtYR9r+ut?=
 =?us-ascii?Q?debc4xHyMl00OS4PtpXpDGrnL1olgZHT7qVUuig8W2Dqcrz31QDwZRc1XhW5?=
 =?us-ascii?Q?T4P1aW89vzKSyyGAh+LoVGG+5UIt25N2bnYKzr1kMib/mC2LnKWm1hOktQhV?=
 =?us-ascii?Q?6wSAjPr1ZGpmHEKR1bT01HemjY3g2jXYzIf63la62lfZgcmZS1oyhn6wi+Sr?=
 =?us-ascii?Q?V/YhxRS5X2KdR3hxH6YqOcQxZTCP4q2LJo8Rl+J4sRF3cVv5CABPg0tvi9CO?=
 =?us-ascii?Q?bYTkQJVSzkRkG8JNbzMUY4N+TeFxxWjYpSEWxpYy2jFKYfQrpmSYAwdiv7KU?=
 =?us-ascii?Q?SilQCy68iNS2Z1UG+PFms0/8eV6puaeXkuZHFDoK5XiePNuZXKNNP83i5Frq?=
 =?us-ascii?Q?ohahDZ944djJsV2KM3iLUBK6j1i8IZbRRay4ED6DC8Os0/wQ7MlwpzlDqOv9?=
 =?us-ascii?Q?vg+6aNhR2lRCJhdKZLpYV/tb+1yrZNLRWQq7iawErrUc2Yb3BbBZMBopDlcg?=
 =?us-ascii?Q?mAGJhNrl3tZe8ZzIhhDrL1H+gptXy54HdDpBZGBM6eolCzYs1BgPAPFWuer4?=
 =?us-ascii?Q?QRZsXqHOnKUdnreeMqms90MKy/ZyLPoEUdTgjGNOnBg+gw=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a617cade-243b-4e31-3d04-08dbefd6d017
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 05:56:49.5751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14zhNYtGdGMK8mFJnUryiD/p71uJxjY8qmaXgzlGFNociUTM9tTrgI9asKgt1LmlS10lnrnDfQLoOkW3lf0VaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
X-Proofpoint-ORIG-GUID: TKGZzOUKiCex8eAuKfb9lObv6N5OPEiT
X-Proofpoint-GUID: TKGZzOUKiCex8eAuKfb9lObv6N5OPEiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_04,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxscore=0 mlxlogscore=868 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
handler missing FPE event status and leads to FPE handshaking failure and
retries.
To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
MAC_FPE_CTRL_STS in those methods.

Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking pr=
ocedure")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Jianheng Zhang <jianheng@synopsys.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++---------=
----
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
 include/linux/stmmac.h                             |  1 +
 7 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.c
index e95d35f..8fd1675 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, stru=
ct net_device *dev,
 	}
 }
=20
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable)
 {
 	u32 value;
=20
-	if (!enable) {
-		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-
-		value &=3D ~EFPE;
-
-		writel(value, ioaddr + MAC_FPE_CTRL_STS);
-		return;
+	if (enable) {
+		cfg->fpe_csr =3D EFPE;
+		value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
+		value &=3D ~GMAC_RXQCTRL_FPRQ;
+		value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr =3D 0;
 	}
-
-	value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
-	value &=3D ~GMAC_RXQCTRL_FPRQ;
-	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-	writel(value, ioaddr + GMAC_RXQ_CTRL1);
-
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-	value |=3D EFPE;
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
 }
=20
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct =
net_device *dev)
=20
 	status =3D FPE_EVENT_UNKNOWN;
=20
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
 	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
=20
 	if (value & TRSP) {
@@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struc=
t net_device *dev)
 	return status;
 }
=20
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_typ=
e type)
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *=
cfg,
+			     enum stmmac_mpacket_type type)
 {
-	u32 value;
+	u32 value =3D cfg->fpe_csr;
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (type =3D=3D MPACKET_VERIFY) {
-		value &=3D ~SRSP;
+	if (type =3D=3D MPACKET_VERIFY)
 		value |=3D SVER;
-	} else {
-		value &=3D ~SVER;
+	else if (type =3D=3D MPACKET_RESPONSE)
 		value |=3D SRSP;
-	}
=20
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.h
index 53c138d..34e6207 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct =
stmmac_est *cfg,
 			 unsigned int ptp_rate);
 void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/=
net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 453e88b..a74e71d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioadd=
r, struct stmmac_est *cfg,
 	return 0;
 }
=20
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
+static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe=
_cfg *cfg,
+				   u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ether=
net/stmicro/stmmac/hwif.h
index b95d3e1..68aa2d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -412,9 +412,11 @@ struct stmmac_ops {
 			     unsigned int ptp_rate);
 	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
 			       struct stmmac_extra_stats *x, u32 txqcnt);
-	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			      u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd5..7791e9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_=
priv *priv, bool is_up)
 	bool *hs_enable =3D &fpe_cfg->hs_enable;
=20
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
 	} else {
 		*lo_state =3D FPE_STATE_OFF;
 		*lp_state =3D FPE_STATE_OFF;
@@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_pri=
v *priv, int status)
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_RESPONSE);
 	}
=20
@@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 		if (*lo_state =3D=3D FPE_STATE_ENTERING_ON &&
 		    *lp_state =3D=3D FPE_STATE_ENTERING_ON) {
 			stmmac_fpe_configure(priv, priv->ioaddr,
+					     fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
 					     *enable);
@@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, b=
ool enable)
 	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
@@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
 		stmmac_fpe_configure(priv, priv->ioaddr,
+				     priv->plat->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/=
ethernet/stmicro/stmmac/stmmac_tc.c
index ac41ef4..6ad3e0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
=20
 	priv->plat->fpe_cfg->enable =3D false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
+			     priv->plat->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 0b4658a..dee5ad6 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 };
=20
 struct stmmac_safety_feature_cfg {
--=20
1.8.3.1

